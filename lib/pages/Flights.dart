import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Firebase_U.dart';
import 'package:http/http.dart' as http;
import 'package:date_picker_timeline/date_picker_timeline.dart';

FirebaseL flightd = FirebaseL();
late Map _getToken;
late List data = [];
late Map data1;
late int ci;
var pname;

class Flights extends StatefulWidget {
  Future getAuth() async {
    var url =
        Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token');
    var response = await http.post(url, body: {
      'grant_type': 'client_credentials',
      'client_id': 'ZkSLmIDxR15i4awaGt36ROV28yQMtwf6',
      'client_secret': 'q0cOeiSZIhFqGOGQ'
    });
    _getToken = json.decode(response.body);
    return _getToken;
  }

  @override
  _FlightsState createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {
  int fc = 0;
  Future getFlight(String ori, String des, String date) async {
    String ttype = _getToken['token_type'];
    String atoken = _getToken['access_token'];
    var url = Uri.parse(
        'https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$ori&destinationLocationCode=$des&departureDate=$date&adults=1&currencyCode=INR');

    var request =
        await http.get(url, headers: {'Authorization': ttype + ' ' + atoken});

    var exdata = json.decode(request.body);
    data = exdata['data'];
    data1 = exdata['dictionaries'];
    if (request.statusCode == 200) {
      setState(() {
        addWidget();
      });
    } else if (request.statusCode == 400) {
      Text(
        'No Flights',
        style: TextStyle(fontSize: 20.0, color: Colors.red),
      );
    }
  }

  String wTo = '';
  String wFrom = '';
  List<Widget> createWidget() {
    List<Widget> _contatos = new List.generate(1, (int i) => new TicketView());
    return _contatos;
  }

  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();
  String date1 = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (value) {
                        wTo = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Where to?',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (value) {
                        wFrom = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Where from?',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  setState(() {
                    getFlight(wTo, wFrom, date1);
                  });
                },
                child: Text("Search"),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),
                  child: DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.black,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      // New date selected
                      setState(() {
                        _selectedValue = date;
                        date1 = _selectedValue.toString().substring(0, 10);
                        print(date1);
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(
              children: createWidget(),
            )
          ],
        ),
      ],
    );
  }

  void addWidget() {
    setState(() {
      fc = data.length;
    });
  }
}

class TicketView extends StatefulWidget {
  @override
  _TicketViewState createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: data.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          pname = data1['carriers']
              [data[index]['itineraries'][0]['segments'][0]['carrierCode']];
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            data[index]['itineraries'][0]['segments'][0]
                                ['departure']['iataCode'],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.indigo.shade50,
                                borderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                              height: 8,
                              width: 8,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Colors.indigo.shade400,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                    height: 24,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Flex(
                                          children: List.generate(
                                              (constraints.constrainWidth() / 6)
                                                  .floor(),
                                              (index) => SizedBox(
                                                    height: 1,
                                                    width: 3,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade300),
                                                    ),
                                                  )),
                                          direction: Axis.horizontal,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                        );
                                      },
                                    ),
                                  ),
                                  Center(
                                      child: Transform.rotate(
                                    angle: 1.5,
                                    child: Icon(
                                      Icons.local_airport,
                                      color: Colors.indigo.shade300,
                                      size: 24,
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.pink.shade50,
                                borderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                              height: 8,
                              width: 8,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Colors.pink.shade400,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            data[index]['itineraries'][0]['segments'][0]
                                ['arrival']['iataCode'],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                              width: 100,
                              child: Text(
                                '',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )),
                          Text(
                            data[index]['itineraries'][0]['duration']
                                .toString()
                                .substring(2),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                              width: 100,
                              child: Text(
                                "",
                                textAlign: TextAlign.end,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            data[index]['itineraries'][0]['segments'][0]
                                    ['departure']['at']
                                .toString()
                                .substring(11),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data[index]['itineraries'][0]['segments'][0]
                                    ['arrival']['at']
                                .toString()
                                .substring(11),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "LastDate Booking " +
                                data[index]['lastTicketingDate'],
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 10,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.grey.shade200),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Flex(
                                children: List.generate(
                                    (constraints.constrainWidth() / 10).floor(),
                                    (index) => SizedBox(
                                          height: 1,
                                          width: 5,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade400),
                                          ),
                                        )),
                                direction: Axis.horizontal,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 10,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              color: Colors.grey.shade200),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24))),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(Icons.flight_land, color: Colors.amber),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(pname,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey)),
                      Expanded(
                          child: Text(
                              "\u{20B9}" + data[index]['price']['grandTotal'],
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
