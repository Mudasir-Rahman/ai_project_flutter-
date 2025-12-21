import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../domin/file_usecase/upload_file_usecase.dart';
import '../bloc/file_bloc.dart';
import '../bloc/file_event.dart';
import '../bloc/file_state.dart';

class FileUploadPage extends StatefulWidget {
  final String userId;

  const FileUploadPage({
    super.key,
    required this.userId,
  });

  @override
  State<FileUploadPage> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  bool _isUploading = false;
  String? _uploadedFileName;
  String? _fileSize;
  FileType _selectedType = FileType.custom;
  bool _showOptions = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FileBloc, FileState>(
      listener: (context, state) {
        if (state is FileLoading) {
          setState(() {
            _isUploading = true;
          });
        } else if (state is FileUploaded) {
          setState(() {
            _isUploading = false;
            _uploadedFileName = state.file.name;
            _fileSize = state.file.size.toString();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is FileError) {
          setState(() {
            _isUploading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Upload File"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Upload Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: _isUploading ? null : _toggleOptions,
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text("Upload"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Show File/Image Options when _showOptions is true
              if (_showOptions)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Choose Upload Type",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // File Upload Option
                            _buildOptionButton(
                              icon: Icons.insert_drive_file,
                              label: "File",
                              onPressed: () => _uploadFile(FileType.custom),
                              isSelected: _selectedType == FileType.custom,
                            ),

                            // Image Upload Option
                            _buildOptionButton(
                              icon: Icons.image,
                              label: "Image",
                              onPressed: () => _uploadImage(),
                              isSelected: _selectedType == FileType.image,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              if (_isUploading)
                Column(
                  children: [
                    const LinearProgressIndicator(),
                    const SizedBox(height: 10),
                    Text(
                      "Uploading...",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),

              if (_uploadedFileName != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Uploaded File:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              _selectedType == FileType.image
                                  ? Icons.image
                                  : Icons.insert_drive_file,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _uploadedFileName!,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (_fileSize != null)
                          Text(
                            "Size: ${_formatFileSize(_fileSize!)}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required bool isSelected,
  }) {
    return Column(
      children: [
        IconButton.filled(
          onPressed: onPressed,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            backgroundColor: isSelected
                ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                : null,
            foregroundColor: isSelected
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
          ),
        ),
      ],
    );
  }

  void _toggleOptions() {
    setState(() {
      _showOptions = !_showOptions;
    });
  }

  Future<void> _uploadFile(FileType fileType) async {
    setState(() {
      _selectedType = fileType;
      _showOptions = false;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: fileType == FileType.custom ? ['pdf', 'doc', 'docx'] : null,
      );

      if (result == null) return;

      final filePath = result.files.single.path!;
      final fileName = result.files.single.name;
      final extension = fileName.split('.').last;

      final params = UploadFileParams(
        filePath: filePath,
        userId: widget.userId,
        fileExtension: extension,
        fileName: fileName,
      );

      context.read<FileBloc>().add(UploadFileEvent(params));
    } catch (e) {
      _showErrorSnackBar('Error picking file: $e');
    }
  }

  Future<void> _uploadImage() async {
    setState(() {
      _selectedType = FileType.image;
      _showOptions = false;
    });

    try {
      final imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (image == null) return;

      final params = UploadFileParams(
        filePath: image.path,
        userId: widget.userId,
        fileExtension: 'jpg',
        fileName: image.name,
      );

      context.read<FileBloc>().add(UploadFileEvent(params));
    } catch (e) {
      _showErrorSnackBar('Error picking image: $e');
    }
  }

  String _formatFileSize(String bytes) {
    try {
      final sizeInBytes = double.parse(bytes);
      if (sizeInBytes < 1024) {
        return '${sizeInBytes.toStringAsFixed(0)} B';
      } else if (sizeInBytes < 1024 * 1024) {
        return '${(sizeInBytes / 1024).toStringAsFixed(1)} KB';
      } else {
        return '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      }
    } catch (e) {
      return '$bytes bytes';
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}