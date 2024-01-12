`timescale 1ns / 1ps

module tb_dolphin_counter();
reg clk, reset_n, count_en, load;
reg [2:0] count_to;
wire done;

// Bi?n ?? ghi l?i th?i gian
integer start_time, end_time, done_active_time;
integer i;

dolphin_counter A (clk, reset_n, count_to, count_en, load, done);

initial begin
    // Kh?i t?o các giá tr? ban ??u
    clk = 1;
    reset_n = 0;
    load = 0;
    count_en = 1;
    count_to = 3'b111; // B?t ??u t? 3b111

    // ??t các tr?ng thái ban ??u
    #160 reset_n = 1;

    // Vòng l?p gi?m d?n count_to t? 3b111 xu?ng 3b000
    for (i = 7; i >= 0; i = i - 1) begin
        count_to = i[2:0]; // C?p nh?t giá tr? count_to
        #40 load = 1;
        #80 load = 0;
        start_time = $time; // Ghi l?i th?i gian b?t ??u
        // ??i chân done chuy?n sang 1
        wait (done == 1'b1);
        end_time = $time; // Ghi l?i th?i gian khi done chuy?n sang 1
        done_active_time = end_time - start_time; // Tính th?i gian ho?t ??ng c?a done
        $display("Time for done to become %d: %d ns in %d",count_to, done_active_time, (done_active_time + 60)/80);

        // D?ng mô ph?ng
        #100 $stop;
    end
    // D?ng mô ph?ng sau khi hoàn thành
end
// T?o xung ??ng h? liên t?c
always #40 clk = ~clk;

endmodule


//`timescale 1ns / 1ps

//module tb_dolphin_counter();

//reg clk, reset_n, count_en, load;
//reg [2:0] count_to;
//wire done;

//// Bi?n ?? ghi l?i th?i gian
//integer start_time, end_time, done_active_time;
//integer i;

//dolphin_counter A (clk, reset_n, count_to, count_en, load, done);

//initial begin
//    // Kh?i t?o các giá tr? ban ??u
//    clk = 1;
//    reset_n = 0;
//    load = 0;
//    count_en = 1;
//    count_to = 3'b011; // B?t ??u t? 3b011

//    // ??t các tr?ng thái ban ??u
//    #160 reset_n = 1;
//    #200 load = 1;
//    #40 load = 0;
//    #40 count_en = 0;
//    #80 count_en = 1;

//    $display("Count_en in 1 Clock");

//    // ??t các tr?ng thái ban ??u
//    #160 reset_n = 1;
//    #40 load = 1;
//    #80 load = 0;
//    #40 reset_n = 0;
//    #40 reset_n = 1;
    
//    $display("Reset_n in 1 Clock");

//    // ??t các tr?ng thái ban ??u
//    #300 reset_n = 1;
//    #40 load = 1;
//    #80 load = 0;
//    #40 load = 1;
//    #40 load = 0;
    
//    $display("Load in 1 Clock");
    
//    // D?ng mô ph?ng
//    #500 $stop;

//    // D?ng mô ph?ng sau khi hoàn thành
//end

//// T?o xung ??ng h? liên t?c
//always #40 clk = ~clk;

//endmodule
