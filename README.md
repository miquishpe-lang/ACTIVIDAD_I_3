# Actividad Integradora 3

**Base de trabajo:** este proyecto reutiliza y mejora la aplicación Flutter de la Actividad Integradora 2 (portafolio móvil). Se conservan la presentación, las habilidades, las tarjetas de proyectos, la navegación al detalle y el formulario, y se agregan servicios nativos desacoplados.

## Identidad visual
- Nombre comercial: **Nexo Portfolio**.
- Paleta: azul noche `#101827`, turquesa `#20D9D2`, verde lima `#C7F36B` y fondo claro `#F5F7FA`.
- Identificador Android/iOS: `com.mikequishpe.nexoportfolio`.
- Icono de aplicación y splash actualizados.

## Funcionalidades
- Portafolio responsive, habilidades, proyectos y navegación a detalle.
- Monitor de conectividad con stream reactivo y banner cuando no hay interfaz de red.
- Persistencia local del estado de conectividad, borrador de contacto y ruta de última imagen con `shared_preferences`.
- Captura desde cámara y selección desde galería, solicitud de permiso de cámara en tiempo de ejecución, recorte y compresión JPEG.
- Notificaciones locales con canal Android `nexo_events` y solicitud de autorización en iOS/Android.

> La detección de conectividad indica disponibilidad de una interfaz de red; no garantiza que un servidor de Internet responda. La prueba real de conectividad debe verificarse en el dispositivo.

## Arquitectura
- `screens/`: presentación y navegación.
- `widgets/`: componentes visuales reutilizables y banner offline.
- `services/`: conectividad, imágenes/permisos y notificaciones.
- `repositories/`: persistencia local.
- `models/`: modelo de proyecto.

Los servicios no dependen de widgets de pantalla. La UI invoca los servicios y representa el resultado; `LocalRepository` centraliza las preferencias locales. La aplicación usa `StatefulWidget`/`setState` para el estado de conectividad global, sin añadir un framework de estado innecesario.

## Requisitos
- Flutter SDK compatible con `environment.sdk` de `pubspec.yaml`.
- Android Studio o VS Code, Android SDK y emulador/dispositivo.
- Para compilar iOS se requiere macOS con Xcode.

## Instalación y ejecución
```bash
cd ecotec_app
flutter doctor -v
flutter pub get
flutter analyze
flutter test
flutter run
```

## Pruebas manuales recomendadas
1. Desactivar Wi-Fi y datos móviles: debe mostrarse el banner rojo de desconexión; el contenido estático sigue visible.
2. Abrir **Servicios del dispositivo** y tomar una foto: verificar permiso, captura, recorte y previsualización.
3. Abrir la galería: seleccionar una imagen, recortarla y comprobar la previsualización.
4. Pulsar **Enviar notificación de prueba**: aceptar permiso y comprobar la alerta del sistema.
5. Cerrar y reabrir la app para comprobar persistencia del último estado de red y de la ruta de imagen (la ruta puede dejar de existir si el sistema limpia el archivo temporal).

## Permisos nativos
- Android: `INTERNET`, `CAMERA`, `POST_NOTIFICATIONS`.
- iOS: textos de propósito para cámara, biblioteca de fotos y adición a biblioteca.
- La selección de fotos usa el selector del sistema cuando está disponible; los permisos varían según la versión del SO.

## Integración de API REST: catálogo de productos

> Nota: DummyJSON proporciona datos de ejemplo para desarrollo y pruebas; los productos y precios no representan un catálogo comercial real.

La aplicación consume la API pública y gratuita **DummyJSON** para mostrar un catálogo de productos.

- Endpoint: https://dummyjson.com/products?limit=20
- Método HTTP: `GET`
- No requiere token ni autenticación.
- Campos utilizados: `id`, `title`, `description`, `price`, `category`, `thumbnail` y `rating`.
- Dependencias añadidas: `http` para peticiones HTTP y `provider` para gestionar el estado.

### Arquitectura

- `lib/models/product.dart`: modelo Dart y conversión `fromJson` / `toJson`.
- `lib/services/product_api_service.dart`: consumo HTTP y validación de la respuesta.
- `lib/providers/products_provider.dart`: estados `loading`, `success` y `error`.
- `lib/screens/products_screen.dart`: interfaz, tarjetas, reintento y actualización Pull-to-Refresh.

### Ejecutar

Desde la carpeta `ecotec_app`:

```bash
flutter pub get
flutter run
```

En la pantalla principal, seleccionar **Catálogo de productos**. Para actualizar, deslizar la lista hacia abajo o pulsar el icono de recarga. Para comprobar el estado de error, ejecutar la aplicación sin conexión y volver a intentar.
