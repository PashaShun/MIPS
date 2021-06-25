
.data

	myArray: .space 28
	
	nextColumn: .asciiz "  "
	
	n: .asciiz " \n"
	
	SortedArray: .asciiz "Sorted array is \n"
	
	NonSortedArray: .asciiz "Input array is \n"

.text
	main:
	# Initialize our array with registers $s1..$s7
	addi $s1, $zero, 1
	addi $s2, $zero, 6
	addi $s3, $zero, 5
	addi $s4, $zero, 8
	addi $s5, $zero, 3
	addi $s6, $zero, 4
	addi $s7, $zero, 7
	# Make sure that $t0 is zero
	addi $t0, $zero, 0
	# Put the values of our array in data segment
	sw   $s1, myArray ($t0)
	addi $t0, $t0, 4
	sw   $s2, myArray ($t0)
	addi $t0, $t0, 4
	sw   $s3, myArray ($t0)
	addi $t0, $t0, 4
	sw   $s4, myArray ($t0)
	addi $t0, $t0, 4
	sw   $s5, myArray ($t0)
	addi $t0, $t0, 4
	sw   $s6, myArray ($t0)
	addi $t0, $t0, 4
	sw   $s7, myArray ($t0)
	# Free used registers and set $t1 with 0
	addi $t0, $zero, 0 
	addi $t1, $zero, 0 
	addi $s1, $zero, 0
	addi $s2, $zero, 0
	addi $s3, $zero, 0
	addi $s4, $zero, 0
	addi $s5, $zero, 0
	addi $s6, $zero, 0
	addi $s7, $zero, 0
	# Print string
	li $v0, 4
	la $a0, NonSortedArray
	syscall
	# Print input array
	while:
		beq $t0, 28, exitwhile  # Check for the end of array
		
		lw $t6, myArray($t0)
		
		addi $t0, $t0, 4
		
		li $v0, 1
		add $a0, $zero, $t6
		syscall
		
		li $v0, 4
		la $a0, nextColumn
		syscall
		
		j while
	exitwhile:
	# Set $t0 in 0
	addi $t0, $zero, 0
	# \n
	li $v0, 4
	la $a0, n
	syscall
	j BubbleSort
	
	BubbleSort:
		# Set our accumulator registers $s1 and $s2 to 0
		addi $s1, $zero, 0
		addi $s2, $zero, 0
		# Set in our registers values from data segment
		lw $s1, myArray($t0)
		addi $t0,$t0, 4
		beq $t0, 28, exitsort 	# Check for the end of array
		lw $s2, myArray($t0)
		#
		slt $t3, $s1, $s2
		# Check if the value. stored in $s1 is less than value in $s2
		beq $t3, 1, store # If $s1 < $s2 jump for store procedure store
		#If $s1 > $s2 store the values in the data segment array
		sw $s1, myArray($t0)
		subi $t0, $t0, 4		
		sw $s2, myArray($t0)
		addi $t0, $t0, 4
		
		addi $t3, $zero, 0 # Set the register for 0
		
		j BubbleSort
		
	store:
		# Store the values from accumulator in data segment
		subi $t0, $t0, 4
		sw $s1, myArray($t0)
		addi $t0, $t0, 4
		sw $s2, myArray($t0)
		addi $t3, $zero, 0
		
		j BubbleSort
		
	exitsort:
		addi $t0, $zero, 0
		addi $t1, $t1, 1
		bne $t1, 8, BubbleSort # In the Bubble Sort we have to check our array for O(n^2) times
		#Print a string
		li $v0, 4
		la $a0, SortedArray
		syscall
	
		addi $t0, $zero, 0
		
		j while1
		
	# Print sorted array
	while1:
		beq $t0, 28, exitwhile1
		
		lw $t4, myArray($t0)
		
		addi $t0, $t0, 4
		
		li $v0, 1
		add $a0, $zero, $t4
		syscall
		
		li $v0, 4
		la $a0, nextColumn
		syscall
		
		j while1
	exitwhile1:
	li $v0, 10
	syscall
	
	
	
	
		
