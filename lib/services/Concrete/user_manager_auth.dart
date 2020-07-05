import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:se380final/models/User/users.dart';
import 'package:se380final/services/Abstract/IAuthService.dart';

class UserManagerAuth implements IAuthService{
  final FirebaseAuth _fireBaseAuth =  FirebaseAuth.instance;
  @override
  Future<User> createUserWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _fireBaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(result.user);
    }catch(e){
      print("Create With Email And Password error : $e");
      throw Exception(e);
    }
  }

  @override
  Future<User> currentUser() async{
    try{
      FirebaseUser user = await _fireBaseAuth.currentUser();
      return _userFromFirebase(user);
    }catch(e){
      print("Occured error current User : $e");
      return null;
    }
  }

  User _userFromFirebase(FirebaseUser user){
    if(user == null)
      return null;
    return User(uid: user.uid,email: user.email);
  }

  @override
  Future<User> signInWithAnonymously() async{
    AuthResult result = await _fireBaseAuth.signInAnonymously();
    return _userFromFirebase(result.user);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _fireBaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(result.user);
    }catch(e){
      print("SignInWith Email And Password Exception : $e");
      return null;
    }

  }

  @override
  Future<User> signInWithFacebook() async{
    //getting package
      final _facebookLogin = FacebookLogin();
      //permission ref => facebook dev de var
      FacebookLoginResult facebookLoginResult = await _facebookLogin.logIn(['public_profile','email']);
      switch(facebookLoginResult.status){
        case FacebookLoginStatus.loggedIn:
          if(facebookLoginResult.accessToken != null){
            AuthResult _firebaseResult = await _fireBaseAuth.signInWithCredential(FacebookAuthProvider.getCredential(accessToken: facebookLoginResult.accessToken.token));
            FirebaseUser user = _firebaseResult.user;
            return _userFromFirebase(user);
          }
          break;
        case FacebookLoginStatus.cancelledByUser:
          print("Login Cancelled!!");
          break;
        case FacebookLoginStatus.error:
          print("Error : ${facebookLoginResult.errorMessage}");
          break;
      }
  }

  @override
  Future<User> signInWithGoogle() async{
    try{
      GoogleSignIn _googleSignIn = GoogleSignIn();
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn(); // gmail ile giriş sayfasının acılmasını saglıyor
      if(_googleUser!= null){
        GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
        //Google la giriş yaptık auth verileri ile firebase ile oturum acabiliriz artık
        if(_googleAuth.idToken != null && _googleAuth.accessToken != null){
          AuthResult result = await _fireBaseAuth.signInWithCredential(GoogleAuthProvider.getCredential(idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken));
          FirebaseUser _user = result.user;
          return _userFromFirebase(_user);
        }else{
          throw Exception("There was an error token.");
        }
      }else{
        throw Exception("When getting User, get an error");
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async{
    try{
      if(await _fireBaseAuth.currentUser() != null){
        final _googleSignIn = GoogleSignIn();
        await _googleSignIn.signOut().catchError((e){
          throw Exception("There is not already any being active user googleSigIn : $e");
        });
        await _fireBaseAuth.signOut().catchError((e){
          throw Exception("There is not already any being active user firebase : $e");
        });
        return true;
      }else{
        print("There is not any user");
        return false;
      }
    }catch(e){
      print("Sign Out error : $e");
      return false;
    }
  }
}