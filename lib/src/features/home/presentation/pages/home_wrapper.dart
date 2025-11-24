import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_forge_ai/src/features/auth/domain/repository/respository_interface.dart';
import 'package:study_forge_ai/src/features/home/presentation/bloc/home_event.dart';
import 'dart:async';

import '../bloc/home_state.dart';


class MainDashboardBloc extends Bloc<MainDashboardEvent, DashboardState> {
  final AuthRepositoryInterface repository;

  MainDashboardBloc(this.repository) : super(DashboardInitial()) {
    on<MainDashboardEvent>(_onMainDashboardEvent);
  }

  Future<void> _onMainDashboardEvent(
      MainDashboardEvent event,
      Emitter<DashboardState> emit,
      ) async {
    emit(DashboardLoading());

    try {
      final result = await repository.getCurrentUser();

      result.fold(
            (failures) => emit(DashboardError(failures.message)),
            (user) => emit(DashboardLoaded(user: user)),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
