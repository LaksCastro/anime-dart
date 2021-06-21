import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ResourceTile extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onTopRightIconTap;
  final VoidCallback onLongPress;
  final double imageWidth;
  final double imageAspectRatio;
  final Map<String, String> imageHttpHeaders;
  final String imageUrl;
  final Widget topRightIcon;
  final String cardLabel;
  final String title;
  final String heroTag;

  static Widget favoriteIcon(BuildContext context, bool isFavorite) {
    return Icon(
      Icons.favorite,
      color: isFavorite
          ? Theme.of(context).secondaryHeaderColor
          : Theme.of(context).canvasColor,
    );
  }

  static Widget bookMarkIcon(BuildContext context, double stats) {
    return Icon(
      Icons.bookmark,
      color: Color.lerp(
        Theme.of(context).canvasColor,
        Theme.of(context).secondaryHeaderColor,
        stats / 100,
      ),
    );
  }

  const ResourceTile({
    Key key,
    this.onTap,
    this.onTopRightIconTap,
    this.onLongPress,
    this.imageWidth = 80,
    this.imageAspectRatio = 1 / 1.5,
    this.imageHttpHeaders,
    this.imageUrl,
    this.topRightIcon,
    this.cardLabel,
    this.title,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildResourceImage(),
                _buildResourceInfo(context),
              ],
            ),
          ),
          if (topRightIcon != null) _buildTopRightIcon(),
        ],
      ),
    );
  }

  Widget _buildResourceImage() {
    return Hero(
      tag: heroTag,
      child: Container(
        width: imageWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: AspectRatio(
            aspectRatio: imageAspectRatio,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              httpHeaders: imageHttpHeaders,
              imageUrl: imageUrl,
              width: imageWidth,
              placeholder: (context, url) => _buildImagePlaceholder(
                context,
                error: false,
              ),
              errorWidget: (context, url, error) => _buildImagePlaceholder(
                context,
                error: true,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResourceInfo(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    cardLabel,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRightIcon() {
    return Positioned(
      child: GestureDetector(
        onTap: onTopRightIconTap,
        child: Container(
          height: 85,
          width: 85,
          padding: EdgeInsets.only(top: 10, right: 10),
          alignment: Alignment.topRight,
          child: topRightIcon,
        ),
      ),
      right: 0,
      top: 0,
    );
  }

  Widget _buildImagePlaceholder(
    BuildContext context, {
    bool error = false,
  }) {
    return Container(
      width: imageWidth,
      color: error
          ? Theme.of(context)
              .colorScheme
              .secondary
              .withOpacity(.10)
              .withOpacity(.60)
          : Theme.of(context).colorScheme.secondary.withOpacity(.10),
    );
  }
}
