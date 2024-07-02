import 'package:flutter/material.dart';
import 'package:social_wallet/utils/app_colors.dart';

class NftItem extends StatefulWidget {


  Function() onClickNft;

  NftItem({
    super.key,
    required this.onClickNft,
  });

  @override
  _NftItemState createState() => _NftItemState();
}

class _NftItemState extends State<NftItem> with WidgetsBindingObserver {


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          widget.onClickNft();
        },
        child: Material(
            elevation: 3,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: AppColors.appBackgroundColor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                "assets/ic_default_nft.jpg",
                fit: BoxFit.fitWidth,
              ),
            )
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
