import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  final inputPath = 'assets/images/app_icon.png';
  final outDir = Directory('android/app/src/main/res/drawable');
  final outputPath = '${outDir.path}/ic_stat_notification.png';

  if (!outDir.existsSync()) {
    outDir.createSync(recursive: true);
  }

  final bytes = File(inputPath).readAsBytesSync();
  final image = img.decodeImage(bytes);

  if (image == null) {
    print('Failed to decode image');
    return;
  }

  // Create a new image for the mask
  final mask = img.Image(width: image.width, height: image.height, numChannels: 4);

  for (var y = 0; y < image.height; y++) {
    for (var x = 0; x < image.width; x++) {
      final pixel = image.getPixel(x, y);
      
      // Calculate luminance to decide if we should make it solid or transparent.
      // Since it's a generated icon, it might have a white background.
      // Let's assume white background means transparent, and colored foreground means solid white.
      final r = pixel.r;
      final g = pixel.g;
      final b = pixel.b;
      
      // If the pixel is close to pure white, make it transparent
      if (r > 240 && g > 240 && b > 240) {
        mask.setPixelRgba(x, y, 0, 0, 0, 0); // Transparent
      } else {
        mask.setPixelRgba(x, y, 255, 255, 255, 255); // Solid White
      }
    }
  }

  File(outputPath).writeAsBytesSync(img.encodePng(mask));
  print('Notification icon generated at $outputPath');
}
