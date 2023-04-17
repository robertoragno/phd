data{
    int<lower=0> J;
    array[J] int N;
    array[J] int A;
    array[J] int Century;
}
parameters{
     vector[12] a;
     // real<lower=0> phi;
     array[12] real<lower=2> theta;
}
model{
    vector[J] pbar;
    a ~ normal(0, 1.5);
    theta ~ exponential(1);
    for ( i in 1:J ) {
        pbar[i] = a[Century[i]];
        pbar[i] = inv_logit(pbar[i]);
    }
    
    vector[J] theta_l;
    vector[J] pbar_l;
    vector[J] beta_c;
    for ( i in 1:J ) {
        theta_l[i] = theta[Century[i]];
        pbar_l[i] = pbar[i]*theta_l[i];
        beta_c[i] = (1 - pbar[i]) * theta_l[i];
    }
    target += beta_binomial_lupmf(A | N, pbar_l, beta_c);
}
