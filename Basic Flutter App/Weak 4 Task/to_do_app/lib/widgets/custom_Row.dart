import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/themes/colors.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/todolist_shape.png',
          width: 25.w,
          height: 25.h,
        ),
        SizedBox(width: 10.w),
        Text(
          'List OF TODO',
          style: TextStyle(
            color: ColorsManager.peachPink,
            fontFamily: 'Montserrat',
            fontSize: 25.sp,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.filter_alt_outlined,
          color: ColorsManager.peachPink,
        ),
      ],
    );
  }
}
