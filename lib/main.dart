import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializePaymob();
  runApp(const MyApp());
}

void initializePaymob() async {
  try {
    await FlutterPaymob.instance.initialize(
        apiKey:"ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RneE9EVXdMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuTURkSlJ3SldCQmdxMG14RDgtcmptSTh4UUhaLWNPTWYxeVRIdmZHTEI4eXlTdGUzc25DUnRuZWNnYWF2cGFPcHlHOGJmNEJHV2RyUndMcTcxVnpLakE=",
        integrationID: 4598242,
        walletIntegrationId: 4598310,
        iFrameID: 852382);

    print("Paymob initialized successfully.");
  } catch (e) {
    print("Error initializing Paymob: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Paymob'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  await FlutterPaymob.instance.payWithCard(
                    context: context,
                    currency: "EGP",
                    amount: 100,
                    onPayment: (response) {

                      print("*");
                      print("Message: ${response.message}");
                      print("Response Code: ${response.responseCode}");
                      print("Success: ${response.success}");
                      print("Transaction ID: ${response.transactionID}");
                      print("*");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response.message ?? "Success"),
                        ),
                      );
                    },
                  );
                } catch (e) {
                  print("Error during card payment: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Payment failed: $e"),
                    ),
                  );
                }
              },
              child: const Text("Pay with Card"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FlutterPaymob.instance.payWithWallet(
                    context: context,
                    currency: "EGP",
                    amount: 100,
                    number: "01010101010",
                    onPayment: (response) {
                      print("*");
                      print("Message: ${response.message}");
                      print("Response Code: ${response.responseCode}");
                      print("Success: ${response.success}");
                      print("Transaction ID: ${response.transactionID}");
                      print("*");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response.message ?? "Success"),
                        ),
                      );
                    },
                  );
                } catch (e) {
                  print("*");
                  print("Error during wallet payment: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Payment failed: $e"),

                    ),
                  );
                }
              },
              child: const Text("Pay with Wallet"),
            ),
          ],
        ),
      ),
    );
  }
}