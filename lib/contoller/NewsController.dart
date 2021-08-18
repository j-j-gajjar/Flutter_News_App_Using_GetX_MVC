import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsappflutter/model/ArticalModel.dart';
import 'package:newsappflutter/model/NewsModel.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  List<Article> news = <Article>[];
  ScrollController scrollController = ScrollController();
  dynamic notFound = false.obs;
  dynamic isLoading = false.obs;
  dynamic cName = ''.obs;
  dynamic country = ''.obs;
  dynamic category = ''.obs;
  dynamic findNews = ''.obs;
  dynamic pageNum = 1.obs;
  dynamic isSwitched = false.obs;
  dynamic isPageLoading = false.obs;
  dynamic pageSize = 10.obs;
  String baseApi = "https://newsapi.org/v2/top-headlines?";

  @override
  void onInit() {
    scrollController = new ScrollController()..addListener(_scrollListener);
    getNews();
    super.onInit();
  }

  changeTheme(value) {
    Get.changeTheme(value == true ? ThemeData.dark() : ThemeData.light());
    isSwitched = value;
    update();
  }

  _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      isLoading = true;
      getNews();
    }
  }

  getNews({channel = '', searchKey = '', reload = false}) async {
    notFound = false;

    if (!reload && isLoading == false) {
    } else {
      country = '';
      category = '';
    }
    if (isLoading == true) {
      pageNum++;
    } else {
      news = [];

      pageNum = 1;
    }
    baseApi = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&";
    baseApi += country == '' ? 'country=in&' : 'country=$country&';
    baseApi += category == '' ? '' : 'category=$category&';
    baseApi += 'apiKey=58b98b48d2c74d9c94dd5dc296ccf7b6';
    if (channel != '') {
      country = '';
      category = '';
      baseApi = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&sources=$channel&apiKey=58b98b48d2c74d9c94dd5dc296ccf7b6";
    }
    if (searchKey != '') {
      country = '';
      category = '';
      baseApi = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&q=$searchKey&apiKey=58b98b48d2c74d9c94dd5dc296ccf7b6";
    }
    print(baseApi);
    getDataFromApi(baseApi);
  }

  getDataFromApi(url) async {
    // update();
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      NewsModel newsData = NewsModel.newsFromJson(res.body);

      if (newsData.articles.length == 0 && newsData.totalResults == 0) {
        notFound = isLoading == true ? false : true;
        isLoading = false;
        update();
      } else {
        if (isLoading == true) {
          news = [...news, ...newsData.articles];
          update();
        } else {
          if (newsData.articles.length != 0) {
            news = newsData.articles;
            scrollController.jumpTo(0.0);
            update();
          }
        }
        notFound = false;
        isLoading = false;
        update();
      }
    } else {
      notFound = true;
      update();
    }
  }
}
