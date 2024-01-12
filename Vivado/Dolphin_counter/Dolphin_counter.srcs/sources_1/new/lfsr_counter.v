module dolphin_counter (clk, reset_n, count_to, count_en, load, done);

input [2:0] count_to; 
input clk, reset_n, count_en, load;
output reg done;
reg [2:0] count, count_next, count_mux;
reg pre_done = 0;


// 2 Mux 2-1
always @(*)
begin
    if (count_en == 1'b1)
        if  (count != 1'b0)   
                count_mux = count - 1;
         else
            count_mux = count;
    else
        count_mux = count;
end

// Mux 4-1
always @ (*)
begin
    case ({count_en, load})
        2'b00 : count_next = count;
        2'b01 : count_next = count_to;
        2'b10 : count_next = count_mux;
        2'b11 : count_next = count_to;
        default: count_next = 3'b111;
    endcase
end

// count Flip-Flop
always @(posedge clk or negedge reset_n)
begin
    if (reset_n == 0) count <=  3'b111;
    else count <= count_next;
end

// Check done
always @(count_next)
begin
    if (count_next == 3'b000) pre_done <= 1;
    else pre_done <= 0;
end
// Done Flip-Flop
always @(posedge clk or negedge reset_n)
begin
    if (reset_n == 0) done <= 0;
    else done <= pre_done;
end

endmodule
