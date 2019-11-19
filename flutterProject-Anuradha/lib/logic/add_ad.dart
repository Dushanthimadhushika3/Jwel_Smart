import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jwel_smart/logic/objects/ad.dart';
import 'package:uuid/uuid.dart';

class AddAd {
  static Future<void> addAd(Ad ad, File image) async {
    if (image != null) {
      String fileName = Uuid().v4();
      final StorageReference storageReference =
          FirebaseStorage().ref().child("ads").child(fileName);

      final StorageUploadTask uploadTask =
          storageReference.putData(image.readAsBytesSync());
      await uploadTask.onComplete;
      ad.imageId = fileName;
    }
    await Firestore.instance.collection('Ads').add(ad.toMap());
  }
}

class EditAd {
  static Future<Ad> editAd(Ad ad, File image) async {
    if (image != null) {
      String fileName = Uuid().v4();
      final StorageReference storageReference =
          FirebaseStorage().ref().child("ads").child(fileName);

      final StorageUploadTask uploadTask =
          storageReference.putData(image.readAsBytesSync());
      await uploadTask.onComplete;
      ad.imageId = fileName;
    }
    await Firestore.instance.collection('Ads').document(ad.id).updateData({
      'name': ad.name,
      'description': ad.description,
      'price': ad.price,
      'image_id': ad.imageId
    });
    return ad;
  }
}

class RateAd {
  static Future<bool> rateAd(String id,int rate,bool isLiked) async {
    isLiked = !isLiked;
    rate = isLiked ? rate-1 : rate-2;
    print(rate);
    await Firestore.instance.collection('Ads').document(id).updateData({
      'rate': rate,
    });
return isLiked;
  }
}
class DeleteAd {
  static Future<void> deleteAd(Ad ad) async {
    if (ad.imageId != null) {
      final StorageReference storageReference =
          FirebaseStorage().ref().child("ads").child(ad.imageId);
      storageReference.delete();
    }
    await Firestore.instance.collection('Ads').document(ad.id).delete();
  }
}
