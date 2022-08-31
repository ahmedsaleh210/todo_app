import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo_app/modules/addTask_screen/addtask_screen.dart';
import 'package:todo_app/modules/search_screen/search_screen.dart';
import 'package:todo_app/modules/uncompleted_tasks/uncompleted_tasks.dart';
import 'package:todo_app/modules/schedule_screen/schedule_screen.dart';
import 'package:todo_app/modules/tasks/tasks.dart';
import 'package:todo_app/shared/widgets/buttons.dart';
import 'package:todo_app/shared/widgets/components.dart';
import '../modules/done_tasks/donetasks.dart';
import '../modules/signin/signin_screen.dart';
import '../shared/local/shared_preferences.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget
{
  final titleController = TextEditingController();
  final timecontroller = TextEditingController();
  final datecontroller = TextEditingController();
  final datecontroller_2 = TextEditingController();
  final searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context,state) {
        if (state is CreateTaskSucess) {
          Navigator.pop(context);
        }
        if(state is SignoutSuccess){
          showToast('Signed out successfully');
          navigateAndFinish(context, SignInScreen());
        }
      },
      builder: (context,state) {
        double w = MediaQuery.of(context).size.width;
        double h = MediaQuery.of(context).size.height;
        DateTime now = DateTime.now();
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          key: scaffoldKey,
          body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              physics: const NeverScrollableScrollPhysics(),
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                return [
                  SliverAppBar(
                    shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(45), bottomRight: Radius.circular(45))),
                    pinned: true,
                    titleSpacing: 0,
                    expandedHeight: 250,
                    leading: IconButton(onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                      icon: const Icon(FontAwesomeIcons.list),),
                    floating: true,
                    snap: true,
                    actions: [
                      IconButton(onPressed: () {
                        navigateTo(context, const SearchScreen());
                      }, icon: const Icon(
                          FontAwesomeIcons.magnifyingGlass
                      )),
                      IconButton(onPressed: () {
                        navigateTo(context, const ScheduleScreen());
                      }, icon: const Icon(
                          FontAwesomeIcons.calendarCheck
                      )),
                    ],
                    title: const Text('Todo'),
                    flexibleSpace: Stack(
                      alignment: Alignment.bottomRight,
                      children:  [
                        FlexibleSpaceBar(
                          background: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: h*0.024,),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              //   child: TextFormField(
                              //     decoration: InputDecoration(
                              //       focusColor: Colors.grey,
                              //       hoverColor: Colors.grey,
                              //       filled: true,
                              //       contentPadding: const EdgeInsets.symmetric(vertical: 2,horizontal: 15),
                              //       suffixIcon: const Icon(Icons.search,color: Colors.grey,),
                              //       hintStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                              //       fillColor: Colors.white,
                              //       hintText: 'Search',
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(25.0),
                              //         borderSide: const BorderSide(
                              //           color: Colors.grey,),
                              //       ),
                              //       enabledBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(25.0),
                              //         borderSide: const BorderSide(
                              //           color: Colors.grey,),
                              //       ),
                              //       focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(25.0),
                              //         borderSide: const BorderSide(
                              //           color: Colors.grey,),
                              //       ),
                              //     ),
                              //     readOnly: true,
                              //     onTap: (){
                              //       AppCubit.get(context).searchResult.clear();
                              //       AppCubit.get(context).isSearchOpened = true;
                              //       navigateTo(context, const SearchScreen());
                              //     },
                              //   ),
                              // ),
                              Padding(
                                padding: EdgeInsets.only(left: w*0.03,right: w*0.04),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: w*0.02),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: SizedBox(
                                          height: h*0.09,
                                          width: w*0.22,
                                          child: Image.network(
                                            'https://i.postimg.cc/mDV4KMk9/1487716857-user-81635.png'
                                            ,fit: BoxFit.cover,),),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${CacheHelper.getData(key: 'name')}',
                                                  style: TextStyle(
                                                    fontSize: w*0.043,
                                                    color: Colors.white,
                                                  ),

                                        ),
                                        const SizedBox(height: 8,),
                                        Text(
                                          'Today',
                                          style: TextStyle(
                                              color: Colors.amber,
                                              height: 1,
                                              fontSize: w*0.05,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('yMMMMd').format(now),
                                          style: TextStyle(
                                            height: h*0.0015,
                                            fontSize: w*0.03,
                                            color: Colors.grey.shade400
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10.0),
                                      child: CircularPercentIndicator(
                                        radius: w/9,
                                        lineWidth: 7.0,
                                        animation: true,
                                        animationDuration: 1200,
                                        backgroundColor: Colors.grey.withOpacity(0.5),
                                        progressColor: Colors.amber,
                                        header: Padding(
                                          padding: const EdgeInsets.only(bottom: 5.0),
                                          child: Text(
                                            'Completed',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.8),
                                              fontSize: w*0.04,
                                            ),
                                          ),
                                        ),
                                        percent: cubit.allTasks.isNotEmpty?cubit.doneTasks.length/cubit.allTasks.length:0,
                                        center: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: h*0.01,),
                                            Text.rich(
                                              TextSpan(
                                                style: TextStyle(
                                                  fontSize: w*0.04,
                                                  height: 1,
                                                ),
                                                children: [
                                                  TextSpan(text: "${cubit.doneTasks.length}/",style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: cubit.doneTasks.length/cubit.allTasks.length!=1?
                                                      Colors.grey.withOpacity(0.7):
                                                      Colors.amber,
                                                      height: 1
                                                  ),

                                                  ),
                                                  TextSpan(text: "${cubit.allTasks.length}",style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.amber,

                                                  ),
                                                  ),
                                                ],
                                              ),),
                                            if(cubit.allTasks.isNotEmpty)...[
                                              Center(
                                                child: Text("${((cubit.doneTasks.length/cubit.allTasks.length)*100).round()}%",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: w*0.05,
                                                    color: Colors.amber,
                                                    height: 1.4
                                                ),),
                                              ),
                                            ]
                                            else Center(
                                              child: Text('0%',style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: w*0.045,
                                                  color: Colors.green,
                                                  height: 1.4
                                              ),),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    bottom:  TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        color: Colors.amber,
                      ),
                      padding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      indicatorWeight: 1,
                      tabs: const [
                        Tab(text: "All Tasks"),
                        Tab(text: "Completed"),
                        Tab(text: "Uncompleted"),
                      ],
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate(
                          [
                            Column(
                              children: const [],
                            ),
                          ]
                      ))
                ];
              },

              body: const TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  TasksScreen(),
                  DoneTasksScreen(),
                  UnCompletedTasksScreen(),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal:w*0.15,vertical: h*0.02),
            child: SizedBox(
              width: double.infinity,
              height: h*0.065,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),),
                  primary: Theme.of(context).floatingActionButtonTheme.backgroundColor
                ),
                onPressed: () {
                  navigateTo(context, AddTaskScreen());
                },
                child:  Text('Add New Task',style: TextStyle(
                  fontSize: h*0.027
                ),),
              ),
            )
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          drawer: SizedBox(
            width: w*0.6,
            child: Drawer(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w*0.02,top: h*0.01,right: w*0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.brightness_4_outlined,size: w*0.07,),
                              SizedBox(width: w*0.02,),
                              Text('Dark Mode',style: TextStyle(
                                  fontSize: h*0.02,
                                  fontWeight: FontWeight.w600
                              ),),
                              const Spacer(),
                              CupertinoSwitch(
                                  activeColor: Colors.amber,
                                  value: AppCubit.get(context).isDark,
                                  onChanged: (value) {
                                    AppCubit.get(context).changeAppMode();
                                  }),
                              SizedBox(height: h*0.055,),
                            ],
                          ),
                          customButton2(
                              context: context,
                              title: 'My Account',
                              h: h,
                              onTap: () {}),
                          customButton2(
                              context: context,
                              title: 'Sign out',
                              h: h,
                              onTap: () {
                                AppCubit.get(context).signOut();
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  



}

