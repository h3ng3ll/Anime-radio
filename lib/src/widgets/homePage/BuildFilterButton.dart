

import 'package:anime_radio/src/dialogs/BuildSearchStationFilterDialog.dart';
import 'package:anime_radio/src/models/StationFilter.dart';
import 'package:anime_radio/src/providers/FilterStationProvider.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildFilterButton extends StatefulWidget {
  const BuildFilterButton({Key? key, required this.updateFilter}) : super(key: key);

  final Function (StationFilter?)  updateFilter;
  @override
  State<BuildFilterButton> createState() => _BuildFilterButtonState();

}

class _BuildFilterButtonState extends State<BuildFilterButton> {

  bool  isAppliedFilter = false;


  Future<void> dialogFunction () async {
    var provider = Provider.of<FilterStationProvider>(context ,listen:  false);
    final themeProvider = Provider.of<ThemeProvider>(context ,listen:  false);

    final bool? applyFilter = await showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "",
        context: context,
        barrierColor: Colors.transparent,
        pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
            ChangeNotifierProvider.value(
              value: provider,
              child: searchStationFilterDialog(
                  context: context,
                  theme: themeProvider.currentTheme
              ),
            )
    );

     // ignore: use_build_context_synchronously
     provider = Provider.of<FilterStationProvider>(context ,listen:  false);

    /// condition complete if User apply the filter and this one  is unique .
    if(applyFilter == true
        // && provider.filter != previousFilter
    ) {

      isAppliedFilter = true;


      widget.updateFilter(provider.filter);
      setState(() { });
    }
    /// filter was active and now it going to turn off .
    else if (!provider.isActiveFilter && isAppliedFilter) {
      isAppliedFilter = false;
      widget.updateFilter(null);
      setState(() {});
    }


  }

  @override
  Widget build(BuildContext context) {

    return IconButton(
        onPressed: dialogFunction ,
        icon:  Icon(
            isAppliedFilter ?
              Icons.filter_alt :
              Icons.filter_alt_outlined

        ));
  }
}
