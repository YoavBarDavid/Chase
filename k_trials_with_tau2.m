%% 
% This script simulates a proportional navigation simulation for every 
% experiment in the selected frequency (as defind by the user in the main).

k = linspace(1,5,50) ; %Checking every gain 
tau = linspace(10,80,8) ;  %Time constant
clear xchaser ychaser LoS LoS_dot flight_direction

for i = 1:22 %Experiments
    
    for j = 1:length(k) %Gains
       for h = 1:length(tau) %Time delays
          clear xchaser ychaser LoS_dot flight_direction
          % initial conditions taken from the measurements
          flight_direction = deg2rad(inertial_direction{i}(1)) ; 
          LoS{i}(1) = deg2rad((t_angle{i}(1))) ;
          LoS_dot = 0 ;
          xchaser(1) = pt2_X{i}(1) ;%location
          ychaser(1) = pt2_Y{i}(1) ; %location
          
          for f = 1:(length(pt1_X{i})-1)
              %simu
              if f<=tau(h) 
                  %while the time of the simulation is smaller then
                  %the time delay the simulated damselfly stays at
                  %the starting point
                  xchaser(f+1) = xchaser(f) ; 
                  ychaser(f+1) = ychaser(f) ;
              else %Chase has begun: the simulated damselfly flies the
                   %same speed as the measurement shows
                  xchaser(f+1) = xchaser(f) + v2{i}(f)*(1/frequency)*cos(flight_direction(f)) ;
                  ychaser(f+1) = ychaser(f) + v2{i}(f)*(1/frequency)*sin(flight_direction(f)) ;
              end
              LoS{i}(f+1) = atan2( (pt3_Y{i}(f+1) - ychaser(f+1)),(pt3_X{i}(f+1) - xchaser(f+1)) ) ; %Line of sight
              LoS_dot(f) = (LoS{i}(f+1) - LoS{i}(f))*frequency ;                                     %Primitive derivitive of LoS
              flight_direction_dot(f+1) = k(j)*LoS_dot(f) ;                                          %Flight direction
              flight_direction(f+1) = flight_direction(f) + (1/frequency)*flight_direction_dot(f+1) ;%Primitive integration
              step_error{i}(f) = sqrt( (pt2_Y{i}(f) - ychaser(f))^2 + (pt2_X{i}(f)-xchaser(f))^2) ;  %Error
              
          end
       mean_error{i}(j,h) = mean(step_error{i}) ;                                  %Calculates average error for the whole simulation (for specific k and tau)
       [minimal_error(i),best_k_index,best_tau_index] = find_min2(mean_error{i}) ; %Finds k and tau for which we have minimal error
       best_k(i) = k(best_k_index) ; 
       best_tau(i) = tau(best_tau_index) ;
       
       end
    end
end


















% k = linspace(1,13,500) ; %Checking every gain between 1,13
% tau = 0 ;  %time constant
% clear xchaser ychaser LoS LoS_dot flight_direction
% 
% for l = 1:length(successful_experiment) 
%     i = successful_experiment(l) ;
%     for j = 1:length(k) 
%        for h = 1:length(tau) 
%           clear xchaser ychaser LoS_dot flight_direction
%           % initial conditions taken from the measurements
%           flight_direction = deg2rad(inertial_direction{i}(1)) ; 
%           LoS{i}(1) = deg2rad((t_angle{i}(1))) ;
%           LoS_dot = 0 ;
%           xchaser(1) = pt2_X{i}(1) ;%location
%           ychaser(1) = pt2_Y{i}(1) ; %location
%           
%           for f = 1:(length(pt1_X{i})-1)
%               %simu
%               if f<=tau(h) 
%                   %while the time of the simulation is smaller then
%                   %the time delay the simulated damselfly stays at
%                   %the starting point
%                   xchaser(f+1) = xchaser(f) ; 
%                   ychaser(f+1) = ychaser(f) ;
%               else %chase has begun: the simulated damselfly flies the
%                    %same speed as the measurement shows
%                   xchaser(f+1) = xchaser(f) + v2{i}(f)*(1/frequency)*cos(flight_direction(f)) ;
%                   ychaser(f+1) = ychaser(f) + v2{i}(f)*(1/frequency)*sin(flight_direction(f)) ;
%               end
%               LoS{i}(f+1) = atan2( (pt3_Y{i}(f+1) - ychaser(f+1)),(pt3_X{i}(f+1) - xchaser(f+1)) ) ; %Line of sight
%               LoS_dot(f) = (LoS{i}(f+1) - LoS{i}(f))*frequency ;                                     %Primitive derivitive of LoS
%               flight_direction_dot(f+1) = k(j)*LoS_dot(f) ;                                          %Flight direction
%               flight_direction(f+1) = flight_direction(f) + (1/frequency)*flight_direction_dot(f+1) ;%Primitive integration
%               step_error{i}(f) = sqrt( (pt2_Y{i}(f) - ychaser(f))^2 + (pt2_X{i}(f)-xchaser(f))^2) ;  %Error
%               
%           end
%        mean_error{i}(j,h) = mean(step_error{i}) ;                                  %Calculates average error for the whole simulation (for specific k and tau)
%        [minimal_error(i),best_k_index,best_tau_index] = find_min2(mean_error{i}) ; %Finds k and tau for which we have minimal error
%        best_k(i) = k(best_k_index) ; 
%        best_tau(i) = tau(best_tau_index) ;
%        
%        end
%     end
% end
