import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:app_name/Colors_Text_Components/appbar.dart';

final bool _kAutoConsume = Platform.isIOS || true;

const String _kSwing_tradingsub_subId = 'course1';
const String _kStockmarket_Basics_subId = 'course12';

const List<String> _kProductIds = <String>[
  _kSwing_tradingsub_subId,
  _kStockmarket_Basics_subId,
];

class InAppPage extends StatefulWidget {
  @override
  State<InAppPage> createState() => _InAppPageState();
}

class _InAppPageState extends State<InAppPage> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  // List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    super.initState();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
    initStoreInfo();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        // _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        // _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        // _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    // final List<String> consumables = await ConsumableStore.load();
    // setState(() {
    //   _isAvailable = isAvailable;
    //   _products = productDetailResponse.productDetails;
    //   _notFoundIds = productDetailResponse.notFoundIDs;
    //   _consumables = consumables;
    //   _purchasePending = false;
    //   _loading = false;
    // });
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = <Widget>[];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: <Widget>[
            _buildConnectionCheckTile(),
            _buildProductList(),
            // _buildConsumableBox(),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError!),
      ));
    }
    if (_purchasePending) {
      stack.add(
        const Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppbar(title: "Purchasing Page")),
      body: Stack(
        children: stack,
      ),
    );
  }

  Card _buildConnectionCheckTile() {
    if (_loading) {
      return const Card(child: ListTile(title: Text('Trying to connect...')));
    }
    final Widget storeHeader = ListTile(
      leading: Icon(_isAvailable ? Icons.check : Icons.block,
          color: _isAvailable
              ? Colors.green
              : ThemeData.light().colorScheme.error),
      title:
          Text('The store is ${_isAvailable ? 'available' : 'unavailable'}.'),
    );
    final List<Widget> children = <Widget>[storeHeader];

    if (!_isAvailable) {
      children.addAll(<Widget>[
        const Divider(),
        ListTile(
          title: Text('Not connected',
              style: TextStyle(color: ThemeData.light().colorScheme.error)),
          subtitle: const Text(
              'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
        ),
      ]);
    }
    return Card(child: Column(children: children));
  }

  Card _buildProductList() {
    if (_loading) {
      return const Card(
          child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...')));
    }
    if (!_isAvailable) {
      return const Card();
    }
    const ListTile productHeader = ListTile(title: Text('Products for Sale'));
    final List<ListTile> productList = <ListTile>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().colorScheme.error)),
          subtitle: const Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    final Map<String, PurchaseDetails> purchases =
        Map<String, PurchaseDetails>.fromEntries(
            _purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));

    productList.addAll(_products.map(
      (ProductDetails productDetails) {
        final PurchaseDetails? previousPurchase = purchases[productDetails.id];
        return ListTile(
          title: Text(
            productDetails.title,
          ),
          subtitle: Text(
            productDetails.description,
          ),
          trailing: previousPurchase != null && Platform.isIOS
              ? IconButton(
                  onPressed: () => confirmPriceChange(context),
                  icon: const Icon(Icons.upgrade))
              : TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    print("Pressed buy");
                    // Check and complete any pending purchases for the same product
                    if (previousPurchase != null &&
                        previousPurchase.status == PurchaseStatus.pending) {
                      print("Is pending and not null");
                      await _inAppPurchase.completePurchase(previousPurchase);
                    }

                    late PurchaseParam purchaseParam;

                    if (Platform.isAndroid) {
                      final GooglePlayPurchaseDetails? oldSubscription =
                          _getOldSubscription(productDetails, purchases);

                      purchaseParam = GooglePlayPurchaseParam(
                          productDetails: productDetails,
                          changeSubscriptionParam: (oldSubscription != null)
                              ? ChangeSubscriptionParam(
                                  oldPurchaseDetails: oldSubscription,
                                  prorationMode:
                                      ProrationMode.immediateWithTimeProration,
                                )
                              : null);
                    } else {
                      print("Purchase params done");
                      purchaseParam = PurchaseParam(
                        productDetails: productDetails,
                      );
                    }

                    print("Buying the non consumable");
                    _inAppPurchase.buyNonConsumable(
                        purchaseParam: purchaseParam);
                  },
                  child: Text(productDetails.price),
                ),
        );
      },
    ));

    return Card(
        child: Column(
      children: <Widget>[
        productHeader,
        const Divider(),
        ...productList,
      ],
    ));
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    GooglePlayPurchaseDetails? oldSubscription;
    if (productDetails.id == _kSwing_tradingsub_subId &&
        purchases[_kStockmarket_Basics_subId] != null) {
      oldSubscription =
          purchases[_kStockmarket_Basics_subId] as GooglePlayPurchaseDetails;
    } else if (productDetails.id == _kStockmarket_Basics_subId &&
        purchases[_kSwing_tradingsub_subId] != null) {
      oldSubscription =
          purchases[_kSwing_tradingsub_subId] as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }

  // Card _buildConsumableBox() {
  //   if (_loading) {
  //     return const Card(
  //         child: ListTile(
  //             leading: CircularProgressIndicator(),
  //             title: Text('Fetching consumables...')));
  //   }
  //   if (!_isAvailable || _notFoundIds.contains(_kStockmarket_Basics_subId)) {
  //     return Card();
  //   }
  //   final List<Widget> tokens = _consumables.map<Widget>((String id) {
  //     return GridTile(
  //       child: IconButton(
  //         icon: const Icon(
  //           Icons.stars,
  //           size: 42.0,
  //           color: Colors.orange,
  //         ),
  //         splashColor: Colors.yellowAccent,
  //         // onPressed: () => consume(id),
  //         onPressed: () {},
  //       ),
  //     );
  //   }).toList();
  //   return Card(
  //       child: Column(
  //     children: <Widget>[
  //       const ListTile(title: Text('Purchased consumables')),
  //       const Divider(),
  //       GridView.count(
  //         crossAxisCount: 5,
  //         shrinkWrap: true,
  //         padding: const EdgeInsets.all(16.0),
  //         children: tokens,
  //       )
  //     ],
  //   ));
  // }

  // Future<void> consume(String id) async {
  //   await ConsumableStore.consume(id);
  //   final List<String> consumables = await ConsumableStore.load();
  //   setState(() {
  //     _consumables = consumables;
  //   });
  // }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isAndroid) {
      return;
    }
    final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
        _inAppPurchase
            .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
    await iosPlatformAddition.showPriceConsentIfNeeded();
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  // void deliverProduct(PurchaseDetails purchaseDetails) async {
  //   print("Delivering the product");
  //   await ConsumableStore.save(purchaseDetails.purchaseID!);
  //   final List<String> consumables = await ConsumableStore.load();
  //   setState(() {
  //     _purchasePending = false;
  //     _purchases.add(purchaseDetails);
  //     _consumables = consumables;
  //   });
  // }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) {
    print("Purchase Verified");
    return Future<bool>.value(true);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      print("Purchase updated.." + purchaseDetails.status.toString());
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await verifyPurchase(purchaseDetails);
          if (valid) {
            // deliverProduct(purchaseDetails);
            print("Deliver the product");
          } else {
            handleError(IAPError(
              source: purchaseDetails.verificationData.source,
              code: '',
              message: 'Invalid Purchase',
            ));
          }
        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          setState(() {
            _purchasePending = false;
          });
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }
}
