clear variables;
clc;
close all;

%% Partie 1
n = 8;
N = 2^n;
K = 5;

% On construit s
s = zeros(N,1);

indexes = randperm(N,K);

s(indexes) = randn(K,1)*100;

% Ondelettes
qmf = MakeONFilter('Daubechies',12);

% Reconstruction de x
j = 0; 
x = IWT_PO(s,j,qmf);

% Matrice d'acquisition
k=3;
M = floor(k*K*log(N/K));
C = orth(randn(M,N)')';

% y
y = C * x;

% Les opérateurs A et At
A = @(x)(C * IWT_PO(x,j,qmf));
At = @(x)(FWT_PO(C'*x,j,qmf));

% Estim de x
s_est = At(y);
x_est = IWT_PO(s_est,j,qmf);

figure()
hold on;
plot(x)
plot(x_est)

% estim avec fc
s_est_bis = l1_qc(s_est,A,At,y);
x_est_bis = IWT_PO(s_est_bis,j,qmf);
plot(x_est_bis)
legend('original','moindre carrée','l1 qc')

y_bruit = y + randn(M,1);
e= At(y_bruit_est);
x_bruit_est = IWT_PO(s_bruit_est, j, qmf);

s_bruit_est_bis = li_qc(