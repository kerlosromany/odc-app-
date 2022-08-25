abstract class HomeStates{}

class HomeInitialState extends HomeStates{}


class ProductsLoadingDataState extends HomeStates{}

class ProductsSuccessDataState extends HomeStates{}

class ProductsErrorDataState extends HomeStates{
  final String error;

  ProductsErrorDataState(this.error);

}


class HomePlantsLoadingDataState extends HomeStates{}

class HomePlantsSuccessDataState extends HomeStates{}

class HomePlantsErrorDataState extends HomeStates{
  final String error;

  HomePlantsErrorDataState(this.error);

}

class HomeToolsLoadingDataState extends HomeStates{}

class HomeToolsSuccessDataState extends HomeStates{}

class HomeToolsErrorDataState extends HomeStates{
  final String error;

  HomeToolsErrorDataState(this.error);

}

class HomeSeedsLoadingDataState extends HomeStates{}

class HomeSeedsSuccessDataState extends HomeStates{}

class HomeSeedsErrorDataState extends HomeStates{
  final String error;

  HomeSeedsErrorDataState(this.error);

}


class BlogsLoadingDataState extends HomeStates{}

class BlogsSuccessDataState extends HomeStates{}

class BlogsErrorDataState extends HomeStates{
  final String error;

  BlogsErrorDataState(this.error);

}


class SearchLoadingState extends HomeStates{}

class SearchSuccessState extends HomeStates{}

class SearchErrorState extends HomeStates{}



