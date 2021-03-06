module LinkedIn
  module ToXmlHelpers

    private

    def status_to_xml(status)
      doc = Nokogiri.XML('<current-status/>', nil, 'UTF-8')
      doc.root.content = status
      doc.to_xml
    end

    def message_to_xml(message)
      doc = Nokogiri.XML('')
      doc.encoding = 'UTF-8'
      doc.root = message.to_xml_node(doc)
      doc.to_xml
    end

    def share_to_xml(options={})
      doc = Nokogiri.XML('<share><comment/><title/><submitted-url/><submitted-image-url/><visibility><code/></visibility></share>', nil, 'UTF-8')

      {:comment => 'comment', :title => 'title', :url => 'submitted-url', :image_url => 'submitted-image-url'}.each do |key, name|
        doc.at_css(name).content = options[key] if options[key]
      end

      doc.at_css('visibility > code').content = options[:visibility] || options[:visability] # backward-compatible typo fix

      doc.to_xml
    end

    def comment_to_xml(comment)
      doc = Nokogiri.XML('<update-comment><comment/><update-comment/>', nil, 'UTF-8')
      doc.at_css('comment').content = comment

      doc.to_xml
    end

    def network_update_to_xml(message)
      doc = Nokogiri::XML('<activity locale="en_US"><content-type>linkedin-html</content-type><body/></activity>', nil, 'UTF-8')
      doc.at_css('body').content = message
      doc.to_xml
    end

  end
end
