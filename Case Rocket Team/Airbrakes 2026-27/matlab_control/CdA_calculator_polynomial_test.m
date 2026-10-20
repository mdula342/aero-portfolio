clear;
clc;
close all;

load("CdA_calculator_polynomial.mat")

CdA_0 = 0.008;
CdA_1 = 0.03;
CdAs = linspace(CdA_0, CdA_1, 100);

X_test = [449.0790; -214.3062];

CdA = CdA_calculator_polynomial(X_test, CdAs, poly_coeffs);

