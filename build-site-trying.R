options(blogdown.server.timeout=240)

library(blogdown)
blogdown::hugo_build()  # no re-compiling
blogdown::serve_site()  # serve the website locally only

blogdown::build_site()


blogdown::stop_server()
