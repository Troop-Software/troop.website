positions = %w[none Patrol\ Leader Assistant\ senior\ patrol\ leader senior\ patrol\ leader troop\ guide Order\ of\ the\ Arrow\ troop\ representative den\ chief scribe librarian historian quartermaster bugler junior\ assistant\ Scoutmaster chaplain\ aide instructor troop\ webmaster Outdoor\ Ethics\ Guide Asst\ Patrol\ Leader]

positions.each do |position|
  Position.seed(name: position)
end