import 'package:flutter/material.dart';
import 'package:smooth_avatar/smooth_avatar.dart';

class ImagenesScreen extends StatelessWidget {
  const ImagenesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Widgets de imagenes')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child:   
             Center(
               child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  //  backgroundImage: NetworkImage('https://picsum.photos/300/300'),
                  backgroundImage: AssetImage('assets/persona.jpeg',),
                ),
             ),
              
              
              
              ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {},
            ),
             ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {},
            ),
             ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {},
            ),
             ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {},
            ),

            SizedBox(height: 50,),


                   Text('Version 1.1.0'),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 20, offset: Offset(0, 5))],
                ),
                child: Image.network(
                  'https://picsum.photos/300/200',
                  width: 300,
                ),
              ),
              SizedBox(height: 40),

              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(30),
                child: Image.network('https://picsum.photos/300/200'),
              ),

              SizedBox(height: 40),

              FadeInImage.assetNetwork(
                placeholder: 'assets/gif/jar-loading.gif',

                image: 'https://picsum.photos/300/200',
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),

              SizedBox(height: 40),

              Text('Circle Avatar'),

              SizedBox(height: 40),

              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,

                //  backgroundImage: NetworkImage('https://picsum.photos/300/300'),
                backgroundImage: AssetImage('assets/persona.jpeg'),
              ),
              SizedBox(height: 40),

              Text('Smooth Avatar'),
              SmoothAvatar(
                image: NetworkImage(
                  'https://randomuser.me/api/portraits/women/68.jpg',
                ),
                radius: 80,
                borderColor: Colors.blue,
                borderWidth: 5,
              ),

              SizedBox(height: 40),

              Text('Opacidad en imagenes'),
              SizedBox(height: 40),

              Opacity(opacity: 0.6, child: Image.asset('assets/persona.jpeg')),


       
            ],
          ),
        ),
      ),
    );
  }
}
