// 3000 ps
`timescale 1ps/1ps
module TestBenchSBqM;
parameter n=3;
reg PhotocellEnter, PhotocellLeave;
reg clk, rst;
reg  [1:0]Tcount;
wire [n+1:0]Wtime;   
wire [n-1:0] Pcount;
wire FullFlag, EmptyFlag;

SBqM  S1(PhotocellEnter, PhotocellLeave, clk, rst, Pcount, Wtime, Tcount, FullFlag, EmptyFlag);

initial begin
    clk= 0;
    forever #50 clk = ~clk;
end 

initial begin
    Tcount=1;
    $display("Number of Tellers = %d\n",Tcount);
    //reset to initialize all values
            rst=1; 
            PhotocellEnter=1; 
            PhotocellLeave=1; 
            #100; 
            rst=0; 
            #100;
    //2 client entered in 70 sec
    repeat(2) begin     
            PhotocellEnter=0;   
            PhotocellLeave=1; 
            #70;    
            PhotocellEnter=1;   
            PhotocellLeave=1; 
            #30;
            end
    //1 client entered in 150 sec    
            PhotocellEnter=0;   
            PhotocellLeave=1; 
            #150;    
            PhotocellEnter=1;   
            PhotocellLeave=1; 
            #50;
    //1 client left in 50 sec  
            PhotocellEnter=1;   
            PhotocellLeave=0; 
            #50;    
            PhotocellEnter=1;   
            PhotocellLeave=1; 
            #150;
    // 1 entered and 1 left at the same time within 90 sec
            PhotocellEnter=0;   
            PhotocellLeave=0; 
            #90;    
            PhotocellEnter=1;   
            PhotocellLeave=1; 
            #10;            
    //reset to re initialize values
            rst=1; 
            PhotocellEnter=1; 
            PhotocellLeave=1; 
            #100; 
            rst=0; 
            #100;       
    //full flag
    repeat(8) begin
            PhotocellEnter=0;   
            PhotocellLeave=1; 
            #90;    
            PhotocellEnter=1;   
            PhotocellLeave=1; 
            #10;            
            end
    // Pcount max , client entered  for warning message
            PhotocellEnter=0;   
            PhotocellLeave=1; 
            #90;    
            PhotocellEnter=1;   
            PhotocellLeave=1; 
            #10;
    //empty flag
    repeat(8) begin
            PhotocellEnter=1;   
            PhotocellLeave=0; 
            #90;    
            PhotocellEnter=1;   
            PhotocellLeave=1; 
            #10;
            end
    // Pcount min , client left  for warning message
            PhotocellEnter=1;   
            PhotocellLeave=0; 
            #90;    
            PhotocellEnter=1;   
            PhotocellLeave=1; 
            #10;  
	
	//Warning Message: Pcount max , client entered 
    if  ((Pcount==7)&&(PhotocellEnter==0))  
		$warning("Sorry, The queue is full please wait for some time.");
    //Warning Message: Pcount min , client left 
    else if  ((Pcount==0)&&(PhotocellLeave==0))  
		$warning("The queue is empty. ");
end

initial begin
    $monitor("time= %5d   PhotocellEnter= %b   PhotocellLeave= %b   Clients Number = %d   waiting time= %d   Full Flag= %d   Empty Flag= %d \n",$time,PhotocellEnter,PhotocellLeave,Pcount,Wtime,FullFlag,EmptyFlag);
 /* $display("Number of clients in the queue = %d",Pcount);
    $display("waiting time in the queue = %d",Wtime);
    $display("Full Flage = %d",FullFlag); 
    $display("Empty Flage = %d\n",EmptyFlag); */
	

end
endmodule