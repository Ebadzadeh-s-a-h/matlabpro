function [REACTION,DISPLACEMENT] = solution(K_T,K,force)
global DOF_T
DISPLACEMENT=K_T\force;
REACTION=K*DISPLACEMENT;
end