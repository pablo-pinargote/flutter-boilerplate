// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'services/_contracts/third_party_services/auth_services_contract.dart'
    as _i3;
import 'services/auth/get_session.dart' as _i5;
import 'third_party_services/provisioning/auth_services.dart' as _i4;
import 'ui/auth/login_presenter.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthServicesContract>(() => _i4.AuthServices());
  gh.factory<_i5.GetSessionContract>(
      () => _i5.GetSession(get<_i3.AuthServicesContract>()));
  gh.factoryParam<_i6.LoginPresenter, _i6.LoginContract?, dynamic>(
      (view, _) => _i6.LoginPresenter(get<_i5.GetSessionContract>(), view));
  return get;
}
