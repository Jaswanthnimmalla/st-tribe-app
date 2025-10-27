// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:localstore/localstore.dart' as _i7;

import '../bloc/article/article_bloc.dart' as _i26;
import '../bloc/auth/auth_bloc.dart' as _i27;
import '../bloc/event/events_bloc.dart' as _i28;
import '../bloc/groupbyin/group_by_in_bloc.dart' as _i29;
import '../bloc/home/home_bloc.dart' as _i30;
import '../bloc/intership/intership_bloc.dart' as _i21;
import '../bloc/profile/profile_bloc.dart' as _i31;
import '../blocobserver/bloc_observer.dart' as _i3;
import '../data/db/db_client.dart' as _i8;
import '../data/network/api_client.dart' as _i11;
import '../data/repository/article_repository.dart' as _i12;
import '../data/repository/auth_repository.dart' as _i4;
import '../data/repository/db_repository.dart' as _i9;
import '../data/repository/event_repository.dart' as _i15;
import '../data/repository/groupbyin_repository.dart' as _i17;
import '../data/repository/intership_repository.dart' as _i19;
import '../data/repository/profile_repository.dart' as _i22;
import '../data/repository/search_repository.dart' as _i24;
import '../domain/usecases/article_usecase.dart' as _i13;
import '../domain/usecases/auth_usecase.dart' as _i14;
import '../domain/usecases/events_usecase.dart' as _i16;
import '../domain/usecases/groupbyin_usecase.dart' as _i18;
import '../domain/usecases/internship_usecase.dart' as _i20;
import '../domain/usecases/profile_usecase.dart' as _i23;
import '../domain/usecases/search_usecase.dart' as _i25;
import '../modules/network_module.dart' as _i33;
import '../modules/preference_module.dart' as _i32;
import '../utils/dynamic_links.dart' as _i5;
import '../utils/loader.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    final preferenceModule = _$PreferenceModule();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i3.AppBlocObserver>(() => _i3.AppBlocObserver());
    gh.lazySingleton<_i4.AuthRepository>(() => _i4.AuthRepository());
    gh.singleton<_i5.DynamicLinks>(
      _i5.DynamicLinks() as _i1.FactoryFunc<_i5.DynamicLinks>,
    );
    gh.lazySingleton<_i6.Loader>(() => _i6.Loader());
    gh.lazySingleton<_i7.Localstore>(
      () => preferenceModule.provideSharedPreferences(),
    );
    gh.lazySingleton<_i8.DBClient>(() => _i8.DBClient(gh<_i7.Localstore>()));
    gh.lazySingleton<_i9.DatabaseRepository>(
      () => _i9.DatabaseRepository(gh<_i8.DBClient>()),
    );
    gh.lazySingleton<_i10.Dio>(
      () => networkModule.provideDio(gh<_i7.Localstore>()),
    );
    gh.lazySingleton<_i11.ApiClient>(() => _i11.ApiClient(gh<_i10.Dio>()));
    gh.lazySingleton<_i12.ArticleRepository>(
      () => _i12.ArticleRepository(gh<_i11.ApiClient>()),
    );
    gh.lazySingleton<_i13.ArticleUseCase>(
      () => _i13.ArticleUseCase(gh<_i12.ArticleRepository>()),
    );
    gh.lazySingleton<_i14.AuthUseCase>(
      () => _i14.AuthUseCase(
        gh<_i4.AuthRepository>(),
        gh<_i9.DatabaseRepository>(),
      ),
    );
    gh.lazySingleton<_i15.EventRepository>(
      () => _i15.EventRepository(gh<_i11.ApiClient>()),
    );
    gh.lazySingleton<_i16.EventUseCase>(
      () => _i16.EventUseCase(gh<_i15.EventRepository>()),
    );
    gh.lazySingleton<_i17.GroupByInRepository>(
      () => _i17.GroupByInRepository(gh<_i11.ApiClient>()),
    );
    gh.lazySingleton<_i18.GroupByInUseCase>(
      () => _i18.GroupByInUseCase(gh<_i17.GroupByInRepository>()),
    );
    gh.lazySingleton<_i19.InternShipRepository>(
      () => _i19.InternShipRepository(gh<_i11.ApiClient>()),
    );
    gh.lazySingleton<_i20.InternShipUseCase>(
      () => _i20.InternShipUseCase(gh<_i19.InternShipRepository>()),
    );
    gh.lazySingleton<_i21.InternshipBloc>(
      () =>
          _i21.InternshipBloc(internShipUseCase: gh<_i20.InternShipUseCase>()),
    );
    gh.lazySingleton<_i22.ProfileRepository>(
      () => _i22.ProfileRepository(
        gh<_i11.ApiClient>(),
        gh<_i9.DatabaseRepository>(),
      ),
    );
    gh.lazySingleton<_i23.ProfileUseCase>(
      () => _i23.ProfileUseCase(gh<_i22.ProfileRepository>()),
    );
    gh.lazySingleton<_i24.SearchRepository>(
      () => _i24.SearchRepository(gh<_i11.ApiClient>()),
    );
    gh.lazySingleton<_i25.SearchUseCase>(
      () => _i25.SearchUseCase(gh<_i24.SearchRepository>()),
    );
    gh.lazySingleton<_i26.ArticleBloc>(
      () => _i26.ArticleBloc(articleUseCase: gh<_i13.ArticleUseCase>()),
    );
    gh.lazySingleton<_i27.AuthBloc>(
      () => _i27.AuthBloc(authUseCase: gh<_i14.AuthUseCase>()),
    );
    gh.lazySingleton<_i28.EventBloc>(
      () => _i28.EventBloc(eventUseCase: gh<_i16.EventUseCase>()),
    );
    gh.lazySingleton<_i29.GroupByInBloc>(
      () => _i29.GroupByInBloc(groupByInUseCase: gh<_i18.GroupByInUseCase>()),
    );
    gh.lazySingleton<_i30.HomeBloc>(
      () => _i30.HomeBloc(searchUseCase: gh<_i25.SearchUseCase>()),
    );
    gh.lazySingleton<_i31.ProfileBloc>(
      () => _i31.ProfileBloc(profileUseCase: gh<_i23.ProfileUseCase>()),
    );
    return this;
  }
}

class _$PreferenceModule extends _i32.PreferenceModule {}

class _$NetworkModule extends _i33.NetworkModule {}
