summary.mami<-function(object,string="--",...){

if(is.null(object$coefficients.s)==FALSE){object$coefficients.s <- round(object$coefficients.s,digits=6)}
if(is.null(object$coefficients.ma)==FALSE){object$coefficients.ma <- round(object$coefficients.ma,digits=6)}
if(is.null(object$coefficients.boot.s)==FALSE){object$coefficients.boot.s <- round(object$coefficients.boot.s,digits=6)}
if(is.null(object$coefficients.ma.boot)==FALSE){object$coefficients.ma.boot <- round(object$coefficients.ma.boot,digits=6)}

blank <- function(mymatrix){
kn<-rownames(mymatrix)
if(is.null(mymatrix)){mymatrix<-NULL} else {
mymatrix <- as.data.frame(mymatrix, row.names=make.names(rownames(mymatrix),unique=TRUE))
if(is.null(mymatrix)==TRUE){mymatrix<-mymatrix}else{ 
for(i in 1:dim(mymatrix)[1]){
if(all(mymatrix[i,]==1,na.rm=TRUE) | all(mymatrix[i,]==0,na.rm=TRUE) | all(mymatrix[i,] %in% c(NA,Inf,NaN,0,1))){mymatrix[i,]<-c(rep(string,length(mymatrix[i,])))}
}}
rownames(mymatrix)<-kn
}
return(mymatrix)
}
object$coefficients.s <- blank(object$coefficients.s)
object$coefficients.boot.s <- blank(object$coefficients.boot.s)
object$coefficients.ma <- blank(object$coefficients.ma)
object$coefficients.ma.boot <- blank(object$coefficients.ma.boot)
factor.cleaning<-function(mystring){
cf<-NULL
for(i in 1:length(mystring)){
if(substr(mystring[i],1,7)!="factor." & substr(mystring[i],1,7)!="factor("){cf<-c(cf,mystring[i])}
if(substr(mystring[i],1,7)=="factor."){
   if(object$setup[[6]]=="BIC+" & object$setup[[2]]!="cox"){
      cf<-c(cf, gsub("[(]$",")",gsub("[.]","(",paste(strsplit(mystring[i],"[.]")[[1]][1],strsplit(mystring[i],"[.]")[[1]][2],"",sep="."))))}else{
        cf<-c(cf, paste(strsplit(mystring[i],"[.]")[[1]][1],strsplit(mystring[i],"[.]")[[1]][2],"",sep="."))}
   } 
if(substr(mystring[i],1,7)=="factor(" & grepl(":",mystring[i])==FALSE){cf<-c(cf, paste(substr(mystring[i],1,nchar(strsplit(mystring[i],")")[[1]][1])),")",sep=""))}
}
cf
}



cat("\n")
MA<-NULL
if(is.null(object$coefficients.ma)==FALSE){
MA<-as.data.frame(object$coefficients.ma[,c(1,3,4)])
MA.title <- "Estimates for model averaging: \n\n"}
if(is.null(object$coefficients.ma.boot)==FALSE){
MA<-cbind(MA,object$coefficients.ma.boot[,2:3])
MA.title <- paste("Estimates for model averaging (based on",dim(object$boot.results[[2]])[1],"bootstrap samples):\n\n",sep=" ")
colnames(MA)[2:5]<-c("LCI","UCI","Boot LCI","Boot UCI")
}
if(is.null(object$variable.importance)==FALSE){
MA$VI<-NA
subset1<- match(names(object$variable.importance),factor.cleaning(rownames(MA)))
if(any(is.na(subset1)) & is.null(object$setup[[14]])==FALSE){
n1 <- names(object$variable.importance)[grepl(":", names(object$variable.importance))] 
mypaste <- function(x)paste(x, collapse = ":")
names(object$variable.importance)[grepl(":", names(object$variable.importance))] <- lapply(lapply(strsplit(n1, "[:]"), rev),mypaste)
subset1<- match(names(object$variable.importance),factor.cleaning(rownames(MA)))
}
MA$VI[subset1]<-round(object$variable.importance,digits=2)
MA[is.na(MA)]<-string
}
if((object$setup[[6]]=="BIC"|object$setup[[6]]=="BIC+") & (is.null(MA)==FALSE)){colnames(MA)[colnames(MA)=="VI"]<-"PEP"}

if(is.null(object$coefficients.ma)==FALSE){
cat(MA.title)
print(MA)
cat("\n")}
  
MS<-NULL
if(is.null(object$coefficients.s)==FALSE){
MS<-as.data.frame(object$coefficients.s[,c(1,3,4)])
MS.title <- "Estimates for model selection: \n\n"}
if(is.null(object$coefficients.boot.s)==FALSE){
MS<-cbind(MS,object$coefficients.boot.s[,2:3])
MS.title <- paste("Estimates for model selection (based on",dim(object$boot.results[[1]])[1],"bootstrap samples):\n\n",sep=" ")
colnames(MS)[2:5]<-c("LCI","UCI","Boot LCI","Boot UCI")
}
if(is.null(object$variable.importance)==FALSE){
MS$VI<-NA
subset2 <- match(names(object$variable.importance),factor.cleaning(rownames(MS)))
MS$VI[subset2]<-round(object$variable.importance,digits=2)
MS[is.na(MS)]<-"--"
}
if(object$setup[[6]]=="BIC"|object$setup[[6]]=="BIC+"){colnames(MS)[colnames(MS)=="VI"]<-"PEP"}


if(is.null(object$coefficients.s)==FALSE){
cat(MS.title)
print(MS)
cat("\n")}

if(is.null(object$setup[[18]])==FALSE){
cat("____________________\n")
cat(paste("The following variables have been excluded by screening:",paste(object$setup[[18]],collapse=" "),"\n"))
}

}