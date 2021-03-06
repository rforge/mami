listSLWrappers <- function(){

cat("Super Learning Wrappers for continuous data\n (i.e. not for g-model in tmle/ltmle): \n")
cat("\n")
cat("Mallows Model Averaging (?mma):\n")
cat("SL.mma:     Mallows Model Averaging with all variables, on the subset of nested models.\n")
cat("SL.mma.all: Mallows Model Averaging with all variables, on all possible models.\n (volatile for complex problems)\n")
cat("SL.mma.int: Mallows Model Averaging incl. all 2-way interactions, on the subset of nested models.\n")
cat("SL.mma2:    Mallows Model Averaging incl. squared (numeric) variables, on the subset of nested models.\n")
cat("\n")
cat("Jackknife Model Averaging (?jma):\n")
cat("SL.jma:     Jackknife Model Averaging with all variables, on the subset of nested models.\n")
cat("SL.jma.all: Jackknife Model Averaging with all variables, on all possible models.\n (volatile for complex problems)\n")
cat("SL.jma.int: Jackknife Model Averaging incl. all 2-way interactions, on the subset of nested models.\n (variables with maximum absolute values>500 are scaled)\n")
cat("SL.jma2:    Jackknife Model Averaging incl. squared (numeric) variables, on the subset of nested models.\n (variables with maximum absolute values>500 are scaled)\n")
cat("\n")

cat("Super Learning Wrappers for both binary and continuous data: \n")
cat("\n")
cat("Lasso Averaging Estimation (?lae):\n")
cat("SL.lae:     Lasso Averaging Estimation (10-fold) with all variables.\n")
cat("SL.lae.int: Lasso Averaging Estimation (10-fold) incl. all 2-way interactions.\n")
cat("SL.lae2:    Lasso Averaging Estimation (10-fold) incl. squared (numeric) variables.\n")
cat("\n")
}