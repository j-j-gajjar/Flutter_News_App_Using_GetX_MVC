import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsappflutter/contoller/NewsController.dart';
import 'package:newsappflutter/view/ViewNews.dart';
import 'package:newsappflutter/view/components/sideDrawer.dart';

class HomeScreen extends StatelessWidget {
  NewsController newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News"),
        actions: [
          IconButton(
            onPressed: () {
              newsController.country = '';
              newsController.category = '';
              newsController.findNews = '';
              newsController.cName = '';
              newsController.getNews(reload: true);
              newsController.update();
            },
            icon: Icon(Icons.refresh),
          ),
          GetBuilder<NewsController>(
            builder: (controller) => Switch(
              value: controller.isSwitched == true ? true : false,
              onChanged: (value) => controller.changeTheme(value),
              activeTrackColor: Colors.yellow,
              activeColor: Colors.red,
            ),
            init: NewsController(),
          ),
        ],
      ),
      drawer: sideDrawer(newsController),
      body: GetBuilder<NewsController>(
        builder: (controller) {
          return controller.notFound
              ? Center(child: Text("Not Found", style: TextStyle(fontSize: 30)))
              : controller.news.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                child: GestureDetector(
                                  onTap: () => Get.to(ViewNews(newsUrl: controller.news[index].url)),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                                    child: Column(
                                      children: [
                                        Stack(children: [
                                          controller.news[index].urlToImage == ''
                                              ? Container()
                                              : ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                    placeholder: (context, url) => Container(child: CircularProgressIndicator()),
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                    imageUrl: controller.news[index].urlToImage,
                                                  ),
                                                ),
                                          Positioned(
                                            bottom: 10,
                                            right: 20,
                                            child: Text("${controller.news[index].source.name}", style: TextStyle(color: Colors.red)),
                                          ),
                                        ]),
                                        Divider(),
                                        Text("${controller.news[index].title}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            index == controller.news.length - 1 && controller.isLoading ? Center(child: CircularProgressIndicator()) : SizedBox(),
                          ],
                        );
                      },
                      itemCount: controller.news.length,
                    );
        },
        init: NewsController(),
      ),
    );
  }
}
