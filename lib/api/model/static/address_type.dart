
import '../../../gen/assets.gen.dart';

class AddressType {
  final String title;
  final String image_path;
  bool is_selected;

  AddressType({
    required this.title,
    required this.image_path,
    this.is_selected = false,
  });
}

final addressTypeList = <AddressType>[
  AddressType(title: 'Home', image_path: Assets.images.svg.addressTypeHome.path),
  AddressType(title: 'Work', image_path: Assets.images.svg.addressTypeWork.path),
  AddressType(title: 'Other', image_path: Assets.images.svg.addressTypeOther.path),
  AddressType(title: 'Other four', image_path: Assets.images.svg.addressTypeOther.path),
  AddressType(title: 'Other 6', image_path: Assets.images.svg.addressTypeOther.path),
  AddressType(title: 'Other seven', image_path: Assets.images.svg.addressTypeOther.path),
];
