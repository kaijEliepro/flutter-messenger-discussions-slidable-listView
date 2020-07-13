
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttermestutos/entites/donnees.dart';
import 'package:fluttermestutos/entites/personne.dart';

class Discussions extends StatefulWidget {
  @override
  _DiscussionsState createState() => _DiscussionsState();
}

class _DiscussionsState extends State<Discussions>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  List<Personne> personnes = personnesData;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Discussions',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        leading: Container(
          padding: EdgeInsets.only(left: 16, top: 3, bottom: 3),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.asset('assets/images/louisxvi.jpg',fit: BoxFit.fill,),
            ),
          ),
        ),
        actions: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white12,
            child: IconButton(
              icon: Icon(Icons.photo_camera, size: 22,color: Color.fromARGB(195, 195, 195, 1),),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            backgroundColor: Colors.white12,
            child: IconButton(
              icon: Icon(Icons.mode_edit, size: 22,color: Color.fromARGB(195, 195, 195, 1),),
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
       body: SingleChildScrollView(
         child: Column(
           children: _buildList(),
         ),
       ),
    );
  }
   List<Widget>_buildList(){
       List<Widget> items =[];
        items.add(_search());
        items.add(_itemsConnected());

        for(int i =0; i<personnes.length;i++){
          items.add(
            Container(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: _slidable(i),
            )
          );
        }

       return items;
   }
  _search(){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30),
          ),
          color: Colors.white12,
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
             icon: Icon(
               Icons.search,
               color: Color.fromARGB(159, 159, 159, 1),
             ),
            suffixIcon: Container(
              width: 80,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.black12,
              ),
              child: Center(
                child: Text('Textos', style: TextStyle(
                  color: Color.fromARGB(159, 159, 159, 1)
                ),),
              ),
            ),
            hintText: "Search",
            hintStyle: TextStyle(
              color: Color.fromARGB(159, 159, 159, 1),
            )
          ),
        ),
      ),
    );
  }

  _itemsConnected(){
    return Container(
      height: 85,
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 16),
      child: ListView.builder(
        itemCount: personnes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return Container(
            width: 60,
            margin: EdgeInsets.only(right: 16),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(

                     height: 55,
                      width: 55,
                      padding: EdgeInsets.all(personnes[index].isChat ? 2:0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white12,
                        border: personnes[index].isChat ?
                        Border.all(width:0):
                        Border.all(width: 3, color: Colors.blue),
                      ),

                      child: ClipOval(
                        child: index ==0 ?
                           IconButton(
                             icon: Icon(Icons.add,
                               size: 30,
                               color: Color.fromARGB(195, 195, 195, 1),
                             ),
                           )
                            :
                            Image.asset('assets/images/avatar.png'),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        height: index ==0 ?0 :18,
                        width: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                          color: Colors.green,
                          border: Border.all(
                            color: Colors.black, width: 3
                          ),
                        ),
                      ),
                      bottom: 0,
                      right: 0,
                    ),
                  ],
                ),

                index ==0 ? Text(
                  'Your strory',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white60
                  ),
                ) :Text(
                    '${personnes[index].nom}',
                  style: TextStyle(
                    color: personnes[index].isChat ?Colors.white : Colors.white60
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _slidable(int i){
     return Slidable(
         key: ValueKey(personnes[i].index),
       actionPane:  SlidableDrawerActionPane(),
       actions: <Widget>[
         myIconSlideAction('Photo', Colors.blue, Icons.photo_camera, context),
         myIconSlideAction('Appel', Colors.white12, Icons.call, context),
         myIconSlideAction('Camera', Colors.white12, Icons.videocam, context)
       ],
       secondaryActions: <Widget>[
         myIconSlideAction('Menu', Colors.white12, Icons.menu, context),
         myIconSlideAction('Alert', Colors.white12, Icons.add_alert, context),
         myIconSlideAction('Delete', Colors.red, Icons.delete, context)
       ],

        dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(),
          closeOnCanceled: true,
          onWillDismiss: (actionType){
            return showDialog<bool>(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text('Delete'),
                  content: Text('Item will be deleted'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: ()=> Navigator.of(context).pop(false),
                    ),
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: ()=> Navigator.of(context).pop(true),
                    ),
                  ],
                );
              }
            );
          },
        ),

       child: ListTile(
         contentPadding: EdgeInsets.only(bottom: 10, right: 8),
         leading:                Stack(
           children: <Widget>[
             Container(

               height: 55,
               width: 55,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(30)),
                 color: Colors.white12,
               ),
               child: ClipOval(
                 child: Image.asset('assets/images/avatar.png'),
               ),
             ),
             Positioned(
               child: Container(
                 height: personnes[i].isConnected ? 18:0,
                 width: 18,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(9)),
                   color: Colors.green,
                   border: Border.all(
                       color: Colors.black, width: 3
                   ),
                 ),
               ),
               bottom: 0,
               right: 0,
             ),
           ],
         ),
         title: Padding(
           padding: EdgeInsets.only(bottom: 16),
           child: Text(
             '${personnes[i].nom}',
                 style: TextStyle(
                 color: Colors.white
           ),
           ),
         ),
         subtitle: Text(
           '${personnes[i].message}',
           style: TextStyle(
             color: Colors.white70
           ),
         ),
         trailing: Icon(
           Icons.check_circle,
           size:20,
           color: personnes[i].isVu ? Colors.white54 : Colors.transparent

         ),
       ),
     );
  }

   myIconSlideAction(String text, Color colors, IconData icons, BuildContext context){

    return IconSlideAction (
       iconWidget: CircleAvatar(
         child: Icon(
           icons,
           color: Colors.white,
         ),
         backgroundColor: colors,
       ),
      color: Colors.black,
      onTap: ()=> _showSnackBar(context, text) ,
    );

   }
  void _showSnackBar(BuildContext context, String text){
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text),));
  }
}
