import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

fun loadProperties(file: File): Properties {
    val properties = Properties()
    FileInputStream(file).use { inputStream ->
        properties.load(inputStream)
    }
    return properties
}

android {
    namespace = "app.firka.naplo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "app.firka.naplo"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 29
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    val secretsDir = File(projectDir.absolutePath, "../../../secrets/")
    val propsFile = File(secretsDir, "keystore.properties")

    if (propsFile.exists()) {
        val props = loadProperties(propsFile)
        val store = File(secretsDir, props["storeFile"].toString())

        println(
            "Signing with:\n" +
                    "\t- store: ${store.name}\n" +
                    "\t- key: ${props["keyAlias"]}"
        )

        signingConfigs {
            create("release") {
                storeFile = store
                storePassword = props["storePassword"] as String
                keyPassword = props["keyPassword"] as String
                keyAlias = props["keyAlias"] as String
            }
        }
    }

    buildTypes {
        getByName("debug") {
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-debug"
        }
        release {
            val config = signingConfigs.findByName("release")

            if (config != null) {
                signingConfig = config
            } else {
                // This isn't an error, however by default flutter will hide warnings and etc.
                // so the only way to make this show up in flutter build is to
                // 1. make it an error
                // 2. use println
                // however, println doesn't bring enough attention to the warning
                // so I decided to use logger.error
                logger.error("[WARNING] No keystore specified! Using debug keys to sign the apk.")
                logger.error("[WARNING] DO NOT STORE ANY SENSITIVE DATA INSIDE THE APP")
                logger.error("[WARNING] Because an attacker could steal it, if you sideload their malicious app.")
            }
        }
    }
}
dependencies {
    implementation("androidx.wear:wear-ongoing:1.0.0")
}

flutter {
    source = "../.."
}
