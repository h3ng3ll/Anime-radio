

import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildListSettingItem extends StatefulWidget {

  const BuildListSettingItem(this.text,  {
    Key? key ,
    required this.icon,
    required this.switchValue,
    required this.callBack
  }) : super(key: key);

  final IconData icon ;
  final String text ;
  final bool switchValue ;
  final Function(bool) callBack ;

  @override
  State<BuildListSettingItem> createState() => _BuildListSettingItemState();
}

class _BuildListSettingItemState extends State<BuildListSettingItem> {

  late bool  switchValue ;

  @override
  void initState() {
    super.initState();
    switchValue = widget.switchValue;
  }

  @override
  Widget build(BuildContext context) {

    final  themeProvider = Provider.of<ThemeProvider>(context , listen:  false);

    bool lightTheme = themeProvider.currentTheme == ThemeMode.light;

    return ListTile(
      leading: Icon(widget.icon),
      title: Row(
        children: [
          Column(
            children: [
              Text(widget.text ),
            ],
          ),
          Switch(
              activeTrackColor: !lightTheme ? ColorService.white : ColorService.black,
              inactiveTrackColor:  !lightTheme ?  ColorService.grey : ColorService.grey,
              thumbColor:    MaterialStateProperty.all<Color>(!lightTheme ?  ColorService.lilac : ColorService.lilac),
              overlayColor:  MaterialStateProperty.all<Color>(ColorService.white.withOpacity(0.3)),
              // thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
              value: switchValue,
              onChanged: (bool value) {
                switchValue = value;
                widget.callBack(value);
                setState(() { });
              }
          ),
        ],
      ),
    );
  }
}
