nop # this code reads the distance from memory and moves f/b depending on the distance
nop # MEMORY-MAPPED VALUES: r1 = Ultrasonic_distance, r2 = go into zigzag mode
nop # r5 = min front distance needed to go back, r4 = counter, r3 = counter_limit
nop # SERVOS: r10 = front right, r11 = front left, r12 = back right, r13 = back left
nop # ECE 350: JAB: Alex Weber & Judy Chen
addi r5, r0, 5 # min distance to go forward
addi r3, r0, 7 # delay
sll r3, r3, 10
LOOP: addi r4, r0, 0 # START OF LOOP
delay1: addi r4, r4, 1
bne r4, r3, delay1
lw r1, 5(r0) # get distance (converted echo -> distance in inches)
lw r2, 25(r0) # get zig zag (switch on FPGA put into memory as a single bit)
bne r2, r0, START_half_forward
blt r1, r5, GO_BACK # if distance < r5 (3 inches), move backwards
GO_FORWARD: addi r10, r0, 0 # else { go forwards
addi r11, r0, 7
addi r12, r0, 0
addi r13, r0, 7
j LOOP
GO_BACK: addi r10, r0, 7 # } go backwards
addi r11, r0, 0
addi r12, r0, 7
addi r13, r0, 0
addi r4, r0, 0 # delay
delay2: addi r4, r4, 1
bne r4, r3, delay2
GO_RIGHT: addi r10, r0, 7 # go right
addi r11, r0, 7
addi r12, r0, 7
addi r13, r0, 7
j LOOP
GO_BACK2: addi r10, r0, 7 # go backwards (for zig zag)
addi r11, r0, 0
addi r12, r0, 7
addi r13, r0, 0
addi r4, r0, 0 # delay
delay3: addi r4, r4, 1
bne r4, r3, delay3
GO_RIGHT2: addi r10, r0, 7 # go right (for zig zag)
addi r11, r0, 7
addi r12, r0, 7
addi r13, r0, 7
delay4: addi r4, r4, 1
bne r4, r3, delay4
START_half_forward: addi r10, r0, 0 # START OF ZIG_ZAG, go forward
addi r11, r0, 7
addi r12, r0, 0
addi r13, r0, 7
addi r3, r0, 7 # delay
sll r3, r3, 15
addi r4, r0, 0
d_81: addi r4, r4, 1
bne r4, r3, d_81
lw r1, 5(r0) # get distance
blt r1, r5, GO_BACK2 # if distance < r5 (3 inches), move backwards
left_loop: addi r10, r0, 0 # left
addi r11, r0, 0
addi r12, r0, 0
addi r13, r0, 0
addi r3, r0, 7 # delay
sll r3, r3, 15
addi r4, r0, 0
d_82: addi r4, r4, 1
bne r4, r3, d_82
lw r1, 5(r0) # get distance
blt r1, r5, GO_BACK2 # if distance < r5 (3 inches), move backwards
full_forward: addi r10, r0, 0 # forward
addi r11, r0, 7
addi r12, r0, 0
addi r13, r0, 7
addi r3, r0, 7 # delay
sll r3, r3, 16
addi r4, r0, 0
d_83: addi r4, r4, 1
bne r4, r3, d_83
lw r1, 5(r0) # get distance
blt r1, r5, GO_BACK2 # if distance < r5 (3 inches), move backwards
right_loop: addi r10, r0, 7 # right
addi r11, r0, 7
addi r12, r0, 7
addi r13, r0, 7
addi r3, r0, 7 # delay
sll r3, r3, 15
addi r4, r0, 0
d_84: addi r4, r4, 1
bne r4, r3, d_84
lw r1, 5(r0) # get distance
blt r1, r5, GO_BACK2 # if distance < r5 (3 inches), move backwards
END_half_forward: addi r10, r0, 0 # forward
addi r11, r0, 7
addi r12, r0, 0
addi r13, r0, 7
addi r3, r0, 7 # delay
sll r3, r3, 15
addi r4, r0, 0
d_85: addi r4, r4, 1
bne r4, r3, d_85
lw r1, 5(r0) # get distance
blt r1, r5, GO_BACK2 # if distance < r5 (3 inches), move backwards
j LOOP
