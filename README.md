# Random_Forest_Experiment
The goal of this project is to identify the tuning parameters of random forest that affect the cross-validation accuracy.



### Get Started (skip if you know how to use git)

For MacOS, open your Terminal and type

```{shell}
$ cd Documents   # optional     or other directories (e.g. Downloads, Desktop, ...)
```

```{shell}
$ git clone https://github.com/davidgohel/officedown.git
```

Then, open your Finder and go to the directory you speficied above

Then looking for a folder called `Random_Forest_Experiment`, and that is this repository. 

##### Edit and Upload (can be ignored)

```{shell}
$ git commit -a -m "(a few sentences about the changes)"  # save your changes to your local repository
$ git push  # publish your changes to remote repository on Github. (may fail)
```



### Reqiurements

* R-version `4.1.0` or above
* Install librarys:
  1. `randomForest` 
  2. `FrF2`
  3. `AlgDesign`
  4. `corrplot`
* Run the following code  to initialize:

```{r}
install.packages(c("randomForest", "FrF2", "AlgDesign", "corrplot"))
```

