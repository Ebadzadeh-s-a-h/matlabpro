function [k] = stiff(AEL,Cx,Cy,Cz)
k=zeros(6,6);
T=[Cx^2 Cx*Cy Cx*Cz;...
    Cy*Cx Cy^2 Cy*Cz;...
    Cz*Cx Cz*Cy Cz^2];
k=AEL*[T -T;-T T];
end