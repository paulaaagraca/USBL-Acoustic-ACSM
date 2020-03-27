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
static const char *ng0 = "/home/ise/EDAtools/proj_v2/src/verilog-rtl/hilbert_chain.v";
static unsigned int ng1[] = {0U, 0U};
static int ng2[] = {0, 0};
static unsigned int ng3[] = {10U, 0U};
static int ng4[] = {1, 0};
static int ng5[] = {2, 0};
static int ng6[] = {8, 0};



static void Always_36_0(char *t0)
{
    char t13[8];
    char t17[8];
    char t19[8];
    char t20[8];
    char t41[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t14;
    char *t15;
    char *t16;
    char *t18;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    unsigned int t31;
    int t32;
    char *t33;
    unsigned int t34;
    int t35;
    int t36;
    unsigned int t37;
    unsigned int t38;
    int t39;
    int t40;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;

LAB0:    t1 = (t0 + 4208U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 4776);
    *((int *)t2) = 1;
    t3 = (t0 + 4240);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(37, ng0);

LAB5:    xsi_set_current_line(38, ng0);
    t4 = (t0 + 1616U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(44, ng0);

LAB15:    xsi_set_current_line(46, ng0);
    t2 = (t0 + 1776U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB16;

LAB17:    xsi_set_current_line(54, ng0);
    t2 = (t0 + 1936U);
    t3 = *((char **)t2);
    memset(t13, 0, 8);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 & 1U);
    if (t10 != 0)
        goto LAB30;

LAB28:    if (*((unsigned int *)t2) == 0)
        goto LAB27;

LAB29:    t4 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t4) = 1;

LAB30:    t5 = (t13 + 4);
    t31 = *((unsigned int *)t5);
    t34 = (~(t31));
    t37 = *((unsigned int *)t13);
    t38 = (t37 & t34);
    t51 = (t38 != 0);
    if (t51 > 0)
        goto LAB31;

LAB32:
LAB33:
LAB18:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(38, ng0);

LAB9:    xsi_set_current_line(39, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 2656);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 16, 0LL);
    xsi_set_current_line(40, ng0);
    xsi_set_current_line(40, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2976);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB10:    t2 = (t0 + 2976);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 744);
    t11 = *((char **)t5);
    memset(t13, 0, 8);
    xsi_vlog_signed_leq(t13, 32, t4, 32, t11, 32);
    t5 = (t13 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (~(t6));
    t8 = *((unsigned int *)t13);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB11;

LAB12:    goto LAB8;

LAB11:    xsi_set_current_line(41, ng0);
    t12 = ((char*)((ng3)));
    t14 = (t0 + 2976);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memset(t17, 0, 8);
    xsi_vlog_unsigned_add(t17, 32, t12, 32, t16, 32);
    t18 = (t0 + 2816);
    t21 = (t0 + 2816);
    t22 = (t21 + 72U);
    t23 = *((char **)t22);
    t24 = (t0 + 2816);
    t25 = (t24 + 64U);
    t26 = *((char **)t25);
    t27 = (t0 + 2976);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    xsi_vlog_generic_convert_array_indices(t19, t20, t23, t26, 1, 1, t29, 32, 1);
    t30 = (t19 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (!(t31));
    t33 = (t20 + 4);
    t34 = *((unsigned int *)t33);
    t35 = (!(t34));
    t36 = (t32 && t35);
    if (t36 == 1)
        goto LAB13;

LAB14:    xsi_set_current_line(40, ng0);
    t2 = (t0 + 2976);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng4)));
    memset(t13, 0, 8);
    xsi_vlog_signed_add(t13, 32, t4, 32, t5, 32);
    t11 = (t0 + 2976);
    xsi_vlogvar_assign_value(t11, t13, 0, 0, 32);
    goto LAB10;

LAB13:    t37 = *((unsigned int *)t19);
    t38 = *((unsigned int *)t20);
    t39 = (t37 - t38);
    t40 = (t39 + 1);
    xsi_vlogvar_wait_assign_value(t18, t17, 0, *((unsigned int *)t20), t40, 0LL);
    goto LAB14;

LAB16:    xsi_set_current_line(46, ng0);

LAB19:    xsi_set_current_line(48, ng0);
    t4 = (t0 + 2816);
    t5 = (t4 + 56U);
    t11 = *((char **)t5);
    t12 = (t0 + 2816);
    t14 = (t12 + 72U);
    t15 = *((char **)t14);
    t16 = (t0 + 2816);
    t18 = (t16 + 64U);
    t21 = *((char **)t18);
    t22 = ((char*)((ng5)));
    xsi_vlog_generic_get_array_select_value(t17, 16, t11, t15, t21, 1, 1, t22, 32, 1);
    t23 = (t0 + 2656);
    xsi_vlogvar_wait_assign_value(t23, t17, 0, 0, 16, 0LL);
    xsi_set_current_line(49, ng0);
    t2 = (t0 + 2096U);
    t3 = *((char **)t2);
    t2 = (t0 + 2816);
    t4 = (t0 + 2816);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2816);
    t14 = (t12 + 64U);
    t15 = *((char **)t14);
    t16 = ((char*)((ng2)));
    xsi_vlog_generic_convert_array_indices(t13, t17, t11, t15, 1, 1, t16, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t32 = (!(t6));
    t21 = (t17 + 4);
    t7 = *((unsigned int *)t21);
    t35 = (!(t7));
    t36 = (t32 && t35);
    if (t36 == 1)
        goto LAB20;

LAB21:    xsi_set_current_line(50, ng0);
    xsi_set_current_line(50, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3136);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB22:    t2 = (t0 + 3136);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 744);
    t11 = *((char **)t5);
    memset(t13, 0, 8);
    xsi_vlog_signed_leq(t13, 32, t4, 32, t11, 32);
    t5 = (t13 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (~(t6));
    t8 = *((unsigned int *)t13);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB23;

LAB24:    goto LAB18;

LAB20:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t17);
    t39 = (t8 - t9);
    t40 = (t39 + 1);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, *((unsigned int *)t17), t40, 0LL);
    goto LAB21;

LAB23:    xsi_set_current_line(51, ng0);
    t12 = (t0 + 2816);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t16 = (t0 + 2816);
    t18 = (t16 + 72U);
    t21 = *((char **)t18);
    t22 = (t0 + 2816);
    t23 = (t22 + 64U);
    t24 = *((char **)t23);
    t25 = (t0 + 3136);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    t28 = ((char*)((ng4)));
    memset(t19, 0, 8);
    xsi_vlog_signed_minus(t19, 32, t27, 32, t28, 32);
    xsi_vlog_generic_get_array_select_value(t17, 16, t15, t21, t24, 1, 1, t19, 32, 1);
    t29 = (t0 + 2816);
    t30 = (t0 + 2816);
    t33 = (t30 + 72U);
    t42 = *((char **)t33);
    t43 = (t0 + 2816);
    t44 = (t43 + 64U);
    t45 = *((char **)t44);
    t46 = (t0 + 3136);
    t47 = (t46 + 56U);
    t48 = *((char **)t47);
    xsi_vlog_generic_convert_array_indices(t20, t41, t42, t45, 1, 1, t48, 32, 1);
    t49 = (t20 + 4);
    t31 = *((unsigned int *)t49);
    t32 = (!(t31));
    t50 = (t41 + 4);
    t34 = *((unsigned int *)t50);
    t35 = (!(t34));
    t36 = (t32 && t35);
    if (t36 == 1)
        goto LAB25;

LAB26:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 3136);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng4)));
    memset(t13, 0, 8);
    xsi_vlog_signed_add(t13, 32, t4, 32, t5, 32);
    t11 = (t0 + 3136);
    xsi_vlogvar_assign_value(t11, t13, 0, 0, 32);
    goto LAB22;

LAB25:    t37 = *((unsigned int *)t20);
    t38 = *((unsigned int *)t41);
    t39 = (t37 - t38);
    t40 = (t39 + 1);
    xsi_vlogvar_wait_assign_value(t29, t17, 0, *((unsigned int *)t41), t40, 0LL);
    goto LAB26;

LAB27:    *((unsigned int *)t13) = 1;
    goto LAB30;

LAB31:    xsi_set_current_line(54, ng0);

LAB34:    xsi_set_current_line(55, ng0);
    t11 = (t0 + 2816);
    t12 = (t11 + 56U);
    t14 = *((char **)t12);
    t15 = (t0 + 2816);
    t16 = (t15 + 72U);
    t18 = *((char **)t16);
    t21 = (t0 + 2816);
    t22 = (t21 + 64U);
    t23 = *((char **)t22);
    t24 = ((char*)((ng6)));
    xsi_vlog_generic_get_array_select_value(t17, 16, t14, t18, t23, 1, 1, t24, 32, 1);
    t25 = (t0 + 2816);
    t26 = (t0 + 2816);
    t27 = (t26 + 72U);
    t28 = *((char **)t27);
    t29 = (t0 + 2816);
    t30 = (t29 + 64U);
    t33 = *((char **)t30);
    t42 = ((char*)((ng2)));
    xsi_vlog_generic_convert_array_indices(t19, t20, t28, t33, 1, 1, t42, 32, 1);
    t43 = (t19 + 4);
    t52 = *((unsigned int *)t43);
    t32 = (!(t52));
    t44 = (t20 + 4);
    t53 = *((unsigned int *)t44);
    t35 = (!(t53));
    t36 = (t32 && t35);
    if (t36 == 1)
        goto LAB35;

LAB36:    xsi_set_current_line(56, ng0);
    xsi_set_current_line(56, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3296);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB37:    t2 = (t0 + 3296);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 744);
    t11 = *((char **)t5);
    memset(t13, 0, 8);
    xsi_vlog_signed_leq(t13, 32, t4, 32, t11, 32);
    t5 = (t13 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (~(t6));
    t8 = *((unsigned int *)t13);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB38;

LAB39:    goto LAB33;

LAB35:    t54 = *((unsigned int *)t19);
    t55 = *((unsigned int *)t20);
    t39 = (t54 - t55);
    t40 = (t39 + 1);
    xsi_vlogvar_wait_assign_value(t25, t17, 0, *((unsigned int *)t20), t40, 0LL);
    goto LAB36;

LAB38:    xsi_set_current_line(57, ng0);
    t12 = (t0 + 2816);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t16 = (t0 + 2816);
    t18 = (t16 + 72U);
    t21 = *((char **)t18);
    t22 = (t0 + 2816);
    t23 = (t22 + 64U);
    t24 = *((char **)t23);
    t25 = (t0 + 3296);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    t28 = ((char*)((ng4)));
    memset(t19, 0, 8);
    xsi_vlog_signed_minus(t19, 32, t27, 32, t28, 32);
    xsi_vlog_generic_get_array_select_value(t17, 16, t15, t21, t24, 1, 1, t19, 32, 1);
    t29 = (t0 + 2816);
    t30 = (t0 + 2816);
    t33 = (t30 + 72U);
    t42 = *((char **)t33);
    t43 = (t0 + 2816);
    t44 = (t43 + 64U);
    t45 = *((char **)t44);
    t46 = (t0 + 3296);
    t47 = (t46 + 56U);
    t48 = *((char **)t47);
    xsi_vlog_generic_convert_array_indices(t20, t41, t42, t45, 1, 1, t48, 32, 1);
    t49 = (t20 + 4);
    t31 = *((unsigned int *)t49);
    t32 = (!(t31));
    t50 = (t41 + 4);
    t34 = *((unsigned int *)t50);
    t35 = (!(t34));
    t36 = (t32 && t35);
    if (t36 == 1)
        goto LAB40;

LAB41:    xsi_set_current_line(56, ng0);
    t2 = (t0 + 3296);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng4)));
    memset(t13, 0, 8);
    xsi_vlog_signed_add(t13, 32, t4, 32, t5, 32);
    t11 = (t0 + 3296);
    xsi_vlogvar_assign_value(t11, t13, 0, 0, 32);
    goto LAB37;

LAB40:    t37 = *((unsigned int *)t20);
    t38 = *((unsigned int *)t41);
    t39 = (t37 - t38);
    t40 = (t39 + 1);
    xsi_vlogvar_wait_assign_value(t29, t17, 0, *((unsigned int *)t41), t40, 0LL);
    goto LAB41;

}

static void Cont_63_1(char *t0)
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

LAB0:    t1 = (t0 + 4456U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(63, ng0);
    t2 = (t0 + 2816);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t6 = (t0 + 2816);
    t7 = (t6 + 72U);
    t8 = *((char **)t7);
    t9 = (t0 + 2816);
    t10 = (t9 + 64U);
    t11 = *((char **)t10);
    t12 = ((char*)((ng6)));
    xsi_vlog_generic_get_array_select_value(t5, 16, t4, t8, t11, 1, 1, t12, 32, 1);
    t13 = (t0 + 4872);
    t14 = (t13 + 56U);
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
    xsi_driver_vfirst_trans(t13, 0, 15);
    t26 = (t0 + 4792);
    *((int *)t26) = 1;

LAB1:    return;
}


extern void work_m_07952647962378844818_1134894253_init()
{
	static char *pe[] = {(void *)Always_36_0,(void *)Cont_63_1};
	xsi_register_didat("work_m_07952647962378844818_1134894253", "isim/tb_all_phase_isim_beh.exe.sim/work/m_07952647962378844818_1134894253.didat");
	xsi_register_executes(pe);
}
