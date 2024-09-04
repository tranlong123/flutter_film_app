import 'package:flutter/widgets.dart';

class MovieScreen extends StatelessWidget {
  final int id;
  const MovieScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('id: $id'),);
  }
}