import 'package:flutter/material.dart';
void main(){runApp(MaterialApp(home:AppEcole(),debugShowCheckedModeBanner:false));}
class AppEcole extends StatelessWidget{
@override Widget build(BuildContext c){
return Scaffold(
appBar: AppBar(title:Text("DIGITALIZ SCHOOL PN"),backgroundColor:Color(0xFF0D1B5E)),
body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children:[
Icon(Icons.school,size:100,color:Color(0xFF0D1B5E)),
SizedBox(height:20),
Text("DIGITALIZ SCHOOL",style:TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
Text("Pointe-Noire",style:TextStyle(fontSize:18)),
SizedBox(height:30),
Text("Bravo ZEMIRA !",style:TextStyle(color:Colors.green,fontSize:22,fontWeight:FontWeight.bold)),
Text("Ton app marche !",style:TextStyle(fontSize:18)),
])),
);
}
}
