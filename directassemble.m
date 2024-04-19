function [K] = directassemble(k,INPUT_ELEMENT,N_node,node_add)
global k_add DOF_T 
K=zeros(DOF_T);
for i=1:size(INPUT_ELEMENT,1)
    start=INPUT_ELEMENT(i,2);
    final=INPUT_ELEMENT(i,3);
    for j=1:N_node
        if (start==j)
            k_add(i,1)=node_add(j,2);
            k_add(i,2)=node_add(j,3);
            k_add(i,3)=node_add(j,4);
        end   
        if (final==j)
            k_add(i,4)=node_add(j,2);
            k_add(i,5)=node_add(j,3);
            k_add(i,6)=node_add(j,4);
        end   
    end
end  
for i=1:size(INPUT_ELEMENT,1)
    K(k_add(i,:),k_add(i,:))=K(k_add(i,:),k_add(i,:))+k{i,1};
end
end