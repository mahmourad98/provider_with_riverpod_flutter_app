import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart' as provider;
import 'package:untitled04/string_service.dart';
import 'package:untitled04/widget.dart';

class MyApp extends StatelessWidget {
  const MyApp() : super(key: null,);

  @override
  Widget build(BuildContext context,) {
    return provider.MultiProvider(
      providers: [
        provider.Provider<StringService>(
          create: (_,) => StringService(),
          lazy: false,
          builder: (context, child) {
            return riverpod.ProviderScope(
              child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.grey,
                  primaryColor: Colors.white,
                  brightness: Brightness.light,
                  backgroundColor: const Color(
                    0xFFE5E5E5,
                  ),
                  accentColor: Colors.black,
                  accentIconTheme: const IconThemeData(color: Colors.white),
                  dividerColor: Colors.white54,
                ),
                darkTheme: ThemeData(
                  primarySwatch: Colors.grey,
                  primaryColor: Colors.black,
                  brightness: Brightness.dark,
                  backgroundColor: const Color(
                    0xFF212121,
                  ),
                  accentColor: Colors.white,
                  accentIconTheme: const IconThemeData(color: Colors.black),
                  dividerColor: Colors.black12,
                ),
                builder: (BuildContext buildContext, Widget? child,) {
                  return SafeArea(
                    child: child!,
                  );
                },
                home: const MyWidget(),
              ),
            );
          },
        ),
      ],
    );
  }
}
