import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:playground/services/_results/failure.dart';
import 'package:playground/services/auth/get_session.dart';
import 'package:playground/services/_models/user.dart';

import '../di.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> implements HomeContract {

  HomePresenter? _presenter;

  _HomeState() {
    _presenter = getIt<HomePresenter>(param1: this);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sample App'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Clean Architecture',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        _presenter!.validateSession(nameController.text, passwordController.text);
                      },
                    )),
              ],
            )));
  }

  @override
  void showAccessToken(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(user.accessToken!),
        );
      },
    );
  }

  @override
  void showFailureType(String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(type),
        );
      },
    );
  }
}

abstract class HomeContract {
  void showAccessToken(User user);
  void showFailureType(String type);
}

@injectable
class HomePresenter {
  HomeContract? _view;

  GetSessionContract? _getSession;
  HomePresenter(GetSessionContract s, @factoryParam HomeContract? c) {
    _getSession = s;
    _view = c;
  }

  void setView(HomeContract view) {
    _view = view;
  }

  void validateSession(userName, password) async {
    Either<User, Failure> getSessionResult = await _getSession!.execute(userName, password);
    getSessionResult.fold((user) => {
      _view!.showAccessToken(user)
    }, (failure) => {
      _view!.showFailureType(failure.runtimeType.toString())
    });
  }
}
