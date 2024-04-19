function STRESS=stress(Cx,Cy,Cz,DISPLACEMENT,node_add,INPUT_ELEMENT,MAT,AREA,L)
STRESS=zeros(size(INPUT_ELEMENT,1),1);
for i=1:size(INPUT_ELEMENT,1)
    first=INPUT_ELEMENT(i,2);
    final=INPUT_ELEMENT(i,3);
    dfirst=node_add(first,2:4);
    dfinal=node_add(final,2:4);
    Cp=[-Cx(i,1) -Cy(i,1) -Cz(i,1) Cx(i,1) Cy(i,1) Cz(i,1)];
    d(1:3,1)=DISPLACEMENT(dfirst);
    d(4:6,1)=DISPLACEMENT(dfinal);
    STRESS(i,1)=(Cp*d*MAT(i,1))/L(i,1);
end
end