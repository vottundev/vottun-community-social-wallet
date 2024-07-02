import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:social_wallet/models/created_wallet_response.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';

import '../../../../utils/app_constants.dart';
import '../../../../utils/helpers/typedefs.dart';


class CreateWalletWebViewBottomDialog extends StatefulWidget {

  String username;
  String hash;
  Function(CreatedWalletResponse createdWalletResponse, int selectedStrategy) onCreatedWallet;

  CreateWalletWebViewBottomDialog({super.key, 
    required this.username,
    required this.hash,
    required this.onCreatedWallet
  });

  @override
  _CreateWalletWebViewBottomDialogState createState() => _CreateWalletWebViewBottomDialogState();
}

class _CreateWalletWebViewBottomDialogState extends State<CreateWalletWebViewBottomDialog>
    with WidgetsBindingObserver {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  AppRouter.pop();
                },
                child: Text(
                    "Close",
                    textAlign: TextAlign.end,
                    style: context.bodyTextMedium.copyWith(
                        fontSize: 20,
                        color: Colors.blue
                    )
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(AppConstants.getCreateWalletUrl(hash: widget.hash, username: widget.username))),
            initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true, // Use this if you encounter issues with AndroidView
                useWideViewPort: true,
                //  useOnDownloadStart: true,
              ),
              crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  useShouldInterceptAjaxRequest: true
              ),
            ),
            onWebViewCreated: (controller) {
              print(controller);
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            shouldInterceptAjaxRequest: (controller, ajaxRequest) {
              /*if (ajaxRequest.data != null) {
                var ajaxProperties = jsonDecode(ajaxRequest.data)["properties"];
                if (ajaxProperties != null) {
                  if (ajaxProperties["block_type"] != null) {
                    var blockType = ajaxProperties["block_type"];
                    if (ajaxProperties["response_id"] != null && blockType == "ending") {

                      String responseId = ajaxProperties["response_id"];
                      if(widget.onResponseIdCreated != null) {
                        widget.onResponseIdCreated!(responseId);
                      }
                    }
                  }
                }
              }*/
              return Future(() => ajaxRequest);
            },
            onAjaxReadyStateChange: (controller, ajaxRequest) async {
              if (ajaxRequest.responseText != null) {
                if (ajaxRequest.responseText!.isNotEmpty) {
                  Map<String, dynamic> decodedJson = jsonDecode(ajaxRequest.responseText!) as JSON;
                  if (decodedJson["accountAddress"] != null && ajaxRequest.readyState == AjaxRequestReadyState.DONE) {
                    CreatedWalletResponse createdWalletResponse = CreatedWalletResponse.fromJson(decodedJson);
                    int strategy = int.parse(ajaxRequest.responseURL?.queryParameters["strategy"] ?? "0");
                    widget.onCreatedWallet(createdWalletResponse, strategy);
                    AppRouter.pop();
                    return AjaxRequestAction.ABORT;
                  }
                }
              }
              return AjaxRequestAction.PROCEED;
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}
