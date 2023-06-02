import 'package:soowgood/common/validator/validators.dart';

mixin RoomValidators {
  final StringValidator nameValidator = NonEmptyStringValidator();
  final String invalidNameErrorText = 'Room name can\'t be empty';
}
