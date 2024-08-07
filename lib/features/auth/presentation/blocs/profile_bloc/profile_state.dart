part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileUploading extends ProfileState {}

class ProfileUploaded extends ProfileState {
  final String imageUrl;

  const ProfileUploaded(this.imageUrl);
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}
