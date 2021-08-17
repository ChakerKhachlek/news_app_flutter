abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}

//business news states
class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates{
  final String error;

  NewsGetBusinessErrorState(this.error);

}

//Technologies news states
class NewsGetTechnologiesLoadingState extends NewsStates{}

class NewsGetTechnologiesSuccessState extends NewsStates{}

class NewsGetTechnologiesErrorState extends NewsStates{
  final String error;

  NewsGetTechnologiesErrorState(this.error);

}

//gaming news states
class NewsGetGamingLoadingState extends NewsStates{}

class NewsGetGamingSuccessState extends NewsStates{}

class NewsGetGamingErrorState extends NewsStates{
  final String error;

  NewsGetGamingErrorState(this.error);

}

class NewsChangeThemeModeState extends NewsStates{}

