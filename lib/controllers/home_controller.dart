import 'package:get/get.dart';
import 'package:portfolio/models/stat_item_model.dart';

class HomeController extends GetxController {
  final RxList<StatItemModel> stats = <StatItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    stats.assignAll(const [
      StatItemModel(label: 'Location', value: 'Austin, TX'),
      StatItemModel(label: 'Experience', value: '5+ Years'),
      StatItemModel(label: 'Projects', value: '24+'),
      StatItemModel(label: 'Availability', value: 'Open'),
    ]);
  }
}
