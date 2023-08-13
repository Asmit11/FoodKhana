import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/ProductModel.dart';
<<<<<<< HEAD

=======
// import '../../../../Desktop/Foodkhana/lib/repositories/ProductRepository.dart';
>>>>>>> d266eb9d0571a7e5f587797b8f123ca40156582a
import '../repositories/ProductRepository.dart';

class ProductViewModel with ChangeNotifier{
  List<QueryDocumentSnapshot<ProductModel>> _productData =[];
  List<QueryDocumentSnapshot<ProductModel>> get productData => _productData;

  Future<void> fetchData() async{
    try{
      final response = await ProductRepository().fetchAllProducts();
      _productData=response;
      notifyListeners();
    }catch(e){
      print(e);
    }
  }

}