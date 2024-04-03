import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:web_three_assessment/blocs/weatherBloc/weather_bloc.dart';
import 'package:web_three_assessment/connectionHandler/connectionHandler.dart';
import 'package:web_three_assessment/constants/apiUrls.dart';
import 'package:web_three_assessment/widgets/apiErrorWidget.dart';
import 'package:web_three_assessment/widgets/boxDecoration.dart';
import 'package:web_three_assessment/widgets/loadingWidget.dart';

class WeatherScreen extends StatefulWidget {
  // latitude and longitude to be passed to get whether API
  final String? latitude, longitude;

  const WeatherScreen({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  /// connectionHandler to handle internet connectivity status.
  ConnectionHandler connectionHandler = ConnectionHandler();

  @override
  void initState() {
    super.initState();
    connectionHandler.init();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider(
        create: (context) => WeatherBloc()..add(GetWeatherEvent(widget.latitude, widget.longitude)),
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.orange, iconTheme: const IconThemeData(color: Colors.white)),
          body: Container(
            height: 100.h,
            width: 100.h,
            decoration: Decor.containerDecoration([Colors.orange, Colors.black], [0, 0.8]),
            child: ValueListenableBuilder(
              valueListenable: connectionHandler.isConnected,
              builder: (context, value, child) {
                if (value) {
                  return BlocConsumer<WeatherBloc, WeatherState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state.weatherStatus == WeatherStatus.loading) {
                          return const BallClipRotatePulse();
                        } else if (state.weatherStatus == WeatherStatus.error) {
                          return ApiErrorWidget(retry: retry, errorMessage: state.error, text: "Retry");
                        } else if (state.weatherStatus == WeatherStatus.loaded) {
                          return ListView(
                            children: [
                              Center(
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  height: 30.h,
                                  width: 30.h,
                                  imageUrl:
                                      ApiUrls.iconUrl.replaceAll("{iconCode}", state.weatherModel.weather![0].icon.toString()).replaceAll("{iconSize}", "4"),
                                  placeholder: (context, url) => const BallClipRotatePulse(),
                                  errorWidget: (context, url, error) => Image.asset("assets/error.png"),
                                ),
                              ),
                              Center(
                                child: Text(
                                  state.weatherModel.name.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: Text(
                                  kelvinToCelsius(state.weatherModel.main!.temp),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 50,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  state.weatherModel.weather![0].main!.toUpperCase().toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  state.weatherModel.weather![0].description!.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Text(
                                  "Humidity: ${state.weatherModel.main!.humidity}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Wind Speed: ${state.weatherModel.wind!.speed} meter/sec",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Min: ${kelvinToCelsius(state.weatherModel.main!.tempMin)}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Text(
                                      "Max: ${kelvinToCelsius(state.weatherModel.main!.tempMax)}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                } else {
                  return ApiErrorWidget(errorMessage: "No Internet", text: "Retry", retry: retry);
                }
              },
            ),
          ),
        ),
      );
    });
  }

  /// function to be executed when the retry button is pressed whenever there is an error.
  retry() {
    Navigator.of(context).pop();
  }

  /// function to convert the kelvin temperature to celsius temperature.
  kelvinToCelsius(double? kelvin) {
    int res = (kelvin! - 273.15).toInt();
    return "$res\u2103";
  }
}
