import 'package:flutter/material.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/generated/dynamique_button.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_simple_input.dart';

import '../../core/constants/color.dart';
import '../../core/constants/strings.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/dial_button.dart';
import '../../core/generated/widgets/polls_container.dart';

import '../../core/generated/widgets/utils/utils.dart';

class CreatePrivatePoll extends StatefulWidget {
  final bool isPrivate;
  const CreatePrivatePoll({super.key, required this.isPrivate});

  @override
  State<CreatePrivatePoll> createState() => _CreatePrivatePollState();
}

class _CreatePrivatePollState extends State<CreatePrivatePoll> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _optionController = TextEditingController();

  int optionCount = 3;
  // ignore: deprecated_member_use
  List<TextEditingController> controllers =
      []; //Pour contenir les controllers des champs de textes
  List<String> options = [];

  DateTime? startCurentDate = DateTime.now();
  DateTime? endCurentDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < optionCount; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: MyAppBar(
        leadingWidget: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.blueBgColor)),
      ),
      floatingActionButton: const FlotingActionButon(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: AppText(
                    widget.isPrivate
                        ? StringData.createPrivatePoll
                        : StringData.createPublicPoll,
                    color: AppColors.blueBgColor,
                    size: 20.0,
                    weight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                // Formulaire de creation
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Title field
                    AppText(
                      StringData.title,
                      color: AppColors.blueBgColor,
                      size: 12.0,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    AppSimpleInput(
                      textEditingController: _titleController,
                      hintText: StringData.writeYourStatement,
                      inputType: TextInputType.text,
                      validator: (value) {
                        return null;
                      },
                      hasSuffix: false,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),

                    //Description field
                    AppText(
                      StringData.description,
                      color: AppColors.blueBgColor,
                      size: 12.0,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    AppSimpleInput(
                      minLine: 4,
                      maxLine: 6,
                      textEditingController: _descriptionController,
                      hintText: StringData.writeYourStatement,
                      inputType: TextInputType.text,
                      validator: (value) {
                        return null;
                      },
                      hasSuffix: false,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),

                    //Start and End Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Start date
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              StringData.startDate,
                              color: AppColors.blueBgColor,
                              size: 12.0,
                              weight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              width: width * .4,
                              height: height * .05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: AppColors.greyBlackColor),
                                  color: AppColors.greySkyColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppText(
                                    UtilsFonction.formatDate(startCurentDate),
                                    color: AppColors.blackColor,
                                  ),
                                  IconButton(
                                      onPressed: _pickStartDate,
                                      icon: Icon(
                                        Icons.calendar_month,
                                        color: AppColors.blueBgColor,
                                        size: 20.0,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),

                        //end date
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              StringData.endDate,
                              color: AppColors.blueBgColor,
                              size: 12.0,
                              weight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              width: width * .4,
                              height: height * .05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: AppColors.greyBlackColor),
                                  color: AppColors.greySkyColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppText(
                                    UtilsFonction.formatDate(startCurentDate),
                                    color: AppColors.blackColor,
                                  ),
                                  IconButton(
                                      onPressed: _pickEndDate,
                                      icon: Icon(
                                        Icons.calendar_month,
                                        color: AppColors.blueBgColor,
                                        size: 20.0,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    AppText(
                      StringData.options,
                      color: AppColors.blueBgColor,
                      weight: FontWeight.bold,
                      size: 12.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),

                    //List des options
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: optionCount,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: AppSimpleInput(
                                    hasSufix: true,
                                    suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          optionCount--;
                                          controllers.removeAt(index);
                                        });
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.blueBgColor,
                                      ),
                                    ),
                                    hasSuffix: true,
                                    validator: (value) {
                                      return null;
                                    },
                                    hintText: StringData.point,
                                    textEditingController: controllers[index],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: AppColors.greySkyColor,
                                  ),
                                  child: IconButton(
                                    color: AppColors.greyColor,
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.lock_outline,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),

                    const SizedBox(
                      height: 16.0,
                    ),

                    //Button add Option
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (() {
                          setState(() {
                            optionCount++;
                            controllers.add(TextEditingController());
                          });
                        }),
                        child: Container(
                          width: 100.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: AppColors.backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    spreadRadius: 1.0,
                                    color: AppColors.blueBgColor,
                                    offset: const Offset(0, 1))
                              ]),
                          alignment: Alignment.center,
                          child: AppText(
                            StringData.addOption,
                            color: AppColors.blueBgColor,
                            size: 12.0,
                          ),
                        ),
                      ),
                    ),

                    // uploading list of voters
                    const SizedBox(
                      height: 14.0,
                    ),
                    widget.isPrivate
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: StringData.importListVoter,
                                  style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 12.0),
                                ),
                                TextSpan(
                                    text: '   ${StringData.excelFile}',
                                    style: TextStyle(
                                        color: AppColors.blueBgColor,
                                        fontSize: 12.0))
                              ])),
                              //  uUpload file
                              InkWell(
                                onTap: (() {}),
                                child: Card(
                                  shadowColor: AppColors.greyColor,
                                  elevation: 3.0,
                                  child: Image.asset(AssetData.dowload),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(
                            height: 12.0,
                          ),
                    const SizedBox(
                      height: 16.0,
                    ),

                    //Push Dynamique button
                    Center(
                        child: DynamiqueButton(
                            childs: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  StringData.vote,
                                  color: AppColors.backgroundColor,
                                  size: 12.0,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  AssetData.go,
                                  color: AppColors.backgroundColor,
                                )
                              ],
                            ),
                            width: 100,
                            height: 40,
                            action: () {},
                            bgColor: AppColors.blueBgColor,
                            radius: 10)),
                    const SizedBox(
                      height: 50.0,
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  Future<void> _pickStartDate() async {
    setState(() async {
      startCurentDate =
          await PollsWidgets.selectDate(context, startCurentDate!);
    });
  }

  Future<void> _pickEndDate() async {
    setState(() async {
      endCurentDate = await PollsWidgets.selectDate(context, endCurentDate!);
    });
  }
}
