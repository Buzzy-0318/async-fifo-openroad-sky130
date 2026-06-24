create_clock -name wclk -period 10 [get_ports wclk]
create_clock -name rclk -period 14 [get_ports rclk]

set_clock_groups -asynchronous \
-group {wclk} \
-group {rclk}
