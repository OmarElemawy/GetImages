
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';


void main() {
  runApp(  const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  AddImages(),
    );
  }
}
class AddImages extends StatefulWidget {
  const AddImages({Key? key}) : super(key: key);

    @override
  _AddImagesState createState() => _AddImagesState();
}
class _AddImagesState extends State<AddImages> {

  List<Asset> images = <Asset>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        if(images.length==5)
          {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delete an Image to add another")));
          }
        else{
          getImage ();
        }

      },),
      body:buildGridView()
    );
  }

    getImage() async
  {
    List<Asset> resultList = <Asset>[];
    resultList = await  MultiImagePicker.pickImages(maxImages: 5-(images.length),);
     setState(() {
       resultList.forEach((element) {
         if(images.length <5) {
           images.add(element);
         }
       });
     });
  }
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Stack(
          children: [

            AssetThumb(
              asset: asset,
              width: 300,
              height: 300,
            ),
            Center(
              child: IconButton(onPressed:(){
                images.removeAt(index);
                setState(() {
                });
              }, icon: const Icon(Icons.highlight_remove,color: Colors.black87,)),
            ),
          ],
        );
      }),
    );
  }
}


