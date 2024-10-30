// ignore_for_file: prefer_const_constructors
import 'package:barber_booking_app/state/state_management.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<ScaffoldState>scaffoldState = GlobalKey();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/jay.jpg'),
            fit:BoxFit.cover )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(onPressed: () =>processLogin(context) , icon:Icon(Icons.phone), label: Text('Login with phone'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ), ),
               )
            ],),
        ),
    );
  }
  
  processLogin(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    if(user == null){
      FirebaseAuthUi.instance()
      .launchAuth([AuthProvider.phone()]).then((firebaseUser){
        //context.read(userLogged).state = FirebaseAuth.instance.currentUser;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login sucess ${FirebaseAuth.instance}')));
      }).catchError((e) {
        if(e is PlatformException){
          if(e.code == FirebaseAuthUi.kUserCancelledError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.message}')));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ukn error')));
        }
        }
      });
    }
    else{

    }
  }
}
