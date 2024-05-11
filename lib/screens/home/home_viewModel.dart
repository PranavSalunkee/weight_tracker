import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../constants/paddings.dart';
import '../../constants/radius.dart';
import '../../constants/strings.dart';
import '../../services/cache/shared_manager.dart';
import '../../ui/bottomShit/bottom_sheet.dart';
import '../../ui/listView/weightList_view.dart';
import 'home_model.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart';


abstract class HomeViewModel extends State<HomeView>
    with TickerProviderStateMixin, ProjectStrings, ProjectPaddings, ProjectRadius {



  // Animation
  late final animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

  // DateTime
  DateTime selectedDate = DateTime.now();

  // Bottom Navigation Bar
  List<Widget> views = [];
  int selectedIndex = 0;
  bool isFloatingActive = true;

  // Data
  List<UserWeight> dataList = [];
  List<String> dateList = [];
  List<String> weightList = [];
  int checkIndex = 0;
  double? currentData;


  // Controller
  bool isEdit = false;
  bool isOkBtnActive = false;
  bool isLoading = false;
  final weightFormFieldController = TextEditingController();
  late final tabController = TabController(length: 2, vsync: this);

  // Multi Selection
  GlobalKey<WeightListViewState> listViewKey = GlobalKey();
  bool isFloatingDelete = false;
  bool isFloatingActiveOnDelete = false;
  bool isSelectedAll = false;

  @override
  void dispose() {
    tabController.removeListener(() {});
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  // Cache

  Future<void> getValues() async {
    _changeLoading();
    UserData? userData = await widget.manager?.getUserData(widget.userName);
    dateList = userData?.dates ?? [] ;
    weightList = userData?.weights ?? [];
    for (var i = 0; i < dateList.length; i++) {
      setState(() => dataList.add(UserWeight(date: DateTime.parse(dateList[i]), weight: double.parse(weightList[i]))));
    }
    _updateCardData();
    _changeLoading();
  }




  Future<void> saveValues() async {
    dateList = [];
    weightList = [];
    for (var data in dataList) {
      dateList.add(data.date.toString());
      weightList.add(data.weight.toString());
    }
    UserData userData = UserData(dates: dateList, weights: weightList);
    await widget.manager?.saveUserData(widget.userName, userData);
    print(widget.userName);
    print(widget.manager?.preferences?.getString(widget.userName));
  }

  // Animation
  void _updateStatus(AnimationStatus status) {
    status == AnimationStatus.completed ? animationController.reset() : null;
  }


  // Change
  void _changeLoading() {
    isLoading = !isLoading;
    setState(() {});
  }

  void applyWeight() {
    final String weightString = weightFormFieldController.text;
    final double weight = double.parse(weightString);
    setState(() {
      dataList.add(UserWeight(date: selectedDate, weight: weight));
      dataList.sort((a, b) => b.date.compareTo(a.date));
      updateCardData();
      tabController.animateTo(0);
      Navigator.pop(context);
      saveValues();
    }
    );
  }

  // Bottom Sheet
  Future<dynamic> showCustomBottomSheet(BuildContext context) {
    isOkBtnActive = false;
    weightFormFieldController.text = '';
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(radiusNormal))),
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
                padding: EdgeInsets.only(top: paddingNormal, bottom: MediaQuery.of(context).viewInsets.bottom),
                child: DataBottomSheetContent(
                  weightFormFieldController: weightFormFieldController,
                  setState: setState,
                  onChanged: (text) => checkIsTextHere(setState),
                  isOkBtnActive: isOkBtnActive,
                  onPressed: isOkBtnActive ? applyWeight : null,
                  customDatePicker: ScrollDatePicker(
                      options: const DatePickerOptions(isLoop: false),
                      selectedDate: selectedDate,
                      locale: const Locale('en'),
                      onDateTimeChanged: (value) {
                        setState(() {
                          selectedDate = value;
                        });
                      }),
                ));
          });
        });
  }

  // Controller
  void checkIsTextHere(StateSetter setState) {
    weightFormFieldController.text.isEmpty
        ? setState(() => isOkBtnActive = false)
        : setState(() => isOkBtnActive = true);
  }

  // DATA
  void updateCardData() {
    setState(() => _updateCardData());
    saveValues();
  }

  void _updateCardData() {
    dataList.isNotEmpty ? currentData = dataList[0].weight : currentData = null;
    if (dataList.length > 1) {
      DateTime currentDate = dataList[0].date;
  }
}}
