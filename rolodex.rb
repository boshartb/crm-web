class Rolodex
  attr_reader :contacts

  def initialize
    @contacts = []
    @@id = 1000
  end

  def add_contact(contact)
    contact.id = @@id
    @contacts << contact
    @@id += 1
  end

  # Takes an id, and returns the matching contact
  def find_contact(id_to_find)
    @contacts.find { |contact| contact.id == id_to_find.to_i }
  end
end