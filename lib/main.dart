import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

   
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
TextEditingController name=TextEditingController();
TextEditingController mobile=TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('hi');
    return Scaffold(

 resizeToAvoidBottomPadding: false,
      body:Container(


       child: Column(
          children: <Widget>[
      Column(
        children: <Widget>[
         Container(
           child:SizedBox(
          height: 100,
           ),
         ),
          Container(
          child:Text("Send data to fire base", style: new TextStyle(
      fontSize: 20.0,
      color: Colors.blue,
    ),),
         ),
          Container(

         child: TextField(
  decoration: InputDecoration(
    border: InputBorder.none,
    hintText: 'Enter name'
  ),
  controller: name,
),

          ),
          Container(
         child: TextField(
  decoration: InputDecoration(
    border: InputBorder.none,
    hintText: 'Mobile'
  ),
  controller: mobile,
),

          ),
          Container(
            child:  RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    
                    color: Colors.blue[50],
                   onPressed: (){
   if(name.text.isNotEmpty && mobile.text.isNotEmpty){
     Firestore.instance.collection('Flutter ').add({'Name':name.text,'Mobile':mobile.text});
   }
                   },
                    child: new Text("Add to list"),
                ),
          )
        ],
      ),
       Container(
            height: 390,
            width: 400,
            color: Colors.blue[50],
            child: StreamBuilder(
                stream: Firestore.instance.collection('Flutter ').orderBy('Name',descending: false).snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    print(snapshot.data.documents);
                   return ListView.builder(
                       itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context,int index){
                       return ListTile(
                         leading: Text(snapshot.data.documents[index]['Name']),
                        title:Text(snapshot.data.documents[index]['Mobile']),
                        trailing: RaisedButton(onPressed: 
                    //     ()async{await Firestore.instance.runTransaction((Transaction transactionHandler)async{
                    //       await transactionHandler.delete(snapshot.data.documents[index].reference);});
                    // }  
                         ()async{await Firestore.instance.runTransaction((Transaction transactionHandler)async{
                          await transactionHandler.update(snapshot.data.documents[index].reference,{'Name':'dany','Mobile':'9847543845'});});
                         }),

                        );
                        
                      }
                    );
                  }
                },
              ),
          ),

],)


      )
     
    );
  }
}
