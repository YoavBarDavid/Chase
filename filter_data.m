function [ filtered_data ] = filt_low( fps,f_cutoff,data )
%filt_low( fps,f_cutoff,data ) Filters using 'low-pass'
%   fps - Filming frequency, f_cutoff - the low threshold, data - data to
%   be filtered.

% filter digitized data
fnorm = f_cutoff/(fps/2);
[b1,a1] = butter(5,fnorm,'low');
%[b1,a1] = butter(3,fnorm,'high');
filtered_data = filtfilt(b1,a1,data);      
end
 
 