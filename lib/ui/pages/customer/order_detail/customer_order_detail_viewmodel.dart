/*
 
 */

import 'package:wahiddarbar/core/utilities/base_logic_viewmodel.dart';

class CustomerOrderDetailViewModel extends BaseLogicViewModel {
  String convertedDate(String date) {
    print(date);
    if (date.contains('فروردین')) {
      date = date.replaceAll('فروردین', 'حمل');
    } else if (date.contains('تیر')) {
      date = date.replaceAll('تیر', 'سرطان');
    } else if (date.contains('مهر')) {
      date = date.replaceAll('مهر', 'میزان');
    } else if (date.contains('دی')) {
      date = date.replaceAll('دی', 'جدی');
    } else if (date.contains('اردیبهشت')) {
      date = date.replaceAll('اردیبهشت', 'ثور');
    } else if (date.contains('مرداد')) {
      date = date.replaceAll('مرداد', 'اسد');
    } else if (date.contains('آبان')) {
      date = date.replaceAll('آبان', 'عقرب');
    } else if (date.contains('بهمن')) {
      date = date.replaceAll('بهمن', 'دلو');
    } else if (date.contains('خرداد')) {
      date = date.replaceAll('خرداد', 'جوزا');
    } else if (date.contains('شهریور')) {
      date = date.replaceAll('شهریور', 'سنبله');
    } else if (date.contains('آذر')) {
      date = date.replaceAll('آذر', 'قوس');
    } else if (date.contains('اسفند')) {
      date = date.replaceAll('اسفند', 'حوت');
    }
    return date;
  }
}
