import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pic_grid/generated/l10n.dart';

class PhotoPickerView extends StatefulWidget {
  const PhotoPickerView({super.key});

  static const int minAssets = 2;
  static const int maxAssets = 12;

  static Future<List<XFile>> pick(BuildContext context) async {
    return await Navigator.of(context).push<List<XFile>>(
          MaterialPageRoute(builder: (_) => const PhotoPickerView()),
        ) ??
        const [];
  }

  @override
  State<PhotoPickerView> createState() => _PhotoPickerViewState();
}

class _PhotoPickerViewState extends State<PhotoPickerView> {
  static const int _pageSize = 80;

  final ScrollController _scrollController = ScrollController();
  final List<AssetEntity> _assets = [];
  final List<AssetEntity> _selectedAssets = [];

  AssetPathEntity? _allPhotos;
  bool _loading = true;
  bool _loadingMore = false;
  bool _hasMore = true;
  bool _permissionDenied = false;
  bool _confirming = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreWhenNeeded);
    _initialize();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMoreWhenNeeded)
      ..dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    const requestOption = PermissionRequestOption(
      androidPermission: AndroidPermission(
        type: RequestType.image,
        mediaLocation: false,
      ),
    );
    final permission = await PhotoManager.requestPermissionExtend(
      requestOption: requestOption,
    );
    if (!permission.hasAccess) {
      if (mounted) {
        setState(() {
          _permissionDenied = true;
          _loading = false;
        });
      }
      return;
    }

    final paths = await PhotoManager.getAssetPathList(
      onlyAll: true,
      type: RequestType.image,
      filterOption: FilterOptionGroup(
        orders: const [
          OrderOption(type: OrderOptionType.createDate, asc: false),
        ],
      ),
    );
    if (paths.isNotEmpty) {
      _allPhotos = paths.first;
      await _loadNextPage();
    }
    if (mounted) setState(() => _loading = false);
  }

  void _loadMoreWhenNeeded() {
    if (_scrollController.position.extentAfter < 500) {
      _loadNextPage();
    }
  }

  Future<void> _loadNextPage() async {
    if (_loadingMore || !_hasMore || _allPhotos == null) return;
    _loadingMore = true;
    final nextAssets = await _allPhotos!.getAssetListPaged(
      page: _page,
      size: _pageSize,
      type: RequestType.image,
    );
    if (!mounted) return;
    setState(() {
      _assets.addAll(nextAssets);
      _page++;
      _hasMore = nextAssets.length == _pageSize;
      _loadingMore = false;
    });
  }

  void _toggleAsset(AssetEntity asset) {
    setState(() {
      final selectedIndex = _selectedAssets.indexOf(asset);
      if (selectedIndex >= 0) {
        _selectedAssets.removeAt(selectedIndex);
      } else if (_selectedAssets.length < PhotoPickerView.maxAssets) {
        _selectedAssets.add(asset);
      }
    });
  }

  Future<void> _confirm() async {
    if (_selectedAssets.length < PhotoPickerView.minAssets || _confirming) {
      return;
    }
    setState(() => _confirming = true);

    final files = <XFile>[];
    for (final asset in _selectedAssets) {
      final file = await asset.file;
      if (file != null) files.add(XFile(file.path));
    }

    if (!mounted) return;
    if (files.length >= PhotoPickerView.minAssets) {
      Navigator.of(context).pop(files);
    } else {
      setState(() => _confirming = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).pickerLoadFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final canConfirm =
        _selectedAssets.length >= PhotoPickerView.minAssets && !_confirming;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).pickerTitle),
        actions: [
          TextButton(
            onPressed: canConfirm ? _confirm : null,
            child: _confirming
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    '${S.of(context).pickerAdd} '
                    '(${_selectedAssets.length}/${PhotoPickerView.maxAssets})',
                  ),
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: _permissionDenied
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Text(
                  S.of(context).pickerMinimumHint,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_permissionDenied) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(S.of(context).albumPermissionRequired),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: PhotoManager.openSetting,
                child: Text(S.of(context).pickerOpenSettings),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: _assets.length,
      itemBuilder: (context, index) {
        final asset = _assets[index];
        final selectedIndex = _selectedAssets.indexOf(asset);
        return _PhotoTile(
          asset: asset,
          selectionNumber: selectedIndex < 0 ? null : selectedIndex + 1,
          onTap: () => _toggleAsset(asset),
        );
      },
    );
  }
}

class _PhotoTile extends StatefulWidget {
  const _PhotoTile({
    required this.asset,
    required this.selectionNumber,
    required this.onTap,
  });

  final AssetEntity asset;
  final int? selectionNumber;
  final VoidCallback onTap;

  @override
  State<_PhotoTile> createState() => _PhotoTileState();
}

class _PhotoTileState extends State<_PhotoTile> {
  late final Future<Uint8List?> _thumbnail;

  @override
  void initState() {
    super.initState();
    _thumbnail = widget.asset.thumbnailDataWithSize(
      const ThumbnailSize.square(240),
      quality: 85,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selectionNumber != null;
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder<Uint8List?>(
            future: _thumbnail,
            builder: (context, snapshot) {
              final bytes = snapshot.data;
              return bytes == null
                  ? Container(color: Colors.black12)
                  : Image.memory(bytes, fit: BoxFit.cover);
            },
          ),
          if (selected) Container(color: Colors.black26),
          Positioned(
            top: 6,
            right: 6,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black38,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: selected
                  ? Text(
                      '${widget.selectionNumber}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
