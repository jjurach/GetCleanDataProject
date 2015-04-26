
# Files

* codebook.txt
* run\_analysis.R

## codebook.md

[codebook.md](codebook.md) contains the code book for the dataset the analysis will produce.

## run\_analysis.R

[run\_analysis.R](run\_analysis.R) processes the information in the specified dataset
directory, and produces a tidy dataset. This script defines a function called
run\_analysis() which is called at the bottom to produce the har.data variable.

Each of the files described in the dataset README.txt which were used for this
project were read using read.table(). Most files had only one column of
interest, so in the analysis script, these were subsetted into a vector
immediately after read.table().

run\_analysis() performs the following steps:

1. Load activity\_labels.txt as activity\_labels
2. Load features.txt as features
3. Determine the subset of features we wish to keep as keep\_features
4. For "train" and "test" cases:
    1. Load test/X\_\*.txt using features for column names
    2. Drop the columns we decide not to keep
    3. Prepend the following columns to the dataset:
        1. 'subject' from subject\_\*.txt
        2. 'activity' from y\_\*.txt, mapped through activity\_labels
        3. 'case' to reflect "train" or "test".
5. rbind() both cases into a single data frame
6. melt() the data.frame to "long form".
7. dcast long form back into wide form, applying mean on every observation value.


