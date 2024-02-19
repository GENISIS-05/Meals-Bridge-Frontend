import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cached_network_image/cached_network_image.dart';


class HomeScreenDistributor extends StatefulWidget {
  // final double screenHeight;
  // final double screenWidth;
  const HomeScreenDistributor({Key? key}) : super(key: key);

  @override
  State<HomeScreenDistributor> createState() => _HomeScreenDistributor();
}

class _HomeScreenDistributor extends State<HomeScreenDistributor> {

  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.019157088,),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.topLeft,
            child: CachedNetworkImage(
              imageUrl: 'Image',
              placeholder: (context, url) => CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.lightGreen,
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.red,
              ),
            ),
          ),

          // Container(
          //   padding: EdgeInsets.all(16.0),
          //   alignment: Alignment.topLeft,
          //   child: Text(
          //     'Current Location: ${_currentPosition?.latitude ?? 0.0}, ${_currentPosition?.longitude ?? 0.0}',
          //     style: TextStyle(fontSize: 16.0),
          //   ),
          // ),

          Expanded(
            child: ListView(

              children: [
                MyCardView(title: "XYZ", imageUrl: "https://www.google.com/search?q=silicon+website&tbm=isch&chips=q:silicon+website,online_chips:silicon+institute:IwEpddL_wYo%3D&prmd=invsmbtz&rlz=1C1CHBD_enIN990IN990&hl=en&sa=X&ved=2ahUKEwi50qGwj7WEAxVGS2wGHVqZD7kQ4lYoAHoECAEQNA&biw=1519&bih=730#imgrc=ZrbnLf4UVCMqrM", distance: 4.5, quantity: 7.9,),
                MyCardView(title: "XYZ", imageUrl: "https://www.google.com/search?q=silicon+website&tbm=isch&chips=q:silicon+website,online_chips:silicon+institute:IwEpddL_wYo%3D&prmd=invsmbtz&rlz=1C1CHBD_enIN990IN990&hl=en&sa=X&ved=2ahUKEwi50qGwj7WEAxVGS2wGHVqZD7kQ4lYoAHoECAEQNA&biw=1519&bih=730#imgrc=ZrbnLf4UVCMqrM", distance: 4.5, quantity: 7.9,),
                MyCardView(title: "XYZ", imageUrl: "https://www.google.com/search?q=silicon+website&tbm=isch&chips=q:silicon+website,online_chips:silicon+institute:IwEpddL_wYo%3D&prmd=invsmbtz&rlz=1C1CHBD_enIN990IN990&hl=en&sa=X&ved=2ahUKEwi50qGwj7WEAxVGS2wGHVqZD7kQ4lYoAHoECAEQNA&biw=1519&bih=730#imgrc=ZrbnLf4UVCMqrM", distance: 4.5, quantity: 7.9,),
                // Add more card views as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class MyCardView extends StatelessWidget {
  final String title; // Assuming title is the organization name
  final String imageUrl; // Image URL from API
  final double distance; // Distance from distributor
  final double quantity; // Quantity of food

  MyCardView({
    required this.title,
    required this.imageUrl,
    required this.distance,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {

    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 80.0, // Adjust as needed
                  height: 80.0, // Adjust as needed
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: wi * 0.045801527),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'Distance: $distance km',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: he * 0.019157088),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantity: $quantity kg',
                  style: TextStyle(fontSize: 16.0),
                ),
                ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    // Handle Details button click
                  },
                  child: Text('Details'),
                ),
              ],
            ),
          ],
        ),
        // Add more widgets or customize as needed
      ),
    );
  }
}



