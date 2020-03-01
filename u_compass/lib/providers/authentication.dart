
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:u_compass/models/loginVM.dart';

class AuthenticationProvider extends ChangeNotifier {

 static String urlServer="https://u-compass-admin.herokuapp.com";

 AuthenticationProvider();


 void connect(String username,String password){
  LoginVm login = LoginVm(username,password,true);
   http.post(urlServer+"/api/authenticate",body: {'username':login.username,'password':login.password,'rememberMe':true})
  .then((resp)=>{
      print(resp)
   });
 }

}
