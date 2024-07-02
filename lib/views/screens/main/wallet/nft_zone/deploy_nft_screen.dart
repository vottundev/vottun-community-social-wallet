import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/user_nfts_model.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/utils/app_constants.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/utils/helpers/form_validator.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/create_nft_cubit.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';
import 'package:social_wallet/views/widget/custom_text_field.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../widget/custom_button.dart';

class DeployNftScreen extends StatefulWidget {

  CreateNftCubit createNftCubit = getCreateNftCubit();
  ToggleStateCubit showImageStateCubit = getToggleStateCubit();

  DeployNftScreen({
    super.key,
  });

  @override
  _DeployNftScreenState createState() => _DeployNftScreenState();
}

class _DeployNftScreenState extends State<DeployNftScreen> with WidgetsBindingObserver {

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController symbolController = TextEditingController(text: '');
  TextEditingController aliasController = TextEditingController(text: '');
  int? selectedNetworkId;


  @override
  void initState() {
    super.initState();
  }

  //TODO PASS A BLOC
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNftCubit, CreateNftState>(
      bloc: widget.createNftCubit,
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ScrollShadow(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    List<UserNfTsModel> response = await widget.createNftCubit.getCreatedUserNfts();
                                    List<AlertDialogAction> actionList = List.empty(growable: true);

                                    if (response.isNotEmpty) {
                                      response.forEach((element) {
                                        actionList.add(
                                            AlertDialogAction(key: element, label: element.nftName)
                                        );
                                      });
                                      if (mounted) {
                                        dynamic result = await showConfirmationDialog(
                                            context: context,
                                            title: "Choose NFT",
                                            message: "Choose an NFT to deploy",
                                            initialSelectedActionKey: null,
                                            style: AdaptiveStyle.material,
                                            actions: actionList,
                                            builder: (context, child) {
                                              if (response.isNotEmpty) {
                                                return Dialog(
                                                  insetPadding: EdgeInsets.symmetric(
                                                    horizontal: ContextUtils(context).screenWidth * 0.05,
                                                    vertical: ContextUtils(context).screenHeight * 0.25,
                                                  ),

                                                  child: Material(
                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                    child: Container(
                                                      padding: const EdgeInsets.all(18.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text("Choose NFT", style: context.bodyTextMediumW500.copyWith(
                                                                      color: AppColors.textBlack,
                                                                      fontSize: 25
                                                                  ))
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("Choose an NFT to deploy", style: context.bodyTextMedium.copyWith(
                                                                      color: AppColors.textBlack,
                                                                      fontSize: 18
                                                                  ))
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Expanded(
                                                            child: SingleChildScrollView(
                                                              child: Column(
                                                                children: response.map((e) =>
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: CheckboxTheme(
                                                                              data: CheckboxThemeData(
                                                                                shape: CircleBorder(),
                                                                              ),
                                                                              child: CheckboxMenuButton(
                                                                                  value: (state.selectedUserNftModel?.id ?? 0) == e.id,
                                                                                  onChanged: (value) {
                                                                                    widget.createNftCubit.setSelectedUserNftModel(e);
                                                                                    AppRouter.pop();
                                                                                  },
                                                                                  child: Text(
                                                                                      e.nftName,
                                                                                      maxLines: 2,
                                                                                      style: context.bodyTextMedium.copyWith(
                                                                                          fontSize: 18, overflow: TextOverflow.ellipsis)
                                                                                  )
                                                                              )
                                                                          ),
                                                                        ),

                                                                      ],
                                                                    )
                                                                ).toList(),
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(child: TextButton(onPressed: () {
                                                                AppRouter.pop();
                                                              },
                                                                  child: Text("Cancel",
                                                                    style: context.bodyTextMedium.copyWith(fontSize: 20, color: Colors.red),))),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return child;
                                            }

                                        );


                                        print(result);
                                      }
                                    } else {
                                      if (mounted) {
                                        AppConstants.showToast(context, "ERC721 not found. Create one first please :)");
                                      }
                                    }
                                  },
                                  child: Text(
                                    (state.selectedUserNftModel != null ? ("${state.selectedUserNftModel?.nftName ?? " "}-${AppConstants.trimAddress(
                                        address: state.selectedUserNftModel?.contractAddress)}") : null) ?? "Select ERC721 Contract Address *",
                                    style: context.bodyTextMedium.copyWith(
                                        fontSize: 18,
                                        color: (state.selectedUserNftModel != null ? (state.selectedUserNftModel?.nftName != null
                                            ? Colors.green
                                            : AppColors.primaryColor) : null) ?? AppColors.primaryColor
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CustomTextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            validator: FormValidator.emptyValidator,
                            labelText: "Collection Name *",
                            labelStyle: context.bodyTextMedium.copyWith(fontSize: 16, color: AppColors.hintTexFieldGrey),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              Visibility(
                                  visible: state.selectedFile != null,
                                  child: BlocBuilder<ToggleStateCubit, ToggleStateState>(
                                    bloc: widget.showImageStateCubit,
                                    builder: (context, showImageState) {
                                      return Column(
                                        children: state.selectedFile?.map((e) =>
                                            !showImageState.isEnabled ? Row(
                                              children: [
                                                Expanded(child: Text(
                                                    e.name,
                                                  style: context.bodyTextMedium.copyWith(
                                                    fontSize: 18
                                                  ),
                                                )),
                                                IconButton(
                                                    icon: Icon(Icons.account_box_outlined),
                                                    color: Colors.green,
                                                  onPressed: () {
                                                    widget.showImageStateCubit.toggleState();
                                                  },
                                                )
                                              ],
                                            ) : Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.close, color: Colors.red),
                                                      color: Colors.green,
                                                      onPressed: () {
                                                        widget.showImageStateCubit.toggleState();
                                                      },
                                                    )
                                                  ],
                                                ),
                                                Image.file(
                                                  File(e.path ?? ''),
                                                  width: 200,
                                                  height: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              ],
                                            )
                                        ).toList() ?? [],
                                      );
                                    },
                                  )
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(onPressed: () async {
                                      await AppConstants.showFilePicker(
                                          allowMultiple: false,
                                          fileType: FileType.image,
                                          onFilesSelected: (selectedFiles) {
                                            widget.createNftCubit.setSelectedFile(selectedFiles ?? []);
                                          }
                                      );
                                    }, child: Text("Pick Files *", style: context.bodyTextMedium.copyWith(fontSize: 18, color: AppColors.primaryColor),)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            validator: FormValidator.emptyValidator,
                            labelText: "Description *",
                            maxLines: 2,
                            alignLabelWithHint: true,
                            labelStyle: context.bodyTextMedium.copyWith(fontSize: 16, color: AppColors.hintTexFieldGrey),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            validator: FormValidator.emptyValidator,
                            labelText: "Edition",
                            maxLines: 1,
                            alignLabelWithHint: true,
                            labelStyle: context.bodyTextMedium.copyWith(fontSize: 16, color: AppColors.hintTexFieldGrey),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            validator: FormValidator.emptyValidator,
                            labelText: "External Url",
                            maxLines: 1,
                            alignLabelWithHint: true,
                            labelStyle: context.bodyTextMedium.copyWith(fontSize: 16, color: AppColors.hintTexFieldGrey),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            validator: FormValidator.emptyValidator,
                            labelText: "Animation Url",
                            maxLines: 1,
                            alignLabelWithHint: true,
                            labelStyle: context.bodyTextMedium.copyWith(fontSize: 16, color: AppColors.hintTexFieldGrey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: Text(
                                        "Attributes",
                                        style: context.bodyTextMedium.copyWith(fontSize: 22),
                                      )),
                                  const Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.add, color: AppColors.primaryColor),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(radius: 10, buttonText: "Deploy", onTap: () {

                  }),
                )
              ],
            )
          ],
        );
      },
    );
  }



  @override
  void dispose() {
    super.dispose();
  }

// @override
// void didChangeAppLifecycleState(AppLifecycleState state) {
//   switch (state) {
//     case AppLifecycleState.resumed:
//       setState(() {
//       });
//       break;
//     case AppLifecycleState.inactive:
//       break;
//     case AppLifecycleState.paused:
//       break;
//     case AppLifecycleState.detached:
//       break;
//   }
// }
}
