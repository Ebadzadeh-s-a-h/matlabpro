function [K_T,F_T] = penaltybc(K,bcdof,F,delta)
n=length(bcdof);
KB=max(diag(K))*1e6;
K_T=K;
F_T=F;
for i=1:n
    c=bcdof(i,1);
    D=delta(i,1);
    K_T(c,c)=K(c,c)+KB;
    F_T(c,1)=F(c,1)+KB*D;
end
end