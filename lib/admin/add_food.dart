import 'dart:io';
import 'package:bitetime/service/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bitetime/widget/app_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_database/firebase_database.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String> items = ['Burger', 'Ice-Cream', 'Salad', 'Pizza'];
  String? value;
  TextEditingController itemnamecontroller = TextEditingController();
  TextEditingController itempriceController = TextEditingController();
  TextEditingController itemdetailcontroller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedimage;

  Future pickimage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedimage = File(image!.path);
    setState(() {});
  }

  Future uploadItem() async {
    if (selectedimage != null &&
        itemnamecontroller.text.isNotEmpty &&
        itempriceController.text.isNotEmpty &&
        itemdetailcontroller.text.isNotEmpty &&
        value != null) {
      String addId = randomAlphaNumeric(10);

      // Upload image to Firebase Storage
      Reference firebaseStorage = FirebaseStorage.instance
          .ref()
          .child("itemImages")
          .child("$addId.jpg");
      UploadTask uploadTask = firebaseStorage.putFile(selectedimage!);
      var downloadUrl = await (await uploadTask).ref.getDownloadURL();

      // Save data to Realtime Database
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref("items").child(addId);

      Map<String, dynamic> itemData = {
        "id": addId,
        "name": itemnamecontroller.text.trim(),
        "price": itempriceController.text.trim(),
        "detail": itemdetailcontroller.text.trim(),
        "category": value,
        "imageUrl": downloadUrl,
      };

      await DatabaseMethods().addFoodItem(itemData, value!).then((_) {
        // Display SnackBar after successful food item addition
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            "Food Item has been added successfully",
            style: TextStyle(fontSize: 20.0),
          )),
        );
      }).catchError((e) {
        // Handle any error that may occur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Item uploaded successfully!")),
      );

      // Clear the form
      setState(() {
        itemnamecontroller.clear();
        itempriceController.clear();
        itemdetailcontroller.clear();
        value = null;
        selectedimage = null;
      });
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields and select an image")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.navigate_before_outlined,
              color: Colors.white,
            )),
        title: Text(
          "Add Items",
          style: AppWidget.headlineTextFieldStyle(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20.0, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Item Picture",
                style: AppWidget.semiboldTextFieldStyle(),
              ),
              SizedBox(
                height: 20.0,
              ),
              selectedimage == null
                  ? GestureDetector(
                      onTap: () {
                        pickimage();
                      },
                      child: Center(
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Center(
                                child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            )),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Center(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.file(
                              selectedimage!,
                              fit: BoxFit.cover,
                            ),
                          )),
                        ),
                      ),
                    ),
              SizedBox(height: 30.0),
              Text(
                "Item Name",
                style: AppWidget.semiboldTextFieldStyle(),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: itemnamecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Name",
                      hintStyle: AppWidget.lightTextFieldStyle()),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Item Price",
                style: AppWidget.semiboldTextFieldStyle(),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: itempriceController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Price",
                      hintStyle: AppWidget.lightTextFieldStyle()),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Item Detail",
                style: AppWidget.semiboldTextFieldStyle(),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: 6,
                  controller: itemdetailcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Detail",
                      hintStyle: AppWidget.lightTextFieldStyle()),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Select Category",
                style: AppWidget.semiboldTextFieldStyle(),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    items: items.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black)),
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                    hint: Text("Select Category"),
                    iconSize: 36,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (newValue) {
                      setState(() {
                        value = newValue;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  uploadItem();
                },
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
