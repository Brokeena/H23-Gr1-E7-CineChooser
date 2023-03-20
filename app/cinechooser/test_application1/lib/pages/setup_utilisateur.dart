import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_application1/components/textField.dart';
import 'package:test_application1/pages/login_page.dart';
import 'package:test_application1/utils/app_styles.dart';


class SetupUtilisateur extends StatefulWidget {
  const SetupUtilisateur({Key? key}) : super(key: key);

  @override
  State<SetupUtilisateur> createState() => _SetupUtilisateurState();
}

class _SetupUtilisateurState extends State<SetupUtilisateur>
{
  void _navigateToPreviousScreen(BuildContext context)
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
  }
  //controller
  final usernameController = TextEditingController();

  dynamic dropdownvalues = "item1";
  List listItemPays = ["item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Personnaliser votre compte', style: Styles.entete),
        leading: IconButton(
          onPressed: () {_navigateToPreviousScreen(context);}, icon: const Icon(Icons.arrow_back,),),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black,
              Colors.white,
            ],
          )
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                   Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                     decoration: const ShapeDecoration(
                         shape: RoundedRectangleBorder(
                             side: BorderSide(width: 1.0, style: BorderStyle.solid),
                             borderRadius: BorderRadius.all(Radius.circular(12),)
                         )
                     ),
                    child: DropdownButton(
                        value: dropdownvalues,
                        dropdownColor: Colors.grey.shade600,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.white,),
                        elevation: 10,
                        items: ["item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", ]
                            .map((dynamic value) => DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white ),
                            ),
                        )).toList(),
                        onChanged: (newItem){
                          setState(() {
                            dropdownvalues = newItem!;
                          });
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

