`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2025 13:05:21
// Design Name: 
// Module Name: uart_trans
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_trans(
input c,r,ee,
input [7:0] din,
output reg eo // encoder o/p
    );
 
 reg [2:0] count1;
reg [3:0] count2; 
 reg [11:0] sr;
 reg [1:0] sm;
 wire p;
 
 always @ (posedge c or negedge r)
 if (r==0) sm<=0; else
 case (sm)
 0 : if (ee==1) sm<=1;
 1 : if ((count1==5) && (count2==12)) sm<=0;
 
 endcase
 
always @ (posedge c or negedge r)
 if (r==0) count1<=0; else
 case (sm)
 0 : count1<=0;
 1 : if (count1==5) count1<=0; else count1<=count1+1; // divide by 6 counter
 endcase
 
 always @ (posedge c or negedge r)
 if (r==0) count2<=0; else
 case (sm)
 0 : count2<=0;
 1 : if (count1==5) count2<=count2+1;
 
 endcase
    
always @ (posedge c or negedge r)
 if (r==0) sr<=12'hfff; else 
 if (ee==1) sr<={2'b11,p,din,1'b0}; else
 if (count1==5) sr<={1'b1,sr[11:1]};
 
 always @ (posedge c or negedge r)
 if (r==0) eo<=1; else
 if (count1==5) eo<=sr[0];
    
 assign p=~(^din);   
    
    
endmodule
