`timescale 1ns/1ps
`include "regfile.h"

module regfile_test;
    /**输入输出端口信号**/
    //时钟&复位
    reg    clk;
    reg    reset_;
    //访问接口
    reg  [`AddrBus] addr;
    reg  [`DataBus] d_in;
    reg             we_;
    wire [`DataBus] d_out;

    /**内部变量**/
    integer         i;
    /**定义仿真循环**/
    parameter       STEP = 100.0000;  //10M

    /***生成时钟***/
    always #(STEP/2) begin
      clk <= ~clk;
    end

    /**实例化测试模块**/
    regfile regfile(
        .clk(clk),
        .reset_(reset_),
        .addr(addr),
        .d_in(d_in),
        .we_(we_),
        .d_out(d_out)
    );

    /**测试用例**/
    
    initial begin
      //初始化信号
      #0 begin
        clk <= `HIGH;
        reset_ <= `ENABLE_;
        addr  <= {`ADDR_W{1'b0}};
        d_in <= {`DATA_W{1'b0}};
        we_ <= `DISABLE_;
      end
      
      # (STEP*3/4)
      //解除复位
      # STEP begin
        reset_ <= `DISABLE_;
      end
      //读写验证
      # STEP begin
        for (i=0;i<`DATA_D;i=i+1)begin
            # STEP begin
              addr <=i;
              d_in <=i;
              we_ <= `ENABLE_;
            end
            # STEP begin
              addr <= {`ADDR_W{1'b0}};
              d_in <= {`DATA_W{1'b0}};
              we_  <= `DISABLE_;
              if(d_out ==i ) begin
                $display($time," ff[%d] Read/Write Check OK!",i);
              end else begin
                $display($time," ff[%d] Read/Write Check NG!",i);
              end
            end
        end
      end
      //结束仿真
      # STEP begin
        $finish;
      end
    end

    /**输出波形**/
    initial begin
      $dumpfile("regfile.vcd");
      $dumpvars(0,regfile);
    end
endmodule