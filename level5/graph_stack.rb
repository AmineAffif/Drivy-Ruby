require 'gruff'
require_relative 'services/commission_calculator'

# Plages de valeurs pour la simulation
durees = (1..30).to_a
prix_totals = (100..20000).step(100).to_a

# Initialisation du graphique
g = Gruff::Area.new(1000)
g.title = 'Analyse de la Rentabilité'
g.theme = {
  colors: ['#501212'],
  marker_color: '#ffffff',
  font_color: '#ffffff',
  background_colors: 'black'
}

# Données pour le graphique
non_rentable_data = Array.new(durees.length, 0)
fill_data = Array.new(durees.length, 0)

durees.each do |duree|
  prix_totals.each do |prix|
    calculator = Services::CommissionCalculator.new(prix, duree)
    commission = calculator.calculate
    drivy_fee = commission[:drivy_fee]

    if drivy_fee < 0
      non_rentable_data[duree - 1] = prix / 100
      fill_data[duree - 1] = prix / 100 # Remplir l'espace en dessous
    end
  end
end

# Ajout des données au graphique
g.data('Seuil de rentabilité', non_rentable_data)

# Réduire le nombre d'étiquettes
g.labels = (1..30).step(2).map { |d| [d - 1, "#{d} j"] }.to_h

# Génération du graphique
g.write('analyse_rentabilite_area.png')
