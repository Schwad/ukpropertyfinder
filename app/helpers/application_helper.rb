module ApplicationHelper


  def build_outcodes_now
    arr_of_arrs = CSV.read("postcode-outcodes.csv")
    counter = true
    arr_of_arrs.each do |codes|
      if counter == true
        counter = false
      else
        Outcode.create(
          :code => codes[1]
          )
      end
    end
  end


end
