
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class BuildSwitchSettingItem extends StatefulWidget {

   BuildSwitchSettingItem(this.text,  {
    Key? key ,
    this.icon,
    required this.switchValue,
    required this.callBack,
    this.customIcon = false,
    this.iconWidget,
    this.switchDisabled = false,
  }) : assert(
      icon != null && customIcon == false ||
      iconWidget != null && customIcon == true
  ) , super(key: key);

  factory BuildSwitchSettingItem.customIcon (String text, {
    Key? key ,
    required  Widget iconWidget,
    required bool switchValue,
    required Function(bool) callBack,
    bool? switchDisabled,
  }) => BuildSwitchSettingItem(
        text,
        switchValue: switchValue,
        callBack: callBack,
        customIcon:  true,
        iconWidget: iconWidget,
        switchDisabled: switchDisabled ?? false,
  );

  final bool customIcon;
  final Widget? iconWidget;
  final IconData? icon ;
  final String text ;
  bool switchValue ;
  final Function(bool) callBack ;
  final bool switchDisabled;

  @override
  State<BuildSwitchSettingItem> createState() => _BuildSwitchSettingItemState();
}

class _BuildSwitchSettingItemState extends State<BuildSwitchSettingItem> {


  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: widget.icon != null ?  Icon(widget.icon) : widget.iconWidget,
      title: Row(
        children: [
          Text(
            widget.text ,
            style: TextStyle(
                color: widget.switchDisabled ? ColorService.grey : null
            ),
          ),
          const Spacer() ,
          Switch(
              activeTrackColor: widget.switchDisabled ?
                  ColorService.dGrey :
                  ColorService.lighterPink1 ,

              inactiveTrackColor: ColorService.grey,

              thumbColor:    MaterialStateProperty.all<Color>(
                  widget.switchDisabled ?
                        ColorService.grey :

                        widget.switchValue ?
                            ColorService.lilac :
                            ColorService.greyShimmer
              ),
              value: widget.switchValue,
              onChanged: widget.switchDisabled ? null :   (bool value) {
                widget.switchValue = value;
                widget.callBack(value);
                setState(() { });
              }
          ),
        ],
      ),
    );
  }
}
