import 'package:equatable/equatable.dart';

sealed class NabiState extends Equatable {
  const NabiState();
}

final class NabiInitial extends NabiState {
  @override
  List<Object> get props => [];
}
