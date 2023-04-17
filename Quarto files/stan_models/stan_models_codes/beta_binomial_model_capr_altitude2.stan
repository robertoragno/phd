data{
    int<lower=0> J;
    array[J] int N;
    array[J] int A;
    array[J] int Chr_id;
    array[J] int Alt;
}
parameters{
     vector[4] a;
     vector[4] b;
     // real<lower=0> phi;
     array[4] real<lower=2> theta;
}
model{
    vector[J] pbar;
    theta ~ exponential(1);
    for ( i in 1:J ) {
        pbar[i] = a[Chr_id[i]] + b[Chr_id[i]]*(Alt[i]/1000);
        pbar[i] = inv_logit(pbar[i]);
    }
    a ~ normal(0,1.5);
    b ~ normal(0,1.5);
    vector[J] theta_l;
    vector[J] pbar_l;
    vector[J] beta_c;
    for ( i in 1:J ) {
        theta_l[i] = theta[Chr_id[i]];
        pbar_l[i] = pbar[i]*theta_l[i];
        beta_c[i] = (1 - pbar[i]) * theta_l[i];
    }
    target += beta_binomial_lupmf(A | N, pbar_l, beta_c);
}
