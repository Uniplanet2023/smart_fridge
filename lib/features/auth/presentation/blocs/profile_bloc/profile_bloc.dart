import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_fridge/features/auth/domain/usecases/upload_profile_image_usecase.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UploadProfileImageUseCase uploadProfileImageUseCase;
  final AuthBloc authBloc;

  ProfileBloc({
    required this.uploadProfileImageUseCase,
    required this.authBloc,
  }) : super(ProfileInitial()) {
    on<UploadProfileImage>(_onUploadProfileImage);
  }

  Future<void> _onUploadProfileImage(
      UploadProfileImage event, Emitter<ProfileState> emit) async {
    emit(ProfileUploading());
    try {
      final imageUrl =
          await uploadProfileImageUseCase(event.image, event.userId);
      emit(ProfileUploaded(imageUrl));
      // Update AuthBloc with the new profile picture
      authBloc.add(UpdateProfilePictureEvent(imageUrl));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
