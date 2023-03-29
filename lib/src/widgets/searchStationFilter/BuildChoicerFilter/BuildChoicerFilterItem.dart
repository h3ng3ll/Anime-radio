

import 'package:anime_radio/src/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class BuildChoicerFilterItem<T> extends StatefulWidget {
  const BuildChoicerFilterItem({
    Key? key,
    required this.addFunction,
    required this.items,
    required this.title,
    required this.onChangeItem,
    required this.initialValue,
    required this.textColor,
    required this.dropDownBackground,
    required this.underline,
    required this.iconDropDownEnabled
  }) : super(key: key);

  final T initialValue;
  final void  Function () addFunction;
  final void  Function (T) onChangeItem;
  final List<T> items;
  final String title;

  /// decoration
  final Color textColor ;
  final Color dropDownBackground ;
  final Color underline ;
  final Color iconDropDownEnabled;

  @override
  State<BuildChoicerFilterItem> createState() => _BuildChoicerFilterItemState();
}

class _BuildChoicerFilterItemState<T> extends State<BuildChoicerFilterItem> {

  T? value ;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(
                widget.title ,
                style:  TextStyle(
                    fontSize: 24 ,
                    color: widget.textColor  ,
                    decoration: TextDecoration.underline
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: widget.dropDownBackground,
                    borderRadius: BorderRadius.circular(17.5)
                ),
                child: DropdownButton<T>(
                    isExpanded: true,
                    underline: Container(
                      color: widget.underline,
                      height: 1,
                      width: 20,
                    ),
                    iconEnabledColor: widget.iconDropDownEnabled,
                    menuMaxHeight: size.height/4,
                    value:  value ?? widget.initialValue ?? widget.items.first,
                    items: widget.items.map<DropdownMenuItem<T>>((dynamic item) {

                      if(item is Enum) {
                        return DropdownMenuItem(
                            value: item as T,
                            child: Text(item.name.capitalize())
                        );
                      }

                      return DropdownMenuItem(
                          value: item,
                          child: Text(item.toString())
                      );
                    }).toList(),
                    onChanged: (dynamic item) {
                      if(item != null){
                        /// additional function
                        widget.onChangeItem(item);

                        value = item;
                        setState(() { });
                      }

                    }
                ),
              ),
            ),
            IconButton(
                onPressed: widget.addFunction,
                icon: const Icon(Icons.add ,)
            ),

          ],
        ),
        const SizedBox(height: 10,)
      ],
    );
  }
}
