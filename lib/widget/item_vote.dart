import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';

class ItemVote extends StatefulWidget {
  final int voteCount;
  const ItemVote({super.key, required this.voteCount});

  @override
  State<ItemVote> createState() => _ItemVoteState();
}

class _ItemVoteState extends State<ItemVote> {
  late int _voteCount;
  bool isVote = false;
  @override
  void initState() {
    super.initState();
    _voteCount = widget.voteCount; // Khởi tạo _voteCount ở đây
  }

  void _toggleVote() {
    setState(() {
      isVote ? _voteCount-- : _voteCount++;
      isVote = !isVote;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return SizedBox(
      height: AppDimensions.sizedBox18,
      child: Row(
        children: [
          _buildHeartIcon(ontap: _toggleVote, isVote: isVote),
          SizedBox(
            width: AppDimensions.sizedBox44,
            height: AppDimensions.sizedBox18,
            child: Text(
              '$_voteCount',
              maxLines: 1, // Giới hạn chỉ hiển thị 1 dòng
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  height: 1.172,
                  fontSize: AppDimensions.fontSize15),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildHeartIcon({required void Function() ontap, required bool isVote}) {
  return GestureDetector(
    onTap: ontap,
    child: Icon(
      Icons.favorite,
      color: isVote ? heart : heart2,
      size: AppDimensions.heartSize,
    ),
  );
}
