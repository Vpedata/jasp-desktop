context("Descriptives")

# does not test
# - error handling

test_that("Main table results match", {
  options <- jasptools::analysisOptions("Descriptives")
  options$variables <- "contNormal"
  options$splitby <- "contBinom"
  options$median <- TRUE
  options$mode <- TRUE
  options$sum <- TRUE
  options$variance <- TRUE
  options$range <- TRUE
  options$standardErrorMean <- TRUE
  options$kurtosis <- TRUE
  options$skewness <- TRUE
  options$shapiro <- TRUE
  options$mode <- TRUE
  options$percentileValuesEqualGroups <- TRUE
  options$percentileValuesEqualGroupsNo <- 5
  options$percentileValuesPercentiles <- TRUE
  options$percentileValuesPercentilesPercentiles <- c(2, 5, 8)
  options$percentileValuesQuartiles <- TRUE
  results <- jasptools::run("Descriptives", "test.csv", options)
  table <- results[["results"]][["stats"]][["data"]]
  expect_equal_tables(table,
    list(1.89652072756094, 0, 3.356094448, -0.120135614827586, -0.2223981035,
				 -2.336742886, 0, -2.336742886, 0.00342000811150064, 5.692837334,
				 0.933547444665698, 0.885861572513177, 1.10575982846952, 0.618135836828014,
				 0.145193378675912, 0.313719932561217, -6.96786566, 58, "contNormal",
				 1.22270479825695, -0.8465404722, -0.6015855064, 0.189093977,
				 0.5121792992, -2.12776693668, -1.6743740472, -1.38430134284,
				 -0.77748184225, -0.2223981035, 0.38502497975, 0.972132667292966,
				 1, 2.179421126, -0.283499835571428, -0.405769511, -3.023963827,
				 0, -3.023963827, 0.401705854633909, 5.203384953, 0.972586424088514,
				 0.166587887409046, 0.994612407217046, 0.716632727345669, 0.15347202634745,
				 0.365360605557062, -11.906993094, 42, "contNormal", 0.989253840590086,
				 -0.9755913562, -0.5800195022, -0.2167812726, 0.521794901, -1.89726255948,
				 -1.61858187715, -1.43841230624, -0.80595539125, -0.405769511,
				 0.4460704255)
  )
})

test_that("Frequencies table matches", {
  options <- jasptools::analysisOptions("Descriptives")
  options$variables <- "facGender"
  options$splitby <- "contBinom"
  options$frequencyTables <- TRUE
  results <- jasptools::run("Descriptives", "test.csv", options)
  table <- results[["results"]][["tables"]][["collection"]][["tables_facGender"]][["data"]]
  expect_equal_tables(table,
  list("TRUE", 44.8275862068966, 26, "f", 44.8275862068966, 44.8275862068966,
			 0, "FALSE", 100, 32, "m", 55.1724137931034, 55.1724137931034,
			 0, "FALSE", "", 0, "Missing", 0, "", "", "FALSE", "", 58, "Total",
			 100, "", "", "TRUE", 57.1428571428571, 24, "f", 57.1428571428571,
			 57.1428571428571, 1, "FALSE", 100, 18, "m", 42.8571428571428,
			 42.8571428571428, 1, "FALSE", "", 0, "Missing", 0, "", "", "FALSE",
			 "", 42, "Total", 100, "", "")
  )
})

test_that("Frequencies table matches with missing values", {
  options <- jasptools::analysisOptions("Descriptives")
  x <- c(rep(NA, 10), rep(1:2, times=10))
  split <- rep(1:2, each=15)
  data <- data.frame(x=as.factor(x), split=as.factor(split))
  options$variables <- "x"
  options$splitby <- "split"
  options$frequencyTables <- TRUE
  results <- jasptools::run("Descriptives", data, options)
  table <- results[["results"]][["tables"]][["collection"]][["tables_x"]][["data"]]
  expect_equal_tables(table,
  list("TRUE", 60, 3, 1, 20, 60, 1, "FALSE", 100, 2, 2, 13.3333333333333,
			 40, 1, "FALSE", "", 10, "Missing", 66.6666666666667, "", "",
			 "FALSE", "", 15, "Total", 100, "", "", "TRUE", 46.6666666666667,
			 7, 1, 46.6666666666667, 46.6666666666667, 2, "FALSE", 100, 8,
			 2, 53.3333333333333, 53.3333333333333, 2, "FALSE", "", 0, "Missing",
			 0, "", "", "FALSE", "", 15, "Total", 100, "", "")
  )
})

test_that("Distribution plot matches", {
  skip("This test need to be verified")
  options <- jasptools::analysisOptions("Descriptives")
  options$variables <- "contNormal"
  options$plotVariables <- TRUE
  results <- jasptools::run("Descriptives", "test.csv", options)
  testPlot <- results[["state"]][["figures"]][[1]][["obj"]]
  expect_equal_plots(testPlot, "distribution", dir="Descriptives")
})

test_that("Correlation plot matches", {
  options <- jasptools::analysisOptions("Descriptives")
  options$variables <- c("contNormal", "contGamma")
  options$plotCorrelationMatrix <- TRUE
  results <- jasptools::run("Descriptives", "test.csv", options)
  testPlot <- results[["state"]][["figures"]][[1]][["obj"]]
  expect_equal_plots(testPlot, "correlation", dir="Descriptives")
})

test_that("Boxplot matches", {
  set.seed(0)
  options <- jasptools::analysisOptions("Descriptives")
  options$variables <- "contGamma"
  options$splitby <- "facFive"
  options$splitPlotBoxplot <- TRUE
  options$splitPlotColour <- TRUE
  options$splitPlotJitter <- TRUE
  options$splitPlotOutlierLabel <- TRUE
  options$splitPlotViolin <- TRUE
  options$splitPlots <- TRUE
  results <- jasptools::run("Descriptives", "test.csv", options)
  testPlot <- results[["state"]][["figures"]][[1]][["obj"]]
  expect_equal_plots(testPlot, "boxplot", dir="Descriptives")
})

test_that("Q-QPlot plot matches", {
  options <- jasptools::analysisOptions("Descriptives")
  options$variables <- "contNormal"
  options$descriptivesQQPlot <- TRUE
  results <- jasptools::run("Descriptives", "test.csv", options)
  testPlot <- results[["state"]][["figures"]][[1]][["obj"]]
  expect_equal_plots(testPlot, "qqplot", dir="Descriptives")
})
