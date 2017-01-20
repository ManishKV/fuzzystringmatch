import os;
os.chdir('YOUR FILES LOCATION')

# Reading both datasets into pandas dataframes
import pandas as pd;
dataset1 = pd.read_csv("dataset1.csv")
dataset2 = pd.read_csv("dataset2.csv")

# Having a look at the datasets 
dataset1.head(5)
dataset2.head(5)

#dataset1 = dataset1.sort_values(by=['Name_String1'], ascending=[1])

# We will be using SequenceMatcher package for finding the distance between two strings
from difflib import SequenceMatcher as SM

dataset1_len = len(dataset1['Name_String1'])
dataset2_len = len(dataset2['Name_String2'])


match_score=[]
String1_list =[]
String2_list= []

# Now we iterate through the datasets and find max match score for each pair in two datasets
for i in xrange(dataset1_len):
    score = 0
    for j in xrange(Asset4_len):
        score_curr = round(SM(None,dataset1["Name_String1"][i],dataset2["Name_String2"][j]).ratio(),3)        
        if score_curr >= score:
            index_j = j
            score = score_curr
    match_score.append(score)
    String1_list.append(dataset1["Name_String1"][i])
    String2_list.append(dataset2["Name_String2"][index_j])

# Create a dataframe by combining the three lists created. 	
name_match = pd.DataFrame({'Match_Score':match_score,'Name_String2':String2_list,'Name_String1':String1_list}]

# Writing the dataframe into csv file
name_match.to_csv('name_match.csv',index = False)