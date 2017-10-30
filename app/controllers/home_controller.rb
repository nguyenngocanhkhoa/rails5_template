class HomeController < ApplicationController

  @@default_cols = Array[
    "master_item_id",
    "ITEM-KEY",
    "Org Item ID",
    "Original Client Description",
    "Client Vendor",
    "Client VenCatNum",
    "Client Manufacturer",
    "Client MfrCatNum",
    "Meperia Vendor",
    "Discerned VenCatNum",
    "Meperia Manufacturer",
    "Discerned MfrCatNum",
    "Item Status",
    "UNSPSC",
    "HCPCS",
    "UOM",
    "QOE",
    "Attribute Enhancement Count",
    "Enhanced Attributes",
    "Auto Tags",
    "Recommended Tags",
    "Original Sequence",
    "ProductGroupID",
    "item_key_old"
  ]

  @@not_use_cols = Array[
    "QOE",
    "UOM",
    "COST",
    "QUANTITY",
    "PPA",
    "PACKAGING",
    "UNSPSC",
    "HCPCS"
  ]

  def process_row (row, headers, isUnmatched)
    #if (row["Discernment Type"] == "DIRECT") && ((row["Method"] == "MANUFACTURER-MFRCATNUM") || (row["Method"] == "VENDOR-VENCATNUM"))
    if (isUnmatched == true)
    @expert_hash = Hash.new
      @auto_tags = Array.new
      @recomment_tags = Array.new
      @original_sequence = Array.new
      @flag_recommended_tag = false

      headers.each do |header|
        if @@default_cols.include? header
          @expert_hash[header]= row[header]
        elsif (header == "Item_Key" or header == "item_key")
          @expert_hash["ITEM-KEY"]= row[header]
        elsif (header.to_s.include? "Auto-") && (header.to_s != "Ordered-Auto-Tags") #add value into auto tags
          if header == "Auto-Unknowns"
            if row[header].to_s != ""
              @array_unknows = row[header].to_s.split(";")
              if @array_unknows.length > 1
                @temp_count = 1
                @array_unknows.each do |item|
                  @auto_tags << "UNKNOWS" + @temp_count.to_s + "=" + item.to_s
                  @original_sequence << "UNKNOWS" + @temp_count.to_s
                  @temp_count += 1
                end
              else
                unless row[header].to_s == ""
                  @auto_tags << "UNKNOWS" + "=" + row[header]
                  @original_sequence << "UNKNOWS"
                end
              end
            end
          else
            unless row[header].to_s == ""

              @auto_tags << header[5..-1] + "=" + row[header]
              @original_sequence << header[5..-1]
            end
          end
        elsif  (header == "NOUN") || (@flag_recommended_tag == true)
            if header == "NOUN"
              @flag_recommended_tag = true
            elsif header == "OTHER"
            @flag_recommended_tag = false
            end
            unless @@not_use_cols.include? header
              @recomment_tags << header + "=" + row[header] unless row[header].to_s == ""
            end
        end
        end

      @expert_hash["Auto Tags"] = @auto_tags.join("|")
      @expert_hash["Recommended Tags"] = @recomment_tags.join("|")
      @expert_hash["Original Sequence"] = @original_sequence.join("|")
    convert_hash_into_array(@expert_hash)
  #else
   # nil
  #end
    else
    if (row["Discernment Type"] != "UNMATCHED")
    @expert_hash = Hash.new
      @auto_tags = Array.new
      @recomment_tags = Array.new
      @original_sequence = Array.new
      @flag_recommended_tag = false

      headers.each do |header|
        if @@default_cols.include? header
          @expert_hash[header]= row[header]
        elsif (header == "Item_Key" or header == "item_key")
          @expert_hash["ITEM-KEY"]= row[header]
        elsif (header.to_s.include? "Auto-") && (header.to_s != "Ordered-Auto-Tags") #add value into auto tags
          if header == "Auto-Unknowns"
            if row[header].to_s != ""
              @array_unknows = row[header].to_s.split(";")
              if @array_unknows.length > 1
                @temp_count = 1
                @array_unknows.each do |item|
                  @auto_tags << "UNKNOWS" + @temp_count.to_s + "=" + item.to_s
                  @original_sequence << "UNKNOWS" + @temp_count.to_s
                  @temp_count += 1
                end
              else
                unless row[header].to_s == ""
                  @auto_tags << "UNKNOWS" + "=" + row[header]
                  @original_sequence << "UNKNOWS"
                end
              end
            end
          else
            unless row[header].to_s == ""

              @auto_tags << header[5..-1] + "=" + row[header]
              @original_sequence << header[5..-1]
            end
          end
        elsif  (header == "NOUN") || (@flag_recommended_tag == true)
            if header == "NOUN"
              @flag_recommended_tag = true
            elsif header == "OTHER"
            @flag_recommended_tag = false
            end
            unless @@not_use_cols.include? header
              @recomment_tags << header + "=" + row[header] unless row[header].to_s == ""
            end
        end
        end

      @expert_hash["Auto Tags"] = @auto_tags.join("|")
      @expert_hash["Recommended Tags"] = @recomment_tags.join("|")
      @expert_hash["Original Sequence"] = @original_sequence.join("|")
    convert_hash_into_array(@expert_hash)
  else
    nil
  end
    end
  end

  def convert_hash_into_array (hash)
    @result_array = Array.new

    @@default_cols.each do |col|
      @result_array << hash[col]
    end

    @result_array
  end

  def write_processed_msss_file (filename, isUnmatched)
    if isUnmatched
      path_output = Rails.root.to_s + "/" + filename[0..-5] + "_processed.csv"
    else
      path_output = Rails.root.to_s + "/" + filename[0..-5] + "_processed_only_matched_items.csv"
    end
    File.open(path_output, "w") do |f|
      f.puts(@@default_cols.join("\t"))
      @begin_time = Time.now
      puts "Begining process file!"

        begin
          @current = 1
          @process_count_row = 0
          path = Rails.root.to_s + "/" + filename
          file = File.open(path, "r")
          @is_header = true
          @row_hash = Hash.new
          @headers = Array.new
          file.each_line do |line|
            if @is_header == true #row is header
              @headers = line.strip.split("\t")
              @is_header = false
            else # row is not header
              @row = line.split("\t", @headers.length)
              # puts @row.inspect
              for i in 0..@row.length
                @row_hash[@headers[i]] = @row[i].to_s.strip
              end
              @array_process = process_row(@row_hash, @headers, isUnmatched)
              if @array_process != nil
                f.puts @array_process.join("\t")
                @process_count_row += 1
                #puts "Current row #{@current} | #{@row_hash["Meperia ASP ID"]}| Count: #{@process_count_row}" +  "|" + @row_hash["Discernment Type"] +"|"+ @row_hash["Method"]
              else
                puts "No #{@current} no process!"
            end


            end
            @current+=1
          end
          puts "Writing is completed!"
          puts "Total #{@current - 1} row!"
          puts "Processed #{@process_count_row} row!"
          @end_time = Time.now
          process_time = @end_time - @begin_time
          puts "Time is: #{process_time}"
        rescue => exception
          puts exception
          puts "Writing is failed!"
        end

    end

  end
  def index
  end

  def import
  end
  
  def export_data
    if params[:input].present?
      spreadsheet = Roo::Spreadsheet.open(params[:input])
      arr = []
      delete_column = 0
        spreadsheet.row(1).each_with_index do |header, index|
          if header == "LENGTH"
            arr << index
          end
        end
        arr.each do |a|
          if spreadsheet.row(2)[a].blank?
            delete_column = a
          end
        end
        header_out = spreadsheet.row(1)
        header = spreadsheet.row(1)
        if delete_column != 0
          header.delete_at(delete_column) 
          header_out.delete_at(delete_column)
        end
        header_out.insert(4, 'ITEM-KEY')
        header_out.insert(4, 'item_key_old')
        header_out = header_out - ["item status", "other", "OTHER", "process status", "Picture 1", "URL_Picture", "Picture Path"]
        ouput =  params[:input].original_filename[0..-6] + "_ouput.txt"
        File.open(ouput, "w") do |f|
          f.puts header_out.join("\t")
          (2..spreadsheet.last_row).each do |i|
            row_excel = spreadsheet.row(i)
            row_excel.delete_at(delete_column) if delete_column != 0
            row = Hash[[header, row_excel].transpose]
            row["ITEM-KEY"] = row["master_item_id"]
            row["item_key_old"] = [row["Org Item ID"], row["Client Vendor"], row["Client VenCatNum"]].join("|")
            row["ProductGroupID"].blank? && row["ProductGroupID"] = -1
            row["Attribute Enhancement Count"].blank? && row["Attribute Enhancement Count"] = -1
            if row['Item Status'].to_s == '1'
              row['Item Status'] = 'FULLY-NORMALIZED'
            elsif !['FULLY-NORMALIZED', 'PARTIALLY-NORMALIZED', 'AUTO-NORMALIZED'].include? row['Item Status']
              flash[:error] = "row [#{i.to_s}] error item status"
              redirect_to :import and return
            end
            f.puts header_out.map{|attr| (row[attr].is_a? String) ? row[attr].upcase : row[attr]}.join("\t")
          end
        end
        write_processed_msss_file(ouput, true)
      end
      flash[:notice] = "import successfully created"
      redirect_to :import
  end

end
