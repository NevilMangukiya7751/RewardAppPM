// ignore_for_file: prefer_const_constructors

/*
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinCollectionScreen extends StatefulWidget {
  @override
  _CoinCollectionScreenState createState() => _CoinCollectionScreenState();
}

class _CoinCollectionScreenState extends State<CoinCollectionScreen> {
  int coinsCollected = 0;
  bool canCollect = true;

  @override
  void initState() {
    super.initState();
    checkIfCanCollect();
    loadCoinsCollected();
  }

  Future<void> loadCoinsCollected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int collected = prefs.getInt('coins_collected_today') ?? 0;

    setState(() {
      coinsCollected = collected;
    });
  }

  Future<void> checkIfCanCollect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime lastCollectionTime =
        DateTime.parse(prefs.getString('last_collection_time')!);

    DateTime now = DateTime.now();
    Duration difference = now.difference(lastCollectionTime);

    if (difference.inHours < 1) {
      setState(() {
        canCollect = false;
      });
    }
  }

  Future<void> collectCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the user can collect
    if (canCollect) {
      // Increment coins collected
      int collected = prefs.getInt('coins_collected_today') ?? 0;
      collected++;
      prefs.setInt('coins_collected_today', collected);

      // Save the current collection time
      prefs.setString('last_collection_time', DateTime.now().toIso8601String());

      setState(() {
        coinsCollected = collected;
        canCollect = false;
      });

      // You can add additional logic here for handling the collection process
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Coin Collection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Coins Collected Today:',
            ),
            Text(
              '$coinsCollected',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              canCollect ? 'Can Collect Today: Yes' : 'Can Collect Today: No',
              style: TextStyle(
                fontSize: 16,
                color: canCollect ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: canCollect ? collectCoins : null,
        tooltip: 'Collect Coins',
        backgroundColor: canCollect ? Colors.blue : Colors.grey,
        child: Icon(Icons.monetization_on),
      ),
    );
  }
}
*/

/// thisss
///
///
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/images/imageConstant.dart';

class CoinCollectionScreen extends StatefulWidget {
  const CoinCollectionScreen({super.key});

  @override
  _CoinCollectionScreenState createState() => _CoinCollectionScreenState();
}

class _CoinCollectionScreenState extends State<CoinCollectionScreen> {
  Map<String, int> coinsCollected = {};
  bool canCollect = true;

  @override
  void initState() {
    super.initState();
    loadCoinsCollected();
    checkIfCanCollect();
  }

  Future<void> loadCoinsCollected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    coinsCollected = {
      'Monday': prefs.getInt('coins_collected_Monday') ?? 0,
      'Tuesday': prefs.getInt('coins_collected_Tuesday') ?? 0,
      'Wednesday': prefs.getInt('coins_collected_Wednesday') ?? 0,
      'Thursday': prefs.getInt('coins_collected_Thursday') ?? 0,
      'Friday': prefs.getInt('coins_collected_Friday') ?? 0,
      'Saturday': prefs.getInt('coins_collected_Saturday') ?? 0,
      'Sunday': prefs.getInt('coins_collected_Sunday') ?? 0,
    };
  }

  Future<void> checkIfCanCollect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime lastCollectionTime =
        DateTime.parse(prefs.getString('last_collection_time') ?? '');

    DateTime now = DateTime.now();
    Duration difference = now.difference(lastCollectionTime);

    if (difference.inHours < 24) {
      setState(() {
        canCollect = false;
      });
    }
  }

  Future<void> collectCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the user can collect
    if (canCollect) {
      // Increment coins collected for the current day
      String weekday = DateTime.now().toUtc().weekday.toString();
      int collected = coinsCollected[weekday] ?? 0;
      collected++;
      coinsCollected[weekday] = collected;
      prefs.setInt('coins_collected_$weekday', collected);

      // Save the current collection time
      prefs.setString('last_collection_time', DateTime.now().toIso8601String());

      setState(() {
        canCollect = false;
      });

      // You can add additional logic here for handling the collection process
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Coin Collection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Image.asset(
                  ImageConstant.coin5,
                  scale: 4,
                ),
                SizedBox(height: 5),
                Text(
                  'Day 1',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF808080),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),

            // for (var entry in coinsCollected.entries)
            Text(
              '${DateTime.now().toUtc().weekday}: ${coinsCollected[DateTime.now().toUtc().weekday.toString()] ?? 0}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: (DateTime.now().weekday == 5)
                    ? Colors.yellow
                    : Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              canCollect ? 'Can Collect Today: Yes' : 'Can Collect Today: No',
              style: TextStyle(
                fontSize: 16,
                color: canCollect ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: canCollect ? collectCoins : null,
        tooltip: 'Collect Coins',
        backgroundColor: canCollect ? Colors.blue : Colors.grey,
        child: Icon(Icons.monetization_on),
      ),
    );
  }
}

/*
class CoinCollectionScreen extends StatefulWidget {
  @override
  _CoinCollectionScreenState createState() => _CoinCollectionScreenState();
}

class _CoinCollectionScreenState extends State<CoinCollectionScreen> {
  Map<String, int> coinsCollected = {};
  bool canCollect = true;

  @override
  void initState() {
    super.initState();
    loadCoinsCollected();
    checkIfCanCollect();
  }

  Future<void> loadCoinsCollected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    coinsCollected = {
      'Monday': prefs.getInt('coins_collected_Monday') ?? 0,
      'Tuesday': prefs.getInt('coins_collected_Tuesday') ?? 0,
      'Wednesday': prefs.getInt('coins_collected_Wednesday') ?? 0,
      'Thursday': prefs.getInt('coins_collected_Thursday') ?? 0,
      'Friday': prefs.getInt('coins_collected_Friday') ?? 0,
      'Saturday': prefs.getInt('coins_collected_Saturday') ?? 0,
      'Sunday': prefs.getInt('coins_collected_Sunday') ?? 0,
    };
  }

  Future<void> checkIfCanCollect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime lastCollectionTime =
        DateTime.parse(prefs.getString('last_collection_time') ?? '');

    DateTime now = DateTime.now();
    Duration difference = now.difference(lastCollectionTime);

    if (difference.inHours < 24) {
      setState(() {
        canCollect = false;
      });
    }
  }

  Future<void> collectCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the user can collect
    if (canCollect) {
      // Increment coins collected for the current day
      String weekday = DateTime.now().toUtc().weekday.toString();
      int collected = coinsCollected[weekday] ?? 0;
      collected++;
      coinsCollected[weekday] = collected;
      prefs.setInt('coins_collected_$weekday', collected);

      // Save the current collection time
      prefs.setString('last_collection_time', DateTime.now().toIso8601String());

      setState(() {
        canCollect = false;
      });

      // You can add additional logic here for handling the collection process
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Coin Collection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var entry in coinsCollected.entries)
              Text(
                '${coinsCollected.keys.first}: ${entry.value}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: entry.value == 0 ? Colors.red : Colors.black,
                ),
              ),
            SizedBox(height: 20),
            Text(
              canCollect ? 'Can Collect Today: Yes' : 'Can Collect Today: No',
              style: TextStyle(
                fontSize: 16,
                color: canCollect ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: canCollect ? collectCoins : null,
        tooltip: 'Collect Coins',
        backgroundColor: canCollect ? Colors.blue : Colors.grey,
        child: Icon(Icons.monetization_on),
      ),
    );
  }
}*/

/// thisss

/*
class CoinCollectionScreen extends StatefulWidget {
  @override
  _CoinCollectionScreenState createState() => _CoinCollectionScreenState();
}

class _CoinCollectionScreenState extends State<CoinCollectionScreen> {
  Map<String, int> coinsCollected = {};
  bool canCollect = true;

  @override
  void initState() {
    super.initState();
    loadCoinsCollected();
    checkIfCanCollect();
  }

  Future<void> loadCoinsCollected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    coinsCollected = {
      'Monday': prefs.getInt('coins_collected_Monday') ?? 0,
      'Tuesday': prefs.getInt('coins_collected_Tuesday') ?? 0,
      'Wednesday': prefs.getInt('coins_collected_Wednesday') ?? 0,
      'Thursday': prefs.getInt('coins_collected_Thursday') ?? 0,
      'Friday': prefs.getInt('coins_collected_Friday') ?? 0,
      'Saturday': prefs.getInt('coins_collected_Saturday') ?? 0,
      'Sunday': prefs.getInt('coins_collected_Sunday') ?? 0,
    };
  }

  Future<void> checkIfCanCollect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime lastCollectionTime =
        DateTime.parse(prefs.getString('last_collection_time') ?? '');

    DateTime now = DateTime.now();
    Duration difference = now.difference(lastCollectionTime);

    if (difference.inHours < 24) {
      setState(() {
        canCollect = false;
      });
    }
  }

  Future<void> collectCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the user can collect
    if (canCollect) {
      // Increment coins collected for the current day
      String weekday = DateTime.now().toUtc().weekday.toString();
      int collected = coinsCollected[weekday] ?? 0;
      collected++;
      coinsCollected[weekday] = collected;
      prefs.setInt('coins_collected_$weekday', collected);

      // Save the current collection time
      prefs.setString('last_collection_time', DateTime.now().toIso8601String());

      setState(() {
        canCollect = false;
      });

      // You can add additional logic here for handling the collection process
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Coin Collection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var entry in coinsCollected.entries)
              Text(
                '${entry.key}: ${entry.value}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            SizedBox(height: 20),
            Text(
              canCollect ? 'Can Collect Today: Yes' : 'Can Collect Today: No',
              style: TextStyle(
                fontSize: 16,
                color: canCollect ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: canCollect ? collectCoins : null,
        tooltip: 'Collect Coins',
        backgroundColor: canCollect ? Colors.blue : Colors.grey,
        child: Icon(Icons.monetization_on),
      ),
    );
  }
}
*/
