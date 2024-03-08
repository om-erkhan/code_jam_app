import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_jam_app/utils/snackbar_utils.dart';
import 'package:code_jam_app/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:code_jam_app/resources/basic_exports.dart';
import 'package:provider/provider.dart';
import 'package:code_jam_app/services/firebase_services.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices _firebaseServices = FirebaseServices();

    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundLinear),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          toolbarHeight: .1.sh,
          title: Text(
            "Restaurants",
            style: textStyles.titleLarge,
          ),
        ),
        body: FutureBuilder(
          future: _firebaseServices.getRestaurants(),
          builder: (context,
              AsyncSnapshot<List<DocumentSnapshot<Map<String, dynamic>>>>
                  snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              // Data is ready
              List<DocumentSnapshot<Map<String, dynamic>>> restaurants =
                  snapshot.data ?? [];
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.046.sw,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                              color: colors.onPrimaryContainer.withOpacity(
                                0.25,
                              ),
                            )
                          ]),
                      child: Consumer<HomeViewModel>(builder: (_, v, c) {
                        return TextFormField(
                          controller: v.controller,
                          onChanged: (val) => v.setValue(val),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: colors.secondary,
                            hintText: "Search Restaurant by name ...",
                            hintStyle: textStyles.labelLarge,
                            prefixIcon: Icon(
                              Icons.search,
                              color: colors.surface,
                            ),
                            suffixIcon: Container(
                                height: 20.h,
                                width: 20.w,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: colors.surface,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Icon(
                                  Icons.filter_list_sharp,
                                  color: colors.secondary,
                                )),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  50.h.verticalSpace,
                  Consumer<HomeViewModel>(builder: (_, v, c) {
                    return Expanded(
                      child: ListView.separated(
                          itemCount: restaurants.length,
                          separatorBuilder: (_, i) => 20.h.verticalSpace,
                          itemBuilder: (_, i) {
                            DocumentSnapshot<Map<String, dynamic>> restaurant =
                                restaurants[i];
                            String name = restaurant['name'] ?? '';

                            if (v.controller.text.isEmpty) {
                              return Container(
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(15.h),
                                        height: 182.h,
                                        width: 343.w,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  restaurant['image_url'])),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          color: colors.secondary,
                                        ),

                                        // child: Image.etwork("src"),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.h,
                                                      horizontal: 10.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    color: colors.primary,
                                                  ),
                                                  child: Row(children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: colors.secondary,
                                                      size: 12.sp,
                                                    ),
                                                    5.w.horizontalSpace,
                                                    Text(
                                                      '${restaurant['rating']}',
                                                      style: textStyles
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              color: colors
                                                                  .secondary),
                                                    )
                                                  ]),
                                                ),
                                                Icon(
                                                  Icons.bookmark_add_outlined,
                                                  color: colors.secondary,
                                                )
                                              ],
                                            ),
                                          ],
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(15.h),
                                        height: 100.h,
                                        width: 343.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                          color: colors.onPrimary,
                                        ),

                                        // child: Image.etwork("src"),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${restaurant['name']}-${restaurant['location']['city']}',
                                              style: textStyles.titleMedium,
                                            ),
                                            5.verticalSpace,
                                            Text(
                                              restaurant['category'].toString(),
                                              style: textStyles.titleSmall,
                                            ),
                                            5.verticalSpace,
                                            Row(
                                              children: [
                                                Icon(Icons.location_on,
                                                    size: 15.sp,
                                                    color: colors.onSecondary),
                                                Text(
                                                  restaurant['location']
                                                          ['street_address']
                                                      .toString(),
                                                  style: textStyles.bodyMedium,
                                                ),
                                                10.horizontalSpace,
                                                Icon(Icons.send_outlined,
                                                    size: 15.sp,
                                                    color: colors.onSecondary),
                                                Text(
                                                    restaurant['distance']
                                                        .toString(),
                                                    style:
                                                        textStyles.bodySmall),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              );
                            } else if (name
                                .toLowerCase()
                                .contains(v.controller.text.toLowerCase())) {
                              return Container(
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(15.h),
                                        height: 182.h,
                                        width: 343.w,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  restaurant['image_url'])),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          color: colors.secondary,
                                        ),

                                        // child: Image.etwork("src"),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.h,
                                                      horizontal: 10.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    color: colors.primary,
                                                  ),
                                                  child: Row(children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: colors.secondary,
                                                      size: 12.sp,
                                                    ),
                                                    5.w.horizontalSpace,
                                                    Text(
                                                      '${restaurant['rating']}',
                                                      style: textStyles
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              color: colors
                                                                  .secondary),
                                                    )
                                                  ]),
                                                ),
                                                Icon(
                                                  Icons.bookmark_add_outlined,
                                                  color: colors.secondary,
                                                )
                                              ],
                                            ),
                                          ],
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(15.h),
                                        height: 100.h,
                                        width: 343.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                          color: colors.onPrimary,
                                        ),

                                        // child: Image.etwork("src"),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${restaurant['name']}-${restaurant['location']['city']}',
                                              style: textStyles.titleMedium,
                                            ),
                                            5.verticalSpace,
                                            Text(
                                              restaurant['category'].toString(),
                                              style: textStyles.titleSmall,
                                            ),
                                            5.verticalSpace,
                                            Row(
                                              children: [
                                                Icon(Icons.location_on,
                                                    size: 15.sp,
                                                    color: colors.onSecondary),
                                                Text(
                                                  restaurant['location']
                                                          ['street_address']
                                                      .toString(),
                                                  style: textStyles.bodyMedium,
                                                ),
                                                10.horizontalSpace,
                                                Icon(Icons.send_outlined,
                                                    size: 15.sp,
                                                    color: colors.onSecondary),
                                                Text(
                                                    restaurant['distance']
                                                        .toString(),
                                                    style:
                                                        textStyles.bodySmall),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                            print(restaurant['rating']);
                          }),
                    );
                  })
                ],
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: IconButton(
            onPressed: () {
              SnackbarUtils.showSnackbar(
                  context, 'Functionality under progress!');
            },
            style: IconButton.styleFrom(
                backgroundColor: colors.primary,
                padding: EdgeInsets.all(15.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r))),
            icon: Icon(
              Icons.add,
              color: colors.secondary,
            )),
      ),
    );
  }
}
