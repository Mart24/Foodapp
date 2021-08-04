part of 'goal_cubit.dart';

abstract class GoalStates {
  const GoalStates();
}

class GoalStateInitial extends GoalStates {}

class StartUploadingImageState extends GoalStates {}

class DoneUploadingImageState extends GoalStates {}

class DoneSettingGoal extends GoalStates {}

class ErrorUploadingImageState extends GoalStates {}

class CancelChoosingImageState extends GoalStates {}
