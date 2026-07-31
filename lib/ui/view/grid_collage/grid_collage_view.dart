import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_grid/ui/view/grid_collage/grid_collage_view_controller.dart';

class GridCollageView extends GetView<GridCollageViewController> {
  const GridCollageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid Collage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: controller.pickImages,
          )
        ],
      ),
      body: Obx(() {
        if (controller.selectedImages.isEmpty) {
          return Center(
            child: ElevatedButton(
              onPressed: controller.pickImages,
              child: const Text('Select 2 to 12 Photos'),
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;

            int rows = controller.rowProportions.length;
            int cols = controller.colProportions.length;

            List<Widget> children = [];

            // Draw cells
            for (int r = 0; r < rows; r++) {
              for (int c = 0; c < cols; c++) {
                int index = r * cols + c;
                if (index < controller.selectedImages.length) {
                  double top = 0;
                  for (int i = 0; i < r; i++) top += controller.rowProportions[i] * height;
                  double left = 0;
                  for (int i = 0; i < c; i++) left += controller.colProportions[i] * width;

                  double cellHeight = controller.rowProportions[r] * height;
                  double cellWidth = controller.colProportions[c] * width;

                  children.add(
                    Positioned(
                      top: top,
                      left: left,
                      width: cellWidth,
                      height: cellHeight,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Image.file(
                          File(controller.selectedImages[index].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }
              }
            }

            // Draw horizontal splitters (draggable)
            double topAcc = 0;
            for (int r = 0; r < rows - 1; r++) {
              topAcc += controller.rowProportions[r] * height;
              int rowIndex = r; // capture for closure
              children.add(
                Positioned(
                  top: topAcc - 10,
                  left: 0,
                  width: width,
                  height: 20,
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      double deltaProp = details.delta.dy / height;
                      controller.updateRowProportion(rowIndex, deltaProp);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          height: 4,
                          color: Colors.blueAccent.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }

            // Draw vertical splitters (draggable)
            double leftAcc = 0;
            for (int c = 0; c < cols - 1; c++) {
              leftAcc += controller.colProportions[c] * width;
              int colIndex = c; // capture for closure
              children.add(
                Positioned(
                  top: 0,
                  left: leftAcc - 10,
                  width: 20,
                  height: height,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      double deltaProp = details.delta.dx / width;
                      controller.updateColProportion(colIndex, deltaProp);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          width: 4,
                          color: Colors.blueAccent.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }

            return Stack(children: children);
          },
        );
      }),
    );
  }
}
