import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firka/helpers/api/consts.dart';

late WebViewController _webViewController;

/// Epic login screen code, licensed under AGPL 3.0, unlike "refilc"
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key}) {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(KretaEndpoints.kretaLoginUrl));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xFFDAE4F7),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final paddingWidthHorizontal = MediaQuery.of(context).size.width -
        MediaQuery.of(context).size.width * 0.95;
    final contentWidth = MediaQuery.of(context).size.width * 0.95;
    final modalHeight = MediaQuery.of(context).size.height * 0.90;
    final List<Map<String, String>> slides = [
      {
        'title': 'A romló tendenciádat tízféle képpen láthatod',
        'subtitle':
            'Annyi statisztikát láthatsz, hogy a 8 általánosos matek nem lesz elég a kisilabizálására.',
        'picture': 'assets/images/carousel/slide1.png',
      },
      {
        'title': 'Minden egy helyen',
        'subtitle':
            'Egyetlen kattintás és máris többet tudsz, mint az osztályfőnököd.',
        'picture': 'assets/images/carousel/slide2.png',
      },
      {
        'title': 'Könnyen érthető elemzések',
        'subtitle': 'Több száz adatból szűrjük ki neked a lényeget.',
        'picture': 'assets/images/carousel/slide3.png',
      },
      {
        'title': 'Valós idejű frissítések',
        'subtitle': 'A statisztikáid mindig naprakészen jelennek meg.',
        'picture': 'assets/images/carousel/slide4.png',
      }
    ];

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFAFFEF),
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: paddingWidthHorizontal),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/logos/colored_logo.png'),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Firka',
                        style: TextStyle(
                          color: Color(0xFF394B0A),
                          fontSize: 17,
                          fontFamily: 'Montserrat',
                          fontVariations: [
                            FontVariation('wght', 700),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: slides.length,
                    itemBuilder: (context, index, realIndex) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingWidthHorizontal),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            slides[index]['title']!,
                            style: TextStyle(
                              color: Color(0xFF394B0A),
                              fontSize: 19,
                              fontFamily: 'Montserrat',
                              fontVariations: [
                                FontVariation('wght', 700),
                              ],
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 8),
                          Text(
                            slides[index]['subtitle']!,
                            style: TextStyle(
                              color: Color(0xFF394B0A),
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                              fontVariations: [
                                FontVariation('wght', 400),
                              ],
                              height: 1.30,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 38),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image(
                              image: AssetImage(slides[index]['picture']!),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    options: CarouselOptions(
                      height: double.infinity,
                      autoPlay: true,
                      autoPlayInterval: const Duration(milliseconds: 4000),
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x00DAE4F7),
                        Color(0xFFDAE4F7)
                      ], // customize colors
                      stops: [0.0, 0.5], // percentages (0% → 50% → 100%)
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingWidthHorizontal),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom
                                ),
                                child: FractionallySizedBox(
                                  heightFactor: 0.90,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 16),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFB9C8E5),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(2)
                                                  ),
                                                ),
                                                width: 40,
                                                height: 4,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.8, // Adjust height for content
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          // Add ClipRRect for circular edges
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: WebViewWidget(
                                              controller: _webViewController,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFA7DB21), // Accent-Accent
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x33647E22),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Bejelentkezés E-Kréta fiókkal',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF394B0A), // Text-Primary
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                fontVariations: [
                                  FontVariation('wght', 700),
                                ],
                                letterSpacing: -0.30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Adatvédelmi tájékoztató',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0x7F394C0A) /* Text-Teritary */,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontVariations: [
                        FontVariation('wght', 500),
                      ],
                      height: 1.30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
