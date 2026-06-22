module fir_da(input clk,rst,
              input [9:0]x0,
              output reg [21:0]y);

reg [9:0]r1,r2,r3,r4,r5,r6,r7,r8,r9,r10, rl1, r12, r13, r14, r15, r16;
reg [12:0]temp;
reg [21:0]calc;
reg [3:0]count;
reg load;


    always @ (posedge clk, posedge rst) begin
    if (rst)
    begin
     {r1,r2,r3,r4,r5,r6,r7,r8,r9,r10, rl1, r12, r13, r14, r15, r16}=0;
     temp = 0;
     calc = 0;
     count = 0; 
     load =1;
     Y = 0;
    end
    else
    begin
        if(load)
        begin
         r1 <= x0;
         r2 <= r1;
         r3 <= r2;
         r4 <= r3;
         r5 <= r4;
         r6 <= r5;
         r7 <= r6;
         r8 <= r7;
         r9 <= r8;
         r10 <= r9;
         r11 <= r10;
         r12 <= r11;
         r13 <= r12;
         r14 <= r13;
         r15 <= r14;
         r16 <= r15;
         load = 0; 
         count = 0;
        end
        else begin
          temp = block1Value( r1[count],r2 [count], r3 [count], r4 [count])+
          block2Value( r5[count], r6 [count], r7[count], r8 [count])+
          block2Value(r12[count], r11[count], r10 [count], r9 [count])+
          block1Value(r16 [count], r15 [count] , r14 [count], r13 [count]);
        if ((count == 4'b1001) &&
              (r1[count]  || r2[count]  || r3[count]  || r4[count]  ||
              r5[count]  || r6[count]  || r7[count]  || r8[count]  ||
              r12[count] || r11[count] || r10[count] || r9[count]  ||
              r16[count] || r15[count] || r14[count] || r13[count]))
            begin
              calc = calc + (~(temp << count) + 1); //for nagative numbers checks msb if its 1 then it'll subtract
            end
        else
            calc = calc + (temp << count);
        if (calc[12] == 1'b1)
            calc[21:13] = 9'b111111111;
        else
            calc[21:13] = 9'b000000000;
        if (count == 4'b1001)
        begin
            y    = calc;
            calc = 0;
            temp = 0;
            load = 1;
        end
        else
            count = count + 1;
        end
    end
    end

        
input a1,a2,a3,a4;
begin
case ( {a1, a2, a3, a4} )
4'b0000 : block1Value = 13'b0000000000000;
4'b0001 : block1Value = 13'b1111111110100;
4'b0010 : block1Value = 13'b1111111111110;
4'b0011 : block1Value = 13'b1111111110010;
4'b0100 : block1Value = 13'b0000000010110;
4'b0101 : block1Value = 13'b0000000001001;
4'b0110 : block1Value = 13'b0000000010011;
4'b0111 : block1Value = 13'b0000000000111;
4'b1000 : block1Value = 13'b0000000001000;
4'b1001 : block1Value = 13'b1111111111100;
4'b1010 : block1Value = 13'b0000000000111;
4'b1011 : block1Value = 13'b1111111111011;
4'b1100 : block1Value = 13'b0000000011100;
4'b1101 : block1Value = 13'b0000000010001;
4'b1110 : block1Value = 13'b0000000011010;
4'b1111 : block1Value = 13'b0000000010000;
default : block1Value = 13'b0000000000000;
endcase
end
endfunction


function [12:0] block2Value;
    input b1, b2, b3, b4;
begin
    case ({b1,b2,b3,b4})
        4'b0000 : block2Value = 13'b0000000000000;
        4'b0001 : block2Value = 13'b0000010010100;
        4'b0010 : block2Value = 13'b1111111110011;
        4'b0011 : block2Value = 13'b0000010111000;
        4'b0100 : block2Value = 13'b1111111101110;
        4'b0101 : block2Value = 13'b0000010000010;
        4'b0110 : block2Value = 13'b1111110000000;
        4'b0111 : block2Value = 13'b0000001110100;
        4'b1000 : block2Value = 13'b0000000010110;
        4'b1001 : block2Value = 13'b00000011001001;
        4'b1010 : block2Value = 13'b0000000001000;
        4'b1011 : block2Value = 13'b0000010011000;
        4'b1100 : block2Value = 13'b0000000000100;
        4'b1101 : block2Value = 13'b0000010010110;
        4'b1110 : block2Value = 13'b1111111110100;
        4'b1111 : block2Value = 13'b0000010001010;
        default : block2Value = 13'b0000000000000;
    endcase
end
endfunction
