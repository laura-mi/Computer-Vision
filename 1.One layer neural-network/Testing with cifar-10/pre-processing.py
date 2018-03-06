#Preprocesare minimala, normalizarea fiecarei imagini scazand valoarea medie peste tot datasetul.
#Imaginile sunt matrixi 32x32x3 cu tipul uint8, iar noi avem nevoie vectori de tip float32.
def preprocess_dataset(X_train, y_train, X_val, y_val, X_test, y_test):
    X_train = X_train.reshape(y_train.shape[0], -1)
    X_test = X_test.reshape(y_test.shape[0], -1)
    X_val = X_val.reshape(y_val.shape[0], -1)
    X_train = X_train.astype('float32')
    X_test = X_test.astype('float32')
    X_val = X_val.astype('float32')
    y_train = y_train.reshape(y_train.shape[0])
    y_test = y_test.reshape(y_test.shape[0])
    y_val = y_val.reshape(y_val.shape[0])
    mean_image = np.mean(X_train, axis=0)
    X_train -= mean_image
    X_test -= mean_image
    X_val -= mean_image
    return X_train, y_train, X_val, y_val, X_test, y_test
	
X_train, y_train, X_val, y_val, X_test, y_test = preprocess_dataset(X_train, y_train, X_val, y_val, X_test, y_test)
print('Train data shape: ', X_train.shape)
print('Train labels shape: ', y_train.shape)
print('Val data shape: ', X_val.shape)
print('Val labels shape: ', y_val.shape)
print('Test data shape: ', X_test.shape)
print('Test labels shape: ', y_test.shape)
