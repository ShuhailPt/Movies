import 'package:api_movie_search/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        shadowColor: Colors.transparent.withOpacity(0.1),
        leading: IconButton(onPressed: (){

        },
        icon:Icon( Icons.arrow_back_ios,)),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Search",style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width/1.2,
                  color: Colors.white24,
                  child: Consumer<MainProvider>(
                    builder: (context,value,child) {
                      return TextField(
                        controller: value.movieName,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20.0),
                          labelText: "Search",labelStyle: TextStyle(color: Colors.white30),
                          border: InputBorder.none,
                        ),
                      );
                    }
                  ),
                ),
                Consumer<MainProvider>(
                  builder: (context,val,child) {
                    return InkWell(
                      onTap: (){
                        val.page=1;
                        val.getApi(val.movieName.text,val.page);
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width*0.2 / 1.2,
                        color: Colors.red,
                        child: Icon(Icons.search,size: 32,color: Colors.white,),
                      ),
                    );
                  }
                )
              ],
            ),
            SizedBox(height: 20,),
            Consumer<MainProvider>(
              builder: (context,val,child) {
                return
                  val.apiList.isNotEmpty?
                  GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemCount: 8,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: .69,
                    ),
                    itemBuilder: (context,index){
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white70,
                          image: DecorationImage(image:
                          val.apiList[index].poster!="null"?
                          NetworkImage("https://image.tmdb.org/t/p/w780/${val.apiList[index].poster}"):
                          AssetImage("assets/image.png") as ImageProvider,
                          fit: BoxFit.fill),

                      ),
                        // child: Image.network("https://image.tmdb.org/t/p/w780/${val.apiList[index].poster}",fit:BoxFit.fill,),

                      );
                }):
                      SizedBox();
              }
            ),

            Consumer<MainProvider>(
              builder: (context,val,child) {
                return val.apiList.isNotEmpty?
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap:()
                    {
                      val.page--;
                      val.getApi(val.movieName.text, val.page);
                    },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.red),
                            color: Colors.grey,
                          ),
                          child: Icon(Icons.arrow_back_ios_new,color: Colors.red)),
                      ),
                      InkWell(
                        onTap: (){
                          val.page++;
                          val.getApi(val.movieName.text, val.page);

                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.red),
                            color: Colors.grey,
                          ),
                          child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.red)),
                      ),
                      // ElevatedButton(
                      //     style:ElevatedButton.styleFrom(
                      //       backgroundColor: Colors.grey,
                      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      //       maximumSize: const Size(80,60),
                      //     ),
                      //     onPressed: (){}, child:Text("Next",style: TextStyle(color: Colors.red),)),

                    ],
                  ),
                ):
                    SizedBox();
              }
            )


          ],
        ),
      ),
    );
  }
}
