import 'package:flutter/cupertino.dart';
import 'package:quest_2/styles/size.dart';

class TypeEventWidget extends StatefulWidget {
  TypeEventWidget({Key? key}) : super(key: key);

  @override
  State<TypeEventWidget> createState() => _TypeEventWidgetState();
}

class _TypeEventWidgetState extends State<TypeEventWidget> {
  late FixedExtentScrollController scrollController;
  final items = [
    'Run',
    'Game',
    'Play',
    'Dance',
    'FreeStyle',
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            items[index],
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: height(context: context) / 50,
            ),
            child: CupertinoButton.filled(
                child: Text(
                  'Open Picker',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      actions: [buildPickerType()],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text('Done'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    ));
  }

  Widget buildPickerType() => SizedBox(
        height: 180,
        child: CupertinoPicker(
          scrollController: scrollController,
          // looping: true,
          itemExtent: 64,
          children: items
              .map((item) => Center(
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 24),
                    ),
                  ))
              .toList(),
          onSelectedItemChanged: (index) {
            setState(() => this.index = index);

            final item = items[index];
            print('Selected Item: $item');
          },
        ),
      );
}
