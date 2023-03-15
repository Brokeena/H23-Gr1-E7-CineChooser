import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_application1/components/textField.dart';
import 'package:test_application1/pages/login_page.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Personnaliser votre compte',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal
          ) ,),
        leading: IconButton(
          onPressed: () {_navigateToPreviousScreen(context);}, icon: Icon(Icons.arrow_back,),),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black,
              Colors.black,
            ],
          )
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

