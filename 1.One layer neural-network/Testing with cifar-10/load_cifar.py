#Incarcarea datasetului - CIFAR-10

(X_train, y_train), (X_test, y_test) = cifar10.load_data()
X_val = X_train[40000:]
X_train = X_train[:40000]
y_val = y_train[40000:]
y_train = y_train[:40000]
