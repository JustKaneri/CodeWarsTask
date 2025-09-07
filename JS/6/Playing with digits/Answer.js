function digPow(n, p){
  let str = ""+n;
  let sum = 0;
  
  for(let i = 0 ; i < str.length; i++){
      sum += Math.pow(parseInt(str[i],10),p);
      p++;
  }
  
  if(sum%n == 0)
    return sum / n;
  else 
    return -1;
}