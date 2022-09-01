import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/shared/models/comment.dart';

class CommentCard extends StatelessWidget {
  CommentCard(this.comment, {super.key});

  Comment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDB8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xF8EDE6E6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sandra Smith',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        (comment.description != null)
                            ? comment.description!
                            : 'description',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(12, 4, 0, 0),
            //   child: Text(
            //     'a min ago',
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
