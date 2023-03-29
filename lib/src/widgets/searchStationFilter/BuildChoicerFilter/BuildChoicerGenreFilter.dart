//
//
//
// import 'package:anime_radio/src/extensions/string_extensions.dart';
// import 'package:anime_radio/src/models/MusicGenre.dart';
// import 'package:anime_radio/src/providers/FilterStationProvider.dart';
// import 'package:anime_radio/src/services/ColorService.dart';
// import 'package:anime_radio/src/widgets/searchStationFilter/BuildChoicerFilter/AddFilterButton.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:provider/provider.dart';
//
// class BuildChoicerGenreFilter extends StatefulWidget {
//
//   const BuildChoicerGenreFilter({
//     Key? key,
//     required this.setState,
//     required this.titleColor,
//
//   }) : super(key: key);
//
//   final Function (Function ()) setState;
//
//   final Color titleColor ;
//   @override
//   State<BuildChoicerGenreFilter> createState() => _BuildChoicerGenreFilterState();
// }
//
// class _BuildChoicerGenreFilterState extends State<BuildChoicerGenreFilter> {
//   @override
//   Widget build(BuildContext context) {
//
//     final size = MediaQuery.of(context).size;
//     final provider = Provider.of<FilterStationProvider>(context , listen:  false);
//
//     MusicGenre genre = provider.genre;
//
//     return Row(
//       children: [
//         Text("${AppLocalizations.of(context)!.by_genre}\t\t" ,
//           style: TextStyle(
//               fontSize: 24 ,
//               color: widget.titleColor ,
//               decoration: TextDecoration.underline
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(5),
//           decoration: BoxDecoration(
//               color:  ColorService.ddGrey ,
//               borderRadius: BorderRadius.circular(17.5)
//           ),
//           child: DropdownButton<MusicGenre>(
//               underline: Container(
//                 color: ColorService.white,
//                 height: 1,
//                 width: 20,
//               ),
//               iconEnabledColor: ColorService.lilac,
//               menuMaxHeight: size.height/4,
//               value:  genre,
//               items: MusicGenre.values.map<DropdownMenuItem<MusicGenre>>(( MusicGenre genre) => DropdownMenuItem<MusicGenre>(
//
//                   value: genre,
//                   child: Text(genre.name.capitalize())
//               ) ).toList(),
//               onChanged: (newGenre) {
//                 if(newGenre == null) return ;
//                 provider.genre = newGenre;
//                 setState(() {}) ;
//               }
//           ),
//         ),
//         AddFilterButton(
//             onPressed: () {
//               provider.filter.addGenre(genre);
//               provider.update();
//             }
//         ),
//       ],
//     );
//   }
// }
