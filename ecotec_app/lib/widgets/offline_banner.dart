import 'package:flutter/material.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) => Material(
        color: const Color(0xFFB42318),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            child: Row(children: const [
              Icon(Icons.wifi_off_rounded, color: Colors.white, size: 18),
              SizedBox(width: 9),
              Expanded(child: Text('Sin conexión de red. Puedes seguir consultando el contenido guardado.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12))),
            ]),
          ),
        ),
      );
}
