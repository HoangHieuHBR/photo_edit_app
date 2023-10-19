import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_edit_app/bloc/detail/photo_detail_cubit.dart';
import 'package:photo_edit_app/bloc/download_status.dart';
import 'package:photo_edit_app/services/services.dart';

import '../../config/config.dart';
import '../../widgets/widgets.dart';

class PhotoDetailScreen extends StatelessWidget {
  const PhotoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoDetailCubit(),
      child: const PhotoDetailLayout(),
    );
  }
}

class PhotoDetailLayout extends StatefulWidget {
  const PhotoDetailLayout({super.key});

  @override
  State<PhotoDetailLayout> createState() => _PhotoDetailLayoutState();
}

class _PhotoDetailLayoutState extends State<PhotoDetailLayout> {
  late PhotoItemModel photo;

  @override
  void didChangeDependencies() {
    photo = ModalRoute.of(context)?.settings.arguments as PhotoItemModel;
    super.didChangeDependencies();
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const LoadingDialog();
      },
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (_) {
          return SuccessDialog(
            message: message,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhotoDetailCubit, PhotoDetailState>(
      listener: (context, state) {
        if (state.shareStatus == DownloadStatus.downloading) {
          _showLoadingDialog(context);
        }

        if (state.shareStatus == DownloadStatus.success) {
          Navigator.pop(context);
        }

        if (state.downloadStatus == DownloadStatus.downloading) {
          _showLoadingDialog(context);
        }
        if (state.downloadStatus == DownloadStatus.success) {
          Navigator.pop(context);
          _showSuccessDialog(context, "Success Download!");
        }

        if (state.shareStatus == DownloadStatus.failed ||
            state.downloadStatus == DownloadStatus.failed) {
          Navigator.pop(context);
          showInfoSnackBar(
            context,
            'Something wrong when downloading photo, please try again!',
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).textTheme.headlineLarge?.color,
            ),
          ),
          centerTitle: false,
          title: Text(
            'Detail Photo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: [
            IconButton(
              onPressed: () => context.read<PhotoDetailCubit>().sharePhoto(
                    photo.src.large,
                  ),
              splashRadius: 20,
              icon: Icon(
                CupertinoIcons.share,
                color: Theme.of(context).textTheme.headlineLarge?.color,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.66,
              child: OriginalImage(photo: photo),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            photo.photographer,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (photo.alt != null &&
                              photo.alt?.isNotEmpty == true) ...[
                            Text(
                              photo.alt ?? '',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                          Row(
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  shape: BoxShape.circle,
                                  color: photo.avgColor.toColor(),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                photo.avgColor,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.editPhoto,
                              arguments: photo,
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Edit Photo',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          OutlinedButton.icon(
                            onPressed: () => context
                                .read<PhotoDetailCubit>()
                                .downloadPhoto(photo.src.original),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            icon: Icon(
                              CupertinoIcons.cloud_download,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.color,
                            ),
                            label: Text(
                              'Download',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
