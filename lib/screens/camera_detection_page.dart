import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraDetectionScreen extends StatefulWidget {
  const CameraDetectionScreen({super.key});

  @override
  State<CameraDetectionScreen> createState() => _CameraDetectionScreenState();
}

class _CameraDetectionScreenState extends State<CameraDetectionScreen> {
  late ImagePicker imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 50, bottom: 15, left: 5, right: 5),
      child: Column(
        children: [
          Card(
            // ignore: sort_child_properties_last
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: const Column(
                      // ignore: sort_child_properties_last
                      children: [
                        Icon(
                          Icons.scanner,
                          size: 25,
                          color: Colors.white,
                        ),
                        Text(
                          "Scan",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: const Column(
                      // ignore: sort_child_properties_last
                      children: [
                        Icon(
                          Icons.document_scanner,
                          size: 25,
                          color: Colors.white,
                        ),
                        Text(
                          "Recognize",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: const Column(
                      // ignore: sort_child_properties_last
                      children: [
                        Icon(
                          Icons.assignment_sharp,
                          size: 25,
                          color: Colors.white,
                        ),
                        Text(
                          "Enhance",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            color: Colors.blueAccent,
          ),

          // CAMERA
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                color: Colors.black,
                child:
                    Container(height: MediaQuery.of(context).size.height - 300),
              ),
            ],
          ),
          // END CAMERA

          Card(
            // ignore: sort_child_properties_last
            child: SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.rotate_left,
                      size: 35,
                      color: Colors.white,
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.camera,
                      size: 50,
                      color: Colors.white,
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.image_outlined,
                      size: 35,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      // ignore: unused_local_variable
                      XFile? xfile = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
