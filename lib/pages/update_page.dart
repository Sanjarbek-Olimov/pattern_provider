import 'package:flutter/material.dart';
import 'package:pattern_provider/model/post_model.dart';
import 'package:pattern_provider/view_model/update_view_model.dart';
import 'package:provider/provider.dart';

class UpdatePage extends StatefulWidget {
  static const String id = "update_page";
  Post post;

  UpdatePage({Key? key, required this.post}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  UpdateView updateView = UpdateView();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateView.post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => updateView,
      child: Consumer<UpdateView>(
          builder: (context, model, index) => Scaffold(
                appBar: AppBar(
                  title: const Text("Update post"),
                  centerTitle: true,
                  actions: [
                    TextButton(
                        onPressed: () {
                          updateView.saveAndExit(context);
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ))
                  ],
                ),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              controller: updateView.titleController..text =updateView.post.title!,
                              maxLines: null,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, top: 10),
                                  hintText: "Title"),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: updateView.bodyController..text = updateView.post.body!,
                              maxLines: null,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: "Body",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    updateView.isLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : Container(),
                  ],
                ),
              )),
    );
  }
}
