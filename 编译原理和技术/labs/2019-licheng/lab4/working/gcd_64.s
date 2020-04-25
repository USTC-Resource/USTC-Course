	.text
	.file	"gcd.c"
	.globl	gcd                     # -- Begin function gcd
	.p2align	2
	.type	gcd,@function
gcd:                                    # @gcd
# %bb.0:
	addi	sp, sp, -48
	sd	ra, 40(sp)
	sd	s0, 32(sp)
	sd	s1, 24(sp)
	sd	s2, 16(sp)
	addi	s0, sp, 48
	sw	a0, -40(s0)
	sw	a1, -44(s0)
	lw	a0, -44(s0)
	bnez	a0, .LBB0_2
	j	.LBB0_1
.LBB0_1:
	lw	a0, -40(s0)
	sw	a0, -36(s0)
	j	.LBB0_3
.LBB0_2:
	lw	s2, -40(s0)
	lw	s1, -44(s0)
	mv	a0, s2
	mv	a1, s1
	call	__divdi3
	mv	a1, s1
	call	__muldi3
	subw	a1, s2, a0
	mv	a0, s1
	call	gcd
	sw	a0, -36(s0)
	j	.LBB0_3
.LBB0_3:
	lw	a0, -36(s0)
	ld	s2, 16(sp)
	ld	s1, 24(sp)
	ld	s0, 32(sp)
	ld	ra, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end0:
	.size	gcd, .Lfunc_end0-gcd
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)
	sd	s0, 16(sp)
	addi	s0, sp, 32
	sw	zero, -20(s0)
	addi	a0, zero, 72
	sw	a0, -24(s0)
	addi	a0, zero, 18
	sw	a0, -28(s0)
	lw	a0, -24(s0)
	lw	a1, -28(s0)
	bge	a0, a1, .LBB1_2
	j	.LBB1_1
.LBB1_1:
	lw	a0, -24(s0)
	sw	a0, -32(s0)
	lw	a0, -28(s0)
	sw	a0, -24(s0)
	lw	a0, -32(s0)
	sw	a0, -28(s0)
	j	.LBB1_2
.LBB1_2:
	lw	a0, -24(s0)
	lw	a1, -28(s0)
	call	gcd
	ld	s0, 16(sp)
	ld	ra, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function

	.ident	"clang version 8.0.1 (tags/RELEASE_801/final)"
	.section	".note.GNU-stack","",@progbits
