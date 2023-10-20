import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_edit_app/bloc/download_status.dart';
import 'package:photo_edit_app/bloc/edit/edit_photo_cubit.dart';
import 'package:photo_edit_app/screens/edit/components/components.dart';
import 'package:photo_edit_app/services/services.dart';
import 'package:screenshot/screenshot.dart';

import '../../widgets/widgets.dart';

class EditPhotoScreen extends StatelessWidget {
  const EditPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditPhotoCubit(),
      child: const EditPhotoLayout(),
    );
  }
}

class EditPhotoLayout extends StatefulWidget {
  const EditPhotoLayout({super.key});

  @override
  State<EditPhotoLayout> createState() => _EditPhotoLayoutState();
}

class _EditPhotoLayoutState extends State<EditPhotoLayout> {
  ScreenshotController screenshotController = ScreenshotController();

  late PhotoItemModel photo;

  @override
  void didChangeDependencies() {
    photo = ModalRoute.of(context)?.settings.arguments as PhotoItemModel;
    super.didChangeDependencies();
  }

  Future<T?> _showConfirmDialog<T>(
      BuildContext context, String title, String desc, String rightButtonText) {
    return showDialog(
      context: context,
      builder: (context) {
        return ConfirmDialog(
          title: title,
          description: desc,
          rightButtonText: rightButtonText,
        );
      },
    );
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final editCubit = context.read<EditPhotoCubit>();
    return BlocListener<EditPhotoCubit, EditPhotoState>(
      listenWhen: (p, c) {
        return p.shareStatus != c.shareStatus ||
            p.downloadStatus != c.downloadStatus;
      },
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
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Screenshot(
              controller: screenshotController,
              child: EditPhotoWidget(photo: photo),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20,
              child: MenuIconWidget(
                onTap: () async {
                  final result = await _showConfirmDialog(
                    context,
                    'Discard changes?',
                    'Are you sure want to Exit? You\'ll lose all the edits you\'ve made',
                    '',
                  );

                  if (result == null) return;

                  if (result) {
                    if (!mounted) return;
                    Navigator.pop(context);
                  }
                },
                icon: Icons.arrow_back_ios_new_rounded,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              right: 20,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MenuIconWidget(
                    onTap: () async {
                      editCubit
                          .changeDownloadStatus(DownloadStatus.downloading);

                      final image = await screenshotController.capture(
                        delay: const Duration(milliseconds: 200),
                      );
                      if (!mounted) return;
                      editCubit.downloadImage(image);
                    },
                    icon: CupertinoIcons.cloud_download,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  MenuIconWidget(
                    onTap: () async {
                      editCubit.changeShareStatus(DownloadStatus.downloading);

                      final image = await screenshotController.capture(
                        delay: const Duration(milliseconds: 200),
                      );
                      if (!mounted) return;
                      editCubit.shareImage(image);
                    },
                    icon: CupertinoIcons.share,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              bottom: MediaQuery.of(context).padding.bottom + 20,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocBuilder<EditPhotoCubit, EditPhotoState>(
                        buildWhen: (p, c) {
                          return p.editState != c.editState ||
                              p.opacityLayer != c.opacityLayer;
                        },
                        builder: (context, state) {
                          return Visibility(
                            visible: state.editState == EditState.layering,
                            maintainState: true,
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height / 2,
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Slider(
                                  value: state.opacityLayer,
                                  min: 0,
                                  max: 1,
                                  onChanged: editCubit.changeOpacityLayer,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      MenuIconWidget(
                        onTap: () async {
                          final currentState = editCubit.state.editState;

                          if (currentState == EditState.layering) {
                            editCubit.changeEditState(EditState.idle);
                          } else {
                            editCubit.changeEditState(EditState.layering);
                          }
                        },
                        icon: Icons.layers,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  MenuIconWidget(
                    onTap: () async {
                      editCubit.changeEditState(EditState.addingText);

                      final result = await addText(context);

                      if (result == null ||
                          result is! DragableWidgetTextChild) {
                        if (!mounted) return;
                        editCubit.changeEditState(EditState.idle);
                        return;
                      }

                      final widget = DragableWidget(
                        widgetId: DateTime.now().microsecondsSinceEpoch,
                        child: result,
                        onPress: (id, widget) async {
                          if (widget is DragableWidgetTextChild) {
                            editCubit.changeEditState(EditState.addingText);

                            final result = await addText(
                              context,
                              widget,
                            );

                            if (result == null ||
                                result is! DragableWidgetTextChild) {
                              if (!mounted) return;
                              editCubit.changeEditState(EditState.idle);
                              return;
                            }

                            if (!mounted) return;
                            editCubit.editWidget(id, result);
                          }
                        },
                        onLongPress: (id) async {
                          final result = await _showConfirmDialog(
                            context,
                            'Delete this text?',
                            'Are you sure want to delete this text?',
                            'Delete',
                          );
                          if (result == null) return;

                          if (result) {
                            if (!mounted) return;
                            editCubit.deleteWidget(id);
                          }
                        },
                      );

                      if (!mounted) return;
                      editCubit.addWidget(widget);
                    },
                    icon: Icons.text_fields_rounded,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
