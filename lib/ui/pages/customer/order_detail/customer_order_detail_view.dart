/*
 
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persian_date/persian_date.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/models/order_models/order_model.dart';
import 'package:wahiddarbar/core/utilities/static_methods.dart';
import 'package:wahiddarbar/ui/helpers/utils.dart';

import 'customer_order_detail_viewmodel.dart';

class CustomerOrderDetailView extends StatelessWidget {
  const CustomerOrderDetailView({Key key, this.order}) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    var _controller = ScrollController();
    var pDate = PersianDate();
    var screenSize = SM.getSize(context);
    return ViewModelBuilder<CustomerOrderDetailViewModel>.reactive(
        builder: (context, viewModel, child) => Scaffold(
              appBar: AppBar(
                title: Text('orderDetail')
                    .tr(namedArgs: {'number': order.id.toString()}),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: ListBody(
                        children: [
                          ListTile(
                            leading: Text('orderNumber').tr(),
                            title: Text(
                              order.id.toString(),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Text('finalPrice').tr(),
                            title:
                                Text('money').plural(double.parse(order.total)),
                          ),
                          Divider(),
                          ListTile(
                            leading: Text('orderDate').tr(),
                            title: Text(
                              viewModel.convertedDate(
                                pDate.gregorianToJalali(
                                    order.dateCreated.toIso8601String(),
                                    'yyyy-MM-d'),
                              ),
                            ),
                          ),
                          Divider(),
                          ListView.builder(
                            itemCount: order.lineItems.length,
                            controller: _controller,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              var item = order.lineItems[index];
                              return ListTile(
                                title: Text(
                                  item.name +
                                      ' ' +
                                      'count'.tr() +
                                      item.quantity.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Text('address').tr(),
                            title: Text(
                              order.shipping.addressOne,
                            ),
                          ),
                          Divider(),
                          Utils.createSizedBox(height: screenSize.height * .1),
                        ],
                      ),
                    ),
                  ],
                  fit: StackFit.expand,
                ),
              ),
            ),
        viewModelBuilder: () => CustomerOrderDetailViewModel());
  }
}
