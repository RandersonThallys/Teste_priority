import 'package:flutter/material.dart';

import 'alert_messenger.dart';

const String errorText = 'Oops, ocorreu um erro. Pedimos desculpas.';
const String warningText = 'Atenção! Você foi avisado.';
const String infoText = 'Este é um aplicativo escrito em Flutter.';

void main() => runApp(const AlertPriorityApp());

class AlertPriorityApp extends StatefulWidget {
  const AlertPriorityApp({super.key});

  @override
  State<AlertPriorityApp> createState() => _AlertPriorityAppState();
}

class _AlertPriorityAppState extends State<AlertPriorityApp> {
  String text = '';
  VoidCallback? nextAction;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Priority',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: const IconThemeData(size: 16.0, color: Colors.white),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(Size(110, 40)),
          ),
        ),
      ),
      home: AlertMessenger(
        child: Builder(
          builder: (context) {
            errorAction(){
              AlertMessenger.of(context).showAlert(
                alert: const Alert(
                  backgroundColor: Colors.red,
                  leading: Icon(Icons.error),
                  priority: AlertPriority.error,
                  child: Text(errorText),
                ),
              ).then((value) =>
              value ? setState(() {
                text = errorText;
              }) : nextAction = errorAction);
            }

            warningAction(){
              AlertMessenger.of(context).showAlert(
                alert: const Alert(
                  backgroundColor: Colors.amber,
                  leading: Icon(Icons.warning),
                  priority: AlertPriority.warning,
                  child: Text(warningText),
                ),
              ).then((value) =>
              value ? setState(() {
                text = warningText;
              }) : nextAction = warningAction);
            }

            infoAction(){
              AlertMessenger.of(context).showAlert(
                alert: const Alert(
                  backgroundColor: Colors.green,
                  leading: Icon(Icons.info),
                  priority: AlertPriority.info,
                  child: Text(infoText),
                ),
              ).then((value) =>
              value ? setState(() {
                text = infoText;
              }) : nextAction = infoAction);
            }

            return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: AppBar(
                title: const Text('Alerts'),
                centerTitle: true,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          text,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: errorAction,
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.error),
                                      SizedBox(width: 4.0),
                                      Text('Error'),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: warningAction,
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.amber),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.warning_outlined),
                                      SizedBox(width: 4.0),
                                      Text('Warning'),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: infoAction,
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.lightGreen),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.info_outline),
                                      SizedBox(width: 4.0),
                                      Text('Info'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 16.0,
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  AlertMessenger.of(context).hideAlert();
                                  setState(() {
                                    text = '';
                                  });
                                  if (nextAction != null){
                                    await Future.delayed(const Duration(milliseconds: 350)).then((value) {
                                      nextAction!();

                                      nextAction = null;
                                    });
                                  }
                                },
                                child: const Text('Hide alert'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
