import 'package:firebase_auth/firebase_auth.dart';
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
  Future<User> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    return null;
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
          throw Exception("Id Token veya Access token gelirken bir hata oluştu");
        }
      }else{
        throw Exception("Google User gelirken bir hata oluştu");
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