import 'package:flutter/material.dart';
import 'package:photo_edit_app/services/services.dart';

import '../config/config.dart';

class OriginalImage extends StatelessWidget {
  final PhotoItemModel photo;
  const OriginalImage({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(
        photo.src.original,
      ),
      fit: BoxFit.cover,
      loadingBuilder: (_, child, progress) {
        if (progress == null) {
          return child;
        }

        return Image(
          image: NetworkImage(photo.src.portrait),
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (_, __, ___) {
            return const Center(
              child: Icon(
                Icons.broken_image_sharp,
                color: Colors.blueGrey,
              ),
            );
          },
        );
      },
      errorBuilder: (_, __, ___) {
        return Center(
          child: Icon(
            Icons.broken_image_rounded,
            color: AppColor.primaryColor,
          ),
        );
      },
    );
  }
}
