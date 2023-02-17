import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filter = {
    'glutenFree': false,
    'vegetarian': false,
    'vegan': false,
    'lactoseFree': false
  };
  List<Meal> availableMeals = DUMMY_MEALS.toList();
  List<Meal> _favoritedMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filter = filterData;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (_filter['glutenFree'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filter['lactoseFree'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filter['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filter['vegan'] && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritedMeals.indexWhere((meal) => mealId == meal.id);
    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritedMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            accentColor: Colors.amber,
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Roboto',
            textTheme: ThemeData.light().textTheme.copyWith(
                  body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                  body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                  title: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                )),
        // home: CategoriesScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(_favoritedMeals),
          CategoryMealsScreen.routeName: (ctx) =>
              CategoryMealsScreen(availableMeals),
          MealDetailScreen.routeName: (ctx) =>
              MealDetailScreen(_toggleFavorite,_isMealFavorite),
          FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filter),
        },
        onGenerateRoute: (settings) {
          print(settings.arguments);
          return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
        },
        onUnknownRoute: (settings) {
          print(settings.arguments);
          return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
        });
  }
}
