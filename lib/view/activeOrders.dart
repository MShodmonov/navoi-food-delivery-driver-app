import 'package:flutter/material.dart';
import 'package:some_flutter/models/OrderModel.dart';
import 'package:some_flutter/models/PageResponse.dart';
import 'package:some_flutter/service/requests.dart';

class ActiveOrders extends StatefulWidget {
  const ActiveOrders({super.key, required this.token});

  final String token;

  @override
  _ActiveOrders createState() => _ActiveOrders();
}

class _ActiveOrders extends State<ActiveOrders> {
  final ApiClient apiClient = ApiClient();
  late Future<PageResponse> futurePageResponse;
  bool loadOrder = true;

  @override
  Widget build(BuildContext context) {
    print("Child Updated");
    var body;
    if (widget.token != "" && loadOrder) {
      print("New data Loaded");
      futurePageResponse =
          apiClient.getActiveOrdersFutureBuilder(widget.token, 0, 10);
      body = Container(
        child: FutureBuilder<PageResponse>(
            future: futurePageResponse,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    Visibility(
                      visible: snapshot.hasData,
                      child: const Text(
                        "Loading over internet",
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error ${snapshot.error ?? ""}");
                } else if (snapshot.hasData) {
                  return Scrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    thickness: 8,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data?.content.length ?? 0,
                      itemBuilder: (BuildContext ctxt, int index) {
                        var order = snapshot.data?.content[index];
                        return Column(
                          children: [
                            Card(
                              shadowColor: Colors.blueGrey,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        " Buyurtma Raqami N: ${order!.getOrderId()}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(width: 10),
                                          const SizedBox(
                                            width: 10,
                                            child: Icon(Icons.shopping_cart),
                                          ),
                                          const SizedBox(width: 30),
                                          Expanded(
                                              child: Text(
                                            order.getRestaurantName(),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(width: 10),
                                          const SizedBox(
                                            width: 10,
                                            child: Icon(Icons.phone),
                                          ),
                                          const SizedBox(width: 30),
                                          Expanded(
                                              child: Text(
                                            order.getPhoneNumber(),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(width: 10),
                                          const SizedBox(
                                            width: 10,
                                            child: Icon(Icons.location_on),
                                          ),
                                          const SizedBox(width: 30),
                                          Expanded(
                                              child: Text(
                                            order.getAddress(),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(width: 10),
                                          const SizedBox(
                                            width: 10,
                                            child: Icon(Icons.car_rental),
                                          ),
                                          const SizedBox(width: 30),
                                          Expanded(
                                              child: Text(
                                            order.getDrivingInfo(),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(width: 10),
                                          const SizedBox(
                                            width: 10,
                                            child: Icon(
                                                Icons.monetization_on_outlined),
                                          ),
                                          const SizedBox(width: 30),
                                          const Text("Buyurtma narxi: "),
                                          Expanded(
                                              child: Text(
                                            order.getSum(),
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(width: 10),
                                          const SizedBox(
                                            width: 10,
                                            child: Icon(
                                                Icons.monetization_on_outlined),
                                          ),
                                          const SizedBox(width: 30),
                                          const Text("To`lov usuli: "),
                                          Expanded(
                                              child: Text(
                                            order.getPaymentMethod(),
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(width: 10),
                                          const SizedBox(
                                            width: 10,
                                            child: Icon(Icons.add_alert),
                                          ),
                                          const SizedBox(width: 30),
                                          const Text("Buyurtma holati:: "),
                                          Expanded(
                                              child: Text(
                                            order.getOrderStatus(),
                                            style: TextStyle(
                                              color: (order.getOrderStatus() ==
                                                      "TAYYOR")
                                                  ? Colors.red
                                                  : Colors.black,
                                              fontSize: 20,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                  getOrderAction(order)
                                ],
                              ),
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return const Text("Empty Body");
                }
              } else {
                return Text(
                    "Error with fututr builder: ${snapshot.connectionState}");
              }
            }),
      );
    } else {
      body = const Text('Active Orders Loading');
    }
    return Scaffold(
      body: Center(
        child: body,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  getActiveOrders() {
    apiClient.getActiveOrders(widget.token, 0, 10).then((response) {
      if (response.statusCode == 200) {
        PageResponse pageResponse = PageResponse.fromJson(response.body);
        print(pageResponse.toString());
      }
    }).catchError((error) {
      print(error);
    });
  }

  Row getOrderAction(OrderModel order) {
    if (order.getStatus() == "CREATED" ||
        order.getStatus() == "PENDING" ||
        order.getStatus() == "ACCEPTED" ||
        order.getStatus() == "PREPARING" ||
        order.getStatus() == "READY_TO_DELIVER") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.redAccent)),
            child: const Text(
              'Bekor qilish',
              style: TextStyle(color: Colors.redAccent),
            ),
            onPressed: () {
              /* ... */
            },
          ),
          const SizedBox(width: 80),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue)),
            child: const Text(
              'Qabul Qilish',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              /* ... */
            },
          ),
          const SizedBox(width: 8),
        ],
      );
    } else if (order.getStatus() == "ON_THE_WAY") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          OutlinedButton(
            child: const Text(
              'Yetkazib berdim',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              /* ... */
            },
          ),
          const SizedBox(width: 8),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text("-------Bu Buyurtma endi tarix--------")],
      );
    }
  }

  acceptOrder(int orderId){

  }
}
