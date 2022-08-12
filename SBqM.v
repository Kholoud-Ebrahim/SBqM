module SBqM (PhotocellEnter, PhotocellLeave, clk, rst, Pcount, Wtime, Tcount, FullFlag, EmptyFlag);
parameter N=3 ;
input PhotocellEnter, PhotocellLeave, clk, rst ;
input [1:0]Tcount;
output [N+1:0]Wtime;   // highest value 3(7+3-1)/3=9 --> 4bits
output [N-1:0] Pcount;
output reg FullFlag, EmptyFlag;
wire Enter, Leave;
assign Enter= ~PhotocellEnter;
assign Leave= ~PhotocellLeave;

UpDownCounter UDC1(Enter, Leave, rst, Pcount);
LUT   LUT1(.Adress({Pcount, Tcount}), .Wtime(Wtime)); 
always @(posedge rst or posedge Enter or posedge Leave) begin
    //initially:empty=1, full=0
    if (rst) begin 
		FullFlag = 0; 
		EmptyFlag = 1; 
	end  
    // Pcount max , full=1
    else if (Pcount==2**N-1)      
		FullFlag = 1;
    // Pcount min , empty=1
    else if  (Pcount==0)           
		EmptyFlag= 1;
    //any other state
    else begin 
		FullFlag = 0; 
		EmptyFlag= 0; 
	end
end
endmodule 

