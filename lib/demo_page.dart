import 'package:flutter/material.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class StartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              child: Text('Open both routes'),
              onPressed: () {
                print("Navigator.push(FirstWidget)");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstWidget()),
                );
                print("Navigator.push(SecondWidget)");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondWidget()),
                );
              },
            ),
            TextButton(
              child: Text('Open FirstWidget'),
              onPressed: () {
                print("Navigator.push(FirstWidget)");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstWidget()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FirstWidget extends StatefulWidget {
  @override
  _FirstWidgetState createState() => _FirstWidgetState();
}

class _FirstWidgetState extends RouteAwareState<FirstWidget> {
  Widget build(BuildContext context) {
    print("build $widget");
    return Scaffold(
      appBar: AppBar(
        title: Text('FirstWidget'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              child: Text('Open SecondWidget'),
              onPressed: () {
                print("Navigator.push(SecondWidget)");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondWidget()),
                );
              },
            ),
            TextButton(
              child: Text('back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondWidget extends StatefulWidget {
  @override
  _SecondWidgetState createState() => _SecondWidgetState();
}

class _SecondWidgetState extends RouteAwareState<SecondWidget> {
  @override
  Widget build(BuildContext context) {
    print("build $widget");
    return Scaffold(
      appBar: AppBar(
        title: Text('SecondWidget'),
      ),
      body: Center(
        child: TextButton(
          child: Text('back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

abstract class RouteAwareState<T extends StatefulWidget> extends State<T>
    with RouteAware {
  @override
  void didChangeDependencies() {
    print("didChangeDependencies $widget");
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute); //Subscribe it here
    super.didChangeDependencies();
  }

  @override
  void didPush() {
    print('didPush $widget');
  }

  @override
  void didPopNext() {
    print('didPopNext $widget');
  }

  @override
  void didPop() {
    print('didPop $widget');
  }

  @override
  void didPushNext() {
    print('didPushNext $widget');
  }

  @override
  void dispose() {
    print("dispose $widget");
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
