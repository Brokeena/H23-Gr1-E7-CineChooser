import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';

class Reglages extends StatefulWidget {
  const Reglages({Key? key}) : super(key: key);

  @override
  State<Reglages> createState() => _ReglagesState();
}

class _ReglagesState extends State<Reglages> {
  List<String> _selectedItems = [];
  dynamic dropdownvalues;
  List<String> pays = [
    'Canada','États-unis','France','Australie','Japon','Austria','Belgium','Bulgaria','Cyprus','Czech Republic','Denmark','Estonia','Finland','Germany','Greece','Hungary','Ireland','Italy','Latvia','Lithuania','Luxembourg','Malta','Netherlands','Poland','Portugal','Romania','Slovakia','Slovenia','Spain','Sweden,United Kingdom'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Reglages de votre compte', style: Styles.entete),
        leading: IconButton(
          onPressed: () {
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
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(height: 25),
              const Text('Vos platformes de streaming :', style: Styles.petittitres),
              const Divider(height: 15),
              Row(
                children: [
                  const Text('Platformes selectionnées : ',
                      style: Styles.informations),
                  Wrap(
                      spacing: 5,
                      direction: Axis.horizontal,
                      children: _selectedItems
                          .map((e) => Chip(label: Text(e)))
                          .toList())
                ],
              ),
              const Divider(height: 15),
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
              const Divider(height: 25),
              const Text('Votre pays :', style: Styles.petittitres),
              const Divider(height: 15),
              Container(
                decoration:  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.only(left : 10.0),
                    child: DropdownButton(
                          borderRadius: BorderRadius.circular(7),
                          hint: const Text('Choisissez votre pays ...',
                              style: TextStyle(
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

                          items: pays.map((dynamic value) => DropdownMenuItem(
                            value: value,
                            child: Text(value, style : const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black87)
                            ),
                          )).toList(),
                          onChanged: (newItem) {
                            setState(() {
                              dropdownvalues = newItem!;
                            });
                          }),
                  ),
                ),
              ),
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
        _selectedItems = results;
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
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
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
                    value: _selectedItems.contains(item),
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