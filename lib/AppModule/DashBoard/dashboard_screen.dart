import 'package:blog_app/AppModule/DashBoard/Controller/data_list_provider.dart';
import 'package:blog_app/AppModule/HomeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Posts/posts_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var auth = FirebaseAuth.instance;
    var providerDash = Provider.of<DataListProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          backgroundColor: Colors.deepOrange,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                providerDash.searchController.clear();
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PostsScreen()));
              },
            ),
            //logout button
            const SizedBox(
              width: 10,
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                providerDash.searchController.clear();
                auth.signOut().then((value) => {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()))
                    });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<DataListProvider>(builder: (context, provider, _) {
            return Column(
              children: [
                TextFormField(
                  controller: provider.searchController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.deepOrange,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    hintText: 'Search any blog',
                    labelStyle: TextStyle(color: Colors.deepOrange),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.deepOrange,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                  ),
                  onChanged: (value) {
                    provider.search = value;
                  },
                ),
                Expanded(
                    child: FirebaseAnimatedList(
                  query: provider.ref.child('Post List'),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    //storing the data in a variable
                    String tempTitle = '${snapshot.child('pTitle').value}';
                    if (provider.searchController.text.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'images/loading4.gif',
                                    //placeholderFit: BoxFit.cover,
                                    placeholderScale: 0.5,
                                    image: '${snapshot.child('pImage').value}',
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  '${snapshot.child('pTitle').value}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 16, bottom: 16),
                                child: Text(
                                  '${snapshot.child('pDescription').value}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                    } else if (tempTitle
                        .toLowerCase()
                        .contains(provider.searchController.text)) {
                      //search is here
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'images/loading4.gif',
                                    //placeholderFit: BoxFit.cover,
                                    placeholderScale: 0.5,
                                    image: '${snapshot.child('pImage').value}',
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  '${snapshot.child('pTitle').value}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 16),
                                child: Text(
                                  '${snapshot.child('pDescription').value}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                )),
              ],
            );
          }),
        ));
  }
}
