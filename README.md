# nono
FIFO IP核的实验示例
本节的实验任务是使用 Vivado 生成一个异步 FIFO，并实现以下功能当FIFO为空时，向FIFO中写入数据，
直至将FIFO写满后停止写操作;当FIFO为满时，从FIFO中读出数据，直到FIFO被读空后停止读操作。
如:将FIFO设置的深度和宽度分别为256和8进行读写测试。
