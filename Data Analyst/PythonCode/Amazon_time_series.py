#!/usr/bin/env python
# coding: utf-8

# #                                                                                   Time Series Analysis    

# #### Time series analysis comprises methods for analyzing time series data in order to extract meaningful statistics and other characteristics of the data. Time series forecasting is the use of a model to predict future values based on previously observed values. While regression analysis is often employed in such a way as to test relationships between one or more different time series, this type of analysis is not usually called "time series analysis", which refers in particular to relationships between different points in time within a single series. Interrupted time series analysis is used to detect changes in the evolution of a time series from before to after some intervention which may affect the underlying variable.

# ![image-blog-time-series-analysis.jpg](attachment:image-blog-time-series-analysis.jpg)

# In[83]:


#Install the Standard libraries
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np


# In[84]:


#Let load the dataset
data=pd.read_csv('AMZN.csv')
data.head()


# In[3]:


data.shape


# In[4]:


#data columns
data.columns


# In[5]:


#Remove the unwanted columns
data=data.drop(['Date','Adj Close'],axis=1)


# In[6]:


data.head()


# In[7]:


plt.plot(data.Close)


# In[8]:


#To view the last 100 values mean 
max100=data.Close.rolling(100).mean()
max100


# In[9]:


#Let's visualize the it
plt.figure(figsize=(12,8))
plt.plot(data.Close)
plt.plot(max100,'red')


# In[10]:


max200=data.Close.rolling(200).mean()


# In[11]:


plt.figure(figsize=(12,8))
plt.plot(data.Close)
plt.plot(max100,'red')
plt.plot(max200,'green')


# In[12]:


data.shape


# # Divided the data into training and testing

# In[13]:


# We take the 70 training data 
# and 30% per testing data 
data_training=pd.DataFrame(data['Close'][0:int(len(data)*0.7)])
data_testing=pd.DataFrame(data['Close'][int(len(data)*0.70): int(len(data))])


# In[14]:


#check the shape
print(data_training.shape)
print(data_testing.shape)


# In[15]:


#Scalling the values using the MinMaxScaler 
from sklearn.preprocessing import MinMaxScaler
scaler=MinMaxScaler(feature_range=(0,1))
data_training_array=scaler.fit_transform(data_training)


# In[16]:


data_training_array


# In[17]:


x_train=[]
y_train=[]
#create for loop for feature prediction for next 100 days
for i in range(100,data_training_array.shape[0]):
    x_train.append(data_training_array[i-100:i])
    y_train.append(data_training_array[i,0])


# In[18]:


x_train,y_train=np.array(x_train),np.array(y_train)


# In[19]:


x_train.shape


# # Model buliding using the LSTM

# In[20]:


#import the kreas libreris
from keras.layers import Dense,Dropout,LSTM
from keras.models import Sequential


# In[40]:


model=Sequential()
#add first layer
model.add(LSTM(units=50,activation='relu',return_sequences=True,input_shape=(x_train.shape[1],1)))
model.add(Dropout(0.2))
#add second layer
model.add(LSTM(units=80,activation='relu',return_sequences=True))
model.add(Dropout(0.5))
#add thired layers
model.add(LSTM(units=100,activation='relu',return_sequences=True))
model.add(Dropout(0.4))
#add fourth layer
model.add(LSTM(units=120,activation='relu'))
model.add(Dropout(0.8))
#add dence layer
model.add(Dense(units=1))


# In[41]:


model.summary()


# In[42]:


#Compile the model with adam optimizer and loss function then finally compile the model
model.compile(optimizer='adam',loss='mean_squared_error')
model.fit(x_train,y_train,epochs=20)


# In[43]:


model.save('LSTM_1.h5')


# In[44]:


data_testing.head()


# In[45]:


past_100_days=data_training.tail()
final_df=past_100_days.append(data_testing,ignore_index=True)
final_df.head()


# In[46]:


input_data=scaler.fit_transform(final_df)
input_data


# In[47]:


input_data.shape


# In[48]:


x_test=[]
y_test=[]
for i in range(100,input_data.shape[0]):
    x_test.append(input_data[i-100:i])
    y_test.append(input_data[i,0])


# In[49]:


x_test,y_test=np.array(x_test),np.array(y_test)
print(x_test.shape)
print(y_test.shape)


# In[50]:


y_predicted=model.predict(x_test)


# In[51]:


y_predicted


# In[52]:


print(y_predicted.shape)
print(y_test.shape)


# In[53]:


y_test


# In[54]:


y_predicted


# In[55]:


scaler.scale_


# In[56]:


scale_factor=1/0.00716125
y_prediction=y_predicted*scale_factor
y_test=y_test*scale_factor


# In[57]:


y_prediction.shape


# In[58]:


plt.figure(figsize=(15,7))
plt.plot(y_test,'blue',label="Original_price")
plt.plot(y_prediction,'red',label="Predicted_price")
plt.xlabel("Time")
plt.ylabel("Price")
plt.legend()
plt.show()


# In[59]:


import plotly.express as px


# In[78]:


y_pred=y_prediction.reshape(-1,)
y_pred.shape


# In[79]:


y_test.shape


# In[85]:


date=data["Date"]


# In[86]:


import plotly.graph_objects as go

fig = go.Figure()
fig.add_trace(go.Scatter(x=date, y=y_test, name="Test", mode="lines"))
fig.add_trace(go.Scatter(x=date, y=y_pred, name="Prediction", mode="lines"))
fig.update_layout(
    title="Amazon stock prices", xaxis_title="Date", yaxis_title="Close"
)
fig.show()


# In[ ]:





# In[ ]:
