import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDetiles extends StatefulWidget {
  const HomeDetiles({super.key});

  @override
  State<HomeDetiles> createState() => _HomeDetilesState();
}

class _HomeDetilesState extends State<HomeDetiles> {
  List<String> titles = [];
  List<String> descriptions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      titles = prefs.getStringList('titles') ?? [];
      descriptions = prefs.getStringList('descriptions') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: titles.isEmpty
            ? const Center(
                child: Text(
                  'No Notes Found',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.white54,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        title: Text(
                          titles[index],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 24),
                        ),
                        subtitle: Text(
                          descriptions[index],
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            setState(() {
                              titles.removeAt(index);
                              descriptions.removeAt(index);
                              prefs.setStringList('titles', titles);
                              prefs.setStringList('descriptions', descriptions);
                            });
                          },
                        ),
                      ));
                },
              ),
      ),
    );
  }
}
