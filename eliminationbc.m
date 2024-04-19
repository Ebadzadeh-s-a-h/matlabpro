function [K_T] = eliminationbc(K,bcdof)
Total_dof=size(K,1);
n=length(bcdof);
K_T=K;
for i=1:n
    for j=1:Total_dof
        c=bcdof(i,1);
        K_T(j,c)=0;
        K_T(c,j)=0;
    end
end
end