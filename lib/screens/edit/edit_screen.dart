import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_edit_app/bloc/edit/edit_photo_cubit.dart';
import 'package:photo_edit_app/screens/edit/components/components.dart';
import 'package:photo_edit_app/services/services.dart';

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
  late PhotoItemModel photo;

  @override
  void didChangeDependencies() {
    photo = ModalRoute.of(context)?.settings.arguments as PhotoItemModel;
    super.didChangeDependencies();
  }

  Future<T?> _showConfirmDialog<T>(
      BuildContext context, String title, String desc) {
    return showDialog(
      context: context,
      builder: (context) {
        return ConfirmDialog(
          title: title,
          description: desc,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final editCubit = context.read<EditPhotoCubit>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          EditPhotoWidget(photo: photo),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            child: MenuIconWidget(
              onTap: () async {
                final result = await _showConfirmDialog(
                  context,
                  'Discard changes?',
                  'Are you sure want to Exit? You\'ll lose all the edits you\'ve made',
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
                  onTap: () async {},
                  icon: CupertinoIcons.cloud_download,
                ),
                const SizedBox(
                  width: 16,
                ),
                MenuIconWidget(
                  onTap: () async {},
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

                    // final result = await addText(context);

                    // if (result == null || result is! DragableWidgetTextChild) {
                    //   if (!mounted) return;
                    //   editCubit.changeEditState(EditState.idle);
                    //   return;
                    // }

                    // final widget = DragableWidget(
                    //   widgetId: DateTime.now().microsecondsSinceEpoch,
                    //   child: result,
                    //   onPress: (id, widget) async {
                    //     if (widget is DragableWidgetTextChild) {
                    //       editCubit.changeEditState(EditState.addingText);

                    //       final result = await addText(
                    //         context,
                    //         widget,
                    //       );

                    //       if (result == null ||
                    //           result is! DragableWidgetTextChild) {
                    //         if (!mounted) return;
                    //         editCubit.changeEditState(EditState.idle);
                    //         return;
                    //       }

                    //       if (!mounted) return;
                    //       editCubit.editWidget(id, result);
                    //     }
                    //   },
                    //   onLongPress: (id) async {
                    //     final result = await _showConfirmDialog(
                    //       context,
                    //       'Delete this text?',
                    //       'Are you sure want to delete this text?',
                    //     );
                    //     if (result == null) return;

                    //     if (result) {
                    //       if (!mounted) return;
                    //       editCubit.deleteWidget(id);
                    //     }
                    //   },
                    // );

                    // if (!mounted) return;
                    // editCubit.addWidget(widget);
                  },
                  icon: Icons.text_fields_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
