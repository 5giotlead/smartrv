import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/auth/login/cubit/login_cubit.dart';
import 'package:flutter_rv_pms/l10n/l10n.dart';
import 'package:flutter_rv_pms/widgets/primary_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:thingsboard_client/thingsboard_client.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LogoutCubit(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(l10n.loginAppBarTitle),
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        // ),
        backgroundColor: const Color.fromARGB(255, 219, 217, 217),
        // bottomNavigationBar: BottomNavBar(),
        body: Center(child: SingleChildScrollView(child: Builder(
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(runAlignment: WrapAlignment.center, children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 30),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: double.infinity,
                        child: Column(
                          children: const [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color.fromRGBO(33, 45, 82, 1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            LoginForm(),
                          ],
                        ),
                      ),
                    ])
                  ]),
            );
          },
        )
            // const Center(
            //   child: SizedBox(
            //     width: 500,
            //     child: Card(
            //       child: LoginForm(),
            //     ),
            //   ),
            // ),
            )));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final tbClient = Modular.get<ThingsboardClient>();
  final _storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormBuilderState>();
  final _isLoginNotifier = ValueNotifier<bool>(false);
  final _showPasswordNotifier = ValueNotifier<bool>(false);
  double _formProgress = 0;

  void _updateFormProgress() {
    _formKey.currentState!.save();
    var progress = 0.0;
    final validates = [
      _formKey.currentState?.fields['username']!.validate(),
      _formKey.currentState?.fields['password']!.validate()
    ];
    for (final validate in validates) {
      if (validate != null && validate) {
        progress += 1 / validates.length;
      }
    }
    setState(() => _formProgress = progress);
  }

  Future<void> _login() async {
    final _authStore = Modular.get<AuthStore>();
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final loginRequest = _formKey.currentState!.value;
      final username = loginRequest['username'].toString();
      final password = loginRequest['password'].toString();
      try {
        final loginResponse =
            await tbClient.login(LoginRequest(username, password));
        await _storage.write(key: 'token', value: loginResponse.token);
        await _storage.write(
          key: 'refreshToken',
          value: loginResponse.refreshToken,
        );
        if (_authStore.pastPage != '') {
          Modular.to.navigate(_authStore.pastPage);
          _authStore.pastPage = '';
        } else {
          Modular.to.navigate('/home');
        }
        _isLoginNotifier.value = true;
      } catch (e) {
        print(e);
        _isLoginNotifier.value = false;
      }
    }
  }

  Future<void> _loginByOAuth() async {
    final oAuth2Clients = await tbClient.getOAuth2Service().getOAuth2Clients();
    if (oAuth2Clients.isNotEmpty) {
      Uri _url;
      if (kIsWeb) {
        _url = Uri.parse(oAuth2Clients[0].url);
        // }else if (Platform.isAndroid) {
      } else {
        _url = Uri.parse('https://rv.5giotlead.com' + oAuth2Clients[0].url);
      }
      if (!await launchUrl(_url, webOnlyWindowName: '_self')) {
        throw 'Could not launch $_url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Column(
      children: <Widget>[
        FormBuilder(
          onChanged: _updateFormProgress,
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: <Widget>[
              AnimatedProgressIndicator(value: _formProgress),
              const SizedBox(height: 27),
              FormBuilderTextField(
                name: 'username',
                decoration: const InputDecoration(
                  labelText: '請輸入帳號',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Email is required.',
                  ),
                  FormBuilderValidators.email(
                    errorText: 'Invalid email format.',
                  )
                ]),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              ValueListenableBuilder(
                  valueListenable: _showPasswordNotifier,
                  builder: (BuildContext context, bool showPassword, child) {
                    return FormBuilderTextField(
                      name: 'password',
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(showPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              _showPasswordNotifier.value =
                                  !_showPasswordNotifier.value;
                            },
                          ),
                          border: OutlineInputBorder(),
                          labelText: '請輸入密碼'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Password is required.'),
                        FormBuilderValidators.minLength(6, errorText: '少於 6 碼.')
                      ]),
                      keyboardType: TextInputType.visiblePassword,
                    );
                  }),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.all(0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child:
                            // MaterialButton(
                            //   color: Theme.of(context).colorScheme.secondary,
                            //   onPressed: _login,
                            //   child: const Text(
                            //     "登入",
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            // ),
                            PrimaryButton(
                      '登入',
                      _login,
                    )),
                    const SizedBox(width: 30),
                    Expanded(
                        child:
                            // MaterialButton(
                            //   color: Theme.of(context).colorScheme.secondary,
                            //   child: const Text(
                            //     "重設",
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            //   onPressed: () {
                            //     _formKey.currentState!.reset();
                            //   },
                            // ),
                            PrimaryButton(
                      '重設',
                      () {
                        _formKey.currentState!.reset();
                      },
                    )),
                  ],
                ),
              ),
              Container(
                height: 30,
                width: 500,
                // color: Color.fromARGB(255, 28, 142, 70),
              ),
              Container(
                height: 50,
                child: GestureDetector(
                  onTap: _loginByOAuth,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(204, 251, 250, 250),
                    ),
                    child: Row(
                      children: const [
                        // SvgPicture.asset(
                        //   "assets/svg/google.svg",
                        //   width: 30.0,
                        // ),
                        Icon(Icons.login),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Oauth2',
                          style: TextStyle(
                            color: Color.fromRGBO(105, 108, 121, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // Container(
              //   height: 50,
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: Container(
              //       padding: EdgeInsets.symmetric(horizontal: 14.0),
              //       height: 50,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //       ),
              //       child: Row(
              //         children: [
              //           SvgPicture.asset(
              //             "assets/svg/google.svg",
              //             width: 30.0,
              //           ),
              //           SizedBox(
              //             width: 10.0,
              //           ),
              //           Text(
              //             "Google",
              //             style: TextStyle(
              //               color: Color.fromRGBO(105, 108, 121, 1),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: 10.0,
              // ),
              // Container(
              //   height: 50,
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: Container(
              //       padding: EdgeInsets.symmetric(horizontal: 14.0),
              //       height: 50,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //       ),
              //       child: Row(
              //         children: [
              //           SvgPicture.asset(
              //             "assets/svg/facebook.svg",
              //             width: 30.0,
              //           ),
              //           SizedBox(
              //             width: 10.0,
              //           ),
              //           Text(
              //             "Facebook",
              //             style: TextStyle(
              //               color: Color.fromRGBO(105, 108, 121, 1),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class AnimatedProgressIndicator extends StatefulWidget {
  const AnimatedProgressIndicator({required this.value, super.key});

  final double value;

  @override
  State<StatefulWidget> createState() {
    return _AnimatedProgressIndicatorState();
  }
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    final colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value?.withOpacity(0.4),
      ),
    );
  }
}
