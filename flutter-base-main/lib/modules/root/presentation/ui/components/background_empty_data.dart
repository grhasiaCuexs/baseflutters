import 'package:myeshop/helpers/assets_helpers.dart';
import 'package:myeshop/modules/root/presentation/ui/components/common_info_widget.dart';

class BackgroundEmptyData extends CommonInfoWidget {
  const BackgroundEmptyData(
      {super.key, required super.title, super.subTitle})
      : super(imgAsset: "${prefixImgAsset}empty_data.png");
}
