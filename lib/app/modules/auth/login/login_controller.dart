import 'package:todo_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_provider/app/exception/auth_exception.dart';
import 'package:todo_provider/app/services/user/user_servise.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.login(email, password);

      if (user != null) {
        sucess();
      } else {
        setError('Usuário ou senha inválidos');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Reset de senha enviado para seu email';
    } on AuthException catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Erro ao resetar senha');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> googleLogin() async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.googleLogin();

      if (user != null) {
        sucess();
      } else {
        _userService.logout();
        setError('Erro ao realizar login');
      }
    } on AuthException catch (e) {
      _userService.logout();
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
