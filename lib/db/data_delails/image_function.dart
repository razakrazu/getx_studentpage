import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageFunction extends GetxController {
  final assetAvatar = 'lib/assets/4.avif'.obs;

  var imgPath = ''.obs;

  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imgPath.value = pickedFile.path;
    } else {
      Get.snackbar('Image not selected!!', 'Please select an image');
    }
  }
}
