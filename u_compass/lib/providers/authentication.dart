
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:u_compass/models/campusService.dart';
import 'dart:convert';
import 'package:u_compass/models/loginVM.dart';

class AuthenticationProvider extends ChangeNotifier {

 static String urlServer="https://u-compass-admin.herokuapp.com";
 String token;
 List<CampusService> campusServices;

 AuthenticationProvider();


 void connect(String username,String password){
  LoginVm login = LoginVm(username,password,true);
  Map<String, String> header = {'content-type':'application/json'};

    http.post(urlServer+"/api/authenticate",headers:header, body: json.encode({'username':login.username,'password':login.password}))
  .then((resp)=>{
    token = json.decode(resp.body)["id_token"]
   });
 }


 Future<List<CampusService>> getAllCampusServices() async{
   var resp = await http.get(urlServer+"/api/campus-services",headers: {"Authorization":"Bearer "+token});
   Iterable iterable = json.decode(resp.body);
   campusServices = iterable.map((model) => CampusService.fromJson(model)).toList();
   return campusServices;
 }

}
