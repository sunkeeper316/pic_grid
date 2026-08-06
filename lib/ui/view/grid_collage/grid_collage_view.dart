import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_grid/generated/l10n.dart';
import 'package:pic_grid/ui/view/grid_collage/grid_collage_view_controller.dart';

class GridCollageView extends GetView<GridCollageViewController> {
  const GridCollageView({super.key});

  static const _borderWidths = <double>[0, 1, 2, 4, 6, 8];
  static const _borderColors = <Color>[
    Colors.white,
    Colors.black,
    Colors.grey,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  void _showBorderSettings(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).borderSettings,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  S.of(context).borderColor,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _borderColors.map((color) {
                    final selected = controller.borderColor.value == color;
                    return Semantics(
                      button: true,
                      selected: selected,
                      label: S.of(context).borderColor,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => controller.setBorderColor(color),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                            border: Border.all(
                              color: selected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).dividerColor,
                              width: selected ? 3 : 1,
                            ),
                          ),
                          child: selected
                              ? Icon(
                                  Icons.check,
                                  size: 20,
                                  color: color.computeLuminance() > 0.5
                                      ? Colors.black
                                      : Colors.white,
                                )
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Text(
                  S.of(context).borderThickness,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _borderWidths.map((width) {
                    return ChoiceChip(
                      label: width == 0
                          ? Text(S.of(context).borderNone)
                          : SizedBox(
                              width: 32,
                              height: 20,
                              child: Center(
                                child: Container(
                                  width: 28,
                                  height: width,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(width),
                                  ),
                                ),
                              ),
                            ),
                      selected: controller.borderWidth.value == width,
                      onSelected: (_) => controller.setBorderWidth(width),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.editorTitle)),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.add_photo_alternate_outlined),
                tooltip: S.of(context).homePickPhoto,
                onPressed: controller.pickImages,
              ),
              IconButton(
                icon: const Icon(Icons.border_style_outlined),
                tooltip: S.of(context).editorBorderSettingsTooltip,
                onPressed: () => _showBorderSettings(context),
              ),
              Obx(
                () => IconButton(
                  icon: controller.isSaving.value
                      ? const SizedBox.square(
                          dimension: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_alt_outlined),
                  tooltip: S.of(context).editorSaveToAlbumTooltip,
                  onPressed: controller.isSaving.value
                      ? null
                      : controller.saveImage,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (controller.selectedImages.isEmpty) {
          return const Center(
            child: Text('Please select 2 to 12 photos from the home page.'),
          );
        }

        // Read these values here so Obx refreshes the preview immediately.
        final selectedImages = controller.selectedImages.toList();
        final rowProportions = controller.rowProportions.toList();
        final colProportions = controller.colProportions.toList();
        final borderWidth = controller.borderWidth.value;
        final borderColor = controller.borderColor.value;
        final isSaving = controller.isSaving.value;
        final mainPhotoOnSide = controller.mainPhotoOnSide.value;

        return LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;

            int rows = rowProportions.length;
            int cols = colProportions.length;
            final hasMainPhoto = selectedImages.length.isOdd;
            final mainPhotoAtLeft = hasMainPhoto && mainPhotoOnSide;
            final mainPhotoAtTop = hasMainPhoto && !mainPhotoOnSide;

            List<Widget> children = [];

            void addPhoto(int index, int row, int col, {bool main = false}) {
              double top = 0;
              for (int i = 0; i < row; i++) {
                top += rowProportions[i] * height;
              }
              double left = 0;
              for (int i = 0; i < col; i++) {
                left += colProportions[i] * width;
              }

              children.add(
                Positioned(
                  top: main ? 0 : top,
                  left: left,
                  width: colProportions[col] * width,
                  height: main ? height : rowProportions[row] * height,
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      border: borderWidth > 0
                          ? Border.all(color: borderColor, width: borderWidth)
                          : null,
                    ),
                    child: Image.file(
                      File(selectedImages[index].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }

            if (mainPhotoAtLeft) {
              addPhoto(0, 0, 0, main: true);
              final secondaryColumns = cols - 1;
              for (int index = 1; index < selectedImages.length; index++) {
                final position = index - 1;
                addPhoto(
                  index,
                  position ~/ secondaryColumns,
                  1 + position % secondaryColumns,
                );
              }
            } else if (mainPhotoAtTop) {
              children.add(
                Positioned(
                  top: 0,
                  left: 0,
                  width: width,
                  height: rowProportions.first * height,
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      border: borderWidth > 0
                          ? Border.all(color: borderColor, width: borderWidth)
                          : null,
                    ),
                    child: Image.file(
                      File(selectedImages.first.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
              for (int index = 1; index < selectedImages.length; index++) {
                final position = index - 1;
                addPhoto(index, 1 + position ~/ cols, position % cols);
              }
            } else {
              for (int index = 0; index < selectedImages.length; index++) {
                addPhoto(index, index ~/ cols, index % cols);
              }
            }

            if (!isSaving) {
              // Draw horizontal splitters (draggable)
              double topAcc = 0;
              for (int r = 0; r < rows - 1; r++) {
                topAcc += rowProportions[r] * height;
                int rowIndex = r; // capture for closure
                children.add(
                  Positioned(
                    top: topAcc - 18,
                    left: mainPhotoAtLeft ? colProportions.first * width : 0,
                    width: mainPhotoAtLeft
                        ? width - colProportions.first * width
                        : width,
                    height: 36,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onDoubleTap: controller.toggleLayout,
                      onVerticalDragUpdate: (details) {
                        double deltaProp = details.delta.dy / height;
                        controller.updateRowProportion(rowIndex, deltaProp);
                      },
                      child: Center(
                        child: _DividerHandle(
                          axis: Axis.horizontal,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                );
              }

              // Draw vertical splitters (draggable)
              double leftAcc = 0;
              for (int c = 0; c < cols - 1; c++) {
                leftAcc += colProportions[c] * width;
                int colIndex = c; // capture for closure
                children.add(
                  Positioned(
                    top: mainPhotoAtTop ? rowProportions.first * height : 0,
                    left: leftAcc - 18,
                    width: 36,
                    height: mainPhotoAtTop
                        ? height - rowProportions.first * height
                        : height,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onDoubleTap: controller.toggleLayout,
                      onHorizontalDragUpdate: (details) {
                        double deltaProp = details.delta.dx / width;
                        controller.updateColProportion(colIndex, deltaProp);
                      },
                      child: Center(
                        child: _DividerHandle(
                          axis: Axis.vertical,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                );
              }
            }

            return RepaintBoundary(
              key: controller.repaintKey,
              child: Stack(children: children),
            );
          },
        );
      }),
    );
  }
}

class _DividerHandle extends StatelessWidget {
  const _DividerHandle({required this.axis, required this.color});

  final Axis axis;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final horizontal = axis == Axis.horizontal;
    return IgnorePointer(
      child: Container(
        width: horizontal ? 34 : 7,
        height: horizontal ? 7 : 34,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.surface,
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
