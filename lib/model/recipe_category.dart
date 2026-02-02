enum RecipeCategory {
  all('Todas'),
  chicken('Frango'),
  meat('Carne Vermelha'),
  fish('Peixe'),
  dessert('Sobremesa'),
  fit('Fit'),
  vegetarian('Vegetariana'),
  sauces('Molhos'),
  pasta('Massa'),
  japanese('Japones');

  final String displayName;

  const RecipeCategory(this.displayName);
}
