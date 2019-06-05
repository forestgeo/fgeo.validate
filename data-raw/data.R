# Reads from tests/private and wirtes to root
# packageVersion("rtbl")
#> [1] '0.0.0.9002'

# path_out <- testthat::test_path("private", "fgeo", "luquillo")
# fs::dir_create(path_out)
create_fgeo_tables("luquillo")
# TODO: Move the directories manually

# # path_out <- testthat::test_path("private", "fgeo", "pasoh")
# # fs::dir_create(path_out)
# create_fgeo_tables("pasoh")
