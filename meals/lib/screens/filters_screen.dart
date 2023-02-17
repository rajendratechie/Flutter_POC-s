import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilter;

  FiltersScreen(this.saveFilters, this.currentFilter);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilter['glutenFree'];
    _vegetarian = widget.currentFilter['vegetarian'];
    _vegan = widget.currentFilter['vegan'];
    _lactoseFree = widget.currentFilter['lactoseFree'];
    super.initState();
  }

  Widget _buildSwitchListTitle(String text, bool currentValue,
      String description, Function updateValue) {
    return SwitchListTile(
        title: Text(text),
        value: currentValue,
        subtitle: Text(description),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilter = {
                  'glutenFree': _glutenFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                  'lactoseFree': _lactoseFree
                };
                widget.saveFilters(selectedFilter);
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal Selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchListTitle(
                  'Gluten Free', _glutenFree, 'Only include Gluten Free meals',
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildSwitchListTitle(
                  'Vegetarian', _vegetarian, 'Only include Vegetarian meals',
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildSwitchListTitle('Vegan', _vegan, 'Only include Vegan meals',
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              _buildSwitchListTitle('Lactose Free', _lactoseFree,
                  'Only include Lactose Free meals', (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              })
            ],
          ))
        ],
      ),
    );
  }
}
