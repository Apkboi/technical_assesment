import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:technical_assesment/common/components/back_button.dart';
import 'package:technical_assesment/common/components/circular_loader.dart';
import 'package:technical_assesment/common/components/custom_button.dart';
import 'package:technical_assesment/common/components/custom_text_field.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';
import 'package:technical_assesment/core/cubits/validation_bloc/validation_cubit.dart';
import 'package:technical_assesment/core/di/injector.dart';
import 'package:technical_assesment/core/helpers/debouncer.dart';
import 'package:technical_assesment/core/utils/app_utils.dart';
import 'package:technical_assesment/features/authentication/presentation/blocs/auth/auth_bloc.dart';
import 'package:technical_assesment/features/dashboard/presentation/screens/dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authBloc = AuthBloc(injector.get());
  final emailValidator = TextFieldValidationCubit();
  final passwordValidator = TextFieldValidationCubit();
  bool isLoading = false;
  bool emailValidated = false;
  bool passwordValidated = false;
  final _emailDebouncer = Debouncer(milliseconds: 300);
  final _passwordDebouncer = Debouncer(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: _listenToAuthStates,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomBackButton(
                                onPressed: () {},
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surface,
                                      foregroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  onPressed: () {},
                                  child: const Text('Switch to Create account'))
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Welcome Back!",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 24),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Be ready to use Kooha in less than 2min ⚡️",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Email address",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          BlocConsumer<TextFieldValidationCubit,
                              ValidationState>(
                            bloc: emailValidator,
                            listener: (context, state) {
                              if (state is ValidationSuccess) {
                                setState(() {
                                  emailValidated = true;
                                });
                              }
                              if (state is ValidationFailure) {
                                setState(() {
                                  emailValidated = false;
                                });
                              }
                            },
                            builder: (context, state) {
                              return CustomTextField(
                                formKey: emailValidator.key,
                                hint: 'john@email.com',
                                controller: _emailController,
                                contentPadding: const EdgeInsets.all(20),
                                suffix: _getSuffixIcon(state, context),
                                outline: true,
                                border: _getInputBorder(state, context),
                                onChanged: (val) {
                                  _emailDebouncer.run(() {
                                    emailValidator.validate();
                                  });

                                },
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Enter your name.'),
                                  EmailValidator(
                                      errorText: 'Enter a valid email.'),
                                ]),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Password",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          BlocConsumer<TextFieldValidationCubit,
                              ValidationState>(
                            listener: (context, state) {
                              if (state is ValidationSuccess) {
                                setState(() {
                                  passwordValidated = true;
                                });
                              }
                              if (state is ValidationFailure) {
                                setState(() {
                                  passwordValidated = false;
                                });
                              }
                            },
                            bloc: passwordValidator,
                            builder: (context, state) {
                              return CustomTextField(
                                formKey: passwordValidator.key,
                                hint: 'Password (min. of 8 characters)',
                                contentPadding: const EdgeInsets.all(20),
                                controller: _passwordController,
                                outline: true,
                                suffix: _getSuffixIcon(state, context),
                                onChanged: (val) {
                                  _passwordDebouncer.run(() {
                                    passwordValidator.validate();
                                  });
                                },
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Enter a password.'),
                                  MinLengthValidator(8,
                                      errorText:
                                          'Password must be up to eight characters')
                                ]),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                            const TextSpan(text: "Forgot Password? "),
                            TextSpan(
                                text: "Reset it",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                          ],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: grey1))),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                          onPressed: (!isLoading &&
                                  (emailValidated && passwordValidated))
                              ? () {
                                  _login();
                                }
                              : null,
                          child: isLoading
                              ? const CircularLoader()
                              : const Text('Login')),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _listenToAuthStates(BuildContext context, AuthState state) {
    if (state is AuthLoadingState) {
      isLoading = true;
      setState(() {});
    }

    if (state is LoginSuccessState) {
      isLoading = false;
      setState(() {});
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ));
    }

    if (state is AuthFailureState) {
      isLoading = false;
      CustomSnackBar.showError(context, message: state.error, action: () {});
      setState(() {});
    }
  }

  // Triggering the login Event
  void _login() {

    if (_formKey.currentState!.validate()) {
      _authBloc
          .add(LoginEvent(_emailController.text, _passwordController.text));
    }
  }
}

_getSuffixIcon(ValidationState state, BuildContext context) {
  if (state is ValidationLoading) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
  if (state is ValidationSuccess) {
    return SizedBox(
      height: 20,
      width: 20,
      child: Icon(
        Icons.check_circle,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

_getInputBorder(ValidationState state, BuildContext context) {
  if (state is ValidationLoading) {
    return OutlineInputBorder(
        gapPadding: 2,
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10));
  }
  if (state is ValidationFailure) {
    return OutlineInputBorder(
        gapPadding: 2,
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10));
  }

  if (state is ValidationSuccess) {
    return OutlineInputBorder(
        gapPadding: 2,
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10));
  }
}
