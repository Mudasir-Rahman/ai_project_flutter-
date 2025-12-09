import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({super.key});

  @override
  State<FileUploadPage> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  bool _isUploading = false;
  bool _uploadComplete = false;
  double _progressValue = 0.0;
  String? _uploadedFileName;
  String? _fileSize;
  String? _uploadError;

  // Assuming you have an UploadUseCase instance
  final UploadUseCase _uploadUseCase = UploadUseCase();

  Future<void> _uploadFile() async {
    // Reset states
    setState(() {
      _isUploading = true;
      _uploadComplete = false;
      _uploadError = null;
      _progressValue = 0.0;
    });

    try {
      // Call the use case to pick and upload file
      final result = await _uploadUseCase.uploadFile(
        onProgress: (progress) {
          setState(() {
            _progressValue = progress;
          });
        },
      );

      // Handle success
      setState(() {
        _isUploading = false;
        _uploadComplete = true;
        _uploadedFileName = result.fileName;
        _fileSize = result.fileSize;
        _progressValue = 1.0;
      });

    } catch (error) {
      // Handle error
      setState(() {
        _isUploading = false;
        _uploadComplete = false;
        _uploadError = error.toString();
      });

      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _simulateUploadForDemo() {
    // For demo purposes, simulate upload progress
    setState(() {
      _isUploading = true;
      _uploadComplete = false;
      _uploadError = null;
      _progressValue = 0.0;
    });

    // Simulate progress updates
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        _progressValue = 0.2;
      });
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _progressValue = 0.4;
      });
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _progressValue = 0.6;
      });
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _progressValue = 0.75;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isUploading = false;
        _uploadComplete = true;
        _uploadedFileName = 'Physics_Notes_Ch1.pdf';
        _fileSize = '2.4 MB';
        _progressValue = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload a New PDF',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Upload icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
              ),
              child: Icon(
                Icons.upload_file,
                size: 50,
                color: _isUploading ? Colors.grey[400] : Colors.blue[700],
              ),
            ),

            const SizedBox(height: 30),

            // Upload text or progress label
            if (!_isUploading && !_uploadComplete)
              const Text(
                'Tap to upload PDF',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

            if (_isUploading)
              const Text(
                'Extracting Text...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

            const SizedBox(height: 40),

            // Progress indicator when uploading
            if (_isUploading) ...[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: LinearProgressIndicator(
                  value: _progressValue,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              const SizedBox(height: 10),

              // Progress percentage
              Text(
                '${(_progressValue * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],

            // Error message
            if (_uploadError != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error, color: Colors.red[600]),
                    const SizedBox(width: 8),
                    Text(
                      _uploadError!,
                      style: TextStyle(color: Colors.red[600]),
                    ),
                  ],
                ),
              ),
            ],

            // Success state
            if (_uploadComplete && _uploadedFileName != null) ...[
              const SizedBox(height: 20),

              const Text(
                'Upload Successful',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 30),

              // File card
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red[600],
                      size: 40,
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _uploadedFileName!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _fileSize != null ? 'PDF Document • $_fileSize' : 'PDF Document',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(
                      Icons.check_circle,
                      color: Colors.green[500],
                      size: 24,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Go to Content Hub button
              ElevatedButton(
                onPressed: () {
                  // Navigate to content hub
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ContentHubPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Go to Content Hub',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),

      // Floating action button for upload
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadFile,
        // For demo, you can use: onPressed: _simulateUploadForDemo,
        backgroundColor: Colors.blue[700],
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

// Example UploadUseCase class (adapt to your actual implementation)
class UploadUseCase {
  Future<UploadResult> uploadFile({
    required Function(double) onProgress,
  }) async {
    // Implement actual file picking and uploading logic
    // This should include:
    // 1. File picker to select PDF
    // 2. Upload to server/storage
    // 3. Update progress via onProgress callback
    // 4. Return upload result

    // Simulated implementation:
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      onProgress(i / 100);
    }

    return UploadResult(
      fileName: 'Physics_Notes_Ch1.pdf',
      fileSize: '2.4 MB',
      fileUrl: 'uploaded_file_url',
    );
  }
}

class UploadResult {
  final String fileName;
  final String fileSize;
  final String fileUrl;

  UploadResult({
    required this.fileName,
    required this.fileSize,
    required this.fileUrl,
  });
}