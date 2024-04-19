function [K_G] = assemble(k,DOF)
N=max(max(DOF));
N_E=size(k,1);
K_G=zeros(N,N);
for i=1:N_E
    K_G(DOF(i,:),DOF(i,:))=K_G(DOF(i,:),DOF(i,:))+k{i,1};
end
end