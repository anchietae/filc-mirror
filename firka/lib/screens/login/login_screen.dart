import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

/// Epic login screen code, licensed under AGPL 3.0, unlike "refilc"
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contentWidth = MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.90;
    final List<Map<String, String>> slides = [
      {
        'title': 'A romló tendenciádat tízféle képpen láthatod',
        'subtitle': 'Annyi statisztikát láthatsz, hogy a 8 általánosos matek nem lesz elég a kisilabizálására.'
      },
      {
        'title': 'Minden egy helyen',
        'subtitle': 'Egyetlen kattintás és máris többet tudsz, mint az osztályfőnököd.'
      },
      {
        'title': 'Könnyen érthető elemzések',
        'subtitle': 'Több száz adatból szűrjük ki neked a lényeget.'
      },
      {
        'title': 'Valós idejű frissítések',
        'subtitle': 'A statisztikáid mindig naprakészen jelennek meg.'
      }
    ];

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFAFFEF),
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: contentWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logos/colored_logo.png'),
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
                  SizedBox(height: 16),
                  Expanded(
                    child: CarouselSlider.builder(
                      itemCount: slides.length,
                      itemBuilder: (context, index, realIndex) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
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
                            )
                          ],
                        ),
                      ),
                      options: CarouselOptions(
                        height: double.infinity,
                        autoPlay: true,
                        autoPlayInterval: const Duration(milliseconds: 3000),
                        viewportFraction: 1.0,
                        enableInfiniteScroll: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
