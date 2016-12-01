@requirements.each { |req| @scout.scout_requirements.each { |test| counter +=1 if test.requirement_id == req.id } }



<% @requirements.each do |req| %>
    <% @scout.scout_requirements.each { |test| counter +=1 if test.requirement_id == req.id } %>
<% end %>