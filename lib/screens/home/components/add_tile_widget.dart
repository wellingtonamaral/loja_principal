import 'package:flutter/material.dart';
import 'package:loja_principal/models/section.dart';
import 'package:loja_principal/models/section_item.dart';
import 'package:loja_principal/screens/edit_product/components/image_source_sheet.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class AddTileWidget extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();
    void onImageSelected(File file) {
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          //Utilizando somente para android
          showModalBottomSheet(
              context: context,
              builder: (_) => ImageSourceSheet(
                    onImageSelected: onImageSelected,
                  ));
        },
        child: Container(
          color: Colors.white.withAlpha(30),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
