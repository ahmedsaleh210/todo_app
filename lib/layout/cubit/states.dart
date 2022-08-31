abstract class AppStates {}

class AppInitialStates extends AppStates {}


class UpdateScreen extends AppStates {}

class DateToggleLoading extends AppStates {}


class CreateTaskSucess extends AppStates {}

class CreateTaskLoading extends AppStates {}

class CreateTaskError extends AppStates {}

class GetTasksSucess extends AppStates {}

class GetTasksLoading extends AppStates {}

class GetTasksError extends AppStates {}

class GetDoneTasksSucess extends AppStates {}

class GetDoneTasksLoading extends AppStates {}

class GetDoneTasksError extends AppStates {}

class RemoveTaskSucess extends AppStates {}

class RemoveTaskLoading extends AppStates {}

class RemoveTaskError extends AppStates {}

class MoveToDoneTaskSucess extends AppStates {}

class MoveToDoneTaskLoading extends AppStates {}

class MoveToDoneTaskError extends AppStates {}

class MoveToArchiveTaskSucess extends AppStates {}

class MoveToArchiveTaskLoading extends AppStates {}

class MoveToArchiveTaskError extends AppStates {}

class DateToggle extends AppStates {
  DateTime? selectedDate;
  DateToggle(this.selectedDate);
}




class AppChangeBottomSheet extends AppStates {}


class SignoutSuccess extends AppStates {}

class SignoutError extends AppStates {}

class ShowDetails extends AppStates {}


class ChangeAppMode extends AppStates {}

class SearchLoadingState extends AppStates {}

class SearchSucessState extends AppStates {}

class ChangeItem extends AppStates {}
