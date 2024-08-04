
class EditingState {}

final class EditingInitial extends EditingState {}
final class EditingnameLoading extends EditingState {}
final class EditingnameSuccess extends EditingState {}
final class EditingnameError extends EditingState {
 final String errorMessage;
  EditingnameError(this.errorMessage);
}


final class EditingpasswordLoading extends EditingState {}
final class EditingpasswordSuccess extends EditingState {}
final class EditingpasswordError extends EditingState {
 final String errorMessage;
  EditingpasswordError(this.errorMessage);
}
