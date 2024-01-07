`include "regfile.h"

module regfile (

    /***时钟和复位***/
    input wire   clk, //时钟
    input wire   reset_, //异步复位(负逻辑)
    /***访问接口***/
    input wire [`AddrBus] addr, //地址
    input wire [`DataBus] d_in, //输入数据
    input wire            we_, //写入有效(负逻辑)
    output wire [`DataBus] d_out // 输出数据
);

    /***内部信号***/
    reg [`DataBus]   ff[`DATA_D-1:0];
    integer          i;

    /***读取访问***/
    assign d_out = ff[addr];

    /***写入访问***/
    always @(posedge clk or negedge reset_)begin
      if (reset_ == `ENABLE_) begin
        /*异步复位*/
        for(i=0; i<`DATA_D; i=i+1) begin
          ff[i]  <= #1 {`DATA_W{1'b0}};
        end
      end else begin
        /*写入访问*/
        if(we_ == `ENABLE_) begin
            ff[addr] <= #1 d_in;
        end
      end
    end 

endmodule