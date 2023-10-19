import 'package:flutter/cupertino.dart';
import 'package:photo_edit_app/services/services.dart';

import '../../../widgets/widgets.dart';
import 'components.dart';

class EditPhotoWidget extends StatelessWidget {
  final PhotoItemModel photo;
  const EditPhotoWidget({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        OriginalImage(photo: photo),
        const ComponentLayer(),
      ],
    );
  }
}
