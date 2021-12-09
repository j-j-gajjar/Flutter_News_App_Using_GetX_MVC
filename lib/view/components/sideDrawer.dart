import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsappflutter/contoller/NewsController.dart';
import 'package:newsappflutter/model/utils.dart';
import 'package:newsappflutter/view/components/dropDownList.dart';

Drawer sideDrawer(NewsController newsController) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.symmetric(vertical: 60),
      children: <Widget>[
        Container(
          child: GetBuilder<NewsController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.cName != ''
                      ? Text("Country = ${controller.cName.value}")
                      : Container(),
                  SizedBox(height: 10),
                  controller.category != ''
                      ? Text("Country = ${controller.category.value}")
                      : Container(),
                  SizedBox(height: 20),
                ],
              );
            },
            init: NewsController(),
          ),
        ),
        Container(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Find Keyword"),
                    scrollPadding: EdgeInsets.all(5),
                    onChanged: (val) {
                      newsController.findNews.value = val;
                      newsController.update();
                    },
                  ),
                ),
              ),
              MaterialButton(
                child: Text("Find"),
                onPressed: () async {
                  newsController.getNews(
                      searchKey: newsController.findNews.value);
                },
              ),
            ],
          ),
        ),
        ExpansionTile(
          title: Text("Country"),
          children: <Widget>[
            for (int i = 0; i < listOfCountry.length; i++)
              dropDownList(
                call: () {
                  newsController.country.value = listOfCountry[i]['code']!;
                  newsController.cName.value =
                      listOfCountry[i]['name']!.toUpperCase();
                  newsController.getNews();
                  // newsController.update();
                },
                name: listOfCountry[i]['name']!.toUpperCase(),
              ),
          ],
        ),
        ExpansionTile(
          title: Text("Category"),
          children: [
            for (int i = 0; i < listOfCategory.length; i++)
              dropDownList(
                  call: () {
                    newsController.category.value = listOfCategory[i]['code']!;
                    newsController.getNews();
                    // newsController.update();
                  },
                  name: listOfCategory[i]['name']!.toUpperCase())
          ],
        ),
        ExpansionTile(
          title: Text("Channel"),
          children: [
            for (int i = 0; i < listOfNewsChannel.length; i++)
              dropDownList(
                call: () {
                  newsController.getNews(channel: listOfNewsChannel[i]['code']);
                  // newsController.update();
                },
                name: listOfNewsChannel[i]['name']!.toUpperCase(),
              ),
          ],
        ),
        ListTile(title: Text("Close"), onTap: () => Get.back()),
      ],
    ),
  );
}
