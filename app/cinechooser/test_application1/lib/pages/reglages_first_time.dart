import 'package:cinechooser/pages/choix.dart';
import 'package:cinechooser/pages/login_page.dart';
import 'package:cinechooser/pages/pagePrincipale.dart';
import 'package:cinechooser/pages/reglages.dart';
import 'package:flutter/material.dart';
import 'package:cinechooser/utils/app_styles.dart';
import 'package:cinechooser/api/api.dart';
import 'package:cinechooser/utils/pays_nom.dart';
import 'package:cinechooser/utils/pays_iso.dart';

class ReglagesFirstTime extends StatefulWidget {
  const ReglagesFirstTime({Key? key}) : super(key: key);

  @override
  State<ReglagesFirstTime> createState() => _ReglagesFirstTimeState();
}

bool isButtonPressed = false;

class _ReglagesFirstTimeState extends State<ReglagesFirstTime> {
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
        title: const Text('Set your account details', style: Styles.entete),
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
          padding: EdgeInsets.all(width / 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: height / 40),
              Container(
                height: height / 20,
                width: width * 0.86,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton(
                        borderRadius: BorderRadius.circular(7),
                        hint: Text(
                          paysSelectionne,
                          style: Styles.bouton3,
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
                                  child: Text(value, style: Styles.bouton3),
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
              Divider(height: height / 30),
              const Text('Streaming services :', style: Styles.petittitres),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width / 25),
                    child: const Text('Your services : ',
                        style: Styles.informations),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 25),
                    child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        direction: Axis.horizontal,
                        children: selectedItems
                            .map((e) => Chip(
                                label: Text(e, style: Styles.informations2)))
                            .toList()),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: _showMultiSelect,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(),
                    fixedSize: Size(width * 0.86, height / 20),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder()),
                child: const Text('Choose your streaming services',
                    style: Styles.bouton3),
              ),
              Divider(
                height: height / 12,
                color: Colors.grey.shade800,),
              Center(
                  child: GestureDetector(
                onTap: () {
                  print(results);
                  if (results == []) {
                    print('vide');
                  } else {
                    print(results);
                  }
                  if (paysSelectionne != 'Country' && results != []) {
                    if (isButtonPressed == false) {
                      isButtonPressed = true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PagePrincipale()),
                      );
                    }
                  }

                  isButtonPressed = false;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Styles.bgColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isButtonPressed
                          ? [
                              //aucune ombre
                            ]
                          : [
                              const BoxShadow(
                                color: Color(0xffB62B32),
                                offset: Offset(4, 4),
                                blurRadius: 10,
                                spreadRadius: 1 / 8,
                              ),
                              const BoxShadow(
                                color: Color(0xffB62B32),
                                offset: Offset(-4, -4),
                                blurRadius: 10,
                                spreadRadius: 1 / 8,
                              ),
                            ]),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 8,
                        ),
                        Text('Start choosing!', style: Styles.bouton2),
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

      db.doc(await docID).update({'providers': results!});
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
      title: const Text('Choose your streaming services',
          style: TextStyle(
              fontFamily: 'Poppins',
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
                            fontFamily: 'Poppins',
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
            child: const Text('Cancel',
                style: TextStyle(fontFamily: 'Poppins', color: Colors.black))),
        ElevatedButton(
          onPressed: _submit,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => Styles.red1,
            ),
          ),
          child: const Text('Continue',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.black)),
        )
      ],
    );
  }
}
