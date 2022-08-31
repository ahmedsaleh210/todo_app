import 'package:todo_app/shared/constants.dart';
import 'package:todo_app/shared/local/shared_preferences.dart';
import 'package:todo_app/shared/widgets/components.dart';

import '../layout/cubit/cubit.dart';
import '../layout/homelayout.dart';

void getSignInDetails(state,context)
{
  uId = state.uId;
  AppCubit.get(context).getTasks().then((value) {
    CacheHelper.saveData(key: 'uId', value: state.uId);
    CacheHelper.saveData(key: 'name', value: state.name);
    showToast('Signed in Successfully');
    AppCubit.get(context).getDoneTasks();
    navigateAndFinish(context, HomeLayout());
    print('${state.name}');
});
}