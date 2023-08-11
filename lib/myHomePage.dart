import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart' as AppColors;
import 'my_tabs.dart';

class myHomePage extends StatefulWidget{
  const myHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return myHomePageState();
  }
}

class myHomePageState extends State<myHomePage> with SingleTickerProviderStateMixin{

  late List popularBooks=[];
  late List books=[];
  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async{
    await DefaultAssetBundle.of(context).loadString("JSONFILES/popularBooks.json").then((value) => setState((){popularBooks = json.decode(value);}) );
    await DefaultAssetBundle.of(context).loadString("JSONFILES/books.json").then((value) => setState((){books = json.decode(value);}) );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.background,
            leading: const ImageIcon(color: Colors.black , AssetImage("image/menu.png") ,),
            actions: [
              // button to search
              ElevatedButton(
                onPressed: (){},
                child: Icon(Icons.search , color: Colors.black,),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.background) , ),
              ),
              // button to notifications
              ElevatedButton(
                onPressed: (){},
                child: Icon(Icons.notifications , color: Colors.black,),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.background) , ),
              ),
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10.0,top: 20.0 , bottom: 20.0,),
                      child: Text("Popular Books" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w400, ),),
                    ),
                  ],
                ),
                Container(
                  height: 180,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8,),
                    itemCount: popularBooks==null?0:popularBooks.length,
                    itemBuilder: (context , i){
                      return Container(
                        margin: const EdgeInsets.only(right: 30.0,),
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: AssetImage(popularBooks[i]["img"]),
                            fit:BoxFit.fill ,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // create json folder and json files
                Expanded(
                  child: NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return[
                        SliverAppBar(
                          backgroundColor: AppColors.sliverBackground,
                          pinned: true,
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(50.0),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20,),
                              child: TabBar(
                                indicatorPadding: const EdgeInsets.only(right:10),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelPadding: const EdgeInsets.only(right:10),
                                controller: _tabController,
                                isScrollable: true,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: Offset(0,0),
                                    ),
                                  ],
                                ),
                                tabs: [
                                  AppTabs(color:AppColors.menu1Color , text: "New",),
                                  AppTabs(color:AppColors.menu2Color , text: "Popular",),
                                  AppTabs(color:AppColors.menu3Color , text: "Trending",),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          itemCount: books==null?0:books.length,
                          itemBuilder: (context , i){
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.tabVarViewColor,
                                  boxShadow: [BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(0, 0),
                                    color: Colors.grey.withOpacity(0.2),
                                  )],
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(books[i]['img']),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width:10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star , size: 24, color: AppColors.starColor,),
                                              SizedBox(width: 5,),
                                              Text(books[i]["rating"],style: TextStyle(color: AppColors.starColor , fontWeight: FontWeight.w800,),),
                                            ],
                                          ),
                                          SizedBox(height: 3,),
                                          Text(books[i]["title"] , style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,),),
                                          SizedBox(height: 3,),
                                          Text(books[i]["text"] , style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500, color: AppColors.subTitleText,),),
                                          SizedBox(height: 3,),
                                          Container(
                                            width: 60,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: AppColors.loveColor,
                                            ),
                                            child: Text("Love" , style: TextStyle(fontSize: 13,color: Colors.white,),),

                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                        Material(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                            ),
                            title: Text("Content"),
                          ),
                        ),
                        Material(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                            ),
                            title: Text("Content"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}









