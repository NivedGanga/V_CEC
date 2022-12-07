import 'package:v_cec_firebse1/presentation/main_screens/departments_screen/branch_widgets/as.dart';
import 'package:v_cec_firebse1/presentation/main_screens/departments_screen/branch_widgets/cs.dart';
import 'package:v_cec_firebse1/presentation/main_screens/departments_screen/branch_widgets/ec.dart';
import 'package:v_cec_firebse1/presentation/main_screens/departments_screen/branch_widgets/ee.dart';
import 'package:v_cec_firebse1/presentation/main_screens/departments_screen/branch_widgets/gs.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/arc/arc.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/edclub/edclub.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/exess/exess.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/foces/foces.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/iedc/iedc.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/ieee/ieee.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/mediacell/mediacell.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/ncc/ncc.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/nss/nss.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/proddec/proddec.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/surge/surge.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/tinkerhub/tinkerhub.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/tpc/tpc.dart';

final facultipages = [
  const ComputerScience(),
  const Electrical(),
  Electronics(),
  const GeneralScience(),
  const AppliedSciece(),
];

List branches = [
  'Computer Science Engineering',
  'Electrical Engineering',
  'Electronics Engineering',
  'General Science',
  'Applied Science',
];

List hods = [
  'HoD : Dr. Manju S Nair ',
  'HoD : Dr. Rajeevan A K',
  'HoD : Dr. Laila D',
  'HoD : Dr. Rajesh V G',
  'HoD : Dr. Madhusoodhanan Nair R',
];

List forum = [
  "PRODDEC",
  "IEEE",
  "IEDC",
  "TINKERHUB",
  "NSS",
  "MEDIA CELL",
  "NCC",
  "ARC",
  "ExESS",
  "FOCES",
  "SURGE",
  "ED CLUB",
  "TPC",
  ""
];

List<String> forumlogos = [
  "assets/images/forums/logo.png",
  "assets/images/forums/Ieee.png",
  "assets/images/forums/iedc.png",
  "assets/images/forums/tinkerhub.png",
  "assets/images/forums/Nss.png",
  "assets/images/forums/mediacell.jpg", //MEDIA CELL
  "assets/images/forums/ncc.png", //NCC
  "assets/images/forums/ARC.png", //ARC
  "assets/images/forums/exesslogo.png", //EXESS
  "assets/images/forums/foces.png",
  "assets/images/forums/surge1.png",
  "assets/images/forums/EDclub.png", //ED CLUB
  "assets/images/forums/tpc.png", //TPC
];
List forum_pages = [
  proddec(),
  Ieee(),
  Iedc(),
  Tinkerhub(),
  Nss(),
  mediacell(),
  ncc(),
  arc(),
  exess(),
  Foces(),
  Surge(),
  edclub(),
  tpc(),
];
