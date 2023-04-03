import 'package:cinechooser/pages/choix.dart';
import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:cinechooser/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
String paysSelectionne = 'Choisissez votre pays ...';
List<String> selectedItems = [];

class ReglagesFirstTime extends StatefulWidget {

  const ReglagesFirstTime({Key? key}) : super(key: key);

  @override
  State<ReglagesFirstTime> createState() => _ReglagesFirstTimeState();
}

bool isButtonPressed = false;

class _ReglagesFirstTimeState extends State<ReglagesFirstTime> {

  dynamic dropdownvalues;

  List<String> pays = [
    'Canada',
    'États-unis',
    'France',
    'Australie',
    'Japon',
    'Austria',
    'Belgium',
    'Bulgaria',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Estonia',
    'Finland',
    'Germany',
    'Greece',
    'Hungary',
    'Ireland',
    'Italy',
    'Latvia',
    'Lithuania',
    'Luxembourg',
    'Malta',
    'Netherlands',
    'Poland',
    'Portugal',
    'Romania',
    'Slovakia',
    'Slovenia',
    'Spain',
    'Sweden,United Kingdom'
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Initialiser les paramètres de votre compte',
            style: Styles.entete),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Choix()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding:  EdgeInsets.all(width/15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: height / 25),
              const Text('Votre pays :', style: Styles.petittitres),
              Divider(height: height / 40),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton(
                        borderRadius: BorderRadius.circular(7),
                        hint:  Text(paysSelectionne,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black87)),
                        value: dropdownvalues,
                        dropdownColor: Colors.white,
                        elevation: 0,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.transparent,
                        ),
                        items: pays
                            .map((dynamic value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.black87)),
                                ))
                            .toList(),
                        onChanged: (newItem) {
                          setState(() {
                            paysSelectionne = newItem.toString();
                            dropdownvalues = newItem!;
                          });
                        }),
                  ),
                ),
              ),
              Divider(height: height / 20),
              const Text('Vos platformes de streaming :',
                  style: Styles.petittitres),
              Divider(height: height / 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text('Platformes selectionnées : ',
                      style: Styles.informations),
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
                  child: const Text(
                      'selectionner vos platformes de streaming ...',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.black87))),
              Divider(height: height / 25),
              Center(
                  child: GestureDetector(
                onTap: () {
                  if (isButtonPressed == false) {
                    isButtonPressed = true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PagePrincipale()),
                    );
                  }
                  isButtonPressed = false;
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Styles.bgColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isButtonPressed
                          ? [
                              //aucune ombre
                            ]
                          : [
                              const BoxShadow(
                                color: Color(0xff1C1825),
                                offset: Offset(4, 4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                              const BoxShadow(
                                color: Color(0xff1C1825),
                                offset: Offset(-4, -4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              )
                            ]),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 8,
                        ),
                        Text('Commencer', style: Styles.bouton),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _showMultiSelect() async {
    final List<String> items = [
      'Netflix',
      'Disney+',
      'PrimeVideo',
      'Crave3',
      'Netfli23',
      'Disney3+',
      'Prim2eVideo',
      'C4rave'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );

    if (results != null) {
      setState(() {
        selectedItems = results;
      });
    }
  }
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
      title: const Text('selectionner vos platformes de streaming',
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
          child: const Text('Confirmer', style: TextStyle(color: Colors.black)),
        )
      ],
    );
  }
}