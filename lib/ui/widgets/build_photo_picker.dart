import 'package:flutter/material.dart';

class BuildPhotoPicker extends StatelessWidget {
  const BuildPhotoPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 55,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)
                )
            ),
            alignment: Alignment.center,
            child: Text("Photo", style: TextStyle(
                color: Colors.white,
                fontSize: 16
            ),),
          ),
          const SizedBox(width: 8,),
          Text("Selected Photo"),
        ],
      ),
    );
  }
}
