import 'package:get/get.dart';
import 'package:kamus_kebidanan/pages/dasboad_screen.dart';
import 'package:kamus_kebidanan/pages/detail_screen.dart';
import 'package:kamus_kebidanan/pages/edit_istilah_screen.dart';
import 'package:kamus_kebidanan/pages/input_screen.dart';
import 'package:kamus_kebidanan/routes/navbar.dart';
import 'package:kamus_kebidanan/routes/route_name.dart';

import '../pages/add_istilah_screen.dart';

class PagesRouting {
  static final pages = [
    GetPage(
      name: RouteName.navbarPage,
      page: () => const Navbar(),
    ),
    GetPage(
      name: RouteName.dasboardPage,
      page: () => const DashboardPage(),
    ),
    GetPage(
      name: RouteName.inputPage,
      page: () => const InputPage(),
    ),
    GetPage(
      name: RouteName.detailPage,
      page: () => const DetailPage(),
    ),
    GetPage(
      name: RouteName.addIstilahPage,
      page: () => const AddIstilah(),
    ),
    GetPage(
      name: RouteName.editIstilahPage,
      page: () => const EditIstilah(),
    ),
  ];
}
