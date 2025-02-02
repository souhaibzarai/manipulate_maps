import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class FloatingSearchBar extends StatefulWidget {
  const FloatingSearchBar({super.key});

  @override
  State<FloatingSearchBar> createState() => _FloatingSearchBarState();
}

class _FloatingSearchBarState extends State<FloatingSearchBar> {
  final _focusNode = FocusNode();

  final searchController = TextEditingController();
  bool isSearchOverlayVisible = false;

  void clearSearchOverlayContent() {
    setState(() {
      searchController.clear();
    });
  }

  void turnOffSearchOverlay() {
    setState(() {
      isSearchOverlayVisible = false;
    });
    _focusNode.unfocus();
  }

  void turnOnSearchOverlay() {
    setState(() {
      isSearchOverlayVisible = true;
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Column(
        children: [
          // The search bar itself
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            color: AppColors.thirdColor.withAlpha(190),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchController.text = value;
                });
              },
              controller: searchController,
              focusNode: _focusNode,
              onTap: turnOnSearchOverlay,
              onTapOutside: (_) {
                turnOffSearchOverlay();
              },
              decoration: InputDecoration(
                hintText: 'Search for a location...',
                hintStyle: TextStyle(
                  color: AppColors.darkColor.withAlpha(170),
                ),
                suffixIcon: IconButton(
                  onPressed: searchController.text.isNotEmpty
                      ? clearSearchOverlayContent
                      : (isSearchOverlayVisible || _focusNode.hasFocus)
                          ? turnOffSearchOverlay
                          : turnOnSearchOverlay,
                  icon: Icon(
                    searchController.text.isNotEmpty
                        ? Icons.remove
                        : (isSearchOverlayVisible || _focusNode.hasFocus)
                            ? Icons.close
                            : Icons.search,
                    color: AppColors.mainColor,
                  ),
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          // The suggestions overlay
          if (isSearchOverlayVisible)
            Container(
              margin: const EdgeInsets.only(top: 8),
              constraints: BoxConstraints(
                maxHeight: size.height * 0.4,
              ),
              decoration: BoxDecoration(
                color: AppColors.thirdColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(180),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: searchController.text.isEmpty
                    ? []
                    : [
                        ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(searchController.value.text),
                          onTap: () {
                            setState(() {
                              isSearchOverlayVisible = false;
                              _focusNode.unfocus();
                            });
                          },
                        ),
                      ],
              ),
            ),
        ],
      ),
    );
  }
}
