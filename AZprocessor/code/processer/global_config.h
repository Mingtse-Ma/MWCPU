//定义有可能变化的参数，如复位信号的极性可能随着使用端口的不同而不同。
//定义选择使用的I/O
`ifndef __CONFIG_HEADER__ //包含文件防范
    `define __CONFIG_HEADER__

    /**复位信号极性的选择**/
    `ifdef POSITIVE_RESET
        /**高电平复位**/
        `define RESET_EDGE posedge //复位信号边沿
        `define RESET_ENABLE 1'b1  //复位有效
        `define RESET_DISABLE 1'b0 //复位无效
        `define MEM_ENABLE 1'b1    //内存有效
        `define MEM_DISABLE 1'b0   //内存无效
    `else
        /**低电平复位**/
        `define RESET_EDGE negedge //复位信号边沿
        `define RESET_ENABLE 1'b0  //复位有效
        `define RESET_DISABLE 1'b1 //复位无效
        `define MEM_ENABLE 1'b0    //内存有效
        `define MEM_DISABLE 1'b1   //内存无效
    `endif
    //`define NEGATIVE_RESET NaN

    /**内存控制信号极性的选择**/
    `define POSITIVE_MEMORY NaN
    `define NEGATIVE_MEMORY NaN
    /**I/O的选择**/
    `define IMPLEMENT_TIMER NaN
    `define IMPLEMENT_UART NaN
    `define IMPLEMENT_GPIO NaN

`endif