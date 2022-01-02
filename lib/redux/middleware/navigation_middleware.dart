import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weekly_bible_trivia/global/enums.dart';
import 'package:weekly_bible_trivia/global/route_paths.dart';
import 'package:weekly_bible_trivia/redux/actions/appbar_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/navgation_actions.dart';
import 'package:weekly_bible_trivia/redux/actions/validation_actions.dart';
import 'package:weekly_bible_trivia/redux/states/app_state.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';

import '../../utils/locator.dart';

final NavigationService _navigationService = locator<NavigationService>();

ThunkAction<AppState> updateTabThunk(NavigationTab tab) {
  return (Store<AppState> store) {
    store.dispatch(UpdateNavigationTabAction(tab));
  };
}

ThunkAction<AppState> updateScreenThunk(dynamic action) {
  return (Store<AppState> store) {
    if (action is NavigateToHomeAction) {
      _navigationService.navigate(RoutePaths.toHomeScreen);
      return;
    } else if (action is NavigateBackToHomeAction) {
      _navigationService.navigateBack(RoutePaths.toHomeScreen);
      return;
    } else if (action is NavigateFromHomeToSignInScreenAction) {
      store.dispatch(ClearErrorsAction());
      checkMenuBarAndNavigate(store, RoutePaths.fromHomeToSignInScreen);
      return;
    } else if (action is NavigateFromHomeToTableResultsScreenAction) {
      checkMenuBarAndNavigate(store, RoutePaths.fromHomeToTableResultsScreen);
      return;
    } else if (action is NavigateFromHomeToAboutScreenAction) {
      checkMenuBarAndNavigate(store, RoutePaths.fromHomeToAboutScreen);
      return;
    } else if (action is NavigateFromHomeToEditProfileScreenAction) {
      checkMenuBarAndNavigate(store, RoutePaths.fromHomeToEditProfileScreen);
      return;
    } else if (action is NavigateFromHomeToTriviaScreenAction) {
      checkMenuBarAndNavigate(store, RoutePaths.fromHomeToTriviaScreen);
      return;
    } else if (action is NavigateFromHomeToSearchScreenAction) {
      checkMenuBarAndNavigate(store, RoutePaths.fromHomeToSearchScreen);
      return;
    } else if (action is NavigateFromHomeToSelectionScreenAction) {
      checkMenuBarAndNavigate(store, RoutePaths.fromHomeToSelectionReaderScreen);
      return;
    } else if (action is NavigateFromSelectionToTranslationScreenAction) {
      _navigationService.navigate(RoutePaths.fromSelectionReaderToTranslationScreen);
      return;
    } else if (action is NavigateFromSignInToHomeScreenAction) {
      //_navigationService.goBack();
      _navigationService.navigateBack(RoutePaths.fromSignInToHomeScreen);
      return;
    } else if (action is NavigateFromSignInToSignUpScreenAction) {
      store.dispatch(ClearErrorsAction());
      _navigationService.navigate(RoutePaths.fromSignInToSignUpScreen);
      return;
    } else if (action is NavigateFromSignUpToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromSignUpToHomeScreen);
      return;
    } else if (action is NavigateFromTableResultsToHomeScreenAction) {
      _navigationService.navigate(RoutePaths.fromTableResultsToHomeScreen);
      return;
    } else if (action is NavigateFromAboutToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromAboutToHomeScreen);
      return;
    } else if (action is NavigateFromEditProfileToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromEditProfileToHomeScreen);
      return;
    } else if (action is NavigateFromTriviaToResultScreenAction) {
      _navigationService.navigateAndReplace(RoutePaths.fromTriviaToResultScreen);
      return;
    }else if (action is NavigateFromTriviaToHomeScreenAction) {
      _navigationService.goBack();
      return;
    } else if (action is NavigateFromResultToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromResultToHomeScreen);
      return;
    } else if (action is NavigateFromSearchToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromSearchToHomeScreen);
      return;
    } else if (action is NavigateFromSelectionToHomeScreenAction) {
      _navigationService.navigateBack(RoutePaths.fromSelectionReaderToHomeScreen);
      return;
    } else if (action is NavigateFromTranslationToSelectionScreenAction) {
      _navigationService
          .navigateBack(RoutePaths.fromTranslationToSelectionScreen);
      return;
    }else if (action is NavigateFromTranslationToHomeScreenAction) {
      _navigationService
          .navigateBack(RoutePaths.fromTranslationToHomeScreen);
      return;
    }
    store.dispatch(action);
  };
}

void checkMenuBarAndNavigate(Store<AppState> store, String routePath) {
  if(store.state.appBarState.isShowMenuBar){
    store.dispatch(UpdateShowMenuBarAction(false));
    Future.delayed(const Duration(milliseconds: 400), () {
      _navigationService.navigate(routePath);
    });
  }else{
    _navigationService.navigate(routePath);
  }

}