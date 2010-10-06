module TitaniumMobile
  module SDoc
    def self.process_data( data )      
      api = []

      data.each do |key, values|
        block = {
          :id => key,
          :description => values["description"].to_s.strip.gsub( /[\n|\t|\r]/, "" ).gsub( /[\s]{2,}/, " " ).strip_tags.capitalize,
          :deprecated => values["deprecated"],
          :compat => values["platforms"].to_a.map{|c| c.capitalize}.join( "|" ),
          :code => [],
          :since => values["since"]
        }

        if !values["examples"].empty?
          values["examples"].each do |e|
            block[:code].push( {
              :code => e["code"].strip.gsub( /[\n|\t|\r]/, "" ).gsub( /[\s]{2,}/, " " ).strip_tags,
              :description => e["description"].strip.gsub( /[\n|\t|\r]/, "" ).gsub( /[\s]{2,}/, " " ).strip_tags
            } )
          end
        end

        api.push( block )

        if values["methods"].empty?
          values["methods"].each do |m|
            block = {
              :id => "#{key}.#{m["name"]}",
              :description => m["value"].to_s.strip.gsub( /[\n|\t|\r]/, "" ).gsub( /[\s]{2,}/, " " ).strip_tags.capitalize,
              :deprecated => m["deprecated"],
              :type => m["returntype"].to_s.split( "," ).map{|c| c.capitalize}.join( "|" ),
              :parameters => [],
              :since => m["since"]
            }

            if m["parameters"]
              m["parameters"].each do |p|
                block[:parameters].push( {:name => p["name"], :description => p["description"], :type => "{#{p["type"].capitalize}}"} )
              end
            end

            api.push( block )
          end
        end

        if !values["properties"].empty?
          values["properties"].each do |p|
            block = {
              :id => "#{key}.#{p["name"]}",
              :description => p["value"].to_s.strip.gsub( /[\n|\t|\r]/, "" ).gsub( /[\s]{2,}/, " " ).strip_tags.capitalize,
              :deprecated => p["deprecated"],
              :type => p["type"].to_s.split( "," ).map{|c| c.capitalize}.join( "|" ),
              :property => true,
              :since => p["since"]
            }
            
            api.push( block )
          end
        end
      end

      api
    end

    def self.build_block( data )
      # open block.
      block = <<-BLOCK
/**
 * #{data[:description]} #{( data[:compat] ) ? "Platforms: " + data[:compat] : ""}
BLOCK

      if data[:code]
        block += <<-BLOCK
 * @code
BLOCK

        data[:code].each do |c|
          block += <<-BLOCK
 * #{c[:description]}:
 * #{c[:code]}
BLOCK
        end
      end

      block += <<-BLOCK
 * @id #{data[:id]}
BLOCK

      if data[:parameters]
        data[:parameters].each do |p|
          block += <<-BLOCK
 * @param #{p[:type]} #{p[:name]} #{p[:description]}
BLOCK
        end
      end
      
      if data[:type]
        block += <<-BLOCK
 * @type #{data[:type]}
BLOCK
      end

      if data[:property]
        block += <<-BLOCK
 * @property
BLOCK
      end

      if data[:since]
        block += <<-BLOCK
 * @since #{data[:since]}
BLOCK
      end

      if data[:deprecated]
        block += <<-BLOCK
 * @deprecated #{data[:deprecated]}
BLOCK
      end

      # close.
      block += <<-BLOCK
 */
BLOCK
    end
  end
end

class String
	def strip_tags
		self.gsub( %r{</?[^>]+?>}, "" )
	end
end
