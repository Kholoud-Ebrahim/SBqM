module UpDownCounter (Enter, Leave, rst, Pcount);
parameter N=3;
input Enter, Leave, rst;
output reg [N-1:0]Pcount; //Pcount max value is (7=3'b111) which needs 3 bits

always @(posedge rst or posedge Enter or posedge Leave) begin
    if (rst) 
		Pcount =0;
		
    // client entered and at the same time another client left
    else if (Enter && Leave)             
		Pcount = Pcount;   
		
    // client entered and Pcount doesn't reach the max (7)
    else if (Enter && ~(Pcount==2**N-1)) 
		Pcount = Pcount +1; 
		
    // client left and Pcount doesn't reach the min (0)
    else if (Leave &&   Pcount)         
		Pcount = Pcount -1;
		
    //any other state
    else                                 
		Pcount = Pcount;
end
endmodule 