import 'package:flutter/material.dart';
import 'package:pattern_provider/view_model/home_view_model.dart';
import 'package:pattern_provider/views/item_of_post.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
          create: (context) => viewModel,
          child: Consumer<HomeViewModel>(
            builder: (context, model, index) => Stack(
              children: [
                ListView.builder(
                  itemCount: viewModel.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return itemOfPosts(viewModel, index, context);
                  },
                ),
                viewModel.isLoading
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : Container(),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.goToCreate(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
