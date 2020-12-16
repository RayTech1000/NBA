FLAGS <- flags(
  flag_numeric("nodes1", 100),
  flag_numeric("nodes2", 100),
  flag_numeric("learning_rate", 0.01),
  flag_numeric("batch_size", 100),
  flag_numeric("epochs", 30),
  flag_string("activation1", "relu"),
  flag_string("activation2", "relu"),
  flag_numeric("dropout1", .01),
  flag_numeric("dropout2", .01)
  
)

model =keras_model_sequential()
model %>%
  layer_dense(units = FLAGS$nodes1, activation = FLAGS$activation1) %>%
  layer_dropout(FLAGS$dropout1) %>%
  layer_dense(units = FLAGS$nodes2, activation = FLAGS$activation2) %>%
  layer_dropout(FLAGS$dropout2) %>%
  layer_dense(units = 1, activation = 'relu')

model %>% compile(
  optimizer = optimizer_adam(lr=FLAGS$learning_rate),
  loss = 'mse')


model %>% fit(NBA_trainx,
              NBA_trainy,
              batch_size=FLAGS$batch_size,
              epochs = FLAGS$epochs,
              validation_data=list(NBA_valx, NBA_valy))

