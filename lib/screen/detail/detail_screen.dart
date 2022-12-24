// ignore_for_file: library_private_types_in_public_api, avoid_returning_null_for_void

import 'package:submis_f2/data/source/api/rest_client.dart';
import 'package:submis_f2/screen/detail/bloc/detail_bloc.dart';
import 'package:submis_f2/screen/detail/widget/menus_sheet.dart';
import 'package:submis_f2/screen/detail/widget/review_sheet.dart';
import 'package:submis_f2/utils/resource/rescolor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailScreen extends StatefulWidget {
  final RestClient client;
  final String id;
  const DetailScreen({Key? key, required this.client, required this.id})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailCubit _detailCubit;

  @override
  void initState() {
    super.initState();
    _detailCubit = DetailCubit(widget.id, widget.client);
    _detailCubit.loadDetail();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _detailCubit,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 70,
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: Colors.white,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        body: BlocConsumer<DetailCubit, DetailState>(
          listener: (context, state) {
            if (state.status == DetailStatus.error) {
              final snackBar = SnackBar(
                duration: const Duration(seconds: 3),
                backgroundColor: ResColor.blue,
                elevation: 1,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  state.message,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                action: SnackBarAction(
                  label: 'Ok',
                  textColor: Colors.white,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (BuildContext context, state) {
            if (state.status == DetailStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ResColor.blue,
                ),
              );
            } else if (state.status == DetailStatus.success) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Column(
                        children: [
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Hero(
                                    tag: state.data?.pictureId ?? "",
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(70),
                                          topLeft: Radius.circular(70),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                ResColor.blue.withOpacity(0.3),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                2.5), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(70),
                                          topRight: Radius.circular(70),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: state.data?.pictureId !=
                                                  null
                                              ? "https://restaurant-api.dicoding.dev/images/medium/${state.data?.pictureId}"
                                              : "",
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: CircularProgressIndicator(
                                                color: ResColor.blue,
                                              ),
                                            ),
                                          ),
                                          errorWidget:
                                              (context, object, stackTrace) =>
                                                  const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Card(
                                      elevation: 6,
                                      shadowColor: ResColor.blue,
                                      child: IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              backgroundColor: Colors.white,
                                              context: context,
                                              isScrollControlled: true,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              builder: (context) {
                                                return menuSheet(
                                                    state.data?.menus);
                                              });
                                        },
                                        iconSize: 25,
                                        icon: const Icon(
                                          Icons.restaurant_menu,
                                          color: ResColor.blue,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 30),
                                    Card(
                                      elevation: 6,
                                      shadowColor: ResColor.blue,
                                      child: IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              backgroundColor: Colors.white,
                                              context: context,
                                              isScrollControlled: true,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              builder: (context) {
                                                return ReviewSheet(
                                                    customerReviews: state
                                                        .data?.customerReviews,
                                                    detailCubit: _detailCubit);
                                              });
                                        },
                                        iconSize: 25,
                                        icon: const Icon(
                                          Icons.reviews,
                                          color: ResColor.blue,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 30),
                                    Card(
                                      elevation: 6,
                                      shadowColor: ResColor.blue,
                                      child: IconButton(
                                        onPressed: () {},
                                        iconSize: 25,
                                        icon: const Icon(
                                          Icons.bookmark_outline,
                                          color: ResColor.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.data?.name ?? "",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                state.data?.city ?? "",
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: ResColor.blue,
                                ),
                              ),
                            ],
                          ),
                          RatingBar.builder(
                            glowRadius: 0,
                            unratedColor: Colors.transparent,
                            initialRating: (state.data?.rating ?? 0),
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemSize: 16,
                            itemBuilder: (context, _) => const Text(
                              "⭐",
                              style: TextStyle(
                                fontSize: 5,
                              ),
                            ),
                            onRatingUpdate: (rating) => null,
                          ),
                          const SizedBox(height: 10),
                          SafeArea(
                            top: false,
                            child: Text(
                              state.data?.description ?? "",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: Image.asset("assets/empty.jpeg"));
          },
        ),
      ),
    );
  }
}
