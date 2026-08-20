import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_grid/generated/l10n.dart';
import 'package:pic_grid/ui/view/grid_collage/grid_collage_view_controller.dart';
import 'package:pic_grid/ui/weiget/divider_handle.dart';

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

  void _showLayoutSettings(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).layoutSettings,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 18),
              if (controller.usesMainPhotoLayout)
                Obx(
                  () => Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _LayoutOption(
                        position: MainPhotoPosition.left,
                        label: S.of(context).layoutMainLeft,
                        selected:
                            controller.mainPhotoPosition.value ==
                            MainPhotoPosition.left,
                        onTap: controller.setMainPhotoPosition,
                      ),
                      _LayoutOption(
                        position: MainPhotoPosition.right,
                        label: S.of(context).layoutMainRight,
                        selected:
                            controller.mainPhotoPosition.value ==
                            MainPhotoPosition.right,
                        onTap: controller.setMainPhotoPosition,
                      ),
                      _LayoutOption(
                        position: MainPhotoPosition.top,
                        label: S.of(context).layoutMainTop,
                        selected:
                            controller.mainPhotoPosition.value ==
                            MainPhotoPosition.top,
                        onTap: controller.setMainPhotoPosition,
                      ),
                      _LayoutOption(
                        position: MainPhotoPosition.bottom,
                        label: S.of(context).layoutMainBottom,
                        selected:
                            controller.mainPhotoPosition.value ==
                            MainPhotoPosition.bottom,
                        onTap: controller.setMainPhotoPosition,
                      ),
                    ],
                  ),
                )
              else
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.screen_rotation_alt_outlined),
                  title: Text(S.of(context).layoutTranspose),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: controller.toggleLayout,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLeave(BuildContext context) async {
    final strings = S.of(context);
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(strings.editorDiscardTitle),
        content: Text(strings.editorDiscardMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(strings.editorKeepEditing),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(strings.editorDiscardAndLeave),
          ),
        ],
      ),
    );

    if (shouldLeave == true && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _confirmPickImages(BuildContext context) async {
    if (controller.selectedImages.isEmpty) {
      await controller.pickImages();
      return;
    }

    final strings = S.of(context);
    final shouldReselect = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(strings.editorReselectTitle),
        content: Text(strings.editorReselectMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(strings.editorKeepEditing),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(strings.editorReselectPhotos),
          ),
        ],
      ),
    );

    if (shouldReselect == true && context.mounted) {
      await controller.pickImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _confirmLeave(context);
        }
      },
      child: Scaffold(
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
                  onPressed: () => _confirmPickImages(context),
                ),
                IconButton(
                  icon: const Icon(Icons.border_style_outlined),
                  tooltip: S.of(context).editorBorderSettingsTooltip,
                  onPressed: () => _showBorderSettings(context),
                ),
                IconButton(
                  icon: const Icon(Icons.dashboard_customize_outlined),
                  tooltip: S.of(context).editorLayoutSettingsTooltip,
                  onPressed: () => _showLayoutSettings(context),
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
            return Center(
              child: Text(S.of(context).editorPhotoSelectionRequired),
            );
          }

          // Read these values here so Obx refreshes the preview immediately.
          final selectedImages = controller.selectedImages.toList();
          final rowProportions = controller.rowProportions.toList();
          final colProportions = controller.colProportions.toList();
          final localProportions = controller.localProportions
              .map((track) => List<double>.of(track))
              .toList();
          final borderWidth = controller.borderWidth.value;
          final borderColor = controller.borderColor.value;
          final isSaving = controller.isSaving.value;
          final mainPhotoPosition = controller.mainPhotoPosition.value;
          final evenLayoutByColumns = controller.evenLayoutByColumns.value;

          return LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth;
              final double height = constraints.maxHeight;

              int rows = rowProportions.length;
              int cols = colProportions.length;
              final hasMainPhoto =
                  selectedImages.length.isOdd && selectedImages.length != 9;
              final mainPhotoAtLeft =
                  hasMainPhoto && mainPhotoPosition == MainPhotoPosition.left;
              final mainPhotoAtRight =
                  hasMainPhoto && mainPhotoPosition == MainPhotoPosition.right;
              final mainPhotoAtTop =
                  hasMainPhoto && mainPhotoPosition == MainPhotoPosition.top;
              final mainPhotoAtBottom =
                  hasMainPhoto && mainPhotoPosition == MainPhotoPosition.bottom;

              List<Widget> children = [];

              void addPhotoRect(
                int index,
                double left,
                double top,
                double cellWidth,
                double cellHeight,
              ) {
                children.add(
                  Positioned(
                    key: ValueKey(selectedImages[index].path),
                    top: top,
                    left: left,
                    width: cellWidth,
                    height: cellHeight,
                    child: _EditablePhotoCell(
                      file: File(selectedImages[index].path),
                      borderWidth: borderWidth,
                      borderColor: borderColor,
                      gesturesEnabled: !isSaving,
                    ),
                  ),
                );
              }

              if (mainPhotoAtLeft || mainPhotoAtRight) {
                final mainColumn = mainPhotoAtLeft ? 0 : cols - 1;
                final mainLeft =
                    colProportions
                        .take(mainColumn)
                        .fold<double>(0, (sum, value) => sum + value) *
                    width;
                addPhotoRect(
                  0,
                  mainLeft,
                  0,
                  colProportions[mainColumn] * width,
                  height,
                );

                int imageIndex = 1;
                for (int track = 0; track < localProportions.length; track++) {
                  final column = (mainPhotoAtLeft ? 1 : 0) + track;
                  final trackLeft =
                      colProportions
                          .take(column)
                          .fold<double>(0, (sum, value) => sum + value) *
                      width;
                  final trackWidth = colProportions[column] * width;
                  double top = 0;
                  for (
                    int segment = 0;
                    segment < localProportions[track].length;
                    segment++
                  ) {
                    final cellHeight =
                        localProportions[track][segment] * height;
                    addPhotoRect(
                      imageIndex++,
                      trackLeft,
                      top,
                      trackWidth,
                      cellHeight,
                    );
                    top += cellHeight;
                  }
                }
              } else if (mainPhotoAtTop || mainPhotoAtBottom) {
                final mainRow = mainPhotoAtTop ? 0 : rows - 1;
                final mainTop =
                    rowProportions
                        .take(mainRow)
                        .fold<double>(0, (sum, value) => sum + value) *
                    height;
                addPhotoRect(
                  0,
                  0,
                  mainTop,
                  width,
                  rowProportions[mainRow] * height,
                );

                int imageIndex = 1;
                for (int track = 0; track < localProportions.length; track++) {
                  final row = (mainPhotoAtTop ? 1 : 0) + track;
                  final trackTop =
                      rowProportions
                          .take(row)
                          .fold<double>(0, (sum, value) => sum + value) *
                      height;
                  final trackHeight = rowProportions[row] * height;
                  double left = 0;
                  for (
                    int segment = 0;
                    segment < localProportions[track].length;
                    segment++
                  ) {
                    final cellWidth = localProportions[track][segment] * width;
                    addPhotoRect(
                      imageIndex++,
                      left,
                      trackTop,
                      cellWidth,
                      trackHeight,
                    );
                    left += cellWidth;
                  }
                }
              } else {
                int imageIndex = 0;
                if (evenLayoutByColumns) {
                  for (
                    int track = 0;
                    track < localProportions.length;
                    track++
                  ) {
                    final trackLeft =
                        colProportions
                            .take(track)
                            .fold<double>(0, (sum, value) => sum + value) *
                        width;
                    final trackWidth = colProportions[track] * width;
                    double top = 0;
                    for (final proportion in localProportions[track]) {
                      final cellHeight = proportion * height;
                      addPhotoRect(
                        imageIndex++,
                        trackLeft,
                        top,
                        trackWidth,
                        cellHeight,
                      );
                      top += cellHeight;
                    }
                  }
                } else {
                  for (
                    int track = 0;
                    track < localProportions.length;
                    track++
                  ) {
                    final trackTop =
                        rowProportions
                            .take(track)
                            .fold<double>(0, (sum, value) => sum + value) *
                        height;
                    final trackHeight = rowProportions[track] * height;
                    double left = 0;
                    for (final proportion in localProportions[track]) {
                      final cellWidth = proportion * width;
                      addPhotoRect(
                        imageIndex++,
                        left,
                        trackTop,
                        cellWidth,
                        trackHeight,
                      );
                      left += cellWidth;
                    }
                  }
                }
              }

              if (!isSaving) {
                void addHorizontalHandle({
                  required double top,
                  required double left,
                  required double handleWidth,
                  required ValueChanged<double> onDrag,
                }) {
                  children.add(
                    Positioned(
                      top: top - 18,
                      left: left,
                      width: handleWidth,
                      height: 36,
                      child: _DraggableDividerHandle(
                        axis: Axis.horizontal,
                        color: Theme.of(context).colorScheme.onSurface,
                        onDrag: onDrag,
                        onDoubleTap: controller.toggleLayout,
                      ),
                    ),
                  );
                }

                void addVerticalHandle({
                  required double left,
                  required double top,
                  required double handleHeight,
                  required ValueChanged<double> onDrag,
                }) {
                  children.add(
                    Positioned(
                      top: top,
                      left: left - 18,
                      width: 36,
                      height: handleHeight,
                      child: _DraggableDividerHandle(
                        axis: Axis.vertical,
                        color: Theme.of(context).colorScheme.onSurface,
                        onDrag: onDrag,
                        onDoubleTap: controller.toggleLayout,
                      ),
                    ),
                  );
                }

                void addGlobalHorizontalHandles() {
                  double top = 0;
                  for (int row = 0; row < rows - 1; row++) {
                    top += rowProportions[row] * height;
                    final rowIndex = row;
                    addHorizontalHandle(
                      top: top,
                      left: 0,
                      handleWidth: width,
                      onDrag: (delta) => controller.updateRowProportion(
                        rowIndex,
                        delta / height,
                      ),
                    );
                  }
                }

                void addGlobalVerticalHandles() {
                  double left = 0;
                  for (int col = 0; col < cols - 1; col++) {
                    left += colProportions[col] * width;
                    final colIndex = col;
                    addVerticalHandle(
                      left: left,
                      top: 0,
                      handleHeight: height,
                      onDrag: (delta) => controller.updateColProportion(
                        colIndex,
                        delta / width,
                      ),
                    );
                  }
                }

                void addLocalHorizontalHandles(int columnOffset) {
                  for (
                    int track = 0;
                    track < localProportions.length;
                    track++
                  ) {
                    final column = columnOffset + track;
                    final trackLeft =
                        colProportions
                            .take(column)
                            .fold<double>(0, (sum, value) => sum + value) *
                        width;
                    final trackWidth = colProportions[column] * width;
                    double top = 0;
                    for (
                      int segment = 0;
                      segment < localProportions[track].length - 1;
                      segment++
                    ) {
                      top += localProportions[track][segment] * height;
                      final trackIndex = track;
                      final segmentIndex = segment;
                      addHorizontalHandle(
                        top: top,
                        left: trackLeft,
                        handleWidth: trackWidth,
                        onDrag: (delta) => controller.updateLocalProportion(
                          trackIndex,
                          segmentIndex,
                          delta / height,
                        ),
                      );
                    }
                  }
                }

                void addLocalVerticalHandles(int rowOffset) {
                  for (
                    int track = 0;
                    track < localProportions.length;
                    track++
                  ) {
                    final row = rowOffset + track;
                    final trackTop =
                        rowProportions
                            .take(row)
                            .fold<double>(0, (sum, value) => sum + value) *
                        height;
                    final trackHeight = rowProportions[row] * height;
                    double left = 0;
                    for (
                      int segment = 0;
                      segment < localProportions[track].length - 1;
                      segment++
                    ) {
                      left += localProportions[track][segment] * width;
                      final trackIndex = track;
                      final segmentIndex = segment;
                      addVerticalHandle(
                        left: left,
                        top: trackTop,
                        handleHeight: trackHeight,
                        onDrag: (delta) => controller.updateLocalProportion(
                          trackIndex,
                          segmentIndex,
                          delta / width,
                        ),
                      );
                    }
                  }
                }

                if (mainPhotoAtLeft || mainPhotoAtRight) {
                  addGlobalVerticalHandles();
                  addLocalHorizontalHandles(mainPhotoAtLeft ? 1 : 0);
                } else if (mainPhotoAtTop || mainPhotoAtBottom) {
                  addGlobalHorizontalHandles();
                  addLocalVerticalHandles(mainPhotoAtTop ? 1 : 0);
                } else {
                  if (evenLayoutByColumns) {
                    addGlobalVerticalHandles();
                    addLocalHorizontalHandles(0);
                  } else {
                    addGlobalHorizontalHandles();
                    addLocalVerticalHandles(0);
                  }
                }
              }

              return RepaintBoundary(
                key: controller.repaintKey,
                child: Stack(children: children),
              );
            },
          );
        }),
      ),
    );
  }
}

class _LayoutOption extends StatelessWidget {
  const _LayoutOption({
    required this.position,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final MainPhotoPosition position;
  final String label;
  final bool selected;
  final ValueChanged<MainPhotoPosition> onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onTap(position),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 148,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 82,
              height: 56,
              child: CustomPaint(
                painter: _LayoutPreviewPainter(
                  position: position,
                  mainColor: colorScheme.primary,
                  secondaryColor: colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class _EditablePhotoCell extends StatefulWidget {
  const _EditablePhotoCell({
    required this.file,
    required this.borderWidth,
    required this.borderColor,
    required this.gesturesEnabled,
  });

  final File file;
  final double borderWidth;
  final Color borderColor;
  final bool gesturesEnabled;

  @override
  State<_EditablePhotoCell> createState() => _EditablePhotoCellState();
}

class _EditablePhotoCellState extends State<_EditablePhotoCell> {
  static const _maxZoom = 5.0;

  ImageStream? _imageStream;
  ImageStreamListener? _imageListener;
  Size? _imageSize;
  double _zoom = 1;
  Offset _offset = Offset.zero;
  double _startZoom = 1;
  Offset _startOffset = Offset.zero;
  Offset _startFocalPoint = Offset.zero;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveImageSize();
  }

  @override
  void didUpdateWidget(covariant _EditablePhotoCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.file.path != widget.file.path) {
      _zoom = 1;
      _offset = Offset.zero;
      _imageSize = null;
      _resolveImageSize();
    }
  }

  void _resolveImageSize() {
    _removeImageListener();
    final stream = FileImage(
      widget.file,
    ).resolve(createLocalImageConfiguration(context));
    late final ImageStreamListener listener;
    listener = ImageStreamListener((info, _) {
      if (!mounted) return;
      setState(() {
        _imageSize = Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        );
      });
    });
    _imageStream = stream;
    _imageListener = listener;
    stream.addListener(listener);
  }

  void _removeImageListener() {
    final stream = _imageStream;
    final listener = _imageListener;
    if (stream != null && listener != null) {
      stream.removeListener(listener);
    }
    _imageStream = null;
    _imageListener = null;
  }

  Offset _clampOffset({
    required Offset offset,
    required Size viewport,
    required Size image,
    required double zoom,
  }) {
    final coverScale = math.max(
      viewport.width / image.width,
      viewport.height / image.height,
    );
    final displayedWidth = image.width * coverScale * zoom;
    final displayedHeight = image.height * coverScale * zoom;
    final maxX = math.max(0.0, (displayedWidth - viewport.width) / 2);
    final maxY = math.max(0.0, (displayedHeight - viewport.height) / 2);
    return Offset(offset.dx.clamp(-maxX, maxX), offset.dy.clamp(-maxY, maxY));
  }

  void _resetCrop() {
    setState(() {
      _zoom = 1;
      _offset = Offset.zero;
    });
  }

  @override
  void dispose() {
    _removeImageListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewport = Size(constraints.maxWidth, constraints.maxHeight);
        final imageSize = _imageSize;
        Widget image;

        if (imageSize == null || viewport.isEmpty) {
          image = Positioned.fill(
            child: Image.file(widget.file, fit: BoxFit.cover),
          );
        } else {
          final coverScale = math.max(
            viewport.width / imageSize.width,
            viewport.height / imageSize.height,
          );
          final displayedWidth = imageSize.width * coverScale * _zoom;
          final displayedHeight = imageSize.height * coverScale * _zoom;
          final offset = _clampOffset(
            offset: _offset,
            viewport: viewport,
            image: imageSize,
            zoom: _zoom,
          );
          image = Positioned(
            left: (viewport.width - displayedWidth) / 2 + offset.dx,
            top: (viewport.height - displayedHeight) / 2 + offset.dy,
            width: displayedWidth,
            height: displayedHeight,
            child: Image.file(widget.file, fit: BoxFit.fill),
          );
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onDoubleTap: widget.gesturesEnabled ? _resetCrop : null,
          onScaleStart: widget.gesturesEnabled && imageSize != null
              ? (details) {
                  _startZoom = _zoom;
                  _startOffset = _clampOffset(
                    offset: _offset,
                    viewport: viewport,
                    image: imageSize,
                    zoom: _zoom,
                  );
                  _startFocalPoint = details.localFocalPoint;
                }
              : null,
          onScaleUpdate: widget.gesturesEnabled && imageSize != null
              ? (details) {
                  final zoom = (_startZoom * details.scale).clamp(
                    1.0,
                    _maxZoom,
                  );
                  final viewportCenter = Offset(
                    viewport.width / 2,
                    viewport.height / 2,
                  );
                  final contentPoint =
                      (_startFocalPoint - viewportCenter - _startOffset) /
                      _startZoom;
                  final offset =
                      details.localFocalPoint -
                      viewportCenter -
                      contentPoint * zoom;
                  setState(() {
                    _zoom = zoom;
                    _offset = _clampOffset(
                      offset: offset,
                      viewport: viewport,
                      image: imageSize,
                      zoom: zoom,
                    );
                  });
                }
              : null,
          child: ClipRect(
            child: Stack(
              fit: StackFit.expand,
              children: [
                image,
                if (widget.borderWidth > 0)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.borderColor,
                            width: widget.borderWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DraggableDividerHandle extends StatefulWidget {
  const _DraggableDividerHandle({
    required this.axis,
    required this.color,
    required this.onDrag,
    required this.onDoubleTap,
  });

  final Axis axis;
  final Color color;
  final ValueChanged<double> onDrag;
  final VoidCallback onDoubleTap;

  @override
  State<_DraggableDividerHandle> createState() =>
      _DraggableDividerHandleState();
}

class _DraggableDividerHandleState extends State<_DraggableDividerHandle> {
  bool _showGuide = false;

  void _setGuideVisible(bool visible) {
    if (_showGuide != visible) {
      setState(() => _showGuide = visible);
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontal = widget.axis == Axis.horizontal;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: widget.onDoubleTap,
      onVerticalDragStart: horizontal ? (_) => _setGuideVisible(true) : null,
      onVerticalDragUpdate: horizontal
          ? (details) => widget.onDrag(details.delta.dy)
          : null,
      onVerticalDragEnd: horizontal ? (_) => _setGuideVisible(false) : null,
      onVerticalDragCancel: horizontal ? () => _setGuideVisible(false) : null,
      onHorizontalDragStart: horizontal ? null : (_) => _setGuideVisible(true),
      onHorizontalDragUpdate: horizontal
          ? null
          : (details) => widget.onDrag(details.delta.dx),
      onHorizontalDragEnd: horizontal ? null : (_) => _setGuideVisible(false),
      onHorizontalDragCancel: horizontal ? null : () => _setGuideVisible(false),
      child: Center(
        child: DividerHandle(
          axis: widget.axis,
          color: widget.color,
          showGuide: _showGuide,
        ),
      ),
    );
  }
}

class _LayoutPreviewPainter extends CustomPainter {
  const _LayoutPreviewPainter({
    required this.position,
    required this.mainColor,
    required this.secondaryColor,
  });

  final MainPhotoPosition position;
  final Color mainColor;
  final Color secondaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    const gap = 2.0;
    final mainPaint = Paint()..color = mainColor;
    final secondaryPaint = Paint()..color = secondaryColor;
    final halfWidth = (size.width - gap) / 2;
    final halfHeight = (size.height - gap) / 2;

    switch (position) {
      case MainPhotoPosition.left:
        canvas.drawRect(Rect.fromLTWH(0, 0, halfWidth, size.height), mainPaint);
        canvas.drawRect(
          Rect.fromLTWH(halfWidth + gap, 0, halfWidth, halfHeight),
          secondaryPaint,
        );
        canvas.drawRect(
          Rect.fromLTWH(
            halfWidth + gap,
            halfHeight + gap,
            halfWidth,
            halfHeight,
          ),
          secondaryPaint,
        );
      case MainPhotoPosition.right:
        canvas.drawRect(
          Rect.fromLTWH(halfWidth + gap, 0, halfWidth, size.height),
          mainPaint,
        );
        canvas.drawRect(
          Rect.fromLTWH(0, 0, halfWidth, halfHeight),
          secondaryPaint,
        );
        canvas.drawRect(
          Rect.fromLTWH(0, halfHeight + gap, halfWidth, halfHeight),
          secondaryPaint,
        );
      case MainPhotoPosition.top:
        canvas.drawRect(Rect.fromLTWH(0, 0, size.width, halfHeight), mainPaint);
        canvas.drawRect(
          Rect.fromLTWH(0, halfHeight + gap, halfWidth, halfHeight),
          secondaryPaint,
        );
        canvas.drawRect(
          Rect.fromLTWH(
            halfWidth + gap,
            halfHeight + gap,
            halfWidth,
            halfHeight,
          ),
          secondaryPaint,
        );
      case MainPhotoPosition.bottom:
        canvas.drawRect(
          Rect.fromLTWH(0, halfHeight + gap, size.width, halfHeight),
          mainPaint,
        );
        canvas.drawRect(
          Rect.fromLTWH(0, 0, halfWidth, halfHeight),
          secondaryPaint,
        );
        canvas.drawRect(
          Rect.fromLTWH(halfWidth + gap, 0, halfWidth, halfHeight),
          secondaryPaint,
        );
    }
  }

  @override
  bool shouldRepaint(covariant _LayoutPreviewPainter oldDelegate) {
    return position != oldDelegate.position ||
        mainColor != oldDelegate.mainColor ||
        secondaryColor != oldDelegate.secondaryColor;
  }
}
