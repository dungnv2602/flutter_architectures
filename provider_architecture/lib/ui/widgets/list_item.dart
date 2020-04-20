import 'package:flutter/material.dart';
import 'package:provider_architecture/provider/mock_posts_notifier.dart';

class ListItem extends StatelessWidget {
  final String title;

  const ListItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: title == mockLoadingIndicator
          ? Center(child: CircularProgressIndicator(strokeWidth: 2.5))
          : Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    color: Colors.grey[400],
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(title),
              alignment: Alignment.center,
            ),
    );
  }
}
