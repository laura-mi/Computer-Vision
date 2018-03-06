# Setup
!pip install -q keras

import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline
from keras.datasets import cifar10
from keras.datasets import mnist
# initializare pentru matplotlib
plt.rcParams['figure.figsize'] = (10.0, 8.0) # setarea dimensiunii plot-urilor 
plt.rcParams['image.interpolation'] = 'nearest'
plt.rcParams['image.cmap'] = 'gray'

# auto-reloading pentru module externe
%load_ext autoreload
%autoreload 2

def rel_error(x, y):
    """ intoarce eroarea relativa """
    return np.max(np.abs(x - y) / (np.maximum(1e-8, np.abs(x) + np.abs(y))))
	
#Date de intrare test
from shallow_net import ShallowNet
input_dim = 4
hidden_dim = 10
num_classes = 3
dataset_size = 5

np.random.seed(0)
net = ShallowNet(input_dim, hidden_dim, num_classes, std=1e-1)

np.random.seed(1)
X_train = 10 * np.random.randn(dataset_size, input_dim)
y_train = np.array([0, 1, 2, 2, 1])

#Propagare inainte (Forward pass). Calcularea scorurilor
scores = net.loss(X_train)
print(scores)

correct_scores = np.asarray([
  [-0.81233741, -1.27654624, -0.70335995],
  [-0.17129677, -1.18803311, -0.47310444],
  [-0.51590475, -1.01354314, -0.8504215 ],
  [-0.15419291, -0.48629638, -0.52901952],
  [-0.00618733, -0.12435261, -0.15226949]])
# Differenta ar trebui sa fie foarte mica < 1e-7
print(np.sum(np.abs(scores - correct_scores)))

#
loss, _ = net.loss(X_train, y_train, reg=0.05)
correct_loss = 1.30378789133

# diferenta ar trebui sa fie foarte mica < 1e-12
print('Difference between your loss and correct loss:')
print(np.sum(np.abs(loss - correct_loss)))

#Propagare inapoi (Backpropagation)

from utils import eval_numerical_gradient

loss, grads = net.loss(X_train, y_train, reg=0.05)
# diferenta ar trebui sa fie foarte mica < 1-8
for param_name in grads:
    f = lambda W: net.loss(X_train, y_train, reg=0.05)[0]
    param_grad_num = eval_numerical_gradient(f, net.params[param_name], verbose=False)
    print('%s max relative error: %e' % (param_name, rel_error(param_grad_num, grads[param_name])))
    
#Antrenarea retelei (training)

stats = net.train(X_train, y_train, X_train, y_train, 
                  learning_rate=1e-1, reg=5e-6,
                  num_iters=100, verbose=False)
print('Final training loss: ', stats['loss_history'][-1])

# plotarea costului
plt.plot(stats['loss_history'])
plt.xlabel('iteration')
plt.ylabel('training loss')
plt.title('Training Loss history')
plt.show()

