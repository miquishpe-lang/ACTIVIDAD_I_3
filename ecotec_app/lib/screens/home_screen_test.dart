import 'package:flutter/material.dart';

class HomeScreenTest extends StatelessWidget {
   
const HomeScreenTest({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(title: Text('Mi App',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),backgroundColor: Colors.green,) ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          
          children: [
            Text('Texto1'),
            Text('Texto2'),
            Text('Texto3'),
            Icon(Icons.person),
            ElevatedButton(
              onPressed: (){

                debugPrint('Presionaste el boton');
              
              
              }, child: Text('Enviar')),
        

        Row(children: [Text('Textoa'), Text('Texto B')],)
        
        
        ],),
      )
    );
  }
}