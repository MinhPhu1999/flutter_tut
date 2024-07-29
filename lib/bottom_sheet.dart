import 'package:flutter/material.dart';

class DraggableSheet extends StatefulWidget {
  final Widget child;
  const DraggableSheet({super.key, required this.child});

  @override
  State<DraggableSheet> createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
  }

  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.05) collapse();
  }

  void collapse() => animateSheet(getSheet.snapSizes!.first);
  // void anchor() => animateSheet(getSheet.snapSizes!.last);
  // void expand() => animateSheet(getSheet.maxChildSize);
  // void hide() => animateSheet(getSheet.minChildSize);

  void animateSheet(double size) => controller.animateTo(size,
      duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);

  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return DraggableScrollableSheet(
          key: sheet,
          initialChildSize: 0.5,
          maxChildSize: 0.95,
          minChildSize: 0,
          expand: true,
          snap: true,
          snapSizes: [60 / constraints.maxHeight, 0.5],
          controller: controller,
          builder: (BuildContext context, ScrollController scrollController) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  topButtonIndicator(),
                  SliverToBoxAdapter(
                    child: widget.child,
                  )
                ],
              ),
            );
          });
    });
  }
}

SliverToBoxAdapter topButtonIndicator() {
  return SliverToBoxAdapter(
      child: Container(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              child: Center(
                  child: Wrap(children: <Widget>[
            Container(
              width: 50,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              height: 5,
              decoration: const BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
            )
          ])))
        ]),
  ));
}

class BottomSheetDummyUI extends StatelessWidget {
  const BottomSheetDummyUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      color: Colors.black45,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          color: Colors.black12,
                          height: 20,
                          width: 240,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                              color: Colors.black12, height: 20, width: 180)),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  )
                ]),
                const SizedBox(height: 10)
              ],
            )));
  }
}
