module ApplicationHelper


  def build_outcodes
    arr_of_arrs = CSV.read("postcode-outcodes.csv")
    counter = true
    arr_of_arrs.each do |codes|
      if counter == true
        counter = false
      else
        Outcode.create(


          )
      end
    end


  end
end
