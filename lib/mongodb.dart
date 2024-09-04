import 'dart:developer';
import 'package:hotel_manager/MongoDBModel.dart';
import 'package:hotel_manager/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    userCollection = db.collection(COLLECTION_NAME);
    // print(await collection.find().toList());
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSucess) {
        return "data Inserted ";
      } else {
        return "Something wrong while inserting data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
