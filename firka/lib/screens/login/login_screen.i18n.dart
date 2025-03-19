import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations.byLocale("en_US") +
      {
        "hu_HU": {
          "title1": "A romló tendenciádat tízféle képpen láthatod",
          "subtitle1":
              "Annyi statisztikát láthatsz, hogy a 8 általánosos matek nem lesz elég a kisilabizálására.",
          "title2": "Kudarcaid most már grafikonon is követhetőek",
          "subtitle2":
              "Nézd ahogy a görbék lefelé mutatnak, akár az életed kilátásai.",
          "title3": "Számokkal bizonyítjuk, mennyire rosszul teljesítesz",
          "subtitle3":
              "Még a szépített adatok is siralmas képet festenek rólad.",
          "title4": "Statisztikák, amelyek igazolják mindenki gyanúját",
          "subtitle4":
              "Most már diagramokon is láthatod, amit mindenki sejtett rólad.",
        },
        "en_US": {
          "title1": "You can see your worsening trend in ten different ways",
          "subtitle1":
              "You'll see so many statistics that elementary school math won't be enough to figure it out.",
          "title2": "Your failures can now be tracked on charts",
          "subtitle2":
              "Watch as the curves point downward, just like your life prospects.",
          "title3": "We prove with numbers how poorly you're performing",
          "subtitle3":
              "Even the prettied-up data paints a miserable picture of you.",
          "title4": "Statistics that confirm everyone's suspicions",
          "subtitle4":
              "Now you can see on diagrams what everyone has suspected about you."
        },
        "de": {
          "title1":
              "Du kannst deinen Abwärtstrend auf zehn verschiedene Arten sehen",
          "subtitle1":
              "Du wirst so viele Statistiken sehen, dass Grundschulmathematik nicht ausreichen wird, um sie zu verstehen.",
          "title2":
              "Deine Misserfolge können jetzt in Diagrammen verfolgt werden",
          "subtitle2":
              "Sieh zu, wie die Kurven nach unten zeigen, genau wie deine Lebensaussichten.",
          "title3": "Wir beweisen mit Zahlen, wie schlecht du abschneidest",
          "subtitle3":
              "Selbst die geschönten Daten zeichnen ein erbärmliches Bild von dir.",
          "title4": "Statistiken, die die Vermutungen aller bestätigen",
          "subtitle4":
              "Jetzt kannst du in Diagrammen sehen, was alle über dich vermutet haben."
        },
        "lolcat": {
          "title1": "U can see ur worsening trend in ten diff wayz",
          "subtitle1":
              "So many statistiks dat ur basic maffs not enuff 2 figger it out.",
          "title2": "Ur failz now trackd on chartz",
          "subtitle2": "Watch as curvz go down, just liek ur life prospekts.",
          "title3": "We proov wif numberz how bad u performin",
          "subtitle3": "Even da prettied-up datas showz how mizerabul u iz.",
          "title4": "Statistiks dat confirm everybuddy suspishuns",
          "subtitle4":
              "Now u can see on diagramz wat everybuddy suspektd bout u."
        },
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
  String plural(int value) => localizePlural(value, this, _t);
  String version(Object modifier) => localizeVersion(modifier, this, _t);
  Map<String?, String> allVersions() => localizeAllVersions(this, _t);
}
