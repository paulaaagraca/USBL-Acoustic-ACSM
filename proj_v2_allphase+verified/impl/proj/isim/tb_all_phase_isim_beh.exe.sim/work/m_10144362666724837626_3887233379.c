/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/ise/EDAtools/proj_v2/src/verilog-rtl/MODSCALE_16.v";
static int ng1[] = {14, 0};
static unsigned int ng2[] = {622U, 0U};
static int ng3[] = {10, 0};



static void Cont_38_0(char *t0)
{
    char t4[8];
    char t6[8];
    char t9[8];
    char t19[8];
    char t21[8];
    char *t1;
    char *t2;
    char *t5;
    char *t7;
    char *t8;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t18;
    char *t20;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    unsigned int t33;
    unsigned int t34;
    char *t35;

LAB0:    t1 = (t0 + 2496U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 1184U);
    t5 = *((char **)t2);
    t2 = ((char*)((ng1)));
    t7 = (t0 + 1184U);
    t8 = *((char **)t7);
    memset(t9, 0, 8);
    t7 = (t9 + 4);
    t10 = (t8 + 4);
    t11 = *((unsigned int *)t8);
    t12 = (t11 >> 17);
    t13 = (t12 & 1);
    *((unsigned int *)t9) = t13;
    t14 = *((unsigned int *)t10);
    t15 = (t14 >> 17);
    t16 = (t15 & 1);
    *((unsigned int *)t7) = t16;
    xsi_vlog_mul_concat(t6, 14, 1, t2, 1U, t9, 1);
    xsi_vlogtype_concat(t4, 32, 32, 2U, t6, 14, t5, 18);
    t18 = ((char*)((ng2)));
    memset(t19, 0, 8);
    xsi_vlog_signed_multiply(t19, 32, t4, 32, t18, 32);
    t20 = ((char*)((ng3)));
    memset(t21, 0, 8);
    xsi_vlog_signed_arith_rshift(t21, 32, t19, 32, t20, 32);
    t22 = (t0 + 2896);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    memset(t26, 0, 8);
    t27 = 65535U;
    t28 = t27;
    t29 = (t21 + 4);
    t30 = *((unsigned int *)t21);
    t27 = (t27 & t30);
    t31 = *((unsigned int *)t29);
    t28 = (t28 & t31);
    t32 = (t26 + 4);
    t33 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t33 | t27);
    t34 = *((unsigned int *)t32);
    *((unsigned int *)t32) = (t34 | t28);
    xsi_driver_vfirst_trans(t22, 0, 15);
    t35 = (t0 + 2816);
    *((int *)t35) = 1;

LAB1:    return;
}


extern void work_m_10144362666724837626_3887233379_init()
{
	static char *pe[] = {(void *)Cont_38_0};
	xsi_register_didat("work_m_10144362666724837626_3887233379", "isim/tb_all_phase_isim_beh.exe.sim/work/m_10144362666724837626_3887233379.didat");
	xsi_register_executes(pe);
}
