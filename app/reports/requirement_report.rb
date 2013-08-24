class RequirementReport < Prawn::Document
  # def initialize(records)
  #   @records = records
  # end
  def to_pdf(records)
    # text "Hello world"    
    
    fields = records.first.project.fields
    records.each do |requirement|
      rows = []
      fields.each do |attribute|
        value = requirement.send(attribute.field_name)
        rows << [Prawn::Table::Cell::Text.new(self, [0,0], content: attribute.name,
                                              inline_format:  true,background_color:  'E8E8D0', font: "Helvetica", font_style: :bold), value.blank? ? "" : value ]
      end
      table(rows)
      move_down 20
    end
    # move_down 20
    
    render
  end
end