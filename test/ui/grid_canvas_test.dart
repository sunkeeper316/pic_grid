import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pic_grid/generated/l10n.dart';
import 'package:pic_grid/ui/view/grid_collage/grid_collage_view.dart';
import 'package:pic_grid/ui/view/grid_collage/grid_collage_view_controller.dart';

void main() {
  testWidgets('Canvas fits viewport and preserves selected export ratio', (
    tester,
  ) async {
    final directory = Directory.systemTemp.createTempSync('grid_canvas_test');
    final file = File('${directory.path}/photo.png')
      ..writeAsBytesSync(
        base64Decode(
          'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aEn8AAAAASUVORK5CYII=',
        ),
      );
    final controller = Get.put(GridCollageViewController());
    controller.selectedImages.assignAll([
      XFile(file.path),
      XFile('${directory.path}/second.png'),
    ]);
    file.copySync('${directory.path}/second.png');
    controller.rowProportions.assignAll([1]);
    controller.colProportions.assignAll([0.5, 0.5]);
    controller.localProportions.assignAll([
      [1],
      [1],
    ]);
    await tester.pumpWidget(
      GetMaterialApp(
        localizationsDelegates: const [S.delegate],
        home: const GridCollageView(),
      ),
    );
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pumpAndSettle();

    for (final viewport in [const Size(800, 600), const Size(400, 800)]) {
      await tester.binding.setSurfaceSize(viewport);
      for (final ratio in CollageAspectRatio.values) {
        controller.canvasAspectRatio.value = ratio;
        await tester.pumpAndSettle();
        final size = tester.getSize(find.byKey(controller.repaintKey));
        expect(size.width / size.height, closeTo(ratio.value, 0.000001));
        expect(size.width, lessThanOrEqualTo(viewport.width));
        expect(size.height, lessThanOrEqualTo(viewport.height));
        expect(tester.takeException(), isNull);
      }
    }
    // Check rendered pixels: two outer borders and one shared seam must
    // each occupy exactly the selected width, including after transposing.
    controller.borderWidth.value = 8;
    controller.borderColor.value = const Color(0xFFFF0000);
    controller.isSaving.value = true;
    controller.canvasAspectRatio.value = CollageAspectRatio.square;
    for (final transpose in [false, true]) {
      if (transpose) controller.toggleLayout();
      await tester.pump();
      final boundary =
          controller.repaintKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      final capture = (await tester.runAsync(() => boundary.toImage()))!;
      final pixels = (await tester.runAsync(
        () => capture.toByteData(format: ui.ImageByteFormat.rawRgba),
      ))!;
      final length = transpose ? capture.height : capture.width;
      final runs = <int>[];
      var run = 0;
      for (var position = 0; position < length; position++) {
        final x = transpose ? 20 : position;
        final y = transpose ? position : 20;
        final offset = (y * capture.width + x) * 4;
        final red =
            pixels.getUint8(offset) == 255 &&
            pixels.getUint8(offset + 1) == 0 &&
            pixels.getUint8(offset + 2) == 0;
        if (red) {
          run++;
        } else if (run > 0) {
          runs.add(run);
          run = 0;
        }
      }
      if (run > 0) runs.add(run);
      expect(runs, [8, 8, 8]);
      capture.dispose();
    }
    controller.isSaving.value = false;
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Canvas aspect ratio'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '4:3'));
    await tester.pumpAndSettle();
    expect(
      controller.canvasAspectRatio.value,
      CollageAspectRatio.landscapeClassic,
    );
    await tester.pumpWidget(const SizedBox());
    Get.reset();
    await tester.binding.setSurfaceSize(null);
    directory.deleteSync(recursive: true);
  });
}
