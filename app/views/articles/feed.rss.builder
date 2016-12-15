#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "TroopWebsite"
    xml.author "Bob Koertge"
    xml.description "Articles from Troop Website"
    xml.link "https://www.troop.website"
    xml.language "en"

    for article in @blog_articles
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ""
        end
        xml.author article.user.username
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link "https://www.troop.website/articles/" + article.id.to_s
        xml.guid article.id

        text = article.description
        # if you like, do something with your content text here e.g. insert image tags.
        # Optional. I'm doing this on my website.
        # if article.image.exists?
        #   image_url = article.image.url(:large)
        #   image_caption = article.image_caption
        #   image_align = ""
        #   image_tag = "
        #         <p><img src='" + image_url +  "' alt='" + image_caption + "' title='" + image_caption + "' align='" + image_align  + "' /></p>
        #       "
        #   text = text.sub('{image}', image_tag)
        # end
        xml.description "<p>" + text + "</p>"

      end
    end
  end
end
