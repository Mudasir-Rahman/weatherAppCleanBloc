import 'package:equatable/equatable.dart';

abstract class ForecostEvent extends Equatable{
  const ForecostEvent();
  @override
  List<Object?>get props=> [];
}
class GetForecostByCity extends ForecostEvent{
  final String cityName;
  const GetForecostByCity({required this.cityName});
  @override
  List<Object?>get props=>[cityName];
}
class GetForecostByLocation extends ForecostEvent{
 const  GetForecostByLocation();
 @override
  List<Object?>get props=>[];
}