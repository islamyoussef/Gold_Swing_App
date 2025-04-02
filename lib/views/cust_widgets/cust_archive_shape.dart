import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/cubit/archive_cubit.dart';

class CustomArchiveShape extends StatelessWidget {
  const CustomArchiveShape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArchiveCubit, ArchiveState>(
        builder: (ctx,state)
        {
          if(state is ArchiveLoadingState){
            return Text('Loading');
          }
          else if (state is ArchiveFailureState)
          {
            return Text( state.errorMsg);
          }
          else if(state is ArchiveSuccessState)
          {
            return Text(state.listOfData.length.toString());
          }
          else {
            return Text('Unexpected error');
          }
        });
  }
}
