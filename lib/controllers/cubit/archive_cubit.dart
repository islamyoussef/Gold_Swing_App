import 'package:all_in_one/ihelper/hive_helper.dart';
import 'package:all_in_one/models/metal_rate_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'archive_state.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  ArchiveCubit() : super(ArchiveInitState());

  static List<MetalRateModel> listOfSavedRecords = [];

  void getRecords({String? metalCategoryShortcut}) {
    try {
      emit(ArchiveLoadingState());
      listOfSavedRecords = HiveHelper.selectAllRecords(metalCategoryShortcut: metalCategoryShortcut);

      if (listOfSavedRecords.isNotEmpty) {
        emit(ArchiveSuccessState(listOfData: listOfSavedRecords));
      } else {
        emit(
          ArchiveFailureState(
            errorMsg: 'Sorry, there is no records in your archive yet.',
          ),
        );
      }
    } catch (ex) {
      emit(
        ArchiveFailureState(
          errorMsg: 'Error while reading data from db \n ${ex.toString()}',
        ),
      );
    }
  }

  Future<void> addRecord(MetalRateModel record) async {
    try {

      await HiveHelper.addRecord(record);
      getRecords(metalCategoryShortcut: record.metal);
    } catch (ex) {
      emit(
        ArchiveFailureState(
          errorMsg: 'Error while adding new record to db \n ${ex.toString()}',
        ),
      );
    }
  }

  Future<void> deleteRecord(MetalRateModel record) async {
    try {
      emit(ArchiveLoadingState());
      await HiveHelper.deleteRecord(record);
      getRecords(metalCategoryShortcut: record.metal);
    } catch (ex) {
      emit(
        ArchiveFailureState(
          errorMsg: 'Error while deleting record from db \n ${ex.toString()}',
        ),
      );
    }
  }
}
