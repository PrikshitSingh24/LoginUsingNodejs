import 'package:assignment/welcomScreen/config/config.dart';
import 'package:assignment/welcomScreen/page_2/model/login_request_model.dart';
import 'package:assignment/welcomScreen/services/api_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class page2 extends StatefulWidget {
  const page2({Key? key}) : super(key: key);
  static String? username;
  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  bool isAPIcallProcess=false;
  bool hidePassword=true;
  GlobalKey<FormState> globalformKey=GlobalKey<FormState>();

  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.yellow,
        child: ProgressHUD(
          child: Form(
            key:globalformKey,
            child:_loginUi(context) ,
          ),
          inAsyncCall:isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }
  Widget _loginUi(BuildContext context){
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
                Text("Sign In",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.red,
                ),),
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
                      page2.username=onSavedVal;
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding:EdgeInsets.only(right: 25,top: 10) ,
                    child: RichText(text: TextSpan(
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:"Forget Password ?",
                          style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap= (){
                            print("Forget Password");
                          },
                        ),
                      ]
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                FormHelper.submitButton(
                  "Sign in",
                    () {
                      if(validateAndSave()){
                        setState(() {
                          isAPIcallProcess=true;
                        });
                        LoginRequestModel model=LoginRequestModel(
                          username: page2.username!,
                          password: password!,
                        );
                        APIService.login(model).then((response){
                          if(response){
                            setState(() {
                              isAPIcallProcess=false;
                            });
                           Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                          }
                          else{
                            FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Invalid Username/Password",
                              "OK",
                                (){
                                Navigator.pushNamed(context, '/');
                                }
                            );
                          }
                        });
                      }
                    },
                  btnColor: Colors.red,
                  txtColor: Colors.white,
                ),
                SizedBox(height: 20,),
                Text("OR",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.red),),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding:EdgeInsets.only(right: 25,top: 10) ,
                    child: RichText(text: TextSpan(
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: "     Don't have an account?"),
                          TextSpan(
                            text:"Sign up",
                            style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap= (){
                              Navigator.pushNamed(context, '/register');
                            },
                          ),
                        ]
                    ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 174),
              child: ElevatedButton(onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, '/guest');
                });
              }, child: Text('SKip'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
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
