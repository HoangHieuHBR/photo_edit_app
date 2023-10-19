import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../screens/edit/components/components.dart';

part 'edit_photo_state.dart';
part 'edit_photo_cubit.freezed.dart';

class EditPhotoCubit extends Cubit<EditPhotoState> {
  EditPhotoCubit() : super(const EditPhotoState());

  void changeEditState(EditState editState) {
    emit(state.copyWith(editState: editState));
  }

  void changeOpacityLayer(double value) {
    emit(state.copyWith(opacityLayer: value));
  }

  void addWidget(DragableWidget widget) {
    emit(state.copyWith(
      widgets: [...state.widgets, widget],
    ));
  }

  void editWidget(int widgetId, DragableWidgetChild widget) {
    var index = state.widgets.indexWhere((e) => e.widgetId == widgetId);
    if (index == -1) return;

    state.widgets[index].child = widget;

    emit(state.copyWith(
      editState: EditState.idle,
      widgets: [...state.widgets],
    ));
  }

  void deleteWidget(int widgetId) {
    emit(
      state.copyWith(
        widgets: List.of(state.widgets)
          ..removeWhere((e) => e.widgetId == widgetId),
      ),
    );
  }
}
