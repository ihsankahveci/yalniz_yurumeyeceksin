

##scraping functions for different parts of the posts. 
# links for posts
get_links = function(url){
  read_html(url) |> 
    html_elements("article") |> 
    html_elements(".elementor-post__thumbnail__link") |> 
    html_attr("href") 
}
# titles
get_title = function(url){
  read_html(url) |> 
    html_elements("article") |> 
    html_element(".entry-title") |> 
    html_text2()
}
# dates
get_date = function(url){
  read_html(url) |> 
    html_elements("article") |> 
    html_element(".entry-date") |> 
    html_text2()
}
# main text
get_text = function(url){
  read_html(url) |> 
    html_elements("article") |> 
    html_element(".entry-content") |> 
    html_text2()
}
# comments
get_comments = function(url){
  read_html(url) |> 
    html_elements("article") |> 
    html_elements("li") |> 
    html_text2() |> 
    unlist()
}
