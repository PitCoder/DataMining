# Data Mining
> This repository contains a final project which covers the contents viewed during the data mining course 2018-1 ESCOM IPN

### Content

- ID3 Algorithm Overview
- ID3 Project Codebase
- Project Screenshots and Demo
- License

### Data Mining usign fundamentals of Machine Learning with decision trees

<p align="center">
  <img src="https://ramandeep2017.files.wordpress.com/2017/08/02705-1cjv-yipk8pejnitg2vxava.png?w=640" alt="An Introduction to Machine Learning With Decision Trees"/>
</p>

### ID3 Algorithm Overview
ID3 stands for Iterative Dichotomizer 3. The ID3 algorithm was invented by Ross Quinlan. It builds a decision tree from a fixed set of examples and the resulting tree is used to classify future samples.

The basic idea is to construct the decision tree by employing a top down, greddy search through the given data sets to test each attribute at every tree node.

#### What Are Decisions Trees?
Simply put, a decision tree is a tree with each branch represents a choice between a number of alternatives and each leaf node represents a decision.

#### Why use it in Machine Learning?
A decision tree is a type of supervised learning algorithm (with a predefined target variable) that is mostly used in classification problems and works for both categorical and continuous input and output variables. It is one of the most widely used and practical methods for inductive inference. (Inductive inference is the process of reaching a general conclusion from specific examples.)

#### What this Project Covers?
As the main project of the course the algorithm is applied to data stored in a database of a music streaming application named (Stopify). This with the purpose of obtaining a better visualization of the overall information structure and to generate very basic business knowledge for decision taking by mining and processing the raw data.

### Project Codebase
The project codebase is contained within the folder "stopify-application", the codebase include both backend and frontend development, for more information please feel free to take a look at it!.

### Project Screenshots and Demo

#### Entity-Relation Diagram of Stopify Database

> The entity relation diagram describes how was made the database's structure, defining entities and their relations.

<p align="center">
  <img src="https://github.com/PitCoder/DataMining/blob/master/Img/database_model.png" alt="Entity Relation Diagram"/> 
</p>

#### Table Index and Data Selection


> The table index shows the current selected table from the database and its attributes, here the user selects the attributes to which analysis will be apply.

<p align="center">
  <img src="https://github.com/PitCoder/DataMining/blob/master/Img/data_selection.png" alt="Data Selection"/>
</p>

#### Parameters and Functions Setup

> Here parameters and functions are set, establishing the criteria that define how the decision tree will be made.


<p align="center">
  <img src="https://github.com/PitCoder/DataMining/blob/master/Img/param_config.png" alt="Parameters and Functions Setup"/>
</p>

#### Decision Tree Generation

> Once the setup has been defined its corresponding decision tree will be generated. The information display within the tree provide helpful information of the data selected.

<p align="center">
  <img src="https://github.com/PitCoder/DataMining/blob/master/Img/tree_gen.png" alt="Tree Generation"/>
</p>

#### Detailed Report Generation

> Finally, the user has the option to generate a more detailed report of the ID3 generation process, all generated data during ID3 creation will be send from the server and it will be displayed in the client's size on a log.

<p align="center">
  <img src="https://github.com/PitCoder/DataMining/blob/master/Img/report.png" alt="Report Generation"/>
</p>

#### Demonstration of how internally ID3 algorithm operates

<p align="center">
  <img src="https://annalyzin.files.wordpress.com/2016/07/decision-tree-tutorial-animated3.gif?w=636&h=312&crop=1" alt="ID3 Algorithm GIF"/>
</p>

### License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright 2018 © <a href="https://github.com/PitCoder" target="_blank">Eric Alejandro López Ayala</a>.

