function [K_T,F]=boundary(K,boundary_condition,DOF_T,force)
Kb=max(diag(K))*1e6;
d=0;
F=force;
K_T=K;
for i=1:DOF_T
    if (boundary_condition(i,1))==1;
        K_T(i,i)=K(i,i)+Kb;
        F(i,1)=d*Kb;
    end
end    
end