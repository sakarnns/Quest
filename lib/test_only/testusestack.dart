import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:food_evt/pages/Daily_dali.dart';

class ExplorePages extends StatefulWidget {
  ExplorePages({Key? key}) : super(key: key);

  @override
  _ExplorePagesState createState() => _ExplorePagesState();
}

class _ExplorePagesState extends State<ExplorePages> {
  get icon => null;

  get crossAxisAlignment => null;

  @override
  Widget build(BuildContext context) {
    // print("w : ${MediaQuery.of(context).size.width}");
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.pink,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.place_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Block B Phase 2 Johar Town, Lahore',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  //Search Bar//////////
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search...',
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white),
                      borderRadius: new BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white),
                      borderRadius: new BorderRadius.circular(25.7),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      image: AssetImage('assets/images/Beach_1.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sport',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          Text(
                            'Run &Run',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              /*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image(
                          image: AssetImage('assets/images/Beach_2.jpg'),
                          height: 300,
                          width: 300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Grocery',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white)),
                            Text(
                              'Order food you love',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image(
                                image: AssetImage('assets/images/Beach_1.jpg'),
                                height: 300,
                                width: 300,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Deserts',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white)),
                                  Text(
                                    'Something Sweet',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              */
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                      child: CarouselSlider(
                    items: imageSliders,
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                    ),
                  )),
                ],
              ),
              /*
              Container(
                child: Row(
                  children: [
                    Text(
                      'Deals',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 235,
                    ),
                    Icon(Icons.arrow_forward_outlined),
                  ],
                ),
              ),
              */
              SizedBox(
                height: 10,
              ),
              /*
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Stack(alignment: Alignment.bottomLeft, children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/Beach_1.jpg'),
                                    height: 300,
                                    width: 300,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/Beach_1.jpg'),
                                    height: 300,
                                    width: 300,
                                  ),
                                ),
                              ]),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Daily Deli',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('Johar Town',
                                            style: TextStyle(
                                              fontSize: 15,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Text('4.8',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Stack(alignment: Alignment.bottomLeft, children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/Beach_1.jpg'),
                                    height: 300,
                                    width: 300,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/Beach_1.jpg')),
                                ),
                              ]),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Rice Bowl',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('  Wapda Town',
                                            style: TextStyle(
                                              fontSize: 15,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Text('4.8',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Stack(alignment: Alignment.bottomLeft, children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/Beach_1.jpg'),
                                    height: 300,
                                    width: 300,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/Beach_1.jpg'),
                                    height: 300,
                                    width: 300,
                                  ),
                                ),
                              ]),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Rice Bowl',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('  Wapda Town',
                                            style: TextStyle(
                                              fontSize: 15,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Text('4.8',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              */
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text('Explore More',
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Stack(alignment: Alignment.bottomLeft, children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/Beach_1.jpg'),
                                  height: 300,
                                  width: 300,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image(
                                image: AssetImage('assets/images/Beach_1.jpg'),
                                height: 300,
                                width: 300,
                              ),
                            ),
                          ]),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, //sizedbox กว้างถึง 150
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jeans Cakes',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Johar Town')
                                  ],
                                ),
                                SizedBox(
                                  width: 158,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text('4.8',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Stack(alignment: Alignment.bottomLeft, children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/Beach_1.jpg'))),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image(
                                  image:
                                      AssetImage('assets/images/Beach_1.jpg')),
                            ),
                          ]),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Thicc Shakes',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Wapda Town')
                                  ],
                                ),
                                SizedBox(
                                  width: 154,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text('4.5',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => DailyPages()),
                        // );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Stack(alignment: Alignment.bottomLeft, children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/Beach_1.jpg'))),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/Beach_1.jpg')),
                              ),
                            ]),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Daily Deli',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('Garden Town')
                                    ],
                                  ),
                                  SizedBox(
                                    width: 180,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text('4.8',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ]),
    ));
  }
}

final List<Widget> imageSliders = [
  Image.asset('assets/images/Beach_1.jpg'),
  Image.asset('assets/images/Beach_2.jpg'),
  Image.asset('assets/images/Beach_3.jpg'),
  Image.asset('assets/images/Beach_4.jpg'),
];
