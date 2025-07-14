`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2025 11:09:46 AM
// Design Name: 
// Module Name: rca
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


module fa(
input a,b,cin,
output s,cout
    );
    
    assign s=a^b^cin;
    assign cout=a&b|b&cin|a&cin;
    
endmodule


module rca(
input a0,a1,a2,a3,
input b0,b1,b2,b3,
input c0,
output c4,
output s0,s1,s2,s3

);
wire c1,c2,c3;
fa f1 (a0,b0,c0,s0,c1);
fa f2 (a1,b1,c1,s1,c2);
fa f3 (a2,b2,c2,s2,c3);
fa f4 (a3,b3,c3,s3,c4);
endmodule


//testbench for simulation
`timescale 1ns / 1ps

module rca_tb;

    // Inputs
    reg a0, a1, a2, a3;
    reg b0, b1, b2, b3;
    reg c0;

    // Outputs
    wire s0, s1, s2, s3;
    wire c4;

    // Instantiate the RCA
    rca uut (
        .a0(a0), .a1(a1), .a2(a2), .a3(a3),
        .b0(b0), .b1(b1), .b2(b2), .b3(b3),
        .c0(c0),
        .c4(c4),
        .s0(s0), .s1(s1), .s2(s2), .s3(s3)
    );

    // Test stimulus
    initial begin
        $display("Time\tA\t\tB\t\tCin\tSum\t\tCout");
        $monitor("%0t\t%b%b%b%b\t%b%b%b%b\t%b\t%b%b%b%b\t%b", 
                  $time, a3, a2, a1, a0, b3, b2, b1, b0, c0,
                  s3, s2, s1, s0, c4);

        // Test 1: 0000 + 0000 + 0 = 0000, carry=0
        a3=0; a2=0; a1=0; a0=0;
        b3=0; b2=0; b1=0; b0=0;
        c0=0; #10;

        // Test 2: 0001 + 0001 + 0 = 0010, carry=0
        a3=0; a2=0; a1=0; a0=1;
        b3=0; b2=0; b1=0; b0=1;
        c0=0; #10;

        // Test 3: 1111 + 0001 + 0 = 0000, carry=1
        a3=1; a2=1; a1=1; a0=1;
        b3=0; b2=0; b1=0; b0=1;
        c0=0; #10;

        // Test 4: 1010 + 0101 + 1 = 1111, carry=0
        a3=1; a2=0; a1=1; a0=0;
        b3=0; b2=1; b1=0; b0=1;
        c0=1; #10;

        // Test 5: 1111 + 1111 + 1 = 1111, carry=1
        a3=1; a2=1; a1=1; a0=1;
        b3=1; b2=1; b1=1; b0=1;
        c0=1; #10;

        $finish;
    end

endmodule


      
