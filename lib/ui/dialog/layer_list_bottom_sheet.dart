import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_grid/generated/l10n.dart';
import 'package:pic_grid/ui/view/editor/editor_view_controller.dart';

class LayerListBottomSheet extends StatelessWidget {
  final EditorViewController controller;

  const LayerListBottomSheet({super.key, required this.controller});

  static void show(EditorViewController controller) {
    Get.bottomSheet(
      LayerListBottomSheet(controller: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              S.of(context).layerListTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.overlayItems.isEmpty) {
                return Center(child: Text(S.of(context).layerListEmpty));
              }
              return ReorderableListView.builder(
                itemCount: controller.overlayItems.length,
                onReorder: controller.reorderOverlayItems,
                itemBuilder: (context, index) {
                  final item = controller.overlayItems[index];
                  return ListTile(
                    key: ValueKey(item.id),
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.file(item.file, fit: BoxFit.cover),
                    ),
                    title: Text(S.of(context).layerItem(index + 1)),
                    trailing: const Icon(Icons.drag_handle),
                    selected: controller.selectedItemId.value == item.id,
                    selectedTileColor: Colors.blue.withValues(alpha: 0.1),
                    onTap: () {
                      controller.selectItem(item.id);
                      Get.back(); // 點擊後關閉面板
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}