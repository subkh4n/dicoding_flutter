// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:submis_f2/data/model/customer_review.dart';
import 'package:submis_f2/screen/detail/bloc/detail_bloc.dart';
import 'package:submis_f2/utils/resource/rescolor.dart';

class ReviewSheet extends StatefulWidget {
  final List<CustomerReview>? customerReviews;
  final DetailCubit detailCubit;

  const ReviewSheet({
    Key? key,
    this.customerReviews,
    required this.detailCubit,
  }) : super(key: key);

  @override
  _ReviewSheetState createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _review = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        builder: (context, controller) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              controller: controller,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Review",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // ignore: avoid_unnecessary_containers
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.customerReviews?[index].name ?? '-'} • ${widget.customerReviews?[index].date ?? '-'}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.customerReviews?[index].review ?? "-",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.withOpacity(0.8),
                        thickness: 1,
                      ),
                      itemCount: widget.customerReviews?.length ?? 0,
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: 280,
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: ResColor.blue,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Add Review",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            controller: _name,
                            cursorColor: ResColor.blue,
                            decoration: const InputDecoration(
                              labelText: "Name",
                            ),
                          ),
                          TextField(
                            maxLines: 3,
                            controller: _review,
                            cursorColor: ResColor.blue,
                            decoration: const InputDecoration(
                              labelText: "Review",
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              if (_name.text.isNotEmpty &&
                                  _review.text.isNotEmpty) {
                                widget.detailCubit
                                    .addReview(_name.text, _review.text);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "Add",
                              style: TextStyle(
                                  color: ResColor.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
