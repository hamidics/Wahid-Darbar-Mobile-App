/*
 
 */

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:persian_date/persian_date.dart';
import 'package:stacked/stacked.dart';
import 'package:wahiddarbar/core/models/order_models/order_model.dart';
import 'package:wahiddarbar/ui/helpers/colors.dart';
import 'package:wahiddarbar/ui/pages/order/finalize/cart_finalize_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';

class CartFinalizeView extends StatelessWidget {
  const CartFinalizeView({Key key, this.order}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    PersianDate pDate = PersianDate();
    return WillPopScope(
      onWillPop: () async => false,
      child: ViewModelBuilder<CartFinalizeViewModel>.reactive(
          builder: (context, viewModel, child) => Scaffold(
                appBar: AppBar(
                  title: Text('confirmOrder').tr(),
                ),
                body: SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: ListBody(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DottedBorder(
                                color: ThemeColors.Fb,
                                radius: Radius.circular(0),
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                child: ListTile(
                                  title: Text(
                                    'متشکریم، سفارش شما دریافت شد.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Text('شماره سفارش : '),
                              title: Text(
                                order.id.toString(),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Text('ایمیل : '),
                              title: Text(
                                order.billing.email,
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Text('قیمت نهایی : '),
                              title: Text(
                                order.total + ' افغانی',
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Text('تاریخ : '),
                              title: Text(
                                viewModel.convertedDate(
                                  pDate.gregorianToJalali(
                                      order.dateCreated.toIso8601String(),
                                      'yyyy-MM-d'),
                                ),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Text('روش پرداخت : '),
                              title: Text(
                                order.paymentMethodTitle,
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
                                        ' تعداد ' +
                                        item.quantity.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                            ),
                            Divider(),
                            ListTile(
                              leading: Text('به نام : '),
                              title: Text(
                                order.billing.firstName +
                                    ' ' +
                                    order.billing.lastName,
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Text('به آدرس : '),
                              title: Text(
                                order.shipping.city +
                                    ' - ' +
                                    order.shipping.addressOne,
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Text('شماره موبایل : '),
                              title: Text(
                                order.billing.phone,
                              ),
                            ),
                            Divider(),
                            ListTile(
                              title: Container(
                                width: double.infinity,
                                child: FlatButton(
                                  child: Text('بازگشت'),
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(16),
                                  onPressed: () => viewModel.goToHome(),
                                  color: ThemeColors.Fb,
                                ),
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ],
                    fit: StackFit.expand,
                  ),
                ),
              ),
          viewModelBuilder: () => CartFinalizeViewModel()),
    );
  }
}
