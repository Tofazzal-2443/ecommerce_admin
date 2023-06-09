import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/models/category_model.dart';
import 'package:ecommerce_admin/models/notification_model.dart';
import 'package:ecommerce_admin/models/order_constant_model.dart';
import 'package:ecommerce_admin/models/order_model.dart';
import 'package:ecommerce_admin/models/product_model.dart';
import 'package:ecommerce_admin/models/purchase_model.dart';

import '../models/comment_model.dart';
import '../models/user_model.dart';

class DbHelper {
  static const String collectionAdmin = 'Admins';
  static final _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addCategory(CategoryModel categoryModel) {
    final catDoc = _db.collection(collectionCategory).doc();
    categoryModel.categoryId = catDoc.id;
    return catDoc.set(categoryModel.toMap());
  }

  static Future<void> addNewProduct(
      ProductModel productModel, PurchaseModel purchaseModel) {
    final wb = _db.batch();
    final productDoc = _db.collection(collectionProduct).doc();
    final purchaseDoc = _db.collection(collectionPurchase).doc();
    productModel.productId = productDoc.id;
    purchaseModel.productId = productDoc.id;
    purchaseModel.purchaseId = purchaseDoc.id;
    wb.set(productDoc, productModel.toMap());
    wb.set(purchaseDoc, purchaseModel.toMap());
    final updatedCount =
        purchaseModel.purchaseQuantity + productModel.category.productCount;
    final catDoc = _db
        .collection(collectionCategory)
        .doc(productModel.category.categoryId);
    wb.update(catDoc, {categoryFieldProductCount: updatedCount});
    return wb.commit();
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants() =>
      _db.collection(collectionUtils).doc(documentOrderConstants).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrders() =>
      _db.collection(collectionOrder).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllPurchases() =>
      _db.collection(collectionPurchase).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductsByCategory(
      String categoryName) =>
      _db
          .collection(collectionProduct)
          .where('$productFieldCategory.$categoryFieldName',
          isEqualTo: categoryName)
          .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() =>
      _db.collection(collectionUser).snapshots();

  static Future<void> updateProductField(
      String productId, Map<String, dynamic> map) {
    return _db.collection(collectionProduct).doc(productId).update(map);
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllPurchaseByProductId(
      String productId) =>
      _db
          .collection(collectionPurchase)
          .where(purchaseFieldProductId, isEqualTo: productId)
          .get();

  static Future<void> repurchase(
      PurchaseModel purchaseModel, ProductModel productModel) async {
    final wb = _db.batch();
    final doc = _db.collection(collectionPurchase).doc();
    purchaseModel.purchaseId = doc.id;
    wb.set(doc, purchaseModel.toMap());
    final productDoc =
    _db.collection(collectionProduct).doc(productModel.productId);
    wb.update(productDoc, {
      productFieldStock: (productModel.stock + purchaseModel.purchaseQuantity)
    });
    final snapshot = await _db
        .collection(collectionCategory)
        .doc(productModel.category.categoryId)
        .get();
    final previousCount = snapshot.data()?[categoryFieldProductCount] ?? 0;
    final catDoc = _db
        .collection(collectionCategory)
        .doc(productModel.category.categoryId);
    wb.update(catDoc, {
      categoryFieldProductCount:
      (purchaseModel.purchaseQuantity + previousCount)
    });
    return wb.commit();
  }

  static Future<void> updateOrderConstants(OrderConstantModel model) {
    return _db
        .collection(collectionUtils)
        .doc(documentOrderConstants)
        .update(model.toMap());
  }

  static Future<void> updateOrderStatus(String orderId, String status) {
    return _db
        .collection(collectionOrder)
        .doc(orderId)
        .update({orderFieldOrderStatus: status});
  }

  static Future<bool> doesUserExist(String uid) async {
    final snapshot = await _db.collection(collectionUser).doc(uid).get();
    return snapshot.exists;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllNotifications() =>
      _db.collection(collectionNotification).snapshots();

  static Future<void> updateNotificationStatus(String id) {
    return _db
        .collection(collectionNotification)
        .doc(id)
        .update({notificationFieldStatus: true});
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getCommentsByProduct(
      String productId) =>
      _db
          .collection(collectionProduct)
          .doc(productId)
          .collection(collectionComment)
          .get();

  static Future<void> approveComment(String productId, CommentModel commentModel) {
    return _db.collection(collectionProduct)
        .doc(productId)
        .collection(collectionComment)
        .doc(commentModel.commentId)
        .update({commentFieldApproved : true});
  }
}
