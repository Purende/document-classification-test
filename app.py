#!/usr/bin/env python
import flask
from flask import Flask,render_template,url_for,request
import pandas as pd
import pickle5 as pickle
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.svm import LinearSVC
import joblib

#import flask
#from flask import Flask,render_template,url_for,request
#import pandas as pd
#import pickle
#from sklearn.feature_extraction.text import CountVectorizer
#from sklearn.svm import LinearSVC
#import joblib

## Load the model from local

clf = joblib.load('multiclass_classifier.pkl')
cv = joblib.load('transform.pkl')
app = flask.Flask(__name__)

@app.route('/')

def home():
    return render_template('home.html')
    

@app.route('/predict',methods=['POST'])
def predict():
    if request.method == 'POST':
        message = request.form['message']
        data = [message]
        # vect = cv.transform(data).toarray()
        my_prediction = clf.predict(data)
    return render_template('result.html',prediction = my_prediction)
    
if __name__ == '__main__':
	app.run(host='0.0.0.0', port=5000, debug=True)
