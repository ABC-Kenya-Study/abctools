test_that("drop_vars_all_na() drops columns that are all NA", {
  (x <- data.frame(a = 1:4, b = rep(NA, 4), c = 5:8, d = c(NA, 'B', 'C', 'D')))
  expect_equal(ncol(drop_vars_all_na(x)), 3)
})
