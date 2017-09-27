

% Moore's Algorithm for 1||Ui
% Nuwan Jaliyagoda
% Last Update : 27/09/2017

clc;

pj = [7 8 4 6 6];       %input('Enter Pj as row vector: ');
dj = [9 17 18 19 23];   %input('Enter Dj as row vector: ');

N = length(pj); % Number of jobs
j = 1:N;
disp('Pj :');disp(pj);
disp('Dj :');disp(dj);

J=1; PJ=2;DJ=3;CJ=4;LJ=5;

sch_unsorted = [j;pj;dj;cj;lj];
sch = sortrows(sch_unsorted',3)';  % Sort accoriding to EDD

disp('    Sorted according to EED :');
disp('    j    Pj    Dj    Cj    Lj');
disp(sch');

for cycle =  1:N-1
   disp('-----------------------------------------');
   % Calculate Cj, Lj
   t = 0;
   for i=1:(N+1-cycle)
       t = t + sch(PJ,i); 
       sch(CJ,i) = t;
       sch(LJ,i) = sch(CJ,i) - sch(DJ,i); %  Cj - Dj
   end
   
   fprintf('Cj calculated on first %d jobs',N+1-cycle);
   disp('    j    Pj    Dj    Cj    Lj');
   disp(sch');
   
   T =0;
   for i=1:(N+1-cycle)
       if(sch(LJ,i)>0)
           % First tardy job
           T = i;
           break;
       elseif i == (N+1-cycle)
           % No tardy jobs founded 
           T  = (N+1-cycle);
       end
   end
       
   if T == (N+1-cycle)
       % End of the processing, if there no any tardy job remaining
       break;
   end
   
   % Find largest processing time before T
   if T>0
       % M is the job which has maximum Pj
       [a,M] = max(sch(PJ,1:T));
       
       % Shift Mth one to end
       temp = sch(:,M);
       sch(:,M) = [];
       sch(:,N) = temp;
   end
   
   disp('After job order changed:');
   disp('    j    Pj    Dj    Cj    Lj');
   disp(sch');
end

t=0;
for i=1:N
       t = t + sch(PJ,i); 
       sch(CJ,i) = t;
       sch(LJ,i) = sch(CJ,i) - sch(DJ,i); %  Cj - Dj
end

disp('-----------------------------------------');
disp('Final result :');
disp('    j    Pj    Dj    Cj    Lj');
disp(sch');

disp('Job Schedule');

jobList = sch(J,:);
disp(jobList);



