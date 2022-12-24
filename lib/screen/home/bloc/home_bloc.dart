import 'package:submis_f2/data/model/base.dart';
import 'package:submis_f2/data/source/api/rest_client.dart';
import 'package:equatable/equatable.dart';

import 'package:submis_f2/data/model/restaurant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final String message;
  final HomeStatus status;
  final List<Restaurant> data;

  const HomeState({
    this.message = "",
    this.status = HomeStatus.initial,
    this.data = const [],
  });

  HomeState copyWith({
    String? message,
    HomeStatus? status,
    List<Restaurant>? data,
  }) {
    return HomeState(
      message: message ?? this.message,
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  List<Object> get props => [message, status, data];
}

class HomeCubit extends Cubit<HomeState> {
  final RestClient _client;
  HomeCubit(this._client) : super(const HomeState());

  void loadRestaurant() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      BaseRestaurants data = await _client.getList();
      if (data.error == false) {
        emit(state.copyWith(
          data: data.restaurants,
          status: HomeStatus.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        message: "Internet not connection",
      ));
    }
  }

  void searchRestaurant(String query) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      BaseRestaurants data = await _client.getSearch(query);
      if (data.error == false) {
        if (data.restaurants != null && data.restaurants!.isNotEmpty) {
          emit(state.copyWith(
            data: data.restaurants,
            status: HomeStatus.success,
          ));
        } else {
          emit(state.copyWith(
            status: HomeStatus.error,
            message: "Not found",
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        message: "Internet not connection",
      ));
    }
  }
}
