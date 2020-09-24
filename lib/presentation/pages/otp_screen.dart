import 'package:cokut/cubit/login_form/login_cubit.dart';
import 'package:cokut/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class Otp extends StatefulWidget {
  static const routeName = '/otpscreen';
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  bool popped = false;
  String smsCode = '';
  int forceResentToken;
  bool isLoading = false;
  String phone;

  void setLoading(bool val) {
    print("Setting loading  $val");
    setState(() {
      isLoading = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return BlocListener<LoginCubit, LoginState>(
          cubit: context.bloc<LoginCubit>(),
          listener: (ctx, state) {
            if (state is PhoneVerifcationFailed) {
              Utils.showWarning(context, content: state.message);
            }
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 8,
                ),
                Lottie.network(
                  'https://assets8.lottiefiles.com/packages/lf20_bd4p6o.json',
                  height: 150,
                ),
                Spacer(),
                Text(
                  'PLEASE ENTER',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.green),
                ),
                SizedBox(height: 20),
                Text(
                  'THE VERIFICATION CODE\nSENT TO YOUR PHONE NO',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (val) {
                      smsCode = val;
                      print(smsCode);
                    },
                    decoration: InputDecoration(
                      prefixStyle: TextStyle(fontSize: 18),
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      hintStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(10),
                          ),
                      // filled: true,
                    ),
                  ),
                ),
                Container(
                  width: 45,
                  child: RaisedButton(
                    color: Colors.green,
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      verify(smsCode);
                    },
                  ),
                ),
                FlatButton(
                  focusColor: Colors.amber,
                  onPressed: () {
                    print("resend pressed");
                  },
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  textColor: Colors.green,
                ),
                isLoading
                    ? SpinKitRing(
                        color: Colors.blue,
                        size: 25,
                        lineWidth: 5,
                      )
                    : Container(),
                Spacer(
                  flex: 10,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void verify(smsCode) {
    context.bloc<LoginCubit>().verifyOtpManually(smsCode);
  }
}
