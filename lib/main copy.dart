import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/components/socal_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/theme.dart';

void main() {
  runApp(const MyApp());
}

// void setSlowAnimations() {
//   timeDilation = 10.0;
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static String routeName = '/myApp';
  @override
  Widget build(BuildContext context) {
    // setSlowAnimations();
    return MaterialApp(
      theme: AppTheme.lightTheme(context),
      initialRoute: Screen1.routeName,
      routes: {
        Screen1.routeName: (context) => const Screen1(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        Screen3.routeName: (context) => const Screen3(),
      },
    );
    // initialRoute: MyApp.routeName,
  }
}

class Screen1 extends StatelessWidget {
  static String routeName = "/Screen1";

  const Screen1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Screen1"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Image.asset(
              "assets/images/success.png",
              height: MediaQuery.of(context).size.height * 0.4, //40%
              // height: 350, //40%
            ),
            const SizedBox(height: 16),
            const Text(
              "Screen1",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
                child: const Text("1"),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class SignInScreen extends StatefulWidget {
  static String routeName = "/signInScreen'";
  const SignInScreen({super.key});

  @override
  _SignInScreen createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 1, left: 1),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (newValue) => email = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: kEmailNullError);
                              } else if (emailValidatorRegExp.hasMatch(value)) {
                                removeError(error: kInvalidEmailError);
                              }
                              return;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                addError(error: kEmailNullError);
                                return "";
                              } else if (!emailValidatorRegExp
                                  .hasMatch(value)) {
                                addError(error: kInvalidEmailError);
                                return "";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Email",
                              hintText: "Enter your email",
                              // labelStyle: TextStyle(),
                              // If  you are using latest version of flutter then lable text and hint text shown like this
                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: CustomSurffixIcon(
                                  svgIcon: "assets/icons/Mail.svg"),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            onSaved: (newValue) => password = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: kPassNullError);
                              } else if (value.length >= 8) {
                                removeError(error: kShortPassError);
                              }
                              return;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                addError(error: kPassNullError);
                                return "";
                              } else if (value.length < 8) {
                                addError(error: kShortPassError);
                                return "";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your password",
                              // If  you are using latest version of flutter then lable text and hint text shown like this
                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: CustomSurffixIcon(
                                  svgIcon: "assets/icons/Lock.svg"),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                value: remember,
                                activeColor: kPrimaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    remember = value;
                                  });
                                },
                              ),
                              const Text("Remember me"),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, ForgotPasswordScreen.routeName),
                                child: const Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                          FormError(errors: errors),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              await pushPageReplacement(
                                  context, const Screen3());

                              // if (_formKey.currentState!.validate()) {
                              //   _formKey.currentState!.save();

                              //   // if all are valid then go to success screen
                              //   // KeyboardUtil.hideKeyboard(context);
                              //   // Navigator.pushNamed(context, Screen3.routeName);
                              //   pushPageReplacement(context, const Screen3());
                              // }
                            },
                            child: const Text("2"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future pushPage(BuildContext context, Widget page) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) {
        return page;
      },
    ),
  );
}

pushPageReplacement(BuildContext context, Widget page) async {
  return await Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) {
        return page;
      },
    ),
  );
}

class Screen3 extends StatelessWidget {
  static String routeName = "/login_success";

  const Screen3({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Screen3"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Image.asset(
              "assets/images/success.png",
              height: MediaQuery.of(context).size.height * 0.4, //40%
              // height: 350, //40%
            ),
            const SizedBox(height: 16),
            const Text(
              "Screen3",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, Screen1.routeName);
                },
                child: const Text("3"),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
