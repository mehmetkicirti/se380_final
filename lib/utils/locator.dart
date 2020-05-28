
import 'package:get_it/get_it.dart';
import 'package:se380final/repository/movieRepository.dart';
import 'package:se380final/repository/userRepository.dart';
import 'package:se380final/services/Concrete/movie_manager.dart';
import 'package:se380final/services/Concrete/user_manager_auth.dart';
import 'package:se380final/services/Concrete/user_manager_firestoreDB.dart';
import 'package:se380final/viewModels/userViewModel.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(()=>UserManagerAuth());
  locator.registerLazySingleton(()=>UserManagerFirestoreDB());
  locator.registerLazySingleton(()=>UserRepository());
  locator.registerLazySingleton(()=>MovieRepository());
  locator.registerLazySingleton(()=>MovieManager());
  locator.registerLazySingleton(()=>UserViewModel());
}