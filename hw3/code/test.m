load fisheriris;
sp = categorical(species)
[B,dev,stats] = mnrfit(meas,sp);