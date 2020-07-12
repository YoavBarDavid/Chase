 clear max delayindex asdf lags aim_trial inertial_direction_trial
close all
for i = 1:22
    
    %% Make sure all vectors are in angles and between -180 and 180
    
      
    aim_trial{i} = limmiting(rad2deg(aim{i})) ; %Making sure all angles are between 180 and -180
    inertial_direction_trial{i} = limmiting(inertial_direction{i}) ; %Making sure all angles are between 180 and -180
    
    inertial_direction_trial{i} = no_jumping(inertial_direction_trial{i}) ; %Lowering the effect of jumping from 179 to -181, for example
    aim_trial{i} = no_jumping(aim_trial{i}) ; %Lowering the effect of jumping from 179 to -181, for example


% % 
%     aim_trial{i} = filter_data(1000,f_cut,cell2mat(aim_trial(i))) ; %Filter
    
%     figure(i)
%     plot(aim_trial{i}) ; hold on ; plot(inertial_direction_trial{i}) ;
%     legend('simu','exp')
    diff{i} = inertial_direction_trial{i} - aim_trial{i} ;
    diff{i} = filter_data(1000,f_cut,cell2mat(diff(i))) ; %Filter
    
    figure(i)
    plot(limmiting(diff{i})) ;
    
    
    
    %% Find correlation
%    [asdf{i},lags{i}] = xcorr(aim_trial{i},(inertial_direction{i})) ;
%    figure(i)
%    plot(lags{i},asdf{i}) ;
end

close figure   21 20 19 18 17 16 6 5 3 2 ;


