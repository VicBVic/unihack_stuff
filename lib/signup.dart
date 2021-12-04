import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(const SignUp());
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {

  final email=TextEditingController();
  final pass=TextEditingController();
  final user=TextEditingController();
  final fname=TextEditingController();
  final lname=TextEditingController();
  final phone=TextEditingController();

  String emailError = "";
  String passError = "";
  String userError = "";
  String fnameError = "";
  String lnameError = "";

  bool disable=false;

  FirebaseAuth auth = FirebaseAuth.instance;

  void _createUser() async{
    setState(() {
      disable=true;
    });
    bool valid=true;
      setState(() {

        String tmp="This field is required";

        if(email.text==""){emailError=tmp;valid=false;}
        else {emailError="";}
        if(pass.text==""){passError=tmp;valid=false;}
        else {passError="";}
        if(user.text==""){userError=tmp;valid=false;}
        else {userError="";}
        if(fname.text==""){fnameError=tmp;valid=false;}
        else {fnameError="";}
        if(lname.text==""){lnameError=tmp;valid=false;}
        else {lnameError="";}

      });

    if(valid){
      try {
      await auth.createUserWithEmailAndPassword(
          email: email.text,
          password: pass.text
      );
    } catch(error){
      if(error is PlatformException){
        setState(() {
          switch (error.code){
            case "ERROR_INVALID_EMAIL":
              emailError="The email is invalid";
              break;
            case "ERROR_EMAIL_ALREADY_IN_USE":
              emailError="The email is already in use";
              break;
          }
        });
      }
    }
  }
    setState(() {
      disable=false;
    });
  }

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Clean our city",
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Clean our city"),
          ),
          body: Center(
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Column(
                    children: [
                      TextField(
                        enabled: !disable,
                        controller: email,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.email_outlined),
                          border: const UnderlineInputBorder(),
                          labelText: "Email",
                          errorText: (emailError!=""?emailError:null),
                        ),
                      ),
                      TextField(
                        enabled: !disable,
                        obscureText: true,
                        controller: pass,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: const UnderlineInputBorder(),
                          labelText: "Password",
                          errorText: (passError!=""?passError:null),
                        ),
                      ),
                      TextField(
                        enabled: !disable,
                        controller: user,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          border: const UnderlineInputBorder(),
                          labelText: "Username",
                          errorText: (userError!=""?userError:null),
                        ),
                      ),
                      TextField(
                        enabled: !disable,
                        controller: fname,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.contact_page_rounded),
                          border: const UnderlineInputBorder(),
                          labelText: "First name",
                          errorText: (fnameError!=""?fnameError:null),
                        ),
                      ),
                      TextField(
                        enabled: !disable,
                        controller: lname,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.contact_page_rounded),
                          border: const UnderlineInputBorder(),
                          labelText: "Last name",
                          errorText: (lnameError!=""?lnameError:null),
                        ),
                      ),
                      //Row(
                        //children: [
                          CountryCodePicker(
                            initialSelection: 'RO',
                            favorite: ['+40','RO'],
                          ),
                          TextField(
                            enabled: !disable,
                            controller: phone,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.contact_page_rounded),
                              border: UnderlineInputBorder(),
                              labelText: "Phone",
                            ),
                          ),
                        //],
                      //),
                      TextButton(
                        onPressed: disable?null:_createUser,
                        child: Text(disable?"Hold on":"Sign Up"),
                      ),
                    ],
                  ),
                ),
            ),
          ),
        )
    );
  }
}
