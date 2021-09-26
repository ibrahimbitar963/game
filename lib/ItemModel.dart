

class ItemModel {
   late String name;
   late String img;
   late String value;
  bool accepting;

  ItemModel({required this.value,required this.img,required this.name,this.accepting = false});
}