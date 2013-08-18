class RequirementReport < Prawn::Document
  # def initialize(records)
  #   @records = records
  # end
  def to_pdf(records)
    # text "Hello world"    
    
    records.each do |requirement|
      rows = []
      requirement.requirement_attributes.each do |attribute|
        rows << [Prawn::Table::Cell::Text.new(self, [0,0], content: attribute.requirement_field.name,
                                              inline_format:  true,background_color:  'E8E8D0', font: "Helvetica", font_style: :bold), attribute.value]
      end
      table(rows)
      move_down 20
    end
    # move_down 20
    
    render
  end
end