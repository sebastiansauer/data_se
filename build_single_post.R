blogdown::new_post(
  title = "Wetterdaten des DWD aufbereiten",
  ext = ".Rmd",
  subdir = "post"
)

blogdown::build_site(
  build_rmd = "content/post/2026-08-14-wetterdaten-des-dwd-aufbereiten/index.Rmd"
)


blogdown::build_site(
  build_rmd = "content/post/2026-08-14-wetterdaten-des-dwd-analysieren-2026/index.Rmd"
)
