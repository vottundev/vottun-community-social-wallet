import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/db/shared_payment.dart';
import 'package:social_wallet/models/db/shared_payment_response_model.dart';
import 'package:social_wallet/models/db/shared_payment_users.dart';
import 'package:social_wallet/models/db/update_user_wallet_info.dart';
import 'package:social_wallet/models/db/user_contact.dart';
import 'package:social_wallet/models/direct_payment_model.dart';
import 'package:social_wallet/models/user_nfts_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/custodied_wallets_info_response.dart';
import '../../models/db/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();
  final String dbName = "database.db";

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    bool exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (exception) {
        print("exception: $exception");
      }

      //copy from asset
      ByteData data = await rootBundle.load(join("assets", "database.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    db = await openDatabase(path, onCreate: (database, version) async {
      await createMockData(database);
    }, version: 3);
  }

  Future<void> createMockData(Database database) async {
    List<CustodiedWalletsInfoResponse>? prevCustomers =
        await getWalletCubit().getCustomerCustiodedWallets();
    String insertQuery = "";
    if (prevCustomers != null) {
      if (prevCustomers.isNotEmpty) {
        insertQuery =
            'INSERT INTO Users(id, vottunId, strategy, userEmail, username, password, accountHash, creationTimestamp) VALUES ';

        String valuesList = "";

        for (var element in prevCustomers) {
          valuesList +=
              '(NULL, "${element.id}",${element.strategy}, "${element.userEmail}", "${element.userEmail.split("@")[0]}", "Doonamis.2022!", "${element.accountHash}", ${element.creationTimestamp}),';
        }

        if (valuesList.isNotEmpty) {
          insertQuery = insertQuery + valuesList;
          //remove last comma, if not throws error
          insertQuery = insertQuery.substring(0, insertQuery.length - 1);
        } else {
          //todo no results
          insertQuery = "";
        }
      }
    }

    await database.execute(
      //todo "CREATE TABLE Users(id INTEGER PRIMARY KEY AUTOINCREMENT, strategy INTEGER NOT NULL, userEmail TEXT NOT NULL UNIQUE, username TEXT NOT NULL UNIQUE, password TEXT, accountHash TEXT UNIQUE, creationTimestamp INTEGER NOT NULL)",
      "CREATE TABLE Users(id INTEGER PRIMARY KEY AUTOINCREMENT, vottunId TEXT, strategy INTEGER, userEmail TEXT NOT NULL UNIQUE, username TEXT NOT NULL, password TEXT, accountHash TEXT, creationTimestamp INTEGER NOT NULL)",
    );
    await database.execute(
      "CREATE TABLE UserContact(id INTEGER NOT NULL, vottunId TEXT NOT NULL, userId INTEGER NOT NULL, email TEXT NOT NULL, username TEXT NOT NULL, address TEXT, FOREIGN KEY (userId) REFERENCES Users(id))",
    );

    //todo amount always int (wei)?
    await database.execute(
      "CREATE TABLE SharedPayments(id INTEGER PRIMARY KEY, ownerId INTEGER NOT NULL, numConfirmations INTEGER NOT NULL, ownerUsername TEXT NOT NULL, hasBeenExecuted INTEGER NOT NULL, ownerEmail TEXT NOT NULL, ownerAddress INTEGER NOT NULL, totalAmount REAL NOT NULL, currencyAddress TEXT, currencyName TEXT NOT NULL, currencySymbol TEXT NOT NULL, tokenDecimals INTEGER, userAddressTo TEXT NOT NULL, networkId INTEGER NOT NULL, creationTimestamp INTEGER NOT NULL, FOREIGN KEY (ownerId) REFERENCES Users(id))",
    );

    await database.execute(
      "CREATE TABLE SharedPaymentsUsers(id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER NOT NULL, sharedPaymentId INTEGER NOT NULL, username TEXT NOT NULL, userAddress TEXT NOT NULL, userAmountToPay REAL NOT NULL, hasPayed INTEGER NOT NULL, FOREIGN KEY (sharedPaymentId) REFERENCES SharedPayments(id))",
    );

    await database.execute(
      "CREATE TABLE DirectPayments(id INTEGER PRIMARY KEY AUTOINCREMENT, payTokenAddress TEXT, ownerId INTEGER NOT NULL, ownerUsername TEXT NOT NULL, payedAmount REAL NOT NULL, currencyName TEXT NOT NULL, currencySymbol TEXT NOT NULL, networkId INTEGER, creationTimestamp INTEGER NOT NULL)",
    );

    await database.execute(
      "CREATE TABLE NFTs(id INTEGER PRIMARY KEY AUTOINCREMENT, contractAddress TEXT NOT NULL, creationTxHash TEXT NOT NULL, ownerId INTEGER NOT NULL, ownerAddress TEXT NOT NULL, nftName TEXT NOT NULL, nftSymbol TEXT NOT NULL, nftAlias TEXT, networkId INTEGER NOT NULL, creationTimestamp INTEGER NOT NULL, FOREIGN KEY (ownerId) REFERENCES Users(id))",
    );

    /*await database.execute(
        "CREATE TABLE DeployedUserNFTs(id INTEGER PRIMARY KEY AUTOINCREMENT, ownerId INTEGER NOT NULL, creationTimestamp INTEGER NOT NULL, FOREIGN KEY (ownerId) REFERENCES NFTs(id))",
      );*/

    await database.execute(insertQuery.isNotEmpty
        ? insertQuery
        : 'INSERT INTO Users(id, vottunId, strategy, userEmail, username, password, accountHash, creationTimestamp) '
            'VALUES (NULL, "", 0, "test_srs_19@yopmail.com", "test_srs_19", "Doonamis.2022!", "0x84fa37c1b4d9dbc87707e47440eae5285edd8e58", 1702426072000),'
            '(NULL, "", 0, "test_srs_20@yopmail.com", "test_srs_20", "Doonamis.2022!", "0x84fa37c1b4d9dbc87707e47440eae5285edd8e58", 1702426072000),'
            '(NULL, "", 0, "test_srs_21@yopmail.com", "test_srs_21", "Doonamis.2022!", "0x84fa37c1b4d9dbc87707e47440eae5285edd8e58", 1702426072000),'
            '(NULL, "", 0, "test_srs_22@yopmail.com", "test_srs_22", "Doonamis.2022!", "0x84fa37c1b4d9dbc87707e47440eae5285edd8e58", 1702426072000),'
            '(NULL, "", 0, "test_srs_23@yopmail.com", "test_srs_23", "Doonamis.2022!", "0x84fa37c1b4d9dbc87707e47440eae5285edd8e58", 1702426072000),'
            '(NULL, "", 0, "test_srs_24@yopmail.com", "test_srs_24", "Doonamis.2022!", "0x84fa37c1b4d9dbc87707e47440eae5285edd8e58", 1702426072000),'
            '(NULL, "", 0, "test_srs_25@yopmail.com", "test_srs_25", "Doonamis.2022!", "0x84fa37c1b4d9dbc87707e47440eae5285edd8e58", 1702426072000)');
  }

  Future<int?> insertUser(User user) async {
    try {
      int result = await db.insert('users', user.toJson());
      return result;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<int?> insertUserContact(UserContact userContact) async {
    try {
      int result = await db.insert('usercontact', userContact.toJson());
      return result;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<int?> insertDirectPayment(
      DirectPaymentModel directPaymentModel) async {
    try {
      int result =
          await db.insert('directpayments', directPaymentModel.toJson());
      return result;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<int?> upsertUserNFT(
      {required UserNfTsModel userNfTsModel, int? id}) async {
    try {
      int? result;
      if (id != null) {
        result = await db.update(
          'nfts',
          userNfTsModel.toJson(),
          where: "id = ?",
          whereArgs: [userNfTsModel.id],
        );
      } else {
        result = await db.insert('nfts', userNfTsModel.toJson());
      }
      return result;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<int?> updateUser(User user) async {
    try {
      int? result = await db.update(
        'users',
        user.toJson(),
        where: "id = ?",
        whereArgs: [user.id],
      );
      return result;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<int?> updateSharedPayment(SharedPayment sharedPayment) async {
    try {
      int? result = await db.update(
        'sharedpayments',
        sharedPayment.toJson(),
        where: "id = ?",
        whereArgs: [sharedPayment.id],
      );
      return result;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<int?> updateUserWalletInfo(
      int userId, UpdateUserWalletInfo infoModel) async {
    try {
      int? result = await db.update(
        'users',
        infoModel.toJson(),
        where: "id = ?",
        whereArgs: [userId],
      );
      return result;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<List<DirectPaymentModel>?> retrieveDirectPayments(int userId) async {
    final List<Map<String, Object?>> queryResult = await db
        .query('directpayments', where: "ownerId = ?", whereArgs: [userId]);
    if (queryResult.firstOrNull == null) {
      return null;
    }
    return queryResult.map((e) => DirectPaymentModel.fromJson(e)).toList();
  }

  Future<List<User>> retrieveUsers() async {
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => User.fromJson(e)).toList();
  }

  Future<User?> retrieveUser(String email, String password) async {
    final List<Map<String, Object?>> queryResult = await db.query('users',
        where: "userEmail = ? AND password= ?", whereArgs: [email, password]);
    if (queryResult.firstOrNull == null) {
      return null;
    }
    return User.fromJson(queryResult.first);
  }

  Future<List<UserContact>?> retrieveUserContact(int userId) async {
    final List<Map<String, Object?>> queryResult =
        await db.query('usercontact', where: "userId = ?", whereArgs: [userId]);
    if (queryResult.firstOrNull == null) {
      return null;
    }
    return queryResult.map((e) => UserContact.fromJson(e)).toList();
  }

  Future<User?> retrieveUserByEmail(String email) async {
    final List<Map<String, Object?>> queryResult =
        await db.query('users', where: "userEmail = ?", whereArgs: [email]);
    if (queryResult.firstOrNull == null) {
      return null;
    }
    return User.fromJson(queryResult.first);
  }

  Future<User?> retrieveUserById(int userId) async {
    final List<Map<String, Object?>> queryResult =
        await db.query('users', where: "id = ?", whereArgs: [userId]);
    if (queryResult.firstOrNull == null) {
      return null;
    }
    return User.fromJson(queryResult.first);
  }

  Future<int> deleteUserContact(int userContactId, int userId) async {
    int result = await db.delete('usercontact',
        where: "id = ? AND userId = ?", whereArgs: [userContactId, userId]);
    return result;
  }

  Future<int?> createSharedPayment(SharedPayment sharedPayment) async {
    try {
      int result = await db.insert('sharedpayments', sharedPayment.toJson());
      return result;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<int?> insertSharedPaymentUser(
      List<SharedPaymentUsers> sharedPaymentUser) async {
    try {
      String insertQuery =
          'INSERT INTO SharedPaymentsUsers(id, userId, sharedPaymentId, username, userAddress, userAmountToPay, hasPayed) VALUES ';
      String valuesList = "";
      for (var element in sharedPaymentUser) {
        valuesList +=
            '(NULL, ${element.userId}, ${element.sharedPaymentId}, "${element.username}", "${element.userAddress}", ${element.userAmountToPay}, ${element.hasPayed}),';
      }

      if (valuesList.isNotEmpty) {
        insertQuery = insertQuery + valuesList;
        //remove last comma, if not throws error
        insertQuery = insertQuery.substring(0, insertQuery.length - 1);
      } else {
        //todo no results
      }

      int? resultAux = await db.rawInsert(insertQuery);

      return resultAux;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<List<SharedPaymentResponseModel>?> retrieveUserSharedPayments(
      {required int userId, required bool isFinished}) async {
    try {
      List<SharedPaymentResponseModel> sharedPaymentResponseModel =
          List.empty(growable: true);
      final List<Map<String, Object?>> queryResult = await db.query(
          'sharedpayments',
          where: !isFinished
              ? "ownerId = ? AND hasBeenExecuted = 0"
              : "ownerId = ? AND hasBeenExecuted = 1",
          whereArgs: [userId]);
      List<SharedPayment>? sharedPaymentsList =
          queryResult.map((e) => SharedPayment.fromJson(e)).toList();
      List<SharedPayment> otherSharedPaymentsList =
          await getOtherSharedPayments(userId, isFinished);
      sharedPaymentsList.addAll(otherSharedPaymentsList);

      await Future.forEach(sharedPaymentsList, (element) async {
        List<SharedPaymentUsers> spuList =
            await getSharedPaymentUsersBySPid(element.id ?? 0);

        if (element.ownerEmail == null) {
          sharedPaymentResponseModel.add(SharedPaymentResponseModel(
              sharedPayment: element.copyWith(ownerEmail: ""),
              sharedPaymentUser: spuList));
        } else {
          sharedPaymentResponseModel.add(SharedPaymentResponseModel(
              sharedPayment: element, sharedPaymentUser: spuList));
        }
      });

      return sharedPaymentResponseModel;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<List<SharedPaymentUsers>> getSharedPaymentUsersBySPid(
      int sharedPaymentId) async {
    try {
      final List<Map<String, Object?>> queryResult = await db.query(
          'sharedpaymentsusers',
          where: "sharedPaymentId = ?",
          whereArgs: [sharedPaymentId]);

      if (queryResult.firstOrNull == null) {
        return [];
      }
      List<SharedPaymentUsers>? sharedPaymentUsersList =
          queryResult.map((e) => SharedPaymentUsers.fromJson(e)).toList();

      return sharedPaymentUsersList;
    } catch (exception) {
      print(exception);
      return [];
    }
  }

  Future<List<UserNfTsModel>> getErc721CreatedByUser(int userId) async {
    try {
      final List<Map<String, Object?>> queryResult =
          await db.query('usernfts', where: "ownerId = ?", whereArgs: [userId]);

      if (queryResult.firstOrNull == null) {
        return [];
      }
      List<UserNfTsModel>? userNFTsList =
          queryResult.map((e) => UserNfTsModel.fromJson(e)).toList();

      return userNFTsList;
    } catch (exception) {
      print(exception);
      return [];
    }
  }

  Future<List<SharedPayment>> getOtherSharedPayments(
      int userId, bool isFinished) async {
    try {
      List<SharedPayment> auxList = List.empty(growable: true);
      final List<Map<String, Object?>> queryResult = await db.query(
          'sharedpaymentsusers',
          where: "userId = ?",
          whereArgs: [userId]);
      if (queryResult.firstOrNull == null) {
        return [];
      }
      List<SharedPaymentUsers>? sharedPaymentUsersList =
          queryResult.map((e) => SharedPaymentUsers.fromJson(e)).toList();
      if (sharedPaymentUsersList.isNotEmpty) {
        await Future.forEach(sharedPaymentUsersList, (element) async {
          final List<Map<String, Object?>> queryResult = await db.query(
              'sharedpayments',
              where: !isFinished
                  ? "id = ? AND hasBeenExecuted = 0"
                  : "id = ? AND hasBeenExecuted = 1",
              whereArgs: [element.sharedPaymentId]);
          List<SharedPayment> sharedPaymentList =
              queryResult.map((e) => SharedPayment.fromJson(e)).toList();

          if (sharedPaymentList.isNotEmpty) {
            auxList.addAll(sharedPaymentList);
          }
        });
      }
      return auxList;
    } catch (exception) {
      print(exception);
      return [];
    }
  }

  Future<int?> updateSharedPaymentUser(
      int spId, SharedPaymentUsers spUserToAdd) async {
    try {
      int? result = await db.update(
        'sharedpaymentsusers',
        spUserToAdd.toJson(),
        where: "id = ?",
        whereArgs: [spId],
      );
      return result;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<int?> deleteSharedPayment(int sharedPaymentId, int userId) async {
    int? result = await db.delete('sharedpayments',
        where: "id = ? AND ownerId = ?", whereArgs: [sharedPaymentId, userId]);
    return result;
  }
}
