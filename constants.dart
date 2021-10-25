import 'package:flutter/material.dart';


const kTextLightColor = Color(0xFFACACAC);
const Color kPrimaryColor2 = Color(0xffffffff);
const Color kBlueColor2 = Color(0xff256fff);
const Color kBlueLight = Color(0xff3ecdff);
const Color kIndigoDark = Color(0xff2c3550);
const Color kIndigoLight = Color(0xff7080b3);
const kDefaultPaddin = 20.0;
const kBackgroundColor = Color(0xFFF8F8F8);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueColor = Color(0xFF817DC0);
const kShadowColor = Color(0xFFE6E6E6);
const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kLightBlueColor = Color(0xFFB2DFDB);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kAnimationDuration = Duration(milliseconds: 200);
const kPrimaryColor3 = Color(0xff186049);
const kBorderColor = Color(0xffE4D5C7);
const kBackgroundWhiteColor = Color(0xffF8F6F5);

const kAmounts = ["50", "100", "250", "500"];


const kTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15.0,
);

const kServer = 'Test';
const otaBaseURL = (kServer == "Test")
    ? 'https://external-dev-avail.cartrawler.com/cartrawlerota/json'
    : 'https://otageo.cartrawler.com/cartrawlerota/json';

//Using a php file on personal server as proxy to get around CORS issue
const kReservationURL =
    "https://simondarcyonline.com/cartrawler/vehres/booking.php";

const kVoucherBaseURL = "https://voucher.cartrawler.com/voucher";

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
);

const kCardMargin = 8.0;

const kFixedButtonPadding =
EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0);

const kTitleStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 25.0,
);

Color greyColor = Colors.black.withOpacity(0.6);

const kHeadingStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const kEnabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: const BorderSide(
    color: Colors.grey,
  ),
);

const kFocusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.blue),
);

const kErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: Colors.red),
);

const kInputSpacing = 16.0;

const currencySymbols = {
  'EUR': '€',
  'USD': '\$',
  'GBP': '£',
};

const carSizes = {
  "1": "Mini",
  "2": "Subcompact",
  "3": "Economy",
  "4": "Compact",
  "5": "Midsize",
  "6": "Intermediate",
  "7": "Standard",
  "8": "Fullsize",
  "9": "Luxury",
  "10": "Premium",
  "11": "Minivan",
  "12": "12 passenger van",
  "13": "Moving van",
  "14": "15 passenger van",
  "15": "Cargo van",
  "16": "12 foot truck",
  "17": "20 foot truck",
  "18": "24 foot truck",
  "19": "26 foot truck",
  "20": "Moped",
  "21": "Stretch",
  "22": "Regular",
  "23": "Unique",
  "24": "Exotic",
  "25": "Small/medium truck",
  "26": "Large truck",
  "27": "Small SUV",
  "28": "Medium SUV",
  "29": "Large SUV",
  "30": "Exotic SUV",
  "31": "Four-wheel drive",
  "32": "Special",
  "33": "Mini elite",
  "34": "Economy elite",
  "35": "Compact elite",
  "36": "Intermediate elite",
  "37": "Standard elite",
  "38": "Fullsize elite",
  "39": "Premium elite",
  "40": "Luxury elite",
  "41": "Oversize",
  "42": "50 passenger coach",
  "43": "Convertible",
  "44": "Estate Car",
  "45": "5 Seat People Carrier",
  "46": "7 Seat People Carrier",
  "47": "9 seat minivan",
  "48": "SUV",
};

const List<String> availableTimes = [
  '10:00',
  '10:30',
  '11:00',
  '11:30',
  '12:00',
  '12:30',
  '13:00',
  '13:30',
  '14:00',
  '14:30',
  '15:00',
  '15:30',
  '16:00',
  '16:30',
  '17:00',
  '17:30',
  '18:00',
  '18:30',
  '19:00',
  '19:30',
  '20:00',
  '20:30',
  '23:00',
  '23:30',
  '00:00',
  '07:00',
  '07:30',
  '08:00',
  '08:30',
  '09:00',
  '09:30',
];