import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinechooser/api/algorithm.dart';
import 'package:cinechooser/pages/friendList.dart';
import 'package:cinechooser/pages/login_page.dart';
import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:cinechooser/api/api.dart';
import 'package:cinechooser/utils/pays_nom.dart';
import 'package:cinechooser/utils/pays_iso.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import '../widget/textField.dart';
import 'auth_page.dart';

class Reglages extends StatefulWidget {
  const Reglages({Key? key}) : super(key: key);

  @override
  State<Reglages> createState() => _ReglagesState();
}

bool isButtonPressed = false;
final _addFriends = TextEditingController();

class _ReglagesState extends State<Reglages> {
  dynamic dropdownvalues;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    int index = listPaysNom.indexOf(paysSelectionne);
    if (index >= 0 && index < listPaysISO.length) {
      paysISO = listPaysISO[index];
      country = paysISO;
    }

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Set your account detail', style: Styles.entete),
        leading: IconButton(
          onPressed: () {
            trimDisplayedMovie();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PagePrincipale()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(width / 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: height / 40),
                Container(
                  height: height * 0.06,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownButton(
                          borderRadius: BorderRadius.circular(7),
                          hint: Text(
                            paysSelectionne,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          value: dropdownvalues,
                          dropdownColor: Colors.white,
                          elevation: 0,
                          icon: const Icon(
                            Icons.expand_more,
                            color: Colors.black,
                          ),
                          items: listPaysNom
                              .map((dynamic value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: Colors.black87,
                                        )),
                                  ))
                              .toList(),
                          onChanged: (newItem) async {
                            setState(() {
                              paysSelectionne = newItem.toString();

                              dropdownvalues = newItem!;
                            });
                            db.doc(docID).update({'pays': paysSelectionne});
                          }),
                    ),
                  ),
                ),
                Divider(height: height / 20),
                const Text('Streaming services :', style: Styles.petittitres),
                Divider(height: height / 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your services : ', style: Styles.informations),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          direction: Axis.horizontal,
                          children: selectedItems
                              .map((e) => Chip(label: Text(e)))
                              .toList()),
                    )
                  ],
                ),
                Divider(height: height / 40),
                ElevatedButton(
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.white,
                      ),
                    ),
                    onPressed: _showMultiSelect,
                    child: const Text('Choose your streaming services',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black87))),
                Divider(height: height / 25),
                MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthPage()),
                    );
                  },
                  color: Colors.red,
                  child: const Text('Sign out'),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FriendsList()),
                    );
                  },
                  color: Colors.red,
                  child: const Text('FriendsList'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _addFriends.dispose();
    super.dispose();
  }

  void _showMultiSelect() async {
    final List<String> items = [
      'Netflix',
      'Disney+',
      'PrimeVideo',
      'Apple TV Plus'
    ];

    results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );

    if (results != null) {
      setState(() {
        selectedItems = results!;
      });

      db.doc(docID).update({'providers': results!});
    }
  }
}

signOut() async {
  paysSelectionne = 'Country';
  paysISO = 'CA';
  selectedItems = [];
  results = [];
  listGenre = [];
  likedMoviesId = [];
  dislikedMoviesId = [];
  showedPoster = [];
  showedNames = [];
  friendCode = '';
  friendList = [];
  selectionne = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  borders = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  colors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ];
  likedMovies = [];
  dislikedMovies = [];
  hasData = ValueNotifier(false);
}

class MultiSelect extends StatefulWidget {
  final List<String> items;

  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedItems.add(itemValue);
      } else {
        selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose your streaming services',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Colors.black)),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    activeColor: Styles.red1,
                    value: selectedItems.contains(item),
                    title: Text(item,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black87)),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
            onPressed: _cancel,
            child: const Text('Cancel', style: TextStyle(color: Colors.black))),
        ElevatedButton(
          onPressed: _submit,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => Styles.red1,
            ),
          ),
          child: const Text('Continue', style: TextStyle(color: Colors.black)),
        )
      ],
    );
  }
}
