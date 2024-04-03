import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:web_three_assessment/blocs/latLongBloc/lat_long_bloc.dart';
import 'package:web_three_assessment/connectionHandler/connectionHandler.dart';
import 'package:web_three_assessment/screens/weatherScreen.dart';
import 'package:web_three_assessment/widgets/apiErrorWidget.dart';
import 'package:web_three_assessment/widgets/boxDecoration.dart';
import 'package:web_three_assessment/widgets/buttonsWidget.dart';
import 'package:web_three_assessment/widgets/listWidget.dart';
import 'package:web_three_assessment/widgets/loadingWidget.dart';
import 'package:web_three_assessment/widgets/textFieldWidget.dart';

/// SearchCityScreen to input city name or select from the pre defined list.
class SearchCityScreen extends StatefulWidget {
  const SearchCityScreen({Key? key}) : super(key: key);

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  /// formKey to handle the input validation.
  final formKey = GlobalKey<FormState>();

  /// textEditingController to get the input from the text field.
  final TextEditingController textEditingController = TextEditingController();

  /// latLongContext to handle LatLongBloc event.
  BuildContext? latLongContext;

  /// connectionHandler to handle internet connectivity status.
  ConnectionHandler connectionHandler = ConnectionHandler();

  /// pre defined city list.
  List<String> cityList = ["Mangalore", "Bangalore", "London", "Delhi", "Manipur", "Mysore"];

  @override
  void initState() {
    super.initState();
    connectionHandler.init();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider(
        create: (context) => LatLongBloc(),
        child: WillPopScope(
          onWillPop: backPressed,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.orange,
            ),
            body: Container(
              height: 100.h,
              width: 100.h,
              decoration: Decor.containerDecoration([Colors.orange, Colors.deepPurple], [0, 0.5]),
              child: ValueListenableBuilder(
                valueListenable: connectionHandler.isConnected,
                builder: (context, value, child) {
                  if (value) {
                    return BlocConsumer<LatLongBloc, LatLongState>(
                      listener: (context, state) {
                        navigateToWeatherScreen(state);
                      },
                      builder: (context, state) {
                        latLongContext = context;
                        if (state.latLongStatus == LatLongStatus.loading) {
                          return const BallClipRotatePulse();
                        } else if (state.latLongStatus == LatLongStatus.error) {
                          return ApiErrorWidget(retry: retry, errorMessage: state.error, text: "Retry");
                        } else {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFieldWidget(controller: textEditingController),
                                  const SizedBox(height: 10),
                                  ButtonsWidget(buttonPress: searchCity, text: "Search"),
                                  const SizedBox(height: 20),
                                  const Text("OR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5, bottom: 0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Select the city from the list",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                                    ),
                                  ),
                                  ListWidget(
                                    list: cityList,
                                    onCLick: (city) {
                                      searchCityFromList(city);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return ApiErrorWidget(errorMessage: "No Internet", text: "Retry", retry: retry);
                  }
                },
              ),
            ),
          ),
        ),
      );
    });
  }

  /// function to be executed when search button is clicked.
  searchCity() {
    if (formKey.currentState!.validate()) {
      latLongContext!.read<LatLongBloc>().add(GetLatLongEvent(textEditingController.text));
    }
  }

  /// function to be executed when the pre defined list is selected.
  searchCityFromList(String cityName) {
    latLongContext!.read<LatLongBloc>().add(GetLatLongEvent(cityName));
  }

  /// if the bloc status is loaded.
  navigateToWeatherScreen(LatLongState state) {
    if (state.latLongStatus == LatLongStatus.loaded) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WeatherScreen(
            latitude: state.latLonModel.lat.toString(),
            longitude: state.latLonModel.lon.toString(),
          ),
        ),
      );
    }
  }

  /// function to be executed when the retry button is pressed whenever there is an error.
  retry() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SearchCityScreen()));
  }

  /// function to be executed when the back button is pressed.
  /// display an alert dialog with yes and no option.
  Future<bool> backPressed() async {
    bool willLeave = false;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure want to exit?'),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ButtonsWidget(
                buttonPress: () {
                  willLeave = true;
                  exit(0);
                },
                text: "Yes"),
            ButtonsWidget(
                buttonPress: () {
                  Navigator.of(context).pop();
                },
                text: "No"),
          ],
        );
      },
    );

    return willLeave;
  }
}
