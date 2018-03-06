import numpy as np
import math 
from utils import eval_numerical_gradient
class ShallowNet():

    class fully_connected:
        """
        Unitatea de baza in reteaua noastra cu un singur strat va fi stratul 
        fully_connected. Am decis sa il implementam ca o clasa distincta pentru
        a fi mai usor sa stocam si sa accesam parametrii stratului in timpul
        propagarii inainte si inapoi.
        Veti avea de implementat mai multe functii in aceasta clasa 
        """
        def __init__(self, w, b, activation="relu"):
            self.w = w
            self.b = b
            self.act = activation

        def linear_forward(self):
            h = None
            ####################################################################
            # TODO: Calcularea unui forward pass printr-un layer de tip fully  #
            # connected fara non-liniaritate ca o combinatie liniara a         #
            # weight-urilor self.w cu inputul self.x si cu bias-ul self.b      #
            # Intoarcerea rezultatului h.                                      #
            ####################################################################
            h = np.dot(self.x,self.w) + self.b
            ####################################################################
            #                         END OF YOUR CODE                         #
            ####################################################################
            return h

        def linear_backward(self, dout):
            dx, dw, db = None, None, None
            ####################################################################
            # TODO: Calcularea unui backward passprintr-un layer de tip fully  #
            # connected fara non-liniaritate. Avem urmatoarele iesiri:         #
            # * dx - gradientul dout/dx; Hint: out = xw + b                   #
            # * dw - gradientul dout/dw; Hint: out = xw + b                   #
            # * db - gradientul dout/db; Hint: out = xw + b                   #
            ####################################################################
           
            db = np.sum(dout, axis=0)
            dx = np.dot(dout, self.w.T)
            dw = np.dot(self.x.T, dout)
            ####################################################################
            #                         END OF YOUR CODE                         #
            ####################################################################
            return dx, dw, db    


        def relu(self, h):
            out = None
            ####################################################################
            # TODO: Aplicarea unei functiei ReLU peste rezultatul primului     #
            # strat ce este stocat in h                                   #
            ####################################################################
            out = np.maximum(0,h);
            ####################################################################
            #                         END OF YOUR CODE                         #
            ####################################################################
            return out

        def relu_backward(self, dout):
            dx = None
            ####################################################################
            # TODO: Propagarea gradientului prin functia ReLU.                 #
            # Hint: trebuie sa "inmultim" gradientul upstream dout cu          #
            # gradientul efectiv al functiei ReLU si sa intoarcem rezultatul   #
            #  "inmultirii" in dx (chain rule).
            ####################################################################
            df = self.relu(self.h)
            df[df > 0] = 1
            dx = df * dout
            ####################################################################
            #                         END OF YOUR CODE                         #
            ####################################################################
            return dx
        
        def softmax(x):
            e_x = np.exp(x - np.max(x))
            return e_x / e_x.sum()

        def sigmoid(self):
            out = np.ones_like(self.h) / (1 + np.exp(-self.h))
            return out

        def sigmoid_backward(self, dout):
            out_sigmoid = np.ones_like(self.h) / (1 + np.exp(-self.h))
            dx = dout * out_sigmoid * (1 - out_sigmoid)
            return dx

        def tanh(self):
            out = (np.exp(self.h) - np.exp(-self.h)) / (np.exp(self.h) + np.exp(-self.h))
            return out

        def tanh_backward(self, dout):
            out_tanh = (np.exp(self.h) - np.exp(-self.h)) / (np.exp(self.h) + np.exp(-self.h))
            dx = dout * (1 - out_tanh ** 2)
            return dx

        def forward(self, x):
            self.x = x
            self.h = self.linear_forward()
            if self.act == "relu":
                self.h_act = self.relu(self.h)
                return self.h_act
            elif self.act == "sigmoid":
                self.h_act = self.sigmoid()
                return self.h_act
            elif self.act == "tanh":
                self.h_act = self.tanh()
                return self.h_act
            else:
                return self.h

        def backward(self, dout):
            if self.act == "relu":
                self.dh = self.relu_backward(dout)
                dx, dw, db = self.linear_backward(self.dh)
                return dx, dw, db
            elif self.act == "sigmoid":
                self.dh = self.sigmoid_backward(dout)
                dx, dw, db = self.linear_backward(self.dh)
                return dx, dw, db
            elif self.act == "tanh":
                self.dh = self.tanh_backward(dout)
                dx, dw, db = self.linear_backward(self.dh)
                return dx, dw, db
            else:
                dx, dw, db = self.linear_backward(dout)
                return dx, dw, db    

    
    def __init__(self,
               input_dim=3*32*32,
               hidden_dim=100,
               num_classes=10,
               std=1e-4,
               activation_fn="relu"):
        """
        Initializarea modelului. Parametrii sunt initializati cu numere mici random
        cu o distributie calibrata dupa numarul de neuroni de intrare. Bias-urile 
        sunt initializate cu zero-uri.
        Parametrii modelului sunt stocati intr-un dictionar self.params.
        Cheile dictionar-ului sunt:
        fc1_w: weight-urile primului strat (input_dim, hidden_dim)
        fc1_b: bias-urile primului strat (hidden_dim,)
        fc2_w: weight-urile celui de-al doilea strat (hidden_dim, num_classes)
        fc2_b: bias-urile celui de-al doilea strat (num_classes,)
        """
        self.input_dim = input_dim
        self.hidden_dim = hidden_dim
        self.num_classes = num_classes
        self.activation_fn = activation_fn
        self.params = {}

        # Pentru a initializa weight-urile cu calibrarea variantei in functie de tipul functiei
        # de activare, putem inlocui std cu urmatoarele :
        # * std = np.sqrt(1.0/input_dim) (pentru functii de activare sigmoid, tanh etc.)
        # * std = np.sqrt(2.0/input_dim) (pentru relu)
        self.params['fc1_w'] = std * np.random.randn(input_dim, hidden_dim)
        self.params['fc1_b'] = np.zeros(hidden_dim)
        self.params['fc2_w'] = std * np.random.randn(hidden_dim, num_classes)
        self.params['fc2_b'] = np.zeros(num_classes)

        self.fc1 = self.fully_connected(w=self.params['fc1_w'], b=self.params['fc1_b'], activation=activation_fn)
        self.fc2 = self.fully_connected(w=self.params['fc2_w'], b=self.params['fc2_b'], activation=None)

    def loss(self, X, y=None, reg=0.0):
        """
        Calcularea functiei obiectiv si a gradientilor

        Input:
        - X: imagini de dimensiune (batch_size, input_dim). Fiecare X[i] este un exemplu.
        - labels: Vector de etichete. labels[i] este label-ul pentru X[i], si fiecare labels[i] este un
          intreg intre 0 <= labels[i] < num_classes. 
          Acest parametru este optional. Daca este omis atunci vom intoarce score-urile.
          Daca este specificat facem o parcurgere inainte si inapoi (feed-forward si backpropagation)
          si intoarcem rezultatul functiei de cost si gradientii calculati.
        - reg: parametrul pentru regularizare.

        Iesire:
        Daca label-urile sunt omise, atunci intoarcem score-urile calculate de feed_forward pass 
        cu o matrice de dimensiunea (batch_size, num_classes), unde fiecare scor[i, c] reprezinta score-ul 
        clasei c pentru inputul X[i].

        Daca label-urile nu sunt omise atunci intoarcem un tuplu:
        * rezultat functie de cost (include si termenul de regularizare) pentru un batch
        de exemple
        * gradientii: un dictionar care mapeaza pentru fiecare parametru gradientul acelui parametru. 
        Are aceleasi chei ca dictionarul pentru parametrii self.params.
        """
        self.l2_reg = reg
        fc1_w, fc1_b = self.params['fc1_w'], self.params['fc1_b']
        fc2_w, fc2_b = self.params['fc2_w'], self.params['fc2_b']
        batch_size, input_dim = X.shape 
    
        # Calcularea scor-urilor cu o propagare inainte prin retea (forward pass)
        scores = None
        #############################################################################
        # TODO: Calcularea unui forward pass din care sa rezulte scorurile finale   #
        # corespunzatoare fiecarei clase pentru fiecare input intr-o matrice de     #
        # dimensiuni (batch_size, num_classes).                                     #
        #############################################################################
        
        X1 = self.fc1.forward(X)
        X2 = self.fc2.forward(X1)
        #print(X2)
        scores = X2
        #############################################################################
        #                              END OF YOUR CODE                             #
        #############################################################################

        # Daca label-urile sunt omise:
        if y is None:
            return scores
        
        # Matrice output pt vectorul de iesire
        # X2 va fi iesirea
        Y = np.zeros(X2.shape)
        for i,row in enumerate(Y):
            row[y[i]] = 1
        
        # Altfel, calculam rezultatul functiei de cost
        loss = 0.0
        #############################################################################
        # TODO: Terminam calcularea unei propagari inainte prin retea (forward pass)#
        # Calculam loss-ul (rezultatul functiei obiectiv pentru intrari. Acesta     #
        # include  loss-ul datelor si regularizarea cu norma L2. Rezultatul trebuie #
        # sa fie un scalar. Regularizarea trebuie aplicata pentru fc1_w si fc2_w.   #
        # Pentru functia de cost folosim functia obiectiv de clasificare:           #
        # cross-entropia.                                                           #
        #############################################################################
      
        # e^X2 and normalize the result
        exp_X2 = np.exp(X2 - np.max(X2))
        exp_X2 = (exp_X2.T/np.sum(exp_X2, axis = 1)).T
        
        loss2 = 0.0
        for i in range(batch_size):
            loss2 -= np.log( exp_X2[i][y[i]] ) 
        loss2 *=1/batch_size
        
        
        loss += reg*np.sum(fc1_w * fc1_w) 
        loss += reg*np.sum(fc2_w * fc2_w)  
        
        loss += loss2 

        #############################################################################
        #                              END OF YOUR CODE                             #
        #############################################################################

        # Propagare inapoi (Backward pass). Calcularea gradientilor
        grads = {}
        #############################################################################
        # TODO: Executarea unei propagari inapoi (backward pass). Calculam          # 
        # gradientul (derivata) loss-ului pentru fiecare parametru: weight si bias. #
        # Stocam rezultatul in dictionarul grads. Grads['fc1_w'] ar trebui sa       #
        # contina gradientul pentru parametrii fc1_w si sa fie o matrice de aceeasi #
        # dimensiuni.                                                               #
        #############################################################################
      
        #First attempt. not working.......
        # dX2 = scores - Y
       #  dW2 = ((dX2.T).dot(X1)).T/batch_size + reg*fc2_w
        #db2 = (dX2.T).dot(np.ones(X1.shape[0]))/batch_size

        #dX1 = dX2.dot(fc2_w.T)
        #dW1 = (((dX1*(X1>0)).T).dot(X)).T/batch_size + reg*fc1_w
       # db1 = (((dX1*(X1>0)).T).dot(np.ones(X.shape[0]))).T/batch_size
        #(_, dW2, db2) = self.fc2.backward(dX2)    
        #(_, dW1, db1) = self.fc1.backward(dX1)

        #dW2 = dW2 + reg * fc2_w
        #dW1 = dW1 + reg * fc1_w
		
        #secondly
        mark_elements = np.zeros_like(X2)
        for (i, j) in enumerate(y):
            mark_elements[i, j] = 1        
        dX2 = []
        for b_index in range(batch_size): #un gradient...se legana...pe o panza de paianjen.
            local_exp_X2 = exp_X2[b_index]
            local_scores = scores[b_index]
            local_marked = mark_elements[b_index]         
            col = []
            for j in range(len(local_scores)):                 
                value = 0            
                for i in range(len(local_exp_X2)):  
                    aux1 = - (1 / batch_size) * local_marked[i] * (1 / local_exp_X2[i])
                    aux2 =  - local_exp_X2[i] * local_exp_X2[j]
                    if i==j:
                        aux2+=local_exp_X2[i]
                    value += aux1 * aux2
                col.append(value)                
            dX2.append(col)
       
        dX2 = np.asarray(dX2)       
        (outp, dW2, dB2) = self.fc2.backward(dX2)    
        (outp, dW1, dB1) = self.fc1.backward(outp)
        dW2 += 2 * reg * fc2_w
        dW1 += 2 * reg * fc1_w
        
        #Finally
        grads['fc2_b'] = dB2
        grads['fc2_w'] = dW2
        grads['fc1_b'] = dB1
        grads['fc1_w'] = dW1
        
        
        #############################################################################
        #                              END OF YOUR CODE                             #
        #############################################################################

        return loss, grads

    def train(self, X, y, X_val, y_val,
            learning_rate=1e-3, learning_rate_decay=0.95,
            reg=5e-6, num_iters=100,
            batch_size=200, verbose=False):
        """
        In aceasta functie trebuie sa antrenam reteaua folosind stochastic gradient
        descent.

        Input:
        - X: Un numpy array (train_dataset_size, input_dim) ce reprezinta input-ul de 
         train.
        - y: Un numpy array (train_dataset_size,) ce reprezinta label-urile de train; 
         y[i] = c inseamna ca 
          imaginea X[i] are label-ul c, unde 0 <= c < num_classes 
        - X_val: Un numpy array (val_dataset_size, input_dim) ce reprezinta imaginile de 
         validare.
        - y_val: Un numpy array (val_dataset_size,) ce reprezinta etichetele de validare.
        - learning_rate: Un scalar ce reprezinta rata de invatare.
        - learning_rate_decay: Un scalar ce reprezinta factorul folosit pentru decay-ul 
         ratei de invatare dupa fiecare epoca
        - reg: Un scalar ce reprezinta factorul cu care se aplica regularizarea 
         parametrilor.
        - num_iters: Numarul de iteratii folosit pentru optimizare.
        - batch_size: Numarul de exemple folosite in fiecare mini-batch de optimizare.
        - verbose: boolean; Flag ce seteaza print-uri in timpul antrenarii pentru a 
         afisa progresul.
        """
        train_dataset_size = X.shape[0]
        iterations_per_epoch = max(train_dataset_size / batch_size, 1)

        # Folositi SGD pentru optimizare
        loss_history = []
        train_acc_history = []
        val_acc_history = []
        self.batch_size = batch_size

        for it in range(num_iters):
            X_batch = None
            y_batch = None

            #########################################################################
            # TODO: Samplati mini-batch-uri random din datele de antrenare (imagini #
            # + labels) si le stocati in X_batch si y_batch                         #
            #########################################################################
            batch_indicies = np.random.choice(train_dataset_size, batch_size, replace = True)
            #replace va fi False, dar pt ca pe datele din test sunt putine intrari las true,
            #ulterior pt cifar va fi False.
            X_batch = X[batch_indicies]
            y_batch = y[batch_indicies]
            #########################################################################
            #                             END OF YOUR CODE                          #
            #########################################################################

            # Calculati costul(eroarea) si gradientii folosin mini-batch-ul curent
            loss, grads = self.loss(X_batch, y=y_batch, reg=reg)
            loss_history.append(loss)

            #########################################################################
            # TODO: Folositi gradientii stocati in dictionarul grads pentru a updata#
            # parametrii retelei (stocati in dictionarul self.params) folosin SGD.   #
            #########################################################################
            for variable in self.params:
                self.params[variable] -= learning_rate*grads[variable]
            #########################################################################
            #                             END OF YOUR CODE                          #
            #########################################################################

            if verbose and it % 100 == 0:
                print('iteration %d / %d: loss %f' % (it, num_iters, loss))

            # La fiecare epoca stocam acuratetea pe datale de antrenare si pe datale 
            # de validare si facem decay la rata de invatare
            if it % iterations_per_epoch == 0:
                # Calculam acuratetea
                train_acc = (self.predict(X_batch) == y_batch).mean()
                val_acc = (self.predict(X_val) == y_val).mean()
                train_acc_history.append(train_acc)
                val_acc_history.append(val_acc)

                # Facem decay la rata de invatare inmultind-o cu un numar subunitar
                learning_rate *= learning_rate_decay

        return {
            'loss_history': loss_history,
            'train_acc_history': train_acc_history,
            'val_acc_history': val_acc_history,
        }

    def predict(self, X):
        """
        In aceasta functie trebuie sa folosim parametrii actuali ai retelei pentru a 
        prezice label-uri noi pentru noi exemple de imagini neetichetate.
        Pentru fiecare exemplu X[i] o sa prezicem clasa cu probabilitate maxima din cele
        num_classes.

        Input:
        - X: Un numpy array (test_dataset_size, image_dim) ce reprezinta imaginile ce 
        trebuie etichetate.

        Iesire:
        - y_pred: Un numpy array (test_dataset_size,) ce reprezinta etichetele prezise 
        pentru fiecare din elementele din X.
        y_pred[i] = c inseamna ca pentru imaginiea X[i] am prezis ca aceasta are clasa c, 
        unde 0 <= c < C.
        """
        y_pred = None

        ###########################################################################
        # TODO: Aici trebuie sa implementam o prezicerea rezultatului pentru un   #
        # un exemplu nou. Asta inseamna ca trebuie sa luam imaginea si sa o trecem#
        # prin retea facand o propagare inainte. Dupa ce obtinem scorurile-logits #
        # trebuie sa executam argmax de scoruri pentru a intoarce clasa cu scorul #
        # cel mai mare. Nu trebuie sa mai facem probabilitatile finale pentru     #
        # fiecare clasa, deoarece nu avem nevoie de ele.                          #
        ###########################################################################
        X1 = np.maximum( X.dot(self.params['fc1_w']) + self.params['fc1_b'], 0 )
        X2 = X1.dot(self.params['fc2_w']) + self.params['fc2_b']
        exp_X2 = pow(math.e, X2)
        scores   = (exp_X2.T/np.sum(exp_X2, axis = 1)).T
    
        y_pred = np.argmax(scores, axis = 1)
        ###########################################################################
        #                              END OF YOUR CODE                           #
        ###########################################################################

        return y_pred