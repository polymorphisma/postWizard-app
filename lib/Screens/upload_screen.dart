import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  final TextEditingController _contextController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio();

  // Selected social media platforms
  final List<String> _selectedSocialMedia = [];

  // Variables to store the link and generated text from the backend
  String? _uploadedImageUrl;
  String? _generatedText;

  void _toggleSocialMediaSelection(String platform) {
    setState(() {
      if (_selectedSocialMedia.contains(platform)) {
        _selectedSocialMedia.remove(platform);
      } else {
        _selectedSocialMedia.add(platform);
      }
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadData() async {
    if (_selectedImage == null || _selectedSocialMedia.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image and choose at least one social media platform.')),
      );
      return;
    }

    try {
      FormData formData = FormData.fromMap({
        'images': await MultipartFile.fromFile(_selectedImage!.path, filename: _selectedImage!.path.split('/').last),
        'context': _contextController.text,
        'socialMedia': _selectedSocialMedia.join(","),
      });

      Response response = await _dio.post(
        'http://10.0.2.2:3000/api/v1/ai/upload', // Replace with your backend URL
        data: formData,
      );

      if (response.statusCode == 200 && response.data is List && response.data.isNotEmpty) {
        // Extract the link and generated text from the response
        setState(() {
          _uploadedImageUrl = response.data[0]['message'];
          _generatedText = response.data[0]['generated_text'];
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: ${response.data["message"]}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image Selection
            _selectedImage != null
                ? Image.file(_selectedImage!)
                : Text('No image selected'),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 16),

            // Context Input
            TextField(
              controller: _contextController,
              decoration: InputDecoration(labelText: 'Context'),
            ),
            SizedBox(height: 16),

            // Social Media Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialMediaIcon(
                  platform: 'LinkedIn',
                  icon: FontAwesomeIcons.linkedin,
                  isSelected: _selectedSocialMedia.contains('LinkedIn'),
                ),
                SizedBox(width: 16),
                _buildSocialMediaIcon(
                  platform: 'Twitter',
                  icon: FontAwesomeIcons.twitter,
                  isSelected: _selectedSocialMedia.contains('Twitter'),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Upload Button
            ElevatedButton(
              onPressed: _uploadData,
              child: Text('Upload'),
            ),

            // Display the uploaded image URL and generated text if available
            if (_uploadedImageUrl != null) ...[
              SizedBox(height: 16),
              Text('Image uploaded successfully!'),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Open the link in a browser or do something with it
                  print('Link clicked: $_uploadedImageUrl');
                },
                child: Text(
                  _uploadedImageUrl!,
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],

            if (_generatedText != null) ...[
              Text(
                'Generated Text:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(_generatedText!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaIcon({
    required String platform,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _toggleSocialMediaSelection(platform),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: isSelected ? Colors.blue : Colors.grey,
        child: FaIcon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
