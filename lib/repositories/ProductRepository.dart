import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ProductModel.dart';
class ProductRepository{
  final instance = FirebaseFirestore.instance.collection("products").withConverter(
      fromFirestore: (snapshot, _){
        return ProductModel.fromFirebaseSnapshot(snapshot);
        },
        toFirestore: (ProductModel model, _)=>model.toJson());

  Future<dynamic>createProduct(ProductModel data) async{
    try{
      final result=await instance.add(data);
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<List<QueryDocumentSnapshot<ProductModel>>> fetchAllProducts() async{
    try{
      final result=(await instance.get()).docs;
      return result;
    } catch (e) {
      return[];
    }
  }

  Future<void>deleteProduct(String id) async{
    try{
      await instance.doc(id).delete();
    }catch(e){
      rethrow;
    }
  }

  Future<ProductModel>getOneProduct(String id) async{
    try{
      final product = await instance.doc(id).get();
      return product.data()!;
    }catch(e){
      print(e);
        rethrow;
    }
  }

  Future<dynamic>updateProduct(String id, ProductModel data) async{
    try{
      await instance.doc(id).set(data);
    } catch(e){
      rethrow;
    }

  }


  addProduct(String name, String description) async{
    try {
          await FirebaseFirestore.instance.collection('products').add({
            'name': name,
            'description': double.parse(description),
          });
        } catch (e) {
          throw e;
        }
  }



}