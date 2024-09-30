import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/themes/colors.dart';
import 'package:to_do_app/core/themes/font_weight_helper.dart';
import 'package:to_do_app/core/themes/styles.dart';
import 'package:to_do_app/models/todo_model.dart';

class ToDoContainer extends StatelessWidget {
  const ToDoContainer({
    super.key,
    required this.index,
    required this.value,
    required this.onChanged,
    required this.todos, // تمرير قائمة المهام هنا
  });

  final int index;
  final bool? value;
  final Function(bool?) onChanged;
  final List<ToDoModel> todos; // تعريف قائمة المهام

  @override
  Widget build(BuildContext context) {
    // التحقق من أن الفهرس ضمن النطاق الصحيح للقائمة
    if (index < 0 || index >= todos.length) {
      return const SizedBox(); // إرجاع عنصر فارغ إذا كان الفهرس غير صحيح
    }

    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        margin: EdgeInsets.symmetric(
          vertical: 10.sp,
        ),
        width: 327.w,
        height: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: index % 2 == 0
              ? ColorsManager.coralPink
              : ColorsManager.peachPink,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todos[index].title, // الوصول إلى العنوان من القائمة
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: ColorsManager.mainWhite,
                decoration:
                    value! ? TextDecoration.lineThrough : TextDecoration.none,
              ),
              maxLines: 1,
            ),
            SizedBox(height: 8.h),
            Text(
              todos[index].description, // الوصول إلى الوصف من القائمة
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.regular,
                color: ColorsManager.mainWhite,
                height: 1.5.h,
                decoration:
                    value! ? TextDecoration.lineThrough : TextDecoration.none,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
            ),
            const Spacer(),
            Text(
              todos[index].date, // الوصول إلى التاريخ من القائمة
              style: TextStyleHelper.Montserratfont11WhiteRegular,
              maxLines: 1,
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
