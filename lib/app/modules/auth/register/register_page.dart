import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_provider/app/core/validators/validators.dart';
import 'package:todo_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_provider/app/core/widget/todo_list_logo.dart';
import 'package:todo_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();

    super.dispose();
  }

  @override
  void initState() {
    var dedaultListener = DefaultListenerNotifier(
      changeNotifier: context.read<RegisterController>(),
    );

    dedaultListener.listener(
      context: context,
      successVoidCallback: (notifier, listenerNotifier) {
        listenerNotifier.dispose();
        Navigator.of(context).pop();
      },
      errorVoidCallback: (notifier, listenerNotifier) {
        print('Ocorreu um erro');
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(fontSize: 14, color: context.primaryColor),
            ),
            Text(
              'Cadastro',
              style: TextStyle(
                fontSize: 16,
                color: context.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ClipOval(
              child: Container(
                color: context.primaryColor.withAlpha(20),
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: context.primaryColor,
                ),
              ),
            )),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListFild(
                    label: 'E-mail',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatorio'),
                      Validatorless.email('E-mail invalido'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListFild(
                    label: 'Senha',
                    obscureText: true,
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatoria'),
                      Validatorless.min(
                        6,
                        'Senha deve ter pelo menos 6 caracteres',
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListFild(
                    label: 'Confirmar senha',
                    obscureText: true,
                    controller: _confirmPasswordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirma senha obrigatoria'),
                      Validators.compare(
                          _passwordEC, 'Senha diferente de confirma senha')
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;

                        if (formValid) {
                          final email = _emailEC.text;
                          final password = _passwordEC.text;

                          context
                              .read<RegisterController>()
                              .registerUser(email, password);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Cadastrar'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
