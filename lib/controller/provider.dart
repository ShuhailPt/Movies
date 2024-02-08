import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import '../modelClass/modelClass.dart';

class MainProvider extends ChangeNotifier{

  String url="https://api.themoviedb.org/3/search/movie";
  String key="b944d6eba2d3f434fdb9d98457345ae8";
  int page=1;
  String name="king";
  int pageCount=1;

  List<Movie> apiList=[];
  TextEditingController movieName=TextEditingController();

  Future getApi(String name, int pageNo) async{
    http.Response response;
    response= await http.get(Uri.parse("$url?api_key=$key&query=$name&page=$pageNo"));
    print(response.body);
    if(response.statusCode == 200)
      {
        final Map<String,dynamic> data= json.decode(response.body);
        final List<dynamic> result=data["results"];

        apiList=result.map((e) => Movie(
          title: e["title"],
          poster: e["poster_path"].toString(),
        )).toList();
        notifyListeners();
      }
    else
      {
        throw Exception("Failed to Load");
      }

  }




}