import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sildeable_list/home_model.dart';
import 'package:sildeable_list/slideable_action.dart';

class SlidableScreen extends StatefulWidget {
  const SlidableScreen({Key? key}) : super(key: key);

  @override
  _SlidableScreenState createState() => _SlidableScreenState();
}

class _SlidableScreenState extends State<SlidableScreen> {

  List<HomeModal> _homeList = [HomeModal('abc'),HomeModal('efgf'),HomeModal('hdgd'),HomeModal('dsfhgsjg'),HomeModal('dfgfd'),HomeModal('dfgdf'),HomeModal('afdfdbc'),HomeModal('fdgf'),HomeModal('dgdfg'),HomeModal('dffd'),HomeModal('drgt'),HomeModal('dfgtr')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Slidable'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
            itemCount: _homeList.length,
            itemBuilder: (context, index){
              final item = _homeList[index];
          return Padding(
            padding: const EdgeInsets.only(left :4.0, right: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Card(
                child: Slidable(
                    //SlidableDrawerActionPane(),
                  //SlidableStrechActionPane()
                  //SlidableScrollActionPane()
                  //SlidableDrawerActionPane()
                  actionExtentRatio: 0.20,
                    key: Key(item.titles),
                    dismissal: SlidableDismissal(
                      child : SlidableDrawerDismissal(),
                      onDismissed: (type){
                        final action = type == SlideActionType.primary ?
                        SlideableAction.order :
                            SlideableAction.wishlist;
                        onDismissed(index, action);
                      },
                    ),
                    actionPane: SlidableStrechActionPane(),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'order',
                    color: Colors.green,
                    icon: Icons.monetization_on,
                    onTap: (){
                      onDismissed(index, SlideableAction.order);
                    },
                  ),
                  IconSlideAction(
                    caption: 'delete',
                    color: Colors.red,
                    icon: Icons.error,
                    onTap: (){
                      onDismissed(index, SlideableAction.delete);
                    },
                  ),

                ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'share',
                      color: Colors.red,
                      icon: Icons.share,
                      onTap: (){
                        onDismissed(index, SlideableAction.share);
                      },
                    ),
                    IconSlideAction(
                      caption: 'wishlist',
                      color: Colors.green,
                      icon: Icons.widgets_sharp,
                      onTap: (){
                        onDismissed(index, SlideableAction.wishlist);
                      },
                    )
                  ],
                  child: buildListTile(item),
                ),
              ),
            ),
          );
        }),

    );
  }
  void onDismissed(int index, SlideableAction action){
    final item = _homeList[index];
    setState(() {
      _homeList.removeAt(index);
    });

    switch (action) {
      case SlideableAction.order :
        final snackBar = SnackBar(
          content:  Text('${item.titles} has been ordered'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
      case SlideableAction.delete :
        final snackBar = SnackBar(
          content:  Text('${item.titles} has been deleted'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
      case SlideableAction.wishlist :
        final snackBar = SnackBar(
          content:  Text('${item.titles} has been added to wishlist'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
      case SlideableAction.share :
        final snackBar = SnackBar(
          content:  Text('${item.titles} has been shared'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
    }
  }
  Widget buildListTile(HomeModal item){
    return Builder(builder: (context) =>  ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      leading: CircleAvatar(
        radius: 25,
        //backgroundColor: Colors.red,
        backgroundImage: NetworkImage('https://images.everydayhealth.com/images/diet-nutrition/34da4c4e-82c3-47d7-953d-121945eada1e00-giveitup-unhealthyfood.jpg?w=1110'),
      ),
      title: Text(item.titles , style: TextStyle(fontSize: 20),),
      onTap: (){
        final slidable = Slidable.of(context);
        final isClosed = slidable!.renderingMode == SlidableRenderingMode.none;
        if(isClosed){
          slidable.open();
        }else{
          slidable.close();
        }
      },
    ));

  }
}
