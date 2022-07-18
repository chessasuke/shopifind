// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shopifind/preview/preview_map.dart';

// class Preview extends StatefulWidget {
//   const Preview({Key? key}) : super(key: key);

//   @override
//   State<Preview> createState() => _PreviewState();
// }

// class _PreviewState extends State<Preview> {

// int _selectIndex = 0;

//   @override
//   Widget build(BuildContext context) {

//     Size dialogSize = const Size(380, 600);

//     TabBarView _views = TabBarView(children: [
//       PreviewMap(dialogSize: dialogSize),
//       Text(
//         'Index 1: Business',
//       ),
//       Text(
//         'Index 2: School',
//       ),
//             Text(
//         'Index 2: School',
//       ),
//     ]);

//     return Dialog(
//         child: Container(
//       decoration: BoxDecoration(border: Border.all(width: 2)),
//       width: dialogSize.width,
//       height: dialogSize.height,
//       child: DefaultTabController(
//         length: 4,
//         child: Scaffold(
//           bottomNavigationBar: SizedBox(
//             height: 50,
//             child: const TabBar(
//             tabs: <Widget>[
//               Tab(
//                   icon: Icon(Icons.cloud_outlined),
//                 ),
//               Tab(
//                 icon: Icon(Icons.cloud_outlined),
//               ),
//               Tab(
//                 icon: Icon(Icons.beach_access_sharp),
//               ),
//               Tab(
//                 icon: Icon(Icons.brightness_5_sharp),
//               ),
//             ],
//         ),
//           ),
//           // bottomNavigationBar: BottomNavigationBar(
            
//           //   items: const <BottomNavigationBarItem>[
//           //     BottomNavigationBarItem(
//           //       icon: Icon(Icons.home),
//           //       label: 'Home',
//           //     ),
//           //     BottomNavigationBarItem(
//           //       icon: Icon(Icons.business),
//           //       label: 'Business',
//           //     ),
//           //     BottomNavigationBarItem(
//           //       icon: Icon(Icons.school),
//           //       label: 'School',
//           //     ),
//           //   ],
//           //   currentIndex: _selectIndex,
//           //   selectedItemColor: Colors.amber[800],
//           //   onTap: (newView) =>
//           //       setState(() {
//           //         _selectIndex = newView;
//           //       }),
//           // ),
//           body: _views,
//         ),
//       ),

//       // PreviewMap(dialogSize: dialogSize)
//     ));
//   }
// }
