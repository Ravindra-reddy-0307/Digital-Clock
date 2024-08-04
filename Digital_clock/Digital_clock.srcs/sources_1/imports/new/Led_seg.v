`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2024 10:43:36
// Design Name: 
// Module Name: Segment_Generator
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


module Led_seg (input clk,input start,input [4:0]hrs, input[5:0] mins, input[5:0] secs, output reg [3:0]Anode, output reg [6:0]Cathode 
    );
      reg [3:0] LED_BCD;
    reg [13:0] refresh_counter=19'b0;
    wire [1:0] LED_activation_counter;

    always @(posedge clk) 
    begin
            refresh_counter <= refresh_counter + 1;
    end
     assign LED_activation_counter = refresh_counter[13:12];

always @(*)
    begin
    if(start==0)
    begin
        case(LED_activation_counter)
        2'b00: begin
            Anode = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = mins%10;
            // the first digit of the 16-bit number
              end
        2'b01: begin
            Anode = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = mins/10;
            // the second digit of the 16-bit number
              end
        2'b10: begin
            Anode = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = hrs%10;
            // the third digit of the 16-bit number
                end
        2'b11: begin
            Anode = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = hrs/10;
            // the fourth digit of the 16-bit number    
               end
        endcase
        end
        if(start==1)
        begin
        case(LED_activation_counter)
        2'b00: begin
            Anode = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = secs%10;
            // the first digit of the 16-bit number
              end
        2'b01: begin
            Anode = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = secs/10;
            // the second digit of the 16-bit number
              end
        2'b10: begin
            Anode = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = mins%10;
            // the third digit of the 16-bit number
                end
        2'b11: begin
            Anode = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = mins/10;
            // the fourth digit of the 16-bit number    
               end
        endcase
        end
    end
    
    always @(*)
    begin
        case(LED_BCD)
        4'b0000: Cathode= 7'b0000001; // "0"     
        4'b0001: Cathode= 7'b1001111; // "1" 
        4'b0010: Cathode= 7'b0010010; // "2" 
        4'b0011: Cathode= 7'b0000110; // "3" 
        4'b0100: Cathode= 7'b1001100; // "4" 
        4'b0101: Cathode= 7'b0100100; // "5" 
        4'b0110: Cathode= 7'b0100000; // "6" 
        4'b0111: Cathode= 7'b0001111; // "7" 
        4'b1000: Cathode= 7'b0000000; // "8"     
        4'b1001: Cathode= 7'b0000100; // "9" 
        default: Cathode= 7'b0000001; // "0"
        endcase
    end
endmodule