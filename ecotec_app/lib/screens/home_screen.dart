import 'package:flutter/material.dart';
import '../models/project.dart';
import '../widgets/project_card.dart';
import 'detail_screen.dart';
import 'services_screen.dart';
import 'products_screen.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const projects = <Project>[
    Project(
      title: 'Implementación de servidor Ubuntu',
      category: 'Sistemas',
      description: 'Configuración de un servidor Ubuntu con usuarios, almacenamiento, red, seguridad y administración del sistema.',
      technologies: 'Ubuntu · Linux · VirtualBox',
      icon: Icons.dns_rounded,
    ),
    Project(
      title: 'Moodle, Chamilo y Grafana',
      category: 'Monitoreo',
      description: 'Implementación de plataformas educativas y monitoreo de recursos mediante Prometheus y Grafana.',
      technologies: 'Prometheus · Grafana · Linux',
      icon: Icons.monitor_heart_outlined,
    ),
    Project(
      title: 'Sistema de seguridad con Arduino',
      category: 'IoT',
      description: 'Sistema de control de acceso con teclado, pantalla LCD, LEDs, sensor de gas y alarma sonora.',
      technologies: 'Arduino · Tinkercad · C++',
      icon: Icons.memory_rounded,
    ),
  ];

  static const skills = [
    ('HTML', Icons.code), ('CSS', Icons.palette_outlined),
    ('Git y GitHub', Icons.account_tree_outlined), ('SQL', Icons.storage_rounded),
    ('Python', Icons.terminal_rounded), ('Linux', Icons.computer_rounded),
  ];

  void _openDetails(BuildContext context, Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(project: project)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [
          CircleAvatar(backgroundColor: Color(0xFF20D9D2), radius: 17,
            child: Text('MQ', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
          SizedBox(width: 10), Text('Nexo Portfolio'),
        ]),
      ),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFF101827),
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF101827), Color(0xFF1B2A3F)],
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 650;
              final intro = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PORTAFOLIO PERSONAL',
                    style: TextStyle(
                      color: Color(0xFF20D9D2), fontSize: 11,
                      fontWeight: FontWeight.bold, letterSpacing: 1.8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text.rich(
                    TextSpan(children: [
                      TextSpan(text: 'Hola, soy\n', style: TextStyle(color: Colors.white)),
                      TextSpan(text: 'Mike Quishpe Alban', style: TextStyle(color: Color(0xFF20D9D2))),
                    ]),
                    style: TextStyle(fontSize: 28, height: 1.15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Estudiante de Ingeniería en Sistemas Inteligentes',
                    style: TextStyle(color: Color(0xFFE1E5EA), fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Me interesa el desarrollo de aplicaciones, las bases de datos, la administración de sistemas y las soluciones tecnológicas funcionales.',
                    style: TextStyle(color: Color(0xFFD0D5DC), height: 1.5),
                  ),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF20D9D2),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _openDetails(context, projects.first),
                    icon: const Icon(Icons.work_outline),
                    label: const Text('Explorar proyectos'),
                  ),
                ],
              );

              final portrait = Container(
                width: isWide ? 220 : 190,
                height: isWide ? 220 : 190,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFC7F36B), width: 3),
                  boxShadow: const [
                    BoxShadow(color: Color(0x3320D9D2), blurRadius: 24, spreadRadius: 1),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/profile_mike.jpeg',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    semanticLabel: 'Fotografía de Mike Quishpe Alban',
                    errorBuilder: (context, error, stackTrace) => const ColoredBox(
                      color: Color(0xFF1B2A3F),
                      child: Icon(Icons.person, color: Colors.white, size: 80),
                    ),
                  ),
                ),
              );

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: intro),
                    const SizedBox(width: 28),
                    portrait,
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [intro, const SizedBox(height: 24), Center(child: portrait)],
              );
            },
          ),
        ),
        const SizedBox(height: 26),
        const Text('Mis habilidades', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: skills.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 2.45),
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE3E6EA))),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(children: [Icon(skills[index].$2, color: colors.primary, size: 21), const SizedBox(width: 8), Expanded(child: Text(skills[index].$1, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))) ]),
          ),
        ),
        const SizedBox(height: 22),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Container(width: 46, height: 46, decoration: BoxDecoration(color: const Color(0xFF20D9D2).withOpacity(.16), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.devices_other_rounded, color: Color(0xFF101827))),
              const SizedBox(width: 12),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Servicios del dispositivo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text('Cámara, galería, recorte y notificaciones locales', style: TextStyle(fontSize: 12, color: Color(0xFF5D6674))),
              ])),
              IconButton(tooltip: 'Abrir servicios nativos', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ServicesScreen())), icon: const Icon(Icons.arrow_forward_rounded)),
            ]),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Container(width: 46, height: 46,
                decoration: BoxDecoration(color: const Color(0xFF20D9D2).withOpacity(.16), borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.storefront_outlined, color: Color(0xFF101827))),
              const SizedBox(width: 12),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Catálogo de productos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text('Consulta productos desde una API REST pública', style: TextStyle(fontSize: 12, color: Color(0xFF5D6674))),
              ])),
              IconButton(tooltip: 'Abrir catálogo', onPressed: () {
                context.read<ProductsProvider>().loadProducts();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductsScreen()));
              }, icon: const Icon(Icons.arrow_forward_rounded)),
            ]),
          ),
        ),
        const SizedBox(height: 26),
        const Text('Proyectos destacados', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        for (final project in projects)
          ProjectCard(project: project, onDetails: () => _openDetails(context, project)),
        const SizedBox(height: 8),
        const Text('¿Tienes una idea o proyecto académico? Abre los detalles de cualquier proyecto para dejar un mensaje.', style: TextStyle(color: Color(0xFF5D636C), height: 1.4)),
        const SizedBox(height: 20),
        const Center(child: Text('© 2026 Mike Quishpe Alban', style: TextStyle(color: Color(0xFF777D85), fontSize: 12))),
      ]),
    );
  }
}
