
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../screem/voting_screems/create_private_poll.dart';
import '../../constants/asset_data.dart';
import '../../constants/color.dart';
import '../../constants/strings.dart';

class FlotingActionButon extends StatelessWidget {
  const FlotingActionButon({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
          animationAngle: pi/2,
          animatedIcon: AnimatedIcons.menu_close,
          spaceBetweenChildren: 12.0,
          spacing: 10.0,
          overlayOpacity: 0.4,
          children: [
            // Create public vote
            SpeedDialChild(
                child:Image.asset(AssetData.publicIcon,color: AppColors.blackColor,),
                label: StringData.createPublicPoll,
                onTap: (() {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const CreatePrivatePoll(isPrivate: false,)));
               
                }),
                backgroundColor: AppColors.backgroundColor),

            //Create private vote
            SpeedDialChild(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const CreatePrivatePoll(isPrivate: true,)));
                },
                child: Image.asset(AssetData.privateIcon,color: AppColors.blackColor,),
                label: StringData.createPrivatePoll,
                backgroundColor: AppColors.backgroundColor),
            
          ],
        );
  }
}