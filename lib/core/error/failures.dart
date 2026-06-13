import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message ;
  const Failure({required this.message});
  @override
  List<Object?> get props => [message];
}
class ServerFailures extends Failure{
 const  ServerFailures({required  super.message}) ;
}
class CacheFailures extends Failure{
 const  CacheFailures({required super.message}) ;
}
class NoInternetFailures extends Failure{
 const  NoInternetFailures({required super.message}) ;
}