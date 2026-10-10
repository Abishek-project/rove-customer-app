import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/repositories/profile_repository.dart';
import '../localization/l10n.dart';

/// A file chosen for upload. [deleteAfterUpload] is true for temporary
/// copies the app made (photos), so identity documents don't linger.
class PickedDocument {
  const PickedDocument(this.file, {this.deleteAfterUpload = false});
  final UploadFile file;
  final bool deleteAfterUpload;
}

String contentTypeFor(String fileName) {
  final ext = fileName.split('.').last.toLowerCase();
  return switch (ext) {
    'pdf' => 'application/pdf',
    'png' => 'image/png',
    'jpg' || 'jpeg' => 'image/jpeg',
    'heic' => 'image/heic',
    _ => 'application/octet-stream',
  };
}

enum _Source { gallery, camera, pdf }

/// Lets the customer choose a photo, take one, or pick a PDF.
Future<PickedDocument?> pickDocument(BuildContext context) async {
  final l10n = context.l10n;
  final source = await showModalBottomSheet<_Source>(
    context: context,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: Text(l10n.uploadChoosePhoto),
            onTap: () => Navigator.of(context).pop(_Source.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: Text(l10n.uploadTakePhoto),
            onTap: () => Navigator.of(context).pop(_Source.camera),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(l10n.uploadChoosePdf),
            onTap: () => Navigator.of(context).pop(_Source.pdf),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
  if (source == null) return null;
  try {
    switch (source) {
      case _Source.gallery:
      case _Source.camera:
        final image = await ImagePicker().pickImage(
          source: source == _Source.camera
              ? ImageSource.camera
              : ImageSource.gallery,
          imageQuality: 85,
          maxWidth: 2400,
          requestFullMetadata: false,
        );
        if (image == null) return null;
        final name = image.name.toLowerCase().endsWith('.png')
            ? image.name
            : _jpegName(image.name);
        return PickedDocument(
          UploadFile(
            fileName: name,
            contentType: contentTypeFor(name),
            path: image.path,
          ),
          deleteAfterUpload: true,
        );
      case _Source.pdf:
        final file = await FilePicker.pickFile(
          type: FileType.custom,
          allowedExtensions: const ['pdf'],
        );
        if (file == null || file.path == null) return null;
        return PickedDocument(
          UploadFile(
            fileName: file.name,
            contentType: 'application/pdf',
            path: file.path,
          ),
          deleteAfterUpload: true,
        );
    }
  } on Exception {
    return null;
  }
}

String _jpegName(String name) {
  final dot = name.lastIndexOf('.');
  final base = dot > 0 ? name.substring(0, dot) : name;
  return '$base.jpg';
}
