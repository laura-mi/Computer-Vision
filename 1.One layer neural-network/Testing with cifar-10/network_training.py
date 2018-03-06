
# Antrenarea retelei pe CIFAR-10
input_size = 32
input_channels = 3
input_dim = input_channels * input_size * input_size
hidden_dim = 50
num_classes = 10
net = ShallowNet(input_dim, hidden_dim, num_classes)

# Antrenam reteaua
stats = net.train(np.concatenate([X_train, X_test], 0), np.concatenate([y_train, y_test], 0), X_val, y_val,
            num_iters=1000, batch_size=200,
            learning_rate=1e-4, learning_rate_decay=0.95,
            reg=0.25, verbose=True)

# Facem preziceri pe datasetul de test si calculam acuratetea
test_acc = (net.predict(X_val) == y_val).mean()
print('Test accuracy: ', test_acc)

#Debugging pentru procesul de antrenare

# Plot the loss function and train / validation accuracies
plt.subplot(2, 1, 1)
plt.plot(stats['loss_history'])
plt.title('Loss history')
plt.xlabel('Iteration')
plt.ylabel('Loss')

plt.subplot(2, 1, 2)
plt.plot(stats['train_acc_history'], label='train')
plt.plot(stats['val_acc_history'], label='val')
plt.title('Classification accuracy history')
plt.xlabel('Epoch')
plt.ylabel('Clasification accuracy')
plt.show()

from utils import visualize_grid

# Vizualizarea parametrilor retelei

def show_net_weights(net, param_key):
    W1 = net.params[param_key]
    W1 = W1.reshape(32, 32, 3, -1).transpose(3, 0, 1, 2)
    plt.imshow(visualize_grid(W1, padding=3).astype('uint8'))
    plt.gca().axis('off')
    plt.show()

show_net_weights(net, 'fc1_w')

#Tunarea hiperparametrilor

best_net = net # cel mai bun model

#################################################################################
# TODO: Tunarea hiperparametrilor pe datele de validare.                        #
# Cel mai bun model trebuie stocat in best_net.                                 #
# Hint: Cea mai simpla tunare poate fi o iterare prin mai multe valori ale      #                            #
# parametrilor pentru hidden_dim, learning_rate, l2_reg, etc.  Departajarea     #
# celui mai bun model se poate face dupa acuratete                              #
#################################################################################
def randomized_search(lr):
    """
    Tune hyperparameters using the validation set.
    Inputs:
    - learning_rates: list of different values for lr
    - learning_rate_decays: list of different values for lrd
    - regularization_strengths= list of different values for rs
    Output:
    - dict returning train and valid accuracy for given lr, rs and lrd.  
    """

    results = {}
    best_val = -1
    best_net = None
    
    input_size = 32
    input_channels = 3
    input_dim = input_channels * input_size * input_size
    hidden_dim = 50
    num_classes = 10

    # bigger => more time
    max_count = 10

    for count in range(max_count):
        # randomly create params
        rs = 10**np.random.uniform(-4.0, -3.0)
        lrd = 10**np.random.uniform(-0.1, 0)

        # print params
        print('Training params: learning rate: {}, reg strength: {}, lr decay: {}'.format(lr, rs, lrd))

        # instantiate NN
        net = ShallowNet(input_dim, hidden_dim, num_classes)

        # train it
        stats = net.train(np.concatenate([X_train, X_test], 0), np.concatenate([y_train, y_test], 0), X_val, y_val,
            num_iters=1000, batch_size=200,
            learning_rate=lr, learning_rate_decay=lrd,
            reg=rs, verbose=True)

        # predict train and valid
        y_train_pred = net.predict(X_train)
        y_val_pred = net.predict(X_val)
        
        # compute accuracies
        train_accuracy = np.mean(y_train == y_train_pred)
        val_accuracy = np.mean(y_val == y_val_pred)

        # save best network
        if val_accuracy > best_val:
            best_val = val_accuracy
            best_net = net

        # store best params
        results[(lr, rs, lrd)] = (train_accuracy, val_accuracy)

    return results, best_val

#hyperparameter tuning
print('\nHyperparameter tuning...')
results, best_val  = randomized_search(lr=3e-3)

for lr, reg, lrd in sorted(results):
    train_accuracy, val_accuracy = results[(lr, reg, lrd)]
    print('lr {} rs {} lrd {} train accuracy: {} val accuracy: {}'.format(lr, reg, lrd, train_accuracy, val_accuracy))
    
print('Best validation accuracy achieved during cross-validation: %f' % best_val)
#################################################################################
#                               END OF YOUR CODE                                #
#################################################################################

# visualize the weights of the best network
show_net_weights(best_net, 'fc1_w')

#Rularea pe datele de test

test_acc = (best_net.predict(X_test) == y_test).mean()
print('Test accuracy: ', test_acc)