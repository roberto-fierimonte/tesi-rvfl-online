function [soluzione,K1] = rvflclass_sequenz(K0,X1,Y1,sol_prec,rete)
%RVFLCLASS_SEQUENZ definisce un algoritmo di addestramento per una rete neurale di
%tipo random vector functional-link da utilizzare in problemi di
%classificazione in cui siano forniti nuovi dati e si desideri aggiornare la stima dei
%parametri
%
%Input: K0: pseudoinversa (K x K) relativa all'iterazione precedente
%       X1: matrice p1 x n dei nuovi campioni di ingresso
%       Y1: matrice p1 x m dei nuovi campioni di uscita
%       sol_prec: matrice K x m dei parametri della rete stimati attraverso
%           i campioni gi� noti
%       rete: struttura che contiene le informazioni relative alla RVFL
%           (dimensione dell'espansione, pesi e soglie della combinazione
%           affine e parametro di regolarizzazione)
%
%Output: soluzione: matrice  K x m dei parametri del modello
%        K1: pseudoinversa (K x K) relativa all'iterazione corrente
    
%Passo 1: estraggo le dimensioni del nuovo dataset
    pX1=size(X1,1);
    pY1=size(Y1,1);

%Se i campioni di ingresso e uscita sono di numero diverso restituisco un
%errore
    if pX1 ~= pY1
        error('Il numero dei nuovi campioni di ingresso (%i) � diverso da quello dei campioni in uscita (%i)',pX1,pY1);
    end
    
%Passo 2: converto i valori della variabile di uscita in valori booleani 
%utilizzando variabili ausiiarie
    aus=dummyvar(Y1);
    
%Passo 3: determino la matrice delle uscite dell'espansione funzionale
%relativamente ai nuovi campioni
    scal1 = X1*rete.coeff';
    aff1 = bsxfun(@plus,scal1,rete.soglie');
    exit1 = (exp(-aff1)+1).^-1;
    A1 = exit1;

    K1=(K0+A1'*A1);

%Passo 4: aggiorno la soluzione utilizzando i nuovi campioni
    soluzione=sol_prec+K1\A1'*(aus-A1*sol_prec);
end
