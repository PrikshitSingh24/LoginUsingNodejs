import 'package:assignment/welcomScreen/config/config.dart';
import 'package:assignment/welcomScreen/page_2/model/register_request_model.dart';
import 'package:assignment/welcomScreen/page_2/model/register_response_model.dart';
import 'package:assignment/welcomScreen/services/api_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAPIcallProcess=false;
  bool hidePassword=true;
  GlobalKey<FormState> globalformKey=GlobalKey<FormState>();

   String? password;
   String? username;
   String? email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
          body: ProgressHUD(
          child: Form(
            key:globalformKey,
            child:_registerUi(context) ,
          ),
          inAsyncCall:isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }
  Widget _registerUi(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ]
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Sign up",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.red,
                  ),),
                ),
                SizedBox(height: 10,),
                FormHelper.inputFieldWidget(
                  context,
                  "username",
                  "userName",
                      (onValidateVal){
                    if(onValidateVal.isEmpty){
                      return "Username can\'t be empty.";
                    }
                    else{
                      return null;
                    }
                  },
                      (onSavedVal){
                    username=onSavedVal;
                  },
                  borderFocusColor: Colors.red,
                  prefixIconColor:Colors.red,
                  borderColor: Colors.red,
                  showPrefixIcon: true,
                  hintColor: Colors.red.withOpacity(0.7),
                  borderRadius: 0.7,
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 10,),
                FormHelper.inputFieldWidget(
                  context,
                  "password",
                  "Password",
                      (onValidateVal){
                    if(onValidateVal.isEmpty){
                      return "Password can\'t be empty.";
                    }
                    else{
                      return null;
                    }
                  },
                      (onSavedVal){
                    password=onSavedVal;
                  },
                  borderFocusColor: Colors.red,
                  prefixIconColor:Colors.red,
                  borderColor: Colors.red,
                  showPrefixIcon: true,
                  hintColor: Colors.red.withOpacity(0.7),
                  borderRadius: 0.7,
                  prefixIcon: Icon(Icons.person),
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword=!hidePassword;
                      });
                    },
                    color:Colors.red,
                    icon:Icon(
                        hidePassword?Icons.visibility_off:Icons.visibility
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                FormHelper.inputFieldWidget(
                  context,
                  "email",
                  "Email",
                      (onValidateVal){
                    if(onValidateVal.isEmpty){
                      return "Email  can\'t be empty.";
                    }
                    else{
                      return null;
                    }
                  },
                      (onSavedVal){
                    email=onSavedVal;
                  },
                  borderFocusColor: Colors.red,
                  prefixIconColor:Colors.red,
                  borderColor: Colors.red,
                  showPrefixIcon: true,
                  hintColor: Colors.red.withOpacity(0.7),
                  borderRadius: 0.7,
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 10,),
                FormHelper.submitButton(
                  "Sign up",
                      () {
                        if(validateAndSave()){
                          setState(() {
                            isAPIcallProcess=true;
                          });
                          RegisterRequestModel model=RegisterRequestModel(
                            username: username,
                            password: password,
                            email:email,
                          );
                          APIService.register(model).then((response){
                            setState(() {
                              isAPIcallProcess=false;
                            });
                            if(response.data!=null){
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Registration Sucessfull.Please login to the account.",
                                  "OK",
                                      (){
                                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                                  }
                              );

                            }
                            else{
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  response.message,
                                  "OK",
                                      (){
                                    Navigator.pop(context);
                                  }
                              );
                            }
                          });
                        }
                      },
                  btnColor: Colors.red,
                  txtColor: Colors.white,
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ],
      ),
    );
  }
  bool validateAndSave(){
    final form=globalformKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }
}
