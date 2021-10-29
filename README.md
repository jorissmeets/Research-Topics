<img src="https://user-images.githubusercontent.com/31740559/139433382-67b35df1-d4bb-4a34-8f83-f017ccf3fc7f.png" width="250" height="90" />


# Multiple imputation in machine learning: classifier pooling
This is the accompying code to the research paper written for the track Missing Data for the course Research Topics in Data Mining (2021) at the TU/Eindhoven. The project was supervised by Rianne Margetha Schouten.

The goal of the project was to test three pooling methods that can used after multiple imputation, in the context of neural networks. The approaches were to pool estimators or weights, pool the imputed datasets and to bag the results. See the pdf for the paper.

<img src="https://user-images.githubusercontent.com/31740559/139426382-94981700-b296-4601-8494-70572e73856a.png" width="250" height="500" />

## How to reproduce
To create the imputed data the R code should be run first. Afterwards the pooling are applied in the Python notebook.

### R
- Set all settings correctly
```
# Select dataset by changing dataset.name to either scale_data/user_data/banknote_data
dataset.name <- 'user_data'

# Change paths for the working directory and read_csv to where the datasets are stored
setwd(sprintf('<dataset directoy>/%1$s/',dataset.name))
data<- read.csv(sprintf('<dataset directoy>/%1$s/%1$s.csv',dataset.name), header = F, sep=',')

# Set the amount of iterations
i <- 1
while (i < 51) {
<other code>
}
```

- Run all code to create test and imputed train dataset

### Python
- Set all settings correctly
```
# Select dataset by changing dataset.name to either scale_data/user_data/banknote_data
dataset_name = 'user_data'

# Select number of Monte Carlo simulations
n_MC = 21

# Change nodes, batchsize and epochs according to dataset
# for the scale data good hyperparameters are: nodes=500, batchsize=32, epochs=10
# for the banknote data good parameters are: nodes=500, batchsize=20, n_epochs=3
# for the user data good parameters are: nodes=500, batchsize=3, n_epochs=25
n_nodes = 500
batchsize = 3
n_epochs = 25

# Change paths to dataset directory
# Location of the train set
file_path = '<dataset directory>' + dataset_name + '/' + MC_ID + '/train' + MD_percentage + i + '.csv'

# Location of the test set
file_path = 'C:/Users/20175878/Documents/DSAI/Y1Q1_RTDM/research_paper/code/' + dataset_name + '/' + MC_ID +'/test.csv'
```
- Run cells to gain accuracy results


## Authors
- Lucas Snijder (l.l.snijder@student.tue.nl)
- Tijs Teulings (t.teulings@student.tue.nl)
- Joris Smeets (j.e.p.smeets@student.tue.nl)
- Maiko Bergman (m.j.n.bergman@student.tue.nl)
- Rob Janssen (r.janssen.3@student.tue.nl)
  
