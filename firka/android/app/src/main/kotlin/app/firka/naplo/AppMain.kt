package app.firka.naplo

import android.annotation.SuppressLint
import android.app.Application
import android.os.Build
import android.util.Log
import org.brotli.dec.BrotliInputStream
import org.json.JSONArray
import org.json.JSONObject
import java.io.File
import java.io.FileOutputStream
import java.security.MessageDigest

class AppMain : Application() {

    private fun File.sha256(): String {
        if (!exists()) return "0000000000000000000000000000000000000000000000000000000000000000"

        val md = MessageDigest.getInstance("SHA-256")
        val digest = md.digest(this.readBytes())
        return digest.fold("") { str, it -> str + "%02x".format(it) }
    }

    @SuppressLint("UnsafeDynamicallyLoadedCode")
    override fun onCreate() {
        super.onCreate()

        val am = assets
        val abi = Build.SUPPORTED_ABIS[0]
        val assets = am.list("")

        if (!assets?.contains("flutter-br-$abi")!!) {
            throw Exception("Unsupported abi: $abi, try downloading an apk with a different abi")
        }

        val compressedLibsIndex = am.open("flutter-br.json")
        val compressedLibs = JSONObject(compressedLibsIndex.readBytes().toString(Charsets.UTF_8))

        val natives = am.list("flutter-br-$abi")!!
        for (lib in natives) {
            val so = lib.substring(0, lib.length-".br".length)
            val soFile = File(cacheDir, so)

            if (soFile.sha256() == compressedLibs.getString("${abi}/$so")) {
                System.load(soFile.absolutePath)
                return
            }

            Log.d("AppMain", "Decompressing: $so")
            val brInput = am.open("flutter-br-$abi/$lib")
            val soOutput = FileOutputStream(soFile)

            val brIn = BrotliInputStream(brInput)
            brIn.copyTo(soOutput)

            brInput.close()
            soOutput.close()

            System.load(soFile.absolutePath)
        }
    }

}