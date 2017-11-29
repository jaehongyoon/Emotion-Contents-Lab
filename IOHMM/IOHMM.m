function [p_val, Q_U, X_k_Update, Cov_U, Trans_num_U, b_U, L_posterior]= IOHMM(X, Q, X_k, Cov, Trans_num, b, L_prior)

% this function is a simple IOHMM version by Jaehong Yoon
% strategy of this function is to use Gaussian classifier as hidden
% markov machine of each layers and update accordingly after each iteration.
% Reason for adopting Gaussian machine is its efficiency in updating
% parameters used in the function.

% Parameters:
% X= observed value (P3_amp, P_lat, N1_amp, N1_lat)
% Q = state parameter. We have two states. ERP detected/not detected. So from
% X we get Q and both Q and X are used to determine value of Y. For
% shematics of Q mealy state machine, refer to note book
% Three parameters determine Q (yjh)
% y: P3 detected? (amplitude above threshold)
% j: N1 detected? (amplitude above threshold)
% h: N1 prior P3?
% if either one of yjh = 0 then Q = s1:ERP not detected.
% X_k = mean value of parameters for each state
% Trans_num = total transfer number from previous trial to now
% Trial_num = total number of happening of each state

%Outputs:
% p_val = percentage of Y (classifier)
% Q_U = updated Q
% trans_mat = transition of state matrix
% Trans_num_U = updated
% Trial_num_U = updated

%% initialization

% to use we need initialization of the parameters.
% please plug in mean values of non-target(not_ERP)/target(ERP) parameters
% (X(initial) = mean(X_training))
% window size is 1s = plug in X with 1s delay
% we need initial prob. of each state = (1/6, 5/6) = pi
% covariance intiail value is (X_training - X_mean) square

%% Estimate state

%calculate transfer rate for each case
a = zeros(2, 2);
b_used = zeros(2, 2);
for i = 1:2
    a(i, 1) = Trans_num(i, 1)/sum(Trans_num(i,:));
    a(i, 2) = Trans_num(i, 2)/sum(Trans_num(i,:));
    b_used(i, 1) = b(i, 1)/sum(b(i,:));
    b_used(i, 2) = b(i, 2)/sum(b(i,:));
end

pi_rate = zeros(1,2);
L = zeros(1,2);

for i = 1:2    
    pi_rate(i) = a(i, Q(2));
    L(i) = 1/sqrt((2*pi)^2.*(Cov))...
        .*exp(-1/2.*(X-X_k(:,i)).*(Cov).*(X-X_k(:,i)));    
end
H = a.*b_used;

%% Maximization state

for i = 1:2
    X_k_Update(:,i) = (L(i)*X+L_prior(i)*X_k)./(L(i) + L_prior(i));
end
Cov_U = (X - X_K_Update)*(X - X_K_Update);
L_posterior = L;

%% Update and determine class
%determine class
class = 0;
Q_now = 0;
Y = zeros(1, 2);
for i=1:2
    Y(i) = 1/sqrt((2*pi)^2.*(Cov_U))...
        .*exp(-1/2.*(X-X_k_Update(:,i)).*(Cov).*(X-X_k_Update(:,i)));
end

if (X(1)>X_k(2,1)*0.7 && X(3)>X_k(2,3)*0.7 && X(2)>X(4))
    Q_now = 2;
else Q_now = 1;
end

if Q(1) == 1 && Q(2) ==2
    if Y(2) > Y(1) && Q_now ==2
        class = 2;
    end
else class = 1;   
end

Q_U(1) = Q(2);
Q_U(2) = Q_now;

b_U = b;
Trans_num_U = Trans_num;
%update Trans_num_U, b_U
if Q_now == 1
    if Q_U(1) == 1; Trans_num_U(1,1) =Trans_num(1,1)+1;
    else Trans_num_U(1,2) =Trans_num(1,2)+1;
    end
else
    if Q_U(1) == 1; Trans_num_U(1,2) =Trans_num(2,1)+1;
    else Trans_num_U(2,2) =Trans_num(2,2)+1;
    end
end

if class == 1
    if Q_now == 1; b_U(1,1) =b(1,1)+1;
    else b_U(1,2) =b(1,2)+1;
    end
else
    if Q_now == 1; b_U(2,1) =b(2,1)+1;
    else b_U(2,2) =b(2,2)+1;
    end
end

p_val = Y(2);
end



