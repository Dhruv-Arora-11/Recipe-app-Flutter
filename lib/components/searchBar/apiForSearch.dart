
import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchAPI {
  static const String _baseUrl = 'www.themealdb.com'; // Corrected base URL.
  static const String _searchPath = '/api/json/v1/1/search.php';

  final http.Client client;

  SearchAPI({http.Client? client}) : client = client ?? http.Client();

  // Method to fetch meals by first letter
  Future<List<Map<String, dynamic>>> fetchMealsByFirstLetter(
      String letter) async {
    final Uri url =
        Uri.https(_baseUrl, _searchPath, {'f': letter}); // Use Uri.https
    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['meals'] != null) {
          // Ensure meals is not null
          return List<Map<String, dynamic>>.from(
              data['meals']); //important cast
        } else {
          return [];
        }
      } else {
        throw Exception(
            'Failed to load meals by first letter: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching meals by first letter: $e');
      return [];
    }
  }

  // Method to fetch meals by name
  Future<List<Map<String, dynamic>>> fetchMealsByName(String name) async {
    final Uri url =
        Uri.https(_baseUrl, _searchPath, {'s': name}); // Use Uri.https
    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['meals'] != null) {
          // 'meals' can be null
          return List<Map<String, dynamic>>.from(
              data['meals']); // Explicitly cast.
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load meals by name: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching meals by name: $e');
      return [];
    }
  }
}