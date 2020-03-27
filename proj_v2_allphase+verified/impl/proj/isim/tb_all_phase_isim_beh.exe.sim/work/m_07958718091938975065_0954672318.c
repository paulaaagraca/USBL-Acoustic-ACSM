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
static const char *ng0 = "/home/ise/EDAtools/proj_v2/src/verilog-rtl/ATAN_ROM_16.v";
static int ng1[] = {778593656, 0, 1415852342, 0, 1634618453, 0, 1630495092, 0, 1835295092, 0, 774861673, 0, 774778670, 0};



static void Initial_43_0(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(44, ng0);

LAB2:    xsi_set_current_line(45, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 1880);
    xsi_vlogfile_readmemh(t1, 224, t2, 0, 0, 0, 0);

LAB1:    return;
}

static void Cont_48_1(char *t0)
{
    char t5[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    char *t26;

LAB0:    t1 = (t0 + 3040U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(48, ng0);
    t2 = (t0 + 1880);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t6 = (t0 + 1880);
    t7 = (t6 + 72U);
    t8 = *((char **)t7);
    t9 = (t0 + 1880);
    t10 = (t9 + 64U);
    t11 = *((char **)t10);
    t12 = (t0 + 1320U);
    t13 = *((char **)t12);
    xsi_vlog_generic_get_array_select_value(t5, 16, t4, t8, t11, 2, 1, t13, 4, 2);
    t12 = (t0 + 3440);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memset(t17, 0, 8);
    t18 = 65535U;
    t19 = t18;
    t20 = (t5 + 4);
    t21 = *((unsigned int *)t5);
    t18 = (t18 & t21);
    t22 = *((unsigned int *)t20);
    t19 = (t19 & t22);
    t23 = (t17 + 4);
    t24 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t24 | t18);
    t25 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t25 | t19);
    xsi_driver_vfirst_trans(t12, 0, 15);
    t26 = (t0 + 3360);
    *((int *)t26) = 1;

LAB1:    return;
}


extern void work_m_07958718091938975065_0954672318_init()
{
	static char *pe[] = {(void *)Initial_43_0,(void *)Cont_48_1};
	xsi_register_didat("work_m_07958718091938975065_0954672318", "isim/tb_all_phase_isim_beh.exe.sim/work/m_07958718091938975065_0954672318.didat");
	xsi_register_executes(pe);
}
