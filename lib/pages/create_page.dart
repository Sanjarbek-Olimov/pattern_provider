import 'package:flutter/material.dart';
import 'package:pattern_provider/view_model/create_view_model.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {
  static const String id = "create_page";

  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  CreateView createView = CreateView();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => createView,
      child: Consumer<CreateView>(
          builder: (context, model, index) => Scaffold(
                appBar: AppBar(
                  title: const Text("Create post"),
                  centerTitle: true,
                  actions: [
                    TextButton(
                        onPressed: () {
                          createView.saveAndExit(context);
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
                              controller: createView.titleController,
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
                              controller: createView.bodyController,
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
                    createView.isLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : Container(),
                  ],
                ),
              )),
    );
  }
}
