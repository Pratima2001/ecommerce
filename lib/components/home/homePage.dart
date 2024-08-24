import 'package:cached_network_image/cached_network_image.dart';

import 'package:ecommerce1/commonwidget/Loader.dart';
import 'package:ecommerce1/commonwidget/allWidgets.dart';
import 'package:ecommerce1/commonwidget/productWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banner_carousel/banner_carousel.dart';

import '../../services/services.dart';
import '../products/subpage.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final iconList = <IconData>[
    Icons.home,
    Icons.search,
    Icons.card_travel,
    Icons.person,
  ];
  List banners = [
    'https://firebasestorage.googleapis.com/v0/b/ecommerce-c93b3.appspot.com/o/banners%2Ffurniture.jpg?alt=media&token=ebc5f890-76ef-43be-9033-e36918d65eee',
    'https://firebasestorage.googleapis.com/v0/b/ecommerce-c93b3.appspot.com/o/banners%2Ffurniture1.jpg?alt=media&token=0f9d80c7-7050-4219-bda1-adfc0c2e4d69',
    'https://firebasestorage.googleapis.com/v0/b/ecommerce-c93b3.appspot.com/o/banners%2Ffurniture3.jpg?alt=media&token=31d798ee-9b26-4dc9-be0f-9002080f315f',
    'https://firebasestorage.googleapis.com/v0/b/ecommerce-c93b3.appspot.com/o/banners%2Ffurniture4.jpg?alt=media&token=db25a06c-6d9c-4444-b35a-ee4e081a1c45'
  ];
  List collections = [
    "https://firebasestorage.googleapis.com/v0/b/ecommerce-c93b3.appspot.com/o/topcollections%2Fbanner%201.png?alt=media&token=201f00f8-a00c-49d8-bc6e-c33b0924ad43",
    "https://firebasestorage.googleapis.com/v0/b/ecommerce-c93b3.appspot.com/o/topcollections%2Fbanner%202.png?alt=media&token=a6550cc8-3d2c-48b3-8332-f1e232f149b7",
    "https://firebasestorage.googleapis.com/v0/b/ecommerce-c93b3.appspot.com/o/topcollections%2FFrame%2033170.png?alt=media&token=3908a270-3da3-4692-854f-9dd7c9b90252"
  ];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await getallCategories();
  }

  int selectedIndex = 0;
  final int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final listAAsyncValue = ref.watch(listAProvider);
    final productAsyncValue = ref.watch(futureProducts);
    final recommendedProducts = ref.watch(recommandedProducts);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          centerTitle: true,
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          flexibleSpace: const Padding(
            padding: EdgeInsets.only(left: 30.0, top: 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.sort),
            ),
          ),
          title: Text(
            "Gemstore",
            style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              listAAsyncValue.when(
                data: (items) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 80,
                  child: ListView.builder(
                      itemCount: items.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchProducts(
                                      category: items[index],
                                      showAllProducts: false,
                                    )));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              items[index].image)),
                                      color: const Color(0xff9D9D9D)
                                          .withOpacity(0.5),
                                      shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  items[index].name,
                                  style: GoogleFonts.aBeeZee(),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                loading: () => Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return categoriesLoader(context);
                      }),
                ),
                error: (err, stack) => Text('Error: $err'),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BannerCarousel(
                      customizedBanners: List.generate(4, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(banners[index]),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                      customizedIndicators: const IndicatorModel.animation(
                          width: 20,
                          height: 5,
                          spaceBetween: 2,
                          widthAnimation: 50),
                      height: 150,
                      spaceBetween: 10,
                      activeColor: Colors.white,
                      disableColor: Colors.white,
                      animation: true,
                      width: MediaQuery.of(context).size.width,
                      borderRadius: 50,
                      indicatorBottom: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Featured Products",
                            style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchProducts(
                                              showFeatured: true,
                                            )));
                              },
                              child: const Text("Show all"))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      height: 240,
                      width: double.infinity,
                      child: productAsyncValue.when(
                        data: (products) => ListView.builder(
                            shrinkWrap: true,
                            itemCount: products.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 150,
                                margin: const EdgeInsets.only(right: 10),
                                child: ProductWidget(
                                  product: products[index],
                                  showLike: false,
                                  showRating: false,
                                  similarProWidegt: true,
                                ),
                              );
                            }),
                        loading: () => Container(
                            child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        )),
                        error: (err, stack) => Text('Error: $err'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: const Color(0xffF8F8FA),
                      width: double.infinity,
                      height: 120,
                      child: CachedNetworkImage(
                        width: double.infinity,
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/ecommerce-c93b3.appspot.com/o/banners%2Fbanner.png?alt=media&token=60977f6f-e224-440c-96e0-cb5275370310",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recommended Products",
                            style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchProducts(
                                              showRecommended: true,
                                            )));
                              },
                              child: const Text("Show all"))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      height: 90,
                      child: recommendedProducts.when(
                        data: (items) => ListView.builder(
                            itemCount: items.length > 5 ? 5 : items.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return recommenedProductWidget(
                                  items[index], context);
                            }),
                        loading: () => const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ),
                        error: (err, stack) => Text('Error: $err'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Collection",
                            style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text("Show all"))
                        ],
                      ),
                    ),
                    ListView.builder(
                        itemCount: collections.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                imageUrl: collections[index]),
                          );
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up resources here
    print('StateNotifier disposed');
    super.dispose();
  }
}

// AnimatedBottomNavigationBar.builder(
//           itemCount: iconList.length,
//           tabBuilder: (int index, bool isActive) {
//             return Icon(
//               iconList[index],
//               size: 24,
//             );
//           },
//           activeIndex: _bottomNavIndex,
//           gapLocation: GapLocation.center,
//           notchSmoothness: NotchSmoothness.verySmoothEdge,
//           leftCornerRadius: 32,
//           rightCornerRadius: 32,
//           onTap: (index) => setState(() => _bottomNavIndex = index),
//           //other params
//         ),