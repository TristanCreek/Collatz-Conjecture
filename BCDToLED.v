//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2017 05:15:39 PM
// Design Name: 
// Module Name: BCDToLED
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

module BCDToLED(
    input [3:0] in,
    output [6:0] segs
    );
    
    assign W = in[3];
    assign X = in[2];
    assign Y = in[1];
    assign Z = in[0];
    
    assign segs[0] = (X&(!Y)&(!Z)) | ((!W)&(!X)&(!Y)&Z);
    assign segs[1] = (X&(!Y)&Z) | (X&Y&(!Z));
    assign segs[2] = (!X&Y&!Z);
    assign segs[3] = ((!W)&(!X)&(!Y)&Z) | (X&(!Y)&(!Z)) | (X&Y&Z);
    assign segs[4] = Z | (X&(!Y));
    assign segs[5] = ((!W)&(!X)&Z) | ((!X)&Y) | (Y&Z);
    assign segs[6] = ((!W)&(!X)&(!Y)) | (X&Y&Z);
    
endmodule

