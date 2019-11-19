import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwel_smart/logic/add_ad.dart';
import 'package:jwel_smart/logic/objects/ad.dart';
import 'package:jwel_smart/views/helpers/alert.dart';

class AddAdView extends StatelessWidget {
  final Ad ad;
  AddAdView(this.ad);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.ad == null ? 'Add Ad' : 'Edit Ad'),
        centerTitle: true,
      ),
      body: AddAdForm(this.ad),
    );
  }
}

class AddAdForm extends StatefulWidget {
  final Ad ad;
  AddAdForm(this.ad);

  @override
  _AddAdFormState createState() => _AddAdFormState();
}

class _AddAdFormState extends State<AddAdForm>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _isSaving;
  bool _isUpdating;
  File _image;

  // TextEditingController _productname;

  // TextEditingController _description;

  // TextEditingController _price;

  @override
  void initState() {
    _isSaving = false;
    if (widget.ad != null) {
      _isUpdating = true;
      // _productname = TextEditingController(text: widget.ad.name);
      // _description = TextEditingController(text: widget.ad.description);
      // _price = TextEditingController(text: widget.ad.price.toString());
    } else {
      _isUpdating = false;
      // _productname = TextEditingController();
      // _description = TextEditingController();
      // _price = TextEditingController();
    }
    super.initState();
  }

  Future<void> _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);//image eka ganna eka.camera eken gnwa nm Imagesource.camera
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _isSaving
        ? Center(
            child: SpinKitChasingDots(color: Theme.of(context).accentColor),
          )
        : Center(
            child: FormBuilder(
              key: _fbKey,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(primaryColor: Theme.of(context).accentColor),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildTitle("Product Name"),
                            _productName,
                            _buildTitle("Product Description"),
                            _productDescription,
                            _buildTitle("Product Price (LKR)"),
                            _productPrice,
                            _buildTitle("Attach Image"),
                            _attachImage,
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Colors.blue[800],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            textColor: Colors.white,
                            child: Text(_isUpdating ? "Update" : "Submit"),
                            onPressed: () => _handleFormSubmit(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            textColor: Colors.white,
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget get _attachImage => Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  child: _image == null
                      ? Text("Attach Image")
                      : Text("Change Image"),
                  onPressed: _getImage,
                ),
              ),
            ],
          ),
          _image == null ? Text('No image selected.') : Image.file(_image),
        ],
      );

  Widget get _productName => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          initialValue: widget.ad == null ? null : widget.ad.name,
          validators: [
            FormBuilderValidators.required(),
          ],
          attribute: "name",
          maxLines: 1,
          decoration: InputDecoration(
              helperText: "Title for your product",
              hintText: "Product Name",
              border: OutlineInputBorder()),
        ),
      );

  Widget get _productDescription => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          initialValue: widget.ad == null ? null : widget.ad.description,
          validators: [
            FormBuilderValidators.required(),
          ],
          attribute: "description",
          decoration: InputDecoration(
              helperText: "Description for your product",
              hintText: "Describe the product",
              border: OutlineInputBorder()),
        ),
      );

  Widget get _productPrice => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          keyboardType: TextInputType.number,
          initialValue: widget.ad == null ? null : widget.ad.price.toString(),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
          ],
          attribute: "price",
          maxLines: 1,
          decoration: InputDecoration(
              helperText: "Product Price",
              hintText: "1000",
              border: OutlineInputBorder()),
        ),
      );

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, bottom: 0.0, top: 20.0),
      child: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _handleFormSubmit() async {
    _fbKey.currentState.save();
    if (_fbKey.currentState.validate()) {
      setState(() {
        _isSaving = true;
      });
      Map<String, dynamic> map = _fbKey.currentState.value;
      Ad returnAd;

      if (_isUpdating) {
        print(map.toString());
        Ad updatedAd = Ad(
            map['name'],
            map['description'],
            double.parse(map['price']),
            widget.ad.ownerId,
            widget.ad.rate,
            widget.ad.imageId,
            widget.ad.timestamp,
            widget.ad.verified,
            widget.ad.reserved,
            widget.ad.reservedBy);
        updatedAd.id = widget.ad.id;
        try {
          returnAd = await EditAd.editAd(updatedAd, _image);
        } catch (e) {
          Alert.showAlertBox(context, e.toString());
        }
      } else {
        map['owner_id'] = (await FirebaseAuth.instance.currentUser()).uid;
        map['timestamp'] = Timestamp.now();
        map['rate'] = 0;
        try {
          await AddAd.addAd(Ad.fromMap(map), _image);
        } catch (e) {
          Alert.showAlertBox(context, e.toString());
        }
      }

      // Map<String, dynamic> map = _fbKey.currentState.value;
      // map['owner_id'] = (await FirebaseAuth.instance.currentUser()).uid;
      // map['timestamp'] = Timestamp.now();

      // try {
      //   await AddAd.addAd(Ad.fromMap(map), _image);
      // } catch (e) {
      //   Alert.showAlertBox(context, e.toString());
      // }

      if (mounted) {
        setState(() {
          _isSaving = false;
        });
        Navigator.pop(context, returnAd);
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
