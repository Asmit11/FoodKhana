import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodkhana/models/ProductModel.dart';
import '../models/CartModel.dart';

class AddToCartRepository {
  final instance = FirebaseFirestore.instance.collection("cart").withConverter(
        fromFirestore: (snapshot, _) {
          return CartModel.fromFirebaseSnapshot(snapshot);
        },
        toFirestore: (CartModel model, _) => model.toJson(),
      );

  Future<dynamic> addToCart(ProductModel data, String id) async {
    try {
      final response = await instance.where("userid", isEqualTo: id).get();
      print(response.size);
      dynamic result;
      if (response.size == 0) {
        print("add");
        result = await instance.add(CartModel(userid: id, products: [data]));
      } else {
        await instance.doc(response.docs.first.id)
            .set({'products': FieldValue.arrayUnion(data as List)} as CartModel);
      }

      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<List<QueryDocumentSnapshot<Object>>> fetchAllCartItems() async {
    try {
      final result = (await instance.get()).docs;
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<void> removeFromCart(String id) async {
    try {
      await instance.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> getCartItem(String id) async {
    try {
      final cartItem = await instance.doc(id).get();
      return cartItem.data()!;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> updateCartItem(String id, CartModel data) async {
    try {
      await instance.doc(id).set(data);
    } catch (e) {
      rethrow;
    }
  }

  addToCartWithDetails(String name, int quantity, double price) async {
    try {
      await FirebaseFirestore.instance.collection('cart').add({
        'name': name,
        'quantity': quantity,
        'price': price,
      });
    } catch (e) {
      throw e;
    }
  }
}
