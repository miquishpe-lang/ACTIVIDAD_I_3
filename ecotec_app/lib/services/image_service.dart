import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePermissionException implements Exception {
  const ImagePermissionException(this.message, {this.permanentlyDenied = false});
  final String message;
  final bool permanentlyDenied;

  @override
  String toString() => message;
}

/// Encapsula permisos, selección, captura, recorte y compresión básica.
class ImageService {
  ImageService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();
  final ImagePicker _picker;

  Future<String?> captureOrChoose(ImageSource source) async {
    if (source == ImageSource.camera) {
      var status = await Permission.camera.status;
      if (status.isDenied || status.isRestricted) {
        status = await Permission.camera.request();
      }
      if (!status.isGranted) {
        throw ImagePermissionException(
          status.isPermanentlyDenied
              ? 'El permiso de cámara está bloqueado. Actívalo en Ajustes.'
              : 'Se necesita permiso de cámara para tomar una fotografía.',
          permanentlyDenied: status.isPermanentlyDenied,
        );
      }
    }

    final selected = await _picker.pickImage(
      source: source,
      imageQuality: 82,
      maxWidth: 1600,
      maxHeight: 1600,
    );
    if (selected == null) return null;

    // El recorte permite ajustar la imagen y guardar una versión JPEG comprimida.
    final cropped = await ImageCropper().cropImage(
      sourcePath: selected.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 82,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Ajustar imagen',
          toolbarColor: const Color(0xFF101827),
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: const Color(0xFF20D9D2),
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Ajustar imagen', doneButtonTitle: 'Guardar', cancelButtonTitle: 'Cancelar'),
      ],
    );
    return cropped?.path;
  }
}
