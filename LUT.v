module LUT(Adress, Wtime);
parameter N=3;
input  [N+1:0]Adress; 
output [N+1:0]Wtime;
wire [N+1:0]ROM [0:31]; 


//     00000         00001      	      00010         	   00011
assign ROM[0]= 0;    assign ROM[1]= 0;    assign ROM[2]= 0;    assign ROM[3]= 0; 

//     00100         00101      	      00110     	       00111
assign ROM[4]= 0;    assign ROM[5]= 3;    assign ROM[6]= 3;    assign ROM[7]= 3;

//     01000         01001     		      01010         4.5    01011                  
assign ROM[8]= 0;    assign ROM[9]= 6;    assign ROM[10]= 4;   assign ROM[11]= 4;

//     01100         01101        		  01110       		   01111  
assign ROM[12]= 0;   assign ROM[13]= 9;   assign ROM[14]= 6;   assign ROM[15]= 5;

//     10000         10001         		  10010   		7.5    10011  
assign ROM[16]= 0;   assign ROM[17]= 12;  assign ROM[18]= 7;   assign ROM[19]= 6;

//     10100         10101      	      10110   		       10111  
assign ROM[20]= 0;   assign ROM[21]= 15;  assign ROM[22]= 9;   assign ROM[23]= 7;  

//    11000          11001        		  11010  	    10.5   11011  
assign ROM[24]= 0;   assign ROM[25]= 18;  assign ROM[26]= 10;  assign ROM[27]= 8; 
    
//    11100          11101        		  11110      		   11111      
assign ROM[28]= 0;   assign ROM[29]= 21;  assign ROM[30]= 12;  assign ROM[31]= 9;      

assign Wtime = ROM[Adress];

endmodule