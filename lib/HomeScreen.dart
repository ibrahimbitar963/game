import 'package:flutter/material.dart';
import 'package:game/ItemModel.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ItemModel> items;
  late List<ItemModel> items2;
  late  int score;
  late bool gameOver;
  initGame(){
    gameOver = false;
    score= 0;
    items=[
      ItemModel(value: 'lion', name: 'Lion', img: 'assets/pic/lion.png'),
      ItemModel(value: 'panda', name: 'Panda', img: 'assets/pic/panda.png'),
      ItemModel(value: 'camel', name: 'Camel', img: 'assets/pic/camel.png'),
      ItemModel(value: 'dog', name: 'Dog', img: 'assets/pic/dog.png'),
      ItemModel(value: 'cat', name: 'Cat', img: 'assets/pic/cat.png'),
      ItemModel(value: 'horse', name: 'Horse', img: 'assets/pic/horse.png'),
      ItemModel(value: 'sheep', name: 'Sheep', img: 'assets/pic/sheep.png'),
      ItemModel(value: 'hen', name: 'Hen', img: 'assets/pic/hen.png'),
      ItemModel(value: 'fox', name: 'Fox', img: 'assets/pic/fox.png'),
      ItemModel(value: 'cow', name: 'Cow', img: 'assets/pic/cow.png'),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }
  @override
  void initState() {
    super.initState();
    initGame();
  }


  @override
  Widget build(BuildContext context) {
    if (items.length == 0) gameOver = true;
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(

        title: Text(
          'Drag and Drop Game'
            ),
        leading: IconButton(
          onPressed: (){},
          icon:Icon(
          Icons.menu
          ),
        ),
        backgroundColor: Colors.white10,
      ),
      body: SafeArea(

        child: SingleChildScrollView(

          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Score: ',

                       style: TextStyle(
                         fontSize: 25,
                       ),
                      ),
                      TextSpan(
                        text: '$score',

                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!gameOver)
                Row(
                  children: [
                    Spacer(),
                    Column(
                      children: items.map((item) {
                        return Container(
                          margin: EdgeInsets.all(8),
                          child: Draggable<ItemModel>(

                            data: item,
                            childWhenDragging: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(item.img),
                              radius: 50,
                            ),
                            feedback: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(item.img),
                              radius: 30,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(item.img),
                              radius: 30,
                            ),
                          ),
                        );
                      }
                      ).toList()
                    ),
                    Spacer(flex:3),
                    Column(
                      children: items2.map((item) {
                        return DragTarget<ItemModel>(
                          onAccept: (receivedItem) {
                            if (item.value == receivedItem.value) {
                              setState(() {
                                items.remove(receivedItem);
                                items2.remove(item);
                              });
                              score += 10;
                              item.accepting = false;

                            } else {
                              setState(() {
                                score -= 5;
                                item.accepting = false;
                              });
                            }
                          },
                          onWillAccept: (receivedItem) {
                            setState(() {
                              item.accepting = true;
                            });
                            return true;
                          },
                          onLeave: (receivedItem) {
                            setState(() {
                              item.accepting = false;
                            });
                          },
                          builder: (context, acceptedItems, rejectedItems) =>
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: item.accepting
                                        ? Colors.grey[400]
                                        : Colors.grey[200],
                                  ),
                                  alignment: Alignment.center,
                                  height:
                                  MediaQuery.of(context).size.width / 6.5,
                                  width: MediaQuery.of(context).size.width / 3,
                                  margin: EdgeInsets.all(8),
                                  child: Text(
                                    item.name,
                                    style:
                                    Theme.of(context).textTheme.headline6,
                                  )),
                        );
                      }).toList(),
                    ),
                    Spacer(),
                  ],
                ),
              if (gameOver)
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Game Over',
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          result(),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ],
                  ),
                ),
              if (gameOver)
                Container(
                  height: MediaQuery.of(context).size.width / 10,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          initGame();
                        });
                      },
                      child: Text(
                        'New Game',
                        style: TextStyle(color: Colors.white),
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }

  //Functions:

  String result() {
    if (score == 100) {
      return 'Awesome!';
    } else {
      return 'Play again to get better score';
    }
  }
}