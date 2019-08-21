load fisheriris
X = meas;
Y = species;
Mdl = fitcecoc(X,Y)
Mdl.ClassNames
CodingMat = Mdl.CodingMatrix
Mdl.BinaryLearners{1}
error = resubLoss(Mdl)