import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../services/services.dart';

class ShowScanBar extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;
  const ShowScanBar(
      {super.key,
      required this.title,
      required this.description,
      required this.child});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;    
    final qrPayService = Provider.of<QrPayService>(context);
    return OrientationBuilder(
      builder: (context, orientation) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              style: const TextStyle(fontSize: 25),
            ),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              // TODO: Redirigir a Perfíl.
              onPressed: (){                                
                qrPayService.emptyFields();
                return Navigator.pop(context);
              } 
                
            ),
            // flexibleSpace: Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/images/appbar/app-bar-image.png'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
          ),
          body: Container(
            padding: EdgeInsets.only(bottom: deviceHeight * 0.025),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      children: [
                        SizedBox(
                          height: deviceHeight * 0.04,
                        ),
                        Text(title, style: const TextStyle(fontSize: 25)),
                        SizedBox(
                          height: deviceHeight * 0.01,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.2),
                          child: Text(
                            description,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.01,
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 4,
                    child: Container(
                      height: deviceHeight * 0.67,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: deviceHeight * 0.55,
                                  alignment: Alignment.center,
                                  child: SizedBox(child: child)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
