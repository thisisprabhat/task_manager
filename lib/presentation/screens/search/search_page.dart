import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const String path = '/search';
  static const String routeName = 'Search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: TextField(
          autofocus: true,
          controller: _controller,
          onChanged: (val) {},
          decoration: InputDecoration(
              hintText: 'Search your tasks...',
              border: InputBorder.none,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(
                      () {},
                    );
                  },
                  icon: const Icon(Icons.close))),
        ),
      ),
      body: Container(),
    );
  }
}
