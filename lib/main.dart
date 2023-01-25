import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final router = GoRouter(
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const MyHomePage(),
      ),
      GoRoute(
        name: '/second',
        path: '/second',
        pageBuilder: (context, state) => CupertinoPage(
          child: SecondPage(
            key: state.pageKey,
            bodyText: state.queryParams['bodyText'] ?? '',
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      theme: ThemeData(
        primaryColor: const Color(0xff4C53FB),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xff4C53FB)),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.pushNamed('/second',
                      queryParams: {'bodyText': 'Sending This To You'});
                },
                child: const Text('Move To Second Page'))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SecondPage extends StatelessWidget {
  final String bodyText;
  const SecondPage({Key? key, required this.bodyText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Login Here",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Image.asset(
                  "assets/images/login_image.jpeg",
                  height: 250,
                  width: double.infinity,
                ),
                const Text(
                  "Get Logged In From Here",
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 12),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      color: Colors.grey[100],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Email',
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 12),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      color: Colors.grey[100],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Password',
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => const ForgotPassword()));
                    },
                    child: const Text(
                      "Forgot Password ? ",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  height: 20,
                  minWidth: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => const ForgotPassword()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
