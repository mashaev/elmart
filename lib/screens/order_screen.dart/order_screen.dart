import 'package:elmart/model/product.dart';
import 'package:elmart/provider/basket_provider.dart';
import 'package:elmart/provider/order_provider.dart';
import 'package:elmart/resourses/validator.dart';
import 'package:elmart/screens/order_waiting_screen/order_waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  FocusNode _addressFocusNode = FocusNode();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();

  // String _address = '';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  _submitHandler() {
    if (_formKey.currentState.validate()) {
      Map _contactData = Map();
      _contactData['address'] = _addressController.text;
      _contactData['name'] = _nameController.text;
      _contactData['phoneNumber'] = _phoneNumberController.text;
      final basket = Provider.of<BasketProvider>(context, listen: false);
      Provider.of<OrderProvider>(context, listen: false)
          .makeOrder(_contactData, basket.ordersMap)
          .then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderWaitingScreen()),
            ),
          );
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _nameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Оформления заказа'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: Column(
              children: [
                Text(
                  'Ваши контактные данные',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // TypeAheadFormField(
                      //   validator: requiredValidation,
                      //   noItemsFoundBuilder: (_) => ListTile(
                      //     title: Text('Ничего не найдено'),
                      //   ),
                      //   textFieldConfiguration: TextFieldConfiguration(
                      //     onSubmitted: (_) {
                      //       FocusScope.of(context).requestFocus(_nameFocusNode);
                      //     },
                      //     textInputAction: TextInputAction.next,
                      //     keyboardType: TextInputType.text,
                      //     controller: _addressController,
                      //     decoration: InputDecoration(labelText: 'Город'),
                      //   ),
                      //   suggestionsCallback: (pattern) =>
                      //       CitiesService.getSuggestions(pattern),
                      //   itemBuilder: (_, suggestion) => ListTile(
                      //     title: Text(suggestion['city']),
                      //     subtitle: Text(suggestion['region']),
                      //   ),
                      //   transitionBuilder: (_, suggestionsBox, ac) =>
                      //       suggestionsBox,
                      //   onSuggestionSelected: (suggestion) {
                      //     _addressController.text = suggestion['city'];
                      //     _address =
                      //         '${suggestion['city']}, ${suggestion['region']}';
                      //   },
                      // ),
                      TextFormField(
                        focusNode: _addressFocusNode,
                        controller: _addressController,
                        validator: requiredValidation,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: 'Address'),
                        onFieldSubmitted: (_) {
                          // FocusScope.of(context)
                          //     .requestFocus(_phoneNumberFocusNode);
                        },
                      ),
                      TextFormField(
                        focusNode: _nameFocusNode,
                        controller: _nameController,
                        validator: requiredValidation,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: 'ФИО'),
                        onFieldSubmitted: (_) {
                          // FocusScope.of(context)
                          //     .requestFocus(_phoneNumberFocusNode);
                        },
                      ),
                      TextFormField(
                        focusNode: _phoneNumberFocusNode,
                        controller: _phoneNumberController,
                        validator: requiredValidation,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: 'Телефон',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Consumer<OrdersProvider>(
          //   builder: (ctx, provider, _) {
          //     if (provider.status == Status.Loading) {
          //       return AppIndicator();
          //     }
          //     return Container();
          //   },
          // )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: _submitHandler,
          child: Text(
            'Отправить на исполнение',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
