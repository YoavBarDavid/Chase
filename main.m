clc
close all 
% clearvars -except best_k mean_error best_tau
clear all

%% for 0Hz
% successful_experiment = [5 7 10 12 13 15 17 18 19] ; %0Hz
% file_start = 1 ;
% file_end = 20 ;

%% for 1Hz
% successful_experiment = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24] ;
% successful_experiment = [1 2 11 12 13 15 16 20 21 22] ; % for 1 Hz  
% file_start = 100 ;
% file_end = 123 ;
% best_k = [ 8.13 13 0 0 0 0 0 0 0 0 7.112 13 10.78 0 5.1 3.0877 0 0 0 13 1 1 0 ] ;

%% for 2Hz
successful_experiment = [1 4 7 8 9 10 11 12 13 14 15 22] ; %for maximal average error = 1.3cm
file_start = 200 ;
file_end = 227 ;
saccade_frame{3} = [ 1485 1694 1987] ;
saccade_frame{4} = [ 679 948] ;
saccade_frame{6} = [ 665 ] ;
saccade_frame{7} = [ 841 ] ;
saccade_frame{9} = [ 326 ] ;
saccade_frame{23} =[ 43 567 ] ;

% best_k = [ 3.67 0 0 4.11 0 0 1.77 2.98 9.53 1.72 5.806 3.778 1.6307 7.848 3.913 0 0 0 0 0 2.86 0 0 0 0 0 0 ] ;

%% 2.5Hz
% successful_experiment = [9 11 12 14 31] ;
% file_start = 250 ;
% file_end = 280 ;
% % best_k = [ 0 0 0 0 0 0 0 0 2.88 0 2.72 9.32 0 2.47 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 ] ; 
% saccade_frame{1} = [ 5 175 269 428 530 783 1037 1247 1595 ] ;
% saccade_frame{4} = [ 231 790 1469 1600 ] ;
% saccade_frame{5} = [ 265 ] ;
% saccade_frame{7} = [ 629 ] ;
% saccade_frame{9} = [ 526 1072 ] ;
% saccade_frame{30}= [ 741 1330 ] ;

%% for large amplitude
% file_start = 1 ;
% file_end = 14 ;
% successful_experiment = [ ] ;

frequency = 1000 ; %frames per second
i = 1 ;
f_cut = 50 ; %for later filtering of the results: larger -> weirder jumps

for file_num = file_start:file_end %goes over all the files
    
    %% read files           
    textFileName = ['C:\Users\User\Desktop\Yoavs everything nov. 19\yoav\Ecology lab\2Hz\actu' num2str(file_num) '.csv'] ;
    A = xlsread(textFileName) ;
    
    %% turning the table to seperate vectors (distance in meters)
    pt1_X{i} = (A(:,1)) ;
    pt1_Y{i} = (A(:,2)) ;
    pt1_Z{i} = (A(:,3)) ;

    pt2_X{i} = (A(:,4)) ;
    pt2_Y{i} = (A(:,5)) ;
    pt2_Z{i} = (A(:,6)) ;

    pt3_X{i} = (A(:,7)) ;
    pt3_Y{i} = (A(:,8)) ;
    pt3_Z{i} = (A(:,9)) ;
    
    %% filter locations
    pt3_X{i} = filter_data(frequency,0.85*f_cut,cell2mat(pt3_X(i))) ;
    pt3_Y{i} = filter_data(frequency,0.85*f_cut,cell2mat(pt3_Y(i))) ;
    pt3_Z{i} = filter_data(frequency,0.85*f_cut,cell2mat(pt3_Z(i))) ;
    
    %% calc absolute distance (meters)
%     dist{i} = sqrt( (pt2_X{i} - pt3_X{i}).^2 + (pt2_Y{i} - pt3_Y{i}).^2 + (pt2_Z{i} - pt3_Z{i}).^2 )';
%     dist{i} = vector_trim(cell2mat(dist(i))) ; %explenation inside the function vector_trim
    
    %% calc velocity (in m/s)
    v1_X{i} = velocity(pt1_X{i},frequency) ;
    v1_Y{i} = velocity(pt1_Y{i},frequency) ;
    v1_Z{i} = velocity(pt1_Z{i},frequency) ;
    
    v2_X{i} = velocity(pt2_X{i},frequency) ;
    v2_Y{i} = velocity(pt2_Y{i},frequency) ;
    v2_Z{i} = velocity(pt2_Z{i},frequency) ;

    v3_X{i} = velocity(pt3_X{i},frequency) ;
    v3_Y{i} = velocity(pt3_Y{i},frequency) ;
    v3_Z{i} = velocity(pt3_Z{i},frequency) ;
       
    %% filter the velocity 
    v1_X{i} = filter_data(frequency,f_cut,cell2mat(v1_X(i))) ;
    v1_Y{i} = filter_data(frequency,f_cut,cell2mat(v1_Y(i))) ;
    v1_Z{i} = filter_data(frequency,f_cut,cell2mat(v1_Z(i))) ;
    
    v2_X{i} = filter_data(frequency,f_cut,cell2mat(v2_X(i))) ;
    v2_Y{i} = filter_data(frequency,f_cut,cell2mat(v2_Y(i))) ;
    v2_Z{i} = filter_data(frequency,f_cut,cell2mat(v2_Z(i))) ;
    
    v3_X{i} = filter_data(frequency,f_cut,cell2mat(v3_X(i))) ;
    v3_Y{i} = filter_data(frequency,f_cut,cell2mat(v3_Y(i))) ;
    v3_Z{i} = filter_data(frequency,f_cut,cell2mat(v3_Z(i))) ;
    
    v3{i} = sqrt(v3_X{i}.^2 + v3_Y{i}.^2) ; %total target speed
    v3{i} = filter_data(frequency,f_cut,v3{i}) ;
    
    v2{i} = sqrt(v2_X{i}.^2 + v2_Y{i}.^2) ; %total damselfly speed in xy plane
    v2_xz{i} = sqrt(v2_X{i}.^2 + v2_Z{i}.^2) ; %total damselfly speed in xz plane
    v2{i} = filter_data(frequency,f_cut,v2{i}) ;
       
    %% calc angles
    inertial_direction{i} = (atan2d(cell2mat(v2_Y(i)),cell2mat(v2_X(i)))) ; %flight angle in world coordinates (on xy plane)
    inertial_z_direction{i} = atan2d(cell2mat(v2_Z(i)),cell2mat(v2_X(i))) ; %flight angle in world coordinates (on xz plane)
    b_angle{i} = atan2d((pt1_Y{i} - pt2_Y{i}),(pt1_X{i} - pt2_X{i})) ; % body angle in world coordinates
    azimuth{i} = calc_azi(pt1_X{i},pt1_Y{i},pt2_X{i},pt2_Y{i},pt3_X{i},pt3_Y{i}) ;  % Line of sight (LoS) with respect to the body IN RADS
    relative_direction{i} = unwrap(inertial_direction{i} - b_angle{i}) ; %slip angle
    t_angle{i} = atan2d((pt3_Y{i} - pt2_Y{i}),(pt3_X{i} - pt2_X{i})) ; %LoS angle in world coordinates
    
    %% filter
    azimuth{i} = filter_data(frequency,f_cut,azimuth{i}) ;
    b_angle{i} = filter_data(frequency,f_cut,b_angle{i}) ;
    relative_direction{i} = filter_data(frequency,f_cut,relative_direction{i}) ;
    
    inertial_direction_dot{i} = velocity((cell2mat(inertial_direction(i))),frequency) ; %angular velocity of azimuth
    inertial_direction1_dot{i} = filter_data(frequency,f_cut,inertial_direction_dot{i}) ;

    azimuth_dot{i} = velocity(transpose(cell2mat(azimuth(i))),frequency) ; %angular velocity of azimuth
    azimuth_dot{i} = filter_data(frequency,f_cut,azimuth_dot{i}) ;
    t_angle_dot{i} = velocity(cell2mat(t_angle(i)),frequency) ; %angular velocity of LoS
    t_angle_dot{i} = filter_data(frequency,1.3*f_cut,t_angle_dot{i}) ; %filter
    
    Displacement(i) = (1/frequency)*sum(v2{i}) ;

 i = i+1 ;
end
