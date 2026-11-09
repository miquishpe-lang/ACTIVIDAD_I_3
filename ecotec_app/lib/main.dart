import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/products_provider.dart';
import 'services/product_api_service.dart';
import 'screens/home_screen.dart';
import 'services/connectivity_service.dart';
import 'services/notification_service.dart';
import 'repositories/local_repository.dart';
import 'widgets/offline_banner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductsProvider(ProductApiService()),
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});
  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  final ConnectivityService _connectivity = ConnectivityService();
  final LocalRepository _repository = LocalRepository();
  StreamSubscription<bool>? _subscription;
  bool _online = true;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      _online = await _connectivity.checkInitialStatus();
      if (mounted) setState(() {});
      await _repository.saveNetworkStatus(_online);
    } catch (error) {
      debugPrint('No se pudo consultar la conectividad inicial: $error');
    }
    _subscription = _connectivity.onlineStream.listen((online) async {
      if (!mounted) return;
      setState(() => _online = online);
      try { await _repository.saveNetworkStatus(online); }
      catch (error) { debugPrint('No se pudo persistir la conectividad: $error'); }
    }, onError: (Object error) => debugPrint('Error en stream de conectividad: $error'));
    try { await NotificationService.instance.initialize(); }
    catch (error) { debugPrint('No se pudo inicializar notificaciones: $error'); }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF101827);
    const cyan = Color(0xFF20D9D2);
    const lime = Color(0xFFC7F36B);
    return MaterialApp(
      title: 'Nexo Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: cyan, brightness: Brightness.light).copyWith(
          primary: navy, secondary: cyan, tertiary: lime, surface: const Color(0xFFF5F7FA),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(backgroundColor: navy, foregroundColor: Colors.white, centerTitle: false),
        cardTheme: CardThemeData(elevation: 1, color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
        filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(backgroundColor: navy, foregroundColor: Colors.white)),
      ),
      builder: (context, child) => Column(children: [
        if (!_online) const OfflineBanner(),
        Expanded(child: child ?? const SizedBox.shrink()),
      ]),
      home: const HomeScreen(),
    );
  }
}
