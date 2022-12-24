// ignore_for_file: library_private_types_in_public_api

import 'package:submis_f2/data/source/api/rest_client.dart';
import 'package:submis_f2/screen/home/bloc/home_bloc.dart';
import 'package:submis_f2/screen/home/widget/item_home.dart';
import 'package:submis_f2/utils/resource/rescolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final RestClient client;
  const HomeScreen({Key? key, required this.client}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _homeCubit;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit(widget.client);
    _homeCubit.loadRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeCubit,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                child: const Text(
                  "Find\nYour favorite\nRestaurants!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: ResColor.blue,
                    // color: ResColor.green,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (query) {
                    _homeCubit.searchRestaurant(query);
                  },
                  decoration: InputDecoration(
                    hintText: "find restaurant",
                    filled: true,
                    suffixIcon: InkWell(
                      child: Icon(Icons.close, color: Colors.grey[500]),
                      onTap: () {
                        _searchController.clear();
                        _homeCubit.loadRestaurant();
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state.status == HomeStatus.error) {
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
                builder: (context, state) {
                  if (state.status == HomeStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ResColor.blue,
                      ),
                    );
                  } else if (state.status == HomeStatus.success) {
                    return Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "/detail",
                                arguments: {
                                  "rest": widget.client,
                                  "id": state.data.elementAt(index).id,
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 14 : 0,
                                right:
                                    index == (state.data.length - 1) ? 14 : 0,
                              ),
                              child: itemHome(state.data.elementAt(index)),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8),
                      ),
                    );
                  }
                  return Center(child: Image.asset("assets/empty.jpeg"));
                },
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
