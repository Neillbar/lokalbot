import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lokalbot/shared/lokal_colors.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

class PhotoBottomSection extends StatefulWidget {
  Function(List<File>) submitImages;
  int? maxPhotos;
  PhotoBottomSection({Key? key, required this.submitImages, this.maxPhotos})
      : super(key: key);

  @override
  State<PhotoBottomSection> createState() => _PhotoBottomSectionState();
}

class _PhotoBottomSectionState extends State<PhotoBottomSection> {
  final picker = ImagePicker();
  ScrollController imageScrollController = ScrollController();
  List<File> imageArray = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(238, 238, 238, 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            topSection(context),
            Container(
              width: LokalVariables.screenWidth(context),
              height: 3,
              color: Colors.grey[300],
            ),
            bottomSection(context)
          ],
        ));
  }

  Widget topSection(context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          if (widget.maxPhotos == null ||
              widget.maxPhotos != null && imageArray.length < widget.maxPhotos!)
            Row(
              children: [
                Container(
                    decoration: const BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          getAndAddImage(ImageSource.camera);
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: const BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {
                          getAndAddImage(ImageSource.gallery);
                        },
                        icon: const Icon(
                          Icons.image,
                          color: Colors.white,
                        ))),
              ],
            ),
          const Spacer(),
          if (imageArray.isNotEmpty)
            SizedBox(
              height: LokalVariables.screenHeight(context) * 0.08,
              width: LokalVariables.screenWidth(context) * 0.3,
              child: TextButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.transparent))),
                    backgroundColor:
                        MaterialStateProperty.all(LokalColors.primaryColor)),
                onPressed: () {
                  widget.submitImages(imageArray);
                },
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          if (imageArray.isEmpty)
            Container(
              alignment: Alignment.centerRight,
              height: LokalVariables.screenHeight(context) * 0.08,
              width: LokalVariables.screenWidth(context) * 0.6,
              child: const Text(
                'Upload photos',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  Widget bottomSection(context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10, top: 10),
          width: LokalVariables.screenWidth(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Selected:",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 25,
                width: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: LokalColors.primaryColor),
                child: Text(
                  "${imageArray.length}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (widget.maxPhotos != null)
                Row(
                  children: [
                    const Text(
                      "/",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Text(
                        "${widget.maxPhotos ?? ''}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 200,
          child: ListView.separated(
            cacheExtent: 9999,
            addAutomaticKeepAlives: true,
            controller: imageScrollController,
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemCount: imageArray.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
              key: ValueKey(imageArray[index].path),
              // width: 250,
              alignment: Alignment.topRight,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.file(
                    imageArray[index],
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) =>
                            Center(
                      child: frame == 0
                          ? child
                          : CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  LokalColors.primaryColor),
                            ),
                    ),
                    fit: BoxFit.contain,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            height: 30,
                            margin: const EdgeInsets.only(top: 3, right: 3),
                            alignment: Alignment.center,
                            child: IconButton(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.zero,
                                iconSize: 25,
                                onPressed: () {
                                  setState(() {
                                    imageArray.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future getAndAddImage(ImageSource imageSource) async {
    if (imageSource == ImageSource.gallery) {
      List<XFile>? pickedImages = await picker.pickMultiImage(imageQuality: 25);

      if (pickedImages != null) {
        for (XFile image in pickedImages) {
          if (imageArray.length < (widget.maxPhotos ?? 0)) {
            var imageFile = File(image.path);
            imageArray.insert(0, imageFile);
          }
        }
      }
    } else if (imageSource == ImageSource.camera) {
      XFile? pickedImage =
          await picker.pickImage(source: imageSource, imageQuality: 25);
      if (pickedImage != null) {
        var imageFile = File(pickedImage.path);
        imageArray.insert(0, imageFile);
      }
    }
    setState(() {});
    return null;
  }
}
