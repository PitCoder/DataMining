# Data Mining
This is a repository that contains exercices and practices of the Data Mining course ESCOM IPN S18-B.

### ID3
ID3 is the main project of this repository, in this project an implementation of the ID3 algorithm is been made. The algorithm is applied to a simulation of a music streaming application database (named Stopify as it is mention in other repository), allowing us to visualize in a better way raw data, therefore generating very basic business knowledge for decision taking.

Bellow there is a brief summary of what is ID3 algorithm, how it works and why use it: 

##### ID3 Algorithm
In decision tree learning, ID3 (Iterative Dichotomiser 3) is an algorithm invented by Ross Quinlan used to generate a decision tree from a dataset. ID3 is the precursor to the C4.5 algorithm, and is typically used in the machine learning and natural language processing domains.

###### Pseudocode
ID3 (Examples, Target_Attribute, Attributes)
    Create a root node for the tree
    If all examples are positive, Return the single-node tree Root, with label = +.
    If all examples are negative, Return the single-node tree Root, with label = -.
    If number of predicting attributes is empty, then Return the single node tree Root,
    with label = most common value of the target attribute in the examples.
    Otherwise Begin
        A ← The Attribute that best classifies examples.
        Decision Tree attribute for Root = A.
        For each possible value, vi, of A,
            Add a new tree branch below Root, corresponding to the test A = vi.
            Let Examples(vi) be the subset of examples that have the value vi for A
            If Examples(vi) is empty
                Then below this new branch add a leaf node with label = most common target value in the examples
            Else below this new branch add the subtree ID3 (Examples(vi), Target_Attribute, Attributes – {A})
    End
    Return Root

###### Usage of the algorithm
The ID3 algorithm is used by training on a data set to produce a decision tree which is stored in memory. At runtime, this decision tree is used to classify new test cases (feature vectors) by traversing the decision tree using the features of the datum to arrive at a leaf node. The class of this terminal node is the class the test case is classified as.
