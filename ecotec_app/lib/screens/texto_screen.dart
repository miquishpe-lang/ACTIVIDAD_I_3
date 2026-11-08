import 'package:flutter/material.dart';

class TextoScreen extends StatelessWidget {
   
const TextoScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    //final anchopantalla= MediaQuery.of(context).size.width;
   // debugPrint(' ancho pantalla $anchopantalla');
   final ancho = double.infinity;
  debugPrint('El ancho de la pantalla es $ancho');



    return  Scaffold(
      appBar: AppBar(title: Text('Widgets de Texto'),),
      body: Center(
         child: Column(
          children: [


                Container(
                  //como detectar el ancho de mi pantalla
                  //width: anchopantalla,
                  
                  width: double.infinity,
                  height: 50,
         
                  color: Colors.amber,
                  child: Text('Duis id deserunt esse cupidatat culpa dolor veniam dolor Lorem consequat. Duis nulla id sit veniam. Cupidatat incididunt occaecat anim officia labore est aute voluptate duis et nisi aliquip. Culpa enim cupidatat incididunt labore sit pariatur consequat minim culpa officia officia cupidatat aliqua laborum. Laborum aliquip ad reprehenderit anim occaecat deserunt nisi.'
         
                  
                  ,),
                )

          ],
         ),
      ),
    );
  }
}