tic
clc
clear all
format long
global k_add DOF_T
%% Input Reading
INPUT=xlsread('input.xlsx','SHEET1');
% number
INPUT_N=INPUT(1,1:4);
N_node=INPUT_N(1,1);
N_element=INPUT_N(1,2);
N_area=INPUT_N(1,3);
N_material=INPUT_N(1,4);
% node information
INPUT_NODE=INPUT(2:N_node+2-1,1:10);
% element information
INPUT_ELEMENT=INPUT(N_node+2:N_element+N_node+2-1,1:5);
% Area information
INPUT_AREA=INPUT(N_node+N_element+2:N_area+N_node+N_element+2-1,1:2);
% Material information
INPUT_MAT=INPUT(N_area+N_node+N_element+2:N_material+N_area+N_node+N_element+2-1,1:2);
% Boundary Condition information
boun_con=INPUT_NODE(1:N_node,5:7);
node_force=INPUT_NODE(1:N_node,8:10);
% Tot DoF information
DOF_node=3;
DOF_T=DOF_node*N_node;
%% Coordinate Node
x_element=zeros(N_element,3);
y_element=zeros(N_element,3);
z_element=zeros(N_element,3);
L=zeros(N_element,1);
for i=1:N_node
    X(i,1)=INPUT_NODE(i,2);
    Y(i,1)=INPUT_NODE(i,3);
    Z(i,1)=INPUT_NODE(i,4);
end
for i=1:N_element
    first=INPUT_ELEMENT(i,2);
    final=INPUT_ELEMENT(i,3);
    x_element(i,1)=X(final,1)-X(first,1);
    y_element(i,1)=Y(final,1)-Y(first,1);
    z_element(i,1)=Z(final,1)-Z(first,1);
    coordinate_element(i,1)=x_element(i,1);
    coordinate_element(i,2)=y_element(i,2);
    coordinate_element(i,3)=z_element(i,3);
    L(i,1)=(x_element(i,1)^2+y_element(i,1)^2+z_element(i,1)^2)^0.5;
end
%% Material & Area
MAT=zeros(N_element,1);
AREA=zeros(N_element,1);
for i=1:N_element
    MAT(i,1)=INPUT_MAT(INPUT_ELEMENT(i,5),2);
    AREA(i,1)=INPUT_AREA(INPUT_ELEMENT(i,4),2);
end
%% Numbering DOF
m=1;
for i=1:N_node
    node_add(i,1)=i;
    node_add(i,2)=3*i-2;
    node_add(i,3)=3*i-1;
    node_add(i,4)=3*i;
    for j=1:DOF_node
        boundary_condition(m,1)=boun_con(i,j);
        force(m,1)=node_force(i,j);
        m=m+1;
    end
end
%% Stiffness on Global CS
for i=1:N_element
    Cx(i,1)=x_element(i,1)/L(i,1);
    Cy(i,1)=y_element(i,1)/L(i,1);
    Cz(i,1)=z_element(i,1)/L(i,1);
    AEL=(AREA(i,1)*MAT(i,1))/L(i,1);
   k{i,1}=stiff(AEL,Cx(i,1),Cy(i,1),Cz(i,1));
end
%% Assembling of stiffness matrix
K=directassemble(k,INPUT_ELEMENT,N_node,node_add);
%% Boundary condition
[K_T,F]=boundary(K,boundary_condition,DOF_T,force);
%% solution 
[REACTION,DISPLACEMENT]=solution(K_T,K,force);
%% Stress
STRESS=stress(Cx,Cy,Cz,DISPLACEMENT,node_add,INPUT_ELEMENT,MAT,AREA,L);
%% Output data
NODE=[1:DOF_T]';
ELEMENT=[1:N_element]';
xlswrite('Result.xlsx',NODE,'SHEET1','A2');
xlswrite('Result.xlsx',DISPLACEMENT,'SHEET1','B2');
xlswrite('Result.xlsx',REACTION,'SHEET1','C2');
xlswrite('Result.xlsx',ELEMENT,'SHEET1','E2');
xlswrite('Result.xlsx',STRESS,'SHEET1','F2');


toc