library(data.table)

ff = fread("../Experiment_Platform/topic_test.csv")


tmp_all = NULL

for(i in 1:1000){
  
  print(i)
  
  # random idx
  idx = sample(1:nrow(ff), 2)
  
  
  ff_p1 = ff[idx[1]] %>% unlist()
  ff_p2 = ff[idx[2]] %>% unlist()
  
  
  
  key_p1 = sample(ff_p1[-1], 6)
  key_p2 = setdiff(ff_p2[-1], ff_p1[-1]) %>% sample(1)
  
  key = c(key_p1, key_p2) %>% sample()
  
  tmp = data.table(topic = ff_p1[1],
                   as.data.table(t(key)),
                   answer = key_p2,
                   answer2 = which(key %in% key_p2))
  names(tmp)[2:8] = paste0("keyword_", 1:7)
  
  tmp_all = rbind(tmp_all, tmp)
}


fwrite(tmp_all, 'test_1.csv')
