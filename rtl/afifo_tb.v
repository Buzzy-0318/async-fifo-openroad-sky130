`timescale 1ns / 1ps
module afifo_tb;

  parameter DSIZE = 8;
  parameter ASIZE = 4;
  parameter N     = 10;     

  reg                  wclk, wrstn, wren;
  reg  [DSIZE-1:0]     wdata;
  wire                 wfull;

  reg                  rclk, rrstn, rden;
  wire [DSIZE-1:0]     rdata;
  wire                 rempty;

  reg [DSIZE-1:0] expected [0:N-1];
  integer errors   = 0;
  integer read_idx = 0;
  integer i;

  afifo #(.dsize(DSIZE), .asize(ASIZE)) dut (
    .wclk   (wclk),
    .wrstn  (wrstn),
    .wren   (wren),
    .wdata  (wdata),
    .wfull  (wfull),
    .rclk   (rclk),
    .rrstn  (rrstn),
    .rden   (rden),
    .rdata  (rdata),
    .rempty (rempty)
  );

 
  initial wclk = 0;
  always #5 wclk = ~wclk;     

  initial rclk = 0;
  always #7 rclk = ~rclk;     

  initial begin
    $dumpfile("afifo_tb.vcd");
    $dumpvars(0, afifo_tb);
  end


  always @(posedge rclk) begin
    if (rrstn && rden && !rempty) begin
      if (rdata !== expected[read_idx]) begin
        $display("[%0t] FAIL idx=%0d expected=%0h got=%0h", $time, read_idx, expected[read_idx], rdata);
        errors = errors + 1;
      end else begin
        $display("[%0t] PASS idx=%0d data=%0h", $time, read_idx, rdata);
      end
      read_idx = read_idx + 1;
    end
  end

 
  initial begin
    wrstn = 0; wren = 0; wdata = 0;
    rrstn = 0; rden = 0;

    repeat (3) @(posedge wclk);
    repeat (3) @(posedge rclk);
    wrstn = 1;
    rrstn = 1;
    @(posedge wclk);
    #1;
    $display("After reset: wfull=%b rempty=%b (expect 0,1)", wfull, rempty);

   
    for (i = 0; i < N; i = i + 1) begin
      expected[i] = $random;
      @(negedge wclk);
      wdata = expected[i];
      wren  = 1;
    end
    @(negedge wclk);
    wren = 0;

    repeat (5) @(posedge rclk);   
    $display("After %0d writes: wfull=%b rempty=%b", N, wfull, rempty);

  
    for (i = 0; i < N; i = i + 1) begin
      @(negedge rclk);
      rden = 1;
    end
    @(negedge rclk);
    rden = 0;

    repeat (4) @(posedge rclk);
    $display("After %0d reads: wfull=%b rempty=%b (expect 0,1)", N, wfull, rempty);

    if (errors == 0)
      $display("\n*** BASIC TEST PASSED (%0d/%0d words matched) ***", N, N);
    else
      $display("\n*** BASIC TEST FAILED: %0d / %0d mismatches ***", errors, N);

    $finish;
  end

  // watchdog
  initial begin
    #20000;
    $display("ERROR: TIMEOUT - simulation hung");
    $finish;
  end

endmodule
