// import 'package:anime_radio/src/providers/FilterStationProvider.dart';
// import 'package:anime_radio/src/services/ColorService.dart';
// import 'package:anime_radio/src/widgets/searchStationFilter/BuildChoicerFilter/AddFilterButton.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class BuildChoicerCountryFilter extends StatefulWidget {
//
//   const BuildChoicerCountryFilter({
//     Key? key,
//     required this.setState, required this.titleColor
//   }) : super(key: key);
//
//   final Function (Function ()) setState;
//   final Color titleColor ;
//
//   @override
//   State<BuildChoicerCountryFilter> createState() => _BuildChoicerCountryFilterState();
// }
//
// class _BuildChoicerCountryFilterState extends State<BuildChoicerCountryFilter> {
//   @override
//   Widget build(BuildContext context) {
//
//     final size = MediaQuery.of(context).size;
//     final provider = Provider.of<FilterStationProvider>(context , listen:  false);
//     final countriesList = provider.countriesList(context);
//
//     return Row(
//       children: [
//         Text("${AppLocalizations.of(context)!.location}\t\t" ,
//           style:  TextStyle(
//               fontSize: 24 ,
//               color: widget.titleColor ,
//               decoration: TextDecoration.underline),
//         ),
//         Container(
//           padding: const  EdgeInsets.all(5),
//           decoration: BoxDecoration(
//               color:  ColorService.ddGrey,
//               borderRadius: BorderRadius.circular(17.5)
//           ),
//           child: DropdownButton<String>(
//               underline: Container(
//                 color: ColorService.ddGrey,
//                 height: 1,
//                 width: 20,
//               ),
//               iconEnabledColor: ColorService.lilac,
//               menuMaxHeight: size.height/4,
//               // value: filter.countryIndex.isNotEmpty ?
//               // countriesList[filter.countryIndex.last] :
//               // countriesList.first,
//               value: countriesList[provider.countryIndex],
//               items: countriesList.map<DropdownMenuItem<String>>(( String country) =>
//                   DropdownMenuItem<String>(
//                       value: country,
//                       child: Text(country)
//                   )).toList(),
//               onChanged: (country) {
//                 if(country == null) return ;
//                 provider.countryIndex = countriesList.indexOf(country);
//                 setState(() { });
//               }
//           ),
//         ),
//         AddFilterButton(
//             onPressed: () {
//               provider.filter.addCounty(provider.countryIndex);
//               provider.update();
//             }
//         ),
//
//       ],
//     );
//   }
// }
