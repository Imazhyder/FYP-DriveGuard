const express = require('express');
const mongoose = require('mongoose');
const app = express();
const cors = require('cors');

// routes
const authRoutes = require('./routes/authroutes');
const userRoutes = require('./routes/userRoutes');
const productRoutes = require('./routes/productRoutes');

const FavRoutes = require('./routes/FavRoutes');

// const categoryRoute = require('./routes/preferenceRoute');
const preferenceRoute = require('./routes/preferenceRoute');
const orderRoutes = require('./routes/orderRoutes');
const carRoutes = require('./routes/Car/carRoutes');
const cancelOrderRoutes = require('./routes/CancelOrderRoutes');

// serviceRoutes

const serviceRoutes = require('./routes/serviceRoutes');

app.use(cors());
app.use(express.json());

app.use('/', serviceRoutes);

app.use('/', authRoutes);

app.use('/', userRoutes);

app.use('/', productRoutes);

app.use('/', FavRoutes);

app.use('/', preferenceRoute);

app.use('/', orderRoutes);

app.use('/', carRoutes);

app.use('/', cancelOrderRoutes);

mongoose
  .connect(
    'mongodb://shahzeel:shahzeel1@ac-npmzddl-shard-00-00.mmxllm4.mongodb.net:27017,ac-npmzddl-shard-00-01.mmxllm4.mongodb.net:27017,ac-npmzddl-shard-00-02.mmxllm4.mongodb.net:27017/?ssl=true&replicaSet=atlas-m95yd5-shard-0&authSource=admin&retryWrites=true&w=majority&appName=Backend'
  )
  .then(() => {
    console.log('Conneted to Database');
    app.listen(3000, () => {
      console.log('Server is running on 3000');
    });
  })
  .catch((e) => {
    console.log('Connection Failed');
  });
