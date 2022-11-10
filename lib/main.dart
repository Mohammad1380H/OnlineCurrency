import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hello_world/Model/Currency.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart' as intl;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('fa', ''),
        ],
        theme: ThemeData(
            // appBarTheme: const AppBarTheme(
            //     toolbarTextStyle: TextStyle(fontFamily: "mitra", fontSize: 20,color: Colors.black)),
            textTheme: const TextTheme(
                headline1: TextStyle(
                    fontFamily: "mitra",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                headline2: TextStyle(
                    fontFamily: "mitra",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                headline3: TextStyle(
                    fontFamily: "mitra",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.green),
                headline4: TextStyle(
                    fontFamily: "mitra",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.red),
                bodyText1: TextStyle(
                    fontFamily: "mitra",
                    fontSize: 19,
                    fontWeight: FontWeight.w300))),
        title: "قیمت روز",
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}

class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> myList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResponse(context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  Future getResponse(BuildContext context) async {
    var url =
        "https://api.navasan.tech/latest/?api_key=freexHcTG1rOTgRN4CYUU2iOwrGXIXEZ";
    var value = await http.get(Uri.parse(url));

    if (myList.isEmpty) {
      if (value.statusCode == 200) {

        Map<String, dynamic> jsonList = convert.jsonDecode(value.body);
        Set<Set<String>> names = {
          {"bahar", "سکه بهار آزادی"},
          {"nim", "نیم سکه"},
          {"rob", "ربع سکه"},
          {"18ayar", "یک گرم طلای 18 عیار"},
          {"usd_sell", "دلار تهران خرید"},
          {"usd_buy", "دلار تهران فروش"},
          {"aud", "دلار استرالیا"},
          {"cad", "دلار کانادا"},
          {"eur", "یورو"},
          {"iqd", "دینار عراق"},
          {"aed", "درهم امارات"},
          {"afn", "افغانی"},
          {"sar", "ریال سعودی"},
        };
        if (jsonList.isNotEmpty) {
          for (int i = 0; i < names.length; i++) {
            setState(() {
              myList.add(Currency(
                  id: "0",
                  title: names.elementAt(i).elementAt(1),
                  price: jsonList[names.elementAt(i).elementAt(0)]["value"]
                      .toString(),
                  changes: jsonList[names.elementAt(i).elementAt(0)]["change"]
                      .toString(),
                  status: "p"));
            });
          }
        }
        _showSnackBar(context, "بروزرسانی با موفقیت انجام شد!");
      }
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          //title : or action:[]
          actions: [
            Image.asset("assets/images/icon.png"),
            Align(
                alignment: Alignment.centerRight,
                child: Text("قیمت به روز ارز ",
                    style: Theme.of(context).textTheme.headline1)),
            Expanded(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset("assets/images/menu.png"))),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/question.png"),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("نرخ ارز آزاد چیست ؟ ",
                      style: Theme.of(context).textTheme.headline1)
                  // style:
                  //     TextStyle(fontSize: 19.5, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                "نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.",
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 130, 130, 130),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("نام آزاد ارز",
                            style: Theme.of(context).textTheme.headline2),
                        Text("قیمت",
                            style: Theme.of(context).textTheme.headline2),
                        Text("تغییر",
                            style: Theme.of(context).textTheme.headline2)
                      ]),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: listFutureBuilder(context)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 232, 232),
                      borderRadius: BorderRadius.circular(1000)),
                  child: Builder(builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextButton.icon(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(
                                          255, 202, 193, 255))),
                              onPressed: () {
                                myList.clear();
                                listFutureBuilder(context);
                              },
                              icon: const Icon(
                                CupertinoIcons.refresh_bold,
                                color: Colors.black,
                              ),
                              label: Text(
                                "بروزرسانی",
                                style: Theme.of(context).textTheme.headline1,
                              )),
                        ),
                        Text(
                          "آخرین بروزرسانی:${_getTime()}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox.shrink()
                      ],
                    );
                  }),
                ),
              )
            ]),
          ),
        ));
  }

  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    return FutureBuilder(
      future: getResponse(context),
      builder: (context, snapshot) {
        return (snapshot.hasData
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: myList.length,
                itemBuilder: (BuildContext myContext, int number) {
                  return MyDelegate(number, myList);
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 5 == 0 && index != 0) {
                    return const Add();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            : Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                      Text(
                        "لطفاً صبر کنید",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ]),
              ));
      },
    );
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 800),
      backgroundColor: Colors.green,
      content: Text(
        msg,
        style: Theme.of(context).textTheme.headline1,
      ),
    ));
  }

  String _getTime() {
    DateTime now = DateTime.now();

    return intl.DateFormat("kk:mm:ss").format(now);
  }
}

class MyDelegate extends StatelessWidget {
  int number;
  List<Currency> myList;
  MyDelegate(
    this.number,
    this.myList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 14,
        decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(
                blurRadius: 1, color: Colors.grey, blurStyle: BlurStyle.outer)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 9,
              child: Text(
                myList[number].title!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                myList[number].price!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                double.parse(myList[number].changes!).toStringAsFixed(1),
                style: double.parse(myList[number].changes!) <= 0
                    ? Theme.of(context).textTheme.headline4
                    : Theme.of(context).textTheme.headline3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Add extends StatelessWidget {
  const Add({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 1, color: Colors.grey, blurStyle: BlurStyle.outer)
          ],
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "تبلیغات",
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}

