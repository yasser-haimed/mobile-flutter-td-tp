import 'dart:convert'; // Pour convertir les données JSON en objets Dart et vice versa
import 'dart:io'; // Pour gérer les entrées/sorties, notamment les requêtes HTTP
import 'package:http/http.dart' as http; // Pour effectuer des requêtes HTTP (GET, POST, etc.)

Future<void> getProducts(String baseUrl) async {
  final response = await http.get(Uri.parse('$baseUrl/products'));

  if (response.statusCode == 200) {
    List<dynamic> products = jsonDecode(response.body);
    print('Produits disponibles:');
    for (var product in products) {
      print('Nom: ${product['name']}, Prix: ${product['price']}');
    }
  } else {
    print('Erreur lors de la récupération des produits');
  }
}

Future<void> getOrders(String baseUrl) async {
  final response = await http.get(Uri.parse('$baseUrl/orders'));

  if (response.statusCode == 200) {
    List<dynamic> orders = jsonDecode(response.body);
    print('Commandes disponibles:');
    for (var order in orders) {
      print('Produit: ${order['product']}, Quantité: ${order['quantity']}');
    }
  } else {
    print('Erreur lors de la récupération des commandes');
  }
}

Future<void> addOrder(String baseUrl, Map<String, dynamic> order) async {
  final response = await http.post(
    Uri.parse('$baseUrl/orders'),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: jsonEncode(order),
  );

  if (response.statusCode == 201) {
    print('Commande créée avec succès');
  } else {
    print('Erreur lors de la création de la commande');
  }
}

Future<void> addProduct(String baseUrl, Map<String, dynamic> product) async {
  final response = await http.post(
    Uri.parse('$baseUrl/products'),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: jsonEncode(product),
  );

  if (response.statusCode == 201) {
    print('Produit ajouté avec succès');
  } else {
    print('Erreur lors de l\'ajout du produit');
  }
}

void main() async {
  // Base URL for the server
  final String baseUrl = 'http://localhost:3000';

  // Fetch all products
  await getProducts(baseUrl);

  // Add a new product
  final newProduct = {'name': 'Produit 1', 'price': 100};
  await addProduct(baseUrl, newProduct);

  // Fetch all orders
  await getOrders(baseUrl);

  // Add a new order
  final newOrder = {'product': 'Produit 1', 'quantity': 2};
  await addOrder(baseUrl, newOrder);
}