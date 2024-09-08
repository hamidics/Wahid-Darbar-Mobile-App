/*
 
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persian_date/persian_date.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/models/order_models/order_model.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';
import 'package:wahiddarbar/ui/pages/customer/order_list/customer_order_list_viewmodel.dart';
import 'package:wahiddarbar/ui/widgets/busy_overlay.dart';

class CustomerOrderListView extends StatelessWidget {
  const CustomerOrderListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = SM.getSize(context);
    return ViewModelBuilder<CustomerOrderListViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('orderList').tr(),
        ),
        body: SafeArea(
          child: BusyOverlay(
            show: viewModel.isBusy,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: ListBody(
                    children: [
                      ListView.builder(
                        itemCount: viewModel.orders.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var item = viewModel.orders[index];
                          return _OrderItem(
                              order: item, screenSize: screenSize);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CustomerOrderListViewModel(),
    );
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem({
    Key key,
    @required this.order,
    @required this.screenSize,
  }) : super(key: key);

  final OrderModel order;
  final Size screenSize;

  String convertedDate(String date) {
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

  @override
  Widget build(BuildContext context) {
    PersianDate pDate = PersianDate();
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => _OrderDetailBottomSheet(
            screenSize: screenSize,
            order: order,
            pDate: convertedDate(
              pDate.gregorianToJalali(
                  order.dateCreated.toIso8601String(), 'yyyy-MM-d'),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[200],
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    FittedBox(
                      child: Text(
                        'orderDetail',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ).tr(namedArgs: {'number': order.id.toString()}),
                    ),
                    Utils.createSizedBox(height: 8),
                    FittedBox(
                      child: Text(
                        'date',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ).tr(args: [
                        convertedDate(
                          pDate.gregorianToJalali(
                              order.dateCreated.toIso8601String(), 'yyyy-MM-d'),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: FittedBox(
                  child: Text(
                    'status',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ).tr(namedArgs: {'status': order.getStatusTitle()}),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderDetailBottomSheet extends StatelessWidget {
  const _OrderDetailBottomSheet({
    Key key,
    @required this.screenSize,
    @required this.order,
    @required this.pDate,
  }) : super(key: key);

  final Size screenSize;
  final OrderModel order;
  final String pDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * .5,
      color: Colors.amber,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: ScrollController(),
            child: ListBody(
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    leading: Text('orderNumber').tr(),
                    title: Text(
                      order.id.toString(),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    leading: Text('finalPrice').tr(),
                    title: Text('money').plural(double.parse(order.total)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    leading: Text('orderDate').tr(),
                    title: Text(
                      pDate,
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: order.lineItems.length,
                  controller: ScrollController(),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var item = order.lineItems[index];
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        title: Text(
                          item.name +
                              ' ' +
                              'count'.tr() +
                              item.quantity.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    leading: Text('address').tr(),
                    title: Text(
                      order.shipping.addressOne,
                    ),
                  ),
                ),
                Utils.createSizedBox(height: screenSize.height * .1),
              ],
            ),
          )
        ],
      ),
    );
  }
}
