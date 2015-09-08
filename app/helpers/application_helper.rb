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

  def scrape_rightmove_api
    Listing.destroy_all
    Tag.destroy_all
    Outcode.all.each do |my_code|
      puts "NOW MOVING ON TO OUT CODE #{my_code.code}"
      scrape = RestClient.get("http://api.rightmove.co.uk/api/sale/find?+&sortType=1&numberOfPropertiesRequested=9999&locationIdentifier=OUTCODE%5E#{my_code.secret_code}&apiApplication=IPAD")
      scrape = JSON.parse(scrape)
      scrape["properties"].each do |property|
        begin
          if property["bedrooms"]
            bedrooms = property["bedrooms"]
          else
            bedrooms = nil
          end

          Listing.create(
            :outcode_id => my_code.id,
            :latitude => property["latitude"],
            :longitude => property["longitude"],
            :property_type => property["propertyType"],
            :bedrooms => bedrooms,
            :price => property["price"],
            :identifier => property["identifier"],
            :address => property["address"],
            :summary => property["summary"],
            :small_thumb => property["photoThumbnailUrl"],
            :large_thumb => property["photoLargeThumbnailUrl"]
            )
        puts "created listing for #{property["identifier"]}!"
        rescue
            puts "scraping error at #{property["identifier"]}"
            sleep 0.15
        end
      end
    end
  end

  def build_secret_codes
    counter = 0
    time = Time.now
    Outcode.all.each do |code|
      begin
         a = Mechanize.new
         a = a.get("http://www.rightmove.co.uk/property-for-sale/search.html?searchLocation=#{code.code}&locationIdentifier=&useLocationIdentifier=false&buy=For+sale")
         a = a.form_with(:id => 'propertySearchCriteria') do |form|
            end.submit
         code.secret_code = /OUTCODE%5E(.*?)&/.match(a.uri.to_s)[1]
         wow = /OUTCODE%5E(.*?)&/.match(a.uri.to_s)[1]
         if code.save
            current_time = Time.now - time
            total = 2700.0 / wow.to_f
            estimate = total * current_time.to_f
            puts "successfully brought in #{code.code} with a secret value of value of #{wow}, time elapsed is #{current_time} seconds. You have about #{estimate - current_time} seconds left."

          else
            puts "didn't save #{code.code}!"
          end
      rescue
        puts "Error at #{code.code}"
        sleep 0.15
      end
    end
  end

  def write_secrets_to_json
    my_hash = Hash.new
    Outcode.all.each do |code|
      if code.secret_code != nil
        my_hash[code.code] = code.secret_code
      end
    end

    File.open("secret_codes.json","w") do |f|
      f.write(my_hash.to_json)
    end
  end
end
