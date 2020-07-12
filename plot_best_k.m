%This script plots chase simulation courses for the best fitting k found by
%the script "k_trials_with_tau2" 

close all
K = best_k ; %Takes the best k from "k_trials_with_tau2" script.
clear aim
% tau = best_tau ;
%%

for i = 1:31    
%     legendCell{h} =['K =  ', num2str(K(h), '%10.2f')] ;
%         tau = best_tau(i) ; 
        %%
        tau = 0 ;
        %%
        
        dt = 1/frequency ; 
        v_chaser = v2{i} ;
        
        %% initial conditions
        vchaserp{i} = v2{i} ;
        xtarget{i}(1) = pt3_X{i}(1) ;
        xchaserp{i}(1) = pt2_X{i}(1) ;
        ychaserp{i}(1) = pt2_Y{i}(1) ;
        azi{i}(1) = deg2rad(t_angle{i}(1)) ;
        aim{i}(1) = deg2rad(inertial_direction{i}(1)) ; %damselfly flight direction in world coordinates during a simulation
        beta{i}(1) = 0 ;
        azi_angular_velocity{i}(1) = 0 ;

        %% simulation
        for f =  1:length(v2{i})-1
            if f<=tau %time delay
             xchaserp{i}(f+1) = xchaserp{i}(f) ; 
             ychaserp{i}(f+1) = ychaserp{i}(f) ;
             azi{i}(f+1) = azi{i}(1) ;
             aim{i}(f+1) = aim{i}(f) ;
            end
            
            % chase
            if f>tau
             azi{i}(f+1) = atan2( (pt3_Y{i}(f-tau) - ychaserp{i}(f)),(pt3_X{i}(f-tau) - xchaserp{i}(f)) ) ; %los angle
             azi_angular_velocity{i}(f+1) = (azi{i}(f+1) - azi{i}(f) )*(frequency) ; % primitive derivative
             aim{i}(f+1) = aim{i}(f) + K(i)*(1/frequency)*azi_angular_velocity{i}(f+1) ; % flight direction in world coordinates
             xchaserp{i}(f+1) = xchaserp{i}(f) + cos(aim{i}(f+1))*vchaserp{i}(f)/frequency ;
             ychaserp{i}(f+1) = ychaserp{i}(f) + sin(aim{i}(f+1))*vchaserp{i}(f)/frequency ;
            end
        end
        %% for different plots
%         figure(i)
%         plot(xchaserp{i},ychaserp{i},pt2_X{i},pt2_Y{i},pt3_X{i},pt3_Y{i})
%         legend('Simulation','Experiment')


end