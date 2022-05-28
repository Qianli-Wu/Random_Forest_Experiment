library(randomForest)

cv.rf <- function(design, y, X){
  
  # ============================================================================
  # cv.rf : Cross validation accuracy for random forest under different parameter
  #         settings.
  #
  # Input:
  #     design: Experimental design containing the setting combinations of the 
  #             seven tuning parameters. It must be a data frame with two or more
  #             rows.
  #
  #     y: Response variable of the main problem. It must be a vector of factors.
  #     X: Matrix of predictors. It must be a data frame.
  #
  # Output:
  #     res.data: Data frame with the design used and the cross validation accuracy
  #               values for the test combinations in the design.
  #
  # ============================================================================
  
  # Data pre-processing.
  if (!is.factor(y)) stop("y must be a vector of factors")
  if (!is.data.frame(X)) stop("X must be a data.frame")
  if (!is.data.frame(design)) stop("design must be a data.frame")
  
  # Define required objects.
  dat <- cbind(y,X)
  n <- nrow(design) 
  cv.responses <- rep(NA, times = n)
  cv_fold <- 10
  
  for (i in 1:n){
    # Preprocess some factors.
    replace.val <- if(design[i,"replace"] == 1 ){TRUE} else {FALSE}
    cut.off.val <- c(design[i,"cutoff"], 1 - design[i,"cutoff"])
    class.wt.value <- c(design[i,"classwt"], 1 - design[i,"classwt"])
    
    # Calculate the Cross-Validation accuracy.
    cv_index <- rep(1:cv_fold, each = nrow(dat) %/% cv_fold + 1)
    cv_index <- cv_index[1:nrow(dat)]
    cv_index <- cv_index[sample(nrow(dat))]
    cv_accuracy <- 0
    for(l in 1:cv_fold) {
      model <- randomForest(y~., data = dat[cv_index == l, ],
                            ntree = design[i,"ntree"], mtry = design[i,"mtry"],
                            replace = replace.val, nodesize = design[i,"nodesize"],
                            classwt = class.wt.value, cutoff = cut.off.val,
                            maxnodes = design[i,"maxnodes"])
      yhat <- predict(model, newdata = dat[cv_index != l, ])
      cv_accuracy <- cv_accuracy + mean(yhat == y[cv_index != l])
    }
    
    cv.responses[i] <- cv_accuracy / cv_fold
    cat("Collecting response on test combination ", i, "\n")
  }
  
  # Save the responses into a data set.
  res.data <- cbind(design, 'CV' = cv.responses)
  return(res.data)
}