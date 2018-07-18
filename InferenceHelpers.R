# various illustrations of issues in statistics

# small sample size, type I error, and effect-size

all_df<-data.frame()
for(sim in 1:1000){
  for(n in c(10,20,50,100,1000)){
    some_data<-rnorm(n,0,1)
    p_value<-t.test(some_data)$p.value
    effect_size<-mean(some_data)/sd(some_data)
    t_df<-data.frame(sim=i,sample_size=n,p_value,effect_size)
    all_df<-rbind(all_df,t_df)
  }
}

type_I_error <-all_df[all_df$p_value<.05,]
type_I_error$sample_size<-as.factor(type_I_error$sample_size)

ggplot(type_I_error,aes(x=p_value,y=effect_size, group=sample_size,color=sample_size))+
  geom_point()+
  theme_classic()+
  ggtitle("Effect sizes for type I errors")
  

plot(all_df[all_df$p_value<.05,]$p_value,abs(all_df[all_df$p_value<.05,]$effect_size))


# small sample size, type I error, and effect-size

all_df<-data.frame()
n<-10
for(sim in 1:1000){
  #for(n in c(10,20,50,100,1000)){
    some_data<-rnorm(n,0,1)
    p_value<-t.test(some_data)$p.value
    effect_size<-mean(some_data)/sd(some_data)
    t_df<-data.frame(sim=i,sample_size=n,p_value,effect_size)
    all_df<-rbind(all_df,t_df)
  #}
}

type_I_error <-all_df
type_I_error$sample_size<-as.factor(type_I_error$sample_size)

ggplot(type_I_error,aes(x=p_value,y=effect_size,color=sample_size))+
  geom_point()+
  theme_classic()+
  ggtitle("Effect sizes for type I errors")


## improving grades

n=40
mean_difference<-length(10000)
for(i in 1:10000){
  pop_scores<-rnorm(1000,75,20)
  pop_scores<-pop_scores[pop_scores<100]
  A<-pop_scores[1:n]
  B<-pop_scores[n+1:n*2]
  mean_difference[i]<-mean(A)-mean(B)
}
t_df<-data.frame(sims=1:10000,mean_difference)
sorted_md<-sort(mean_difference)
lower<-sorted_md[10000*.025]
upper<-sorted_md[10000*.975]

ggplot(t_df,aes(x=mean_difference))+
  geom_histogram(bins=50,color="white")+
  geom_vline(xintercept=lower)+
  geom_vline(xintercept=upper)

## real scores
library(data.table)
scores_df<-fread(file="~/Desktop/finalscores.csv")
ggplot(scores_df,aes(x=score))+
  geom_histogram(color="white")+
  facet_wrap(~year)

aggregate(score~year,scores_df,mean)

hist(scores_df$score)
mean(scores_df$score)
sd(scores_df$score)

#use test scores
scores<-scores_df$score
n=100
mean_difference<-length(10000)
for(i in 1:10000){
  A<-sample(scores,n,replace=T)
  B<-sample(scores,n,replace=T)
  mean_difference[i]<-mean(A)-mean(B)
}
t_df<-data.frame(sims=1:10000,mean_difference)
sorted_md<-sort(mean_difference)
lower<-sorted_md[10000*.025]
upper<-sorted_md[10000*.975]

ggplot(t_df,aes(x=mean_difference))+
  geom_histogram(bins=50,color="white")+
  geom_vline(xintercept=lower)+
  geom_vline(xintercept=upper)