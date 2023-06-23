# import necesary librires
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
     

from google.colab import files


uploaded = files.upload()
     

#Read the data using the pandas
data=pd.read_csv('TSLA (2).csv')
data.head().style.background_gradient(cmap='jet')
     

#data information
data.info()
     

#Data shape
data.shape
     

#data length
len(data)
     

#data stastics
data.describe().style.background_gradient(cmap='winter')
     
*EDAProcess*


fig=px.line(data,x='Date',y='Adj Close',title='Tesla  Adj Close price')
fig.update_layout(bargap=0.5,plot_bgcolor='pink')
fig.show()
     

fig=px.line(data,x='Date',y='High',title='Tesla High and share price')
fig.update_layout(bargap=0.5,plot_bgcolor='green',template = "plotly_dark")
fig.show()
     

fig=px.line(data,x='Date',y='Close',title='Tesla data and Close price')
fig.update_layout(bargap=0.5,plot_bgcolor='yellow',template = "plotly_dark")
fig.show()
     

fig=px.line(data,x='Date',y='High',title='Tesla data and High price')
fig.update_layout(bargap=0.5,plot_bgcolor='red',template = "plotly_dark")
fig.show()
     

fig=px.line(data,x='Date',y='Open',title='Tesla data and Open price')
fig.update_layout(bargap=0.5,plot_bgcolor='cornflowerblue',template = "plotly_dark")
fig.show()
     

fig=px.line(data,x='Date',y='Volume',title='Tesla data and Volume price')
fig.update_layout(bargap=0.5,plot_bgcolor='seashell',template = "plotly_dark")
fig.show()
     

fig=px.line(data,y='Close',title='Tesla opening and closing share market price')
fig.update_layout(bargap=0.5,plot_bgcolor='gray',template = "plotly_dark")
fig.show()
     

#Let's create the tesal variable with close column
tesla=data['Close']
tesla
     

#reset the index
tesla.reset_index(drop=True,inplace=True)
tesla
     

#check the shape
tesla.shape
     

#let's create the dataframe for tesla
tesla=pd.DataFrame(tesla)
tesla.head()
     

#let's check the length of the dataframe using the math models
import math
train_len=math.ceil(len(tesla)*0.8)
train_len
     

#divided the data into train and test
train=tesla.iloc[:750]
test=tesla.iloc[750:]
     

# import the MinMaxScaler to scaling the values
from sklearn.preprocessing import MinMaxScaler
#install the MinMaxScaler
scaler=MinMaxScaler()
#fit the data
scaler.fit(train)
#transform the train and test data using the minmaxscler
scaled_train=scaler.transform(train)
scaled_test=scaler.transform(test)
     

#Check the scaled train data shape
scaled_train.shape
     

#let's check the scaled test data shape
scaled_test.shape
     

#import TimeseriesGenerator from tensorflow
from tensorflow.keras.preprocessing.sequence import TimeseriesGenerator
     

#lets create the generator variable using the TimeseriesGenerator function with length and batch_size
length=604
batch_size=32
generator=TimeseriesGenerator(scaled_train,scaled_train,length=length,batch_size=batch_size)
     

#import the necessary librires for model 
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense,SimpleRNN,LSTM,Dropout
     

#To create the model usint the tensorflow with features
n_features=1
#create the function Sequential
model=Sequential()
#Let's add the data to simpleRNN function with paraments
model.add(SimpleRNN(30,input_shape=(length,n_features)))
#create the dropout function with learning rate 0.2
model.add(Dropout(rate=0.2))
#add the dense layer to the model
model.add(Dense(1))
#compile the model with adam optimizer and mse loss
model.compile(optimizer='adam',loss='mse')
#And fially fit the data with 10 epochs
model.fit_generator(generator,epochs=10,shuffle=False)
     

#Create a dataframe of model history and visualize it
loss=pd.DataFrame(model.history.history)
loss.plot(color='red')
     

#check the scaled_train length
first_eval_batch=scaled_train[length:]
first_eval_batch
     

#create a empty list for text_prediction
text_prediction=[]
#check the scaled_train data length and silcing
first_eval_batch=scaled_train[-length:]
# reshape it
current_batch=first_eval_batch.reshape(1,length,n_features)
#creat a for loop to predict the text predict and add to the empty list using append function 
for i in range(len(test)):
  current_pred=model.predict(current_batch)[0]
  text_prediction.append(current_pred)
  current_batch=np.append(current_batch[:,1:,:],[[current_pred]],axis=1)

     

#convert the text_prediction using the scaler inverse transform
text_predictions=scaler.inverse_transform(text_prediction)
     

text_predictions
     

#create the data frame using the text_prediction
test['predictions']=text_predictions
test
     

#visualize the dataframe using the matplotlib
test.plot(figsize=(12,6),color='blue')
tesla.plot(color='red')
     

#let's transform the tesla data covert the scaling
scaled_full_data=scaler.fit_transform(tesla)
     

#create the generator variable using the TimeseriesGenerator with scaled_data
generator=TimeseriesGenerator(scaled_full_data,scaled_full_data,length=length,batch_size=batch_size)
     

#create the sequential function
model=Sequential()
#add the simplernn to the model with input_shape
model.add(SimpleRNN(30,input_shape=(length,n_features)))
#add the dropout function with learning rate 0.2
model.add(Dropout(rate=0.2))
#add the dense layers 
model.add(Dense(1))
#compile the model with adam optimzer and mse loss
model.compile(optimizer='adam',loss='mse')
#finally fit the data with epoch 10
model.fit_generator(generator,epochs=10,shuffle=False)
     

#Create a dataframe of model history and visualize it.
full_model=pd.DataFrame(model.history.history)
full_model.plot(color='red')
     

#create a empty list for forecast
forecast=[]
#using the scaled_train data length
first_eval_batch=scaled_train[-length:]
#reshape it the aobve variable
current_batch=first_eval_batch.reshape(1,length,n_features)
#create for loop for predict the prediction and append to the empty list
for i in range(20):
  current_pred=model.predict(current_batch)[0]
  forecast.append(current_pred)
  current_batch=np.append(current_batch[:,1:,:],[[current_pred]],axis=1)

     

#let's scaled the above values and transfor the inverse_transform
forecast=scaler.inverse_transform(forecast)
forecast
     

#flatten the values
forecast.flatten()
     

#covert the values into array form using numpy
df_array=np.array(tesla)
df_array
     

#Create data frame to prediction and test data and visualize it
full_data=pd.DataFrame(np.concatenate((df_array.flatten(),forecast.flatten())))
full_data.plot()
     
LSTM


#install the earlystopping function
from tensorflow.keras.callbacks import EarlyStopping
     

early_stop=EarlyStopping(monitor='val_loss',patience=2)
     

length
     

scaled_test.shape
     

#create two variable such as generator and validataion_generator with length and apply the two valrable to the model
length=5
generator=TimeseriesGenerator(scaled_full_data,scaled_full_data,length=length,batch_size=batch_size)
validation_generator=TimeseriesGenerator(scaled_full_data,scaled_full_data,length=length,batch_size=batch_size)
     

#define the Sequential function
model=Sequential()
#add  LSTM to the model with input_shape
model.add(LSTM(30,input_shape=(length,n_features)))
#add the dropout function and add the learning rate
model.add(Dropout(rate=0.2))
#Add the dense layer
model.add(Dense(1))
#complie the model with optimize adam and mse loss
model.compile(optimizer='adam',loss='mse')
#and finaly fit the model
model.fit_generator(generator,validation_data=validation_generator,epochs=10,callbacks=[early_stop],shuffle=False)
     

#create the data frame for model history and visualize it
full_model=pd.DataFrame(model.history.history)
full_model.plot()
     

#create a empty list for text_prediction
forecast=[]
first_eval_batch=scaled_train[-length:]
current_batch=first_eval_batch.reshape(1,length,n_features)
for i in range(len(test)):
  current_pred=model.predict(current_batch)[0]
  forecast.append(current_pred)
  current_batch=np.append(current_batch[:,1:,:],[[current_pred]],axis=1)

     

#transfor the above list into scaler transform and create data frame and visualize it
forecast=scaler.inverse_transform(forecast)
test['test_prediction']=forecast
test.plot()
     

#create a empty list for text_prediction
forecast=[]
first_eval_batch=scaled_train[-length:]
current_batch=first_eval_batch.reshape(1,length,n_features)
for i in range(5):
  current_pred=model.predict(current_batch)[0]
  forecast.append(current_pred)
  current_batch=np.append(current_batch[:,1:,:],[[current_pred]],axis=1)

     

#scaled the above data to invese form
forecast=scaler.inverse_transform(forecast)
     

#create the dataframe test data and our prediction and flatten it and using the concatenate after that visualize it
full_data=pd.DataFrame(np.concatenate((df_array.flatten(),forecast.flatten())))
full_data.plot()
     

forecast
     

full_data.head()
     

full_data.tail()
     

data.head()
     

market=data[['Date','Close']]
market.head()
     

scaled_data=scaler.fit_transform(tesla)
scaled_data
     

train_data=scaled_data[0:train_len,:]
x_train=[]
y_train=[]
for i in range(60,len(train_data)):
  x_train.append(train_data[i-60:i,0])
  y_train.append(train_data[i,0])
  if i<=60:
    print(x_train)
    print(y_train)
    print()
     

x_train,y_train=np.array(x_train),np.array(y_train)
     

x_train=np.reshape(x_train,(x_train.shape[0],x_train.shape[1],1))
x_train.shape
     


     

model=Sequential()
model.add(LSTM(64,return_sequences=True,input_shape=(x_train.shape[1],1)))
model.add(LSTM(64,return_sequences=False))
model.add(Dense(32))
model.add(Dense(1))
model.compile(optimizer='adam',loss='mean_squared_error')
model.fit(x_train,y_train,batch_size=1,epochs=15)
     

test_data=scaled_data[train_len-60:,:]
x_test=[]
for i in range(60,len(test_data)):
  x_test.append(train_data[i-60:i,0])
     

y_test=tesla[train_len:]
y_test.head()
     

x_test=np.array(x_test)
x_test
