import 'package:bloc/bloc.dart';

import '../model/recipe.dart';
import '../provider/rest_provider.dart';

class ManagerBloc extends Bloc<ManagerEvent, ManagerState> {
  ManagerBloc() : super(InsertState()) {
    on<SubmitEvent>((SubmitEvent event, emit) {
      RestProvider.helper.insertRecipe(event.recipe);
    });
    on<BackendEvent>((event, emit) {
      // Fazer algo
    });
  }
}

/*
 Eventos
*/
abstract class ManagerEvent {}

class SubmitEvent extends ManagerEvent {
  Recipe recipe;
  SubmitEvent({required this.recipe});
}

class BackendEvent extends ManagerEvent {}

/*
 Estados
*/
abstract class ManagerState {}

class InsertState extends ManagerState {}
