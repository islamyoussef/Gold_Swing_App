part of 'archive_cubit.dart';

@immutable
sealed class ArchiveState {}

final class ArchiveInitState extends ArchiveState {

}

final class ArchiveLoadingState extends ArchiveState {

}

final class ArchiveSuccessState extends ArchiveState {
  final List<MetalRateModel> listOfData;
  ArchiveSuccessState({required this.listOfData});
}

final class ArchiveFailureState extends ArchiveState {
  final String errorMsg;
  ArchiveFailureState({required this.errorMsg});
}
