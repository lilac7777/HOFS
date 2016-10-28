function [] = vertdata()
filename = 'waveform.data';
f = fopen(filename);
Nsample = 5000;
for i = 1: Nsample
    line = fgetl(f);
    data = regexp(line, ',', 'split');
   % data = data(1:end-1);
  %  data{end} = data{end}(1);
    for j = 1:length(data)-1
 tmp=1;
 %for j = 1:length(data{3})
        d(i,j) = str2num(data{j});
%           if data{3}(j) == 'T'
%              d(i,tmp) = 0;tmp = tmp+1;
%          elseif data{3}(j) == 'A'
%              d(i,tmp) = 1;tmp = tmp+1;
%          elseif data{3}(j) == 'G'
%              d(i,tmp) = 2;tmp = tmp+1;
%          elseif data{3}(j) == 'C'
%              d(i,tmp) = 3;tmp = tmp+1;
% %          elseif data{j} == 'n'
% %              d(i,j) = 4;
% %         elseif data{j} == 'w'
% %             d(i,j) = 5;
% %         elseif data{j} == 'b'
% %             d(i,j) = 6;
%           end
%     end
%      if strcmp(data{1},'EI')
%          label(i) = 1;
%      elseif strcmp(data{1},'IE')
%          label(i) = 2;
%      else
%          label(i) = 0;
      end
    label(i) = str2num(data{end});
    disp(i);
end
data =d;
label = label';
end