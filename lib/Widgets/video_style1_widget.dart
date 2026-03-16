import 'package:sanad_2025/Models/home_model.dart';
import 'package:sanad_2025/Utilities/text_style_helper.dart';
import 'package:sanad_2025/Widgets/custom_network_image.dart';
import 'package:sanad_2025/Widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoStyle1Widget extends StatelessWidget {
  final VideoModel video;
  final double? width,height,radius;
  const VideoStyle1Widget({super.key, required this.video, this.width, this.height, this.radius});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=> VideoPlayerWidget(videoUrl: video.video))),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radius??18.r),
            child: CustomNetworkImage(url: video.image,
            width: width??350.w,height: height??135.h,fit: BoxFit.cover,
            radius: radius??18.r,),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius??18.r),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle,color: Colors.white,size: 38.r,),
                  if(video.title != null) SizedBox(height: 8.h,),
                  if(video.title != null) Text(video.title!,style: TextStyleHelper.of(context).s_18W600.copyWith(color: Colors.white),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
