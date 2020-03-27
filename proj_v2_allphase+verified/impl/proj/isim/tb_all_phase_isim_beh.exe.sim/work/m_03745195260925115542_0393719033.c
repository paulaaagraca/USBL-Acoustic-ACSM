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
static const char *ng0 = "/home/ise/EDAtools/proj_v2/src/verilog-rtl/cordic_calc.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {339968U, 0U};
static unsigned int ng3[] = {184320U, 0U};



static void Always_67_0(char *t0)
{
    char t18[8];
    char t19[8];
    char t20[8];
    char t39[8];
    char t47[8];
    char t67[8];
    char t75[8];
    char t76[8];
    char t77[8];
    char t78[8];
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
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    char *t34;
    char *t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    char *t40;
    char *t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    char *t46;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    char *t57;
    unsigned int t58;
    unsigned int t59;
    char *t60;
    unsigned int t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;

LAB0:    t1 = (t0 + 4600U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(67, ng0);
    t2 = (t0 + 5416);
    *((int *)t2) = 1;
    t3 = (t0 + 4632);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(68, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB5;

LAB6:    xsi_set_current_line(77, ng0);

LAB9:    xsi_set_current_line(78, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB10;

LAB11:
LAB12:
LAB7:    goto LAB2;

LAB5:    xsi_set_current_line(69, ng0);

LAB8:    xsi_set_current_line(70, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 3048);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 18, 0LL);
    xsi_set_current_line(71, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3208);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 18, 0LL);
    xsi_set_current_line(72, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 19, 0LL);
    xsi_set_current_line(73, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3368);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    xsi_set_current_line(74, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3528);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    goto LAB7;

LAB10:    xsi_set_current_line(79, ng0);

LAB13:    xsi_set_current_line(80, ng0);
    t4 = (t0 + 1528U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t13 = *((unsigned int *)t4);
    t14 = (~(t13));
    t15 = *((unsigned int *)t5);
    t16 = (t15 & t14);
    t17 = (t16 != 0);
    if (t17 > 0)
        goto LAB14;

LAB15:    xsi_set_current_line(89, ng0);

LAB39:    xsi_set_current_line(90, ng0);
    t2 = (t0 + 3208);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t39, 0, 8);
    t5 = (t39 + 4);
    t11 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 17);
    t8 = (t7 & 1);
    *((unsigned int *)t39) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 17);
    t13 = (t10 & 1);
    *((unsigned int *)t5) = t13;
    memset(t20, 0, 8);
    t12 = (t39 + 4);
    t14 = *((unsigned int *)t12);
    t15 = (~(t14));
    t16 = *((unsigned int *)t39);
    t17 = (t16 & t15);
    t22 = (t17 & 1U);
    if (t22 != 0)
        goto LAB43;

LAB41:    if (*((unsigned int *)t12) == 0)
        goto LAB40;

LAB42:    t21 = (t20 + 4);
    *((unsigned int *)t20) = 1;
    *((unsigned int *)t21) = 1;

LAB43:    t28 = (t20 + 4);
    t34 = (t39 + 4);
    t23 = *((unsigned int *)t39);
    t24 = (~(t23));
    *((unsigned int *)t20) = t24;
    *((unsigned int *)t28) = 0;
    if (*((unsigned int *)t34) != 0)
        goto LAB45;

LAB44:    t30 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t30 & 1U);
    t31 = *((unsigned int *)t28);
    *((unsigned int *)t28) = (t31 & 1U);
    memset(t19, 0, 8);
    t35 = (t20 + 4);
    t32 = *((unsigned int *)t35);
    t33 = (~(t32));
    t36 = *((unsigned int *)t20);
    t37 = (t36 & t33);
    t38 = (t37 & 1U);
    if (t38 != 0)
        goto LAB46;

LAB47:    if (*((unsigned int *)t35) != 0)
        goto LAB48;

LAB49:    t41 = (t19 + 4);
    t42 = *((unsigned int *)t19);
    t43 = *((unsigned int *)t41);
    t44 = (t42 || t43);
    if (t44 > 0)
        goto LAB50;

LAB51:    t45 = *((unsigned int *)t19);
    t48 = (~(t45));
    t49 = *((unsigned int *)t41);
    t50 = (t48 || t49);
    if (t50 > 0)
        goto LAB52;

LAB53:    if (*((unsigned int *)t41) > 0)
        goto LAB54;

LAB55:    if (*((unsigned int *)t19) > 0)
        goto LAB56;

LAB57:    memcpy(t18, t76, 8);

LAB58:    t73 = (t0 + 3048);
    xsi_vlogvar_wait_assign_value(t73, t18, 0, 0, 18, 0LL);
    xsi_set_current_line(91, ng0);
    t2 = (t0 + 3208);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t39, 0, 8);
    t5 = (t39 + 4);
    t11 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 17);
    t8 = (t7 & 1);
    *((unsigned int *)t39) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 17);
    t13 = (t10 & 1);
    *((unsigned int *)t5) = t13;
    memset(t20, 0, 8);
    t12 = (t39 + 4);
    t14 = *((unsigned int *)t12);
    t15 = (~(t14));
    t16 = *((unsigned int *)t39);
    t17 = (t16 & t15);
    t22 = (t17 & 1U);
    if (t22 != 0)
        goto LAB62;

LAB60:    if (*((unsigned int *)t12) == 0)
        goto LAB59;

LAB61:    t21 = (t20 + 4);
    *((unsigned int *)t20) = 1;
    *((unsigned int *)t21) = 1;

LAB62:    t28 = (t20 + 4);
    t34 = (t39 + 4);
    t23 = *((unsigned int *)t39);
    t24 = (~(t23));
    *((unsigned int *)t20) = t24;
    *((unsigned int *)t28) = 0;
    if (*((unsigned int *)t34) != 0)
        goto LAB64;

LAB63:    t30 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t30 & 1U);
    t31 = *((unsigned int *)t28);
    *((unsigned int *)t28) = (t31 & 1U);
    memset(t19, 0, 8);
    t35 = (t20 + 4);
    t32 = *((unsigned int *)t35);
    t33 = (~(t32));
    t36 = *((unsigned int *)t20);
    t37 = (t36 & t33);
    t38 = (t37 & 1U);
    if (t38 != 0)
        goto LAB65;

LAB66:    if (*((unsigned int *)t35) != 0)
        goto LAB67;

LAB68:    t41 = (t19 + 4);
    t42 = *((unsigned int *)t19);
    t43 = *((unsigned int *)t41);
    t44 = (t42 || t43);
    if (t44 > 0)
        goto LAB69;

LAB70:    t45 = *((unsigned int *)t19);
    t48 = (~(t45));
    t49 = *((unsigned int *)t41);
    t50 = (t48 || t49);
    if (t50 > 0)
        goto LAB71;

LAB72:    if (*((unsigned int *)t41) > 0)
        goto LAB73;

LAB74:    if (*((unsigned int *)t19) > 0)
        goto LAB75;

LAB76:    memcpy(t18, t76, 8);

LAB77:    t73 = (t0 + 3208);
    xsi_vlogvar_wait_assign_value(t73, t18, 0, 0, 18, 0LL);
    xsi_set_current_line(92, ng0);
    t2 = (t0 + 3208);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t39, 0, 8);
    t5 = (t39 + 4);
    t11 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 17);
    t8 = (t7 & 1);
    *((unsigned int *)t39) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 17);
    t13 = (t10 & 1);
    *((unsigned int *)t5) = t13;
    memset(t20, 0, 8);
    t12 = (t39 + 4);
    t14 = *((unsigned int *)t12);
    t15 = (~(t14));
    t16 = *((unsigned int *)t39);
    t17 = (t16 & t15);
    t22 = (t17 & 1U);
    if (t22 != 0)
        goto LAB81;

LAB79:    if (*((unsigned int *)t12) == 0)
        goto LAB78;

LAB80:    t21 = (t20 + 4);
    *((unsigned int *)t20) = 1;
    *((unsigned int *)t21) = 1;

LAB81:    t28 = (t20 + 4);
    t34 = (t39 + 4);
    t23 = *((unsigned int *)t39);
    t24 = (~(t23));
    *((unsigned int *)t20) = t24;
    *((unsigned int *)t28) = 0;
    if (*((unsigned int *)t34) != 0)
        goto LAB83;

LAB82:    t30 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t30 & 1U);
    t31 = *((unsigned int *)t28);
    *((unsigned int *)t28) = (t31 & 1U);
    memset(t19, 0, 8);
    t35 = (t20 + 4);
    t32 = *((unsigned int *)t35);
    t33 = (~(t32));
    t36 = *((unsigned int *)t20);
    t37 = (t36 & t33);
    t38 = (t37 & 1U);
    if (t38 != 0)
        goto LAB84;

LAB85:    if (*((unsigned int *)t35) != 0)
        goto LAB86;

LAB87:    t41 = (t19 + 4);
    t42 = *((unsigned int *)t19);
    t43 = *((unsigned int *)t41);
    t44 = (t42 || t43);
    if (t44 > 0)
        goto LAB88;

LAB89:    t45 = *((unsigned int *)t19);
    t48 = (~(t45));
    t49 = *((unsigned int *)t41);
    t50 = (t48 || t49);
    if (t50 > 0)
        goto LAB90;

LAB91:    if (*((unsigned int *)t41) > 0)
        goto LAB92;

LAB93:    if (*((unsigned int *)t19) > 0)
        goto LAB94;

LAB95:    memcpy(t18, t78, 8);

LAB96:    t70 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t70, t18, 0, 0, 19, 0LL);

LAB16:    goto LAB12;

LAB14:    xsi_set_current_line(81, ng0);

LAB17:    xsi_set_current_line(82, ng0);
    t11 = (t0 + 1688U);
    t12 = *((char **)t11);
    memset(t20, 0, 8);
    t11 = (t20 + 4);
    t21 = (t12 + 4);
    t22 = *((unsigned int *)t12);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t20) = t24;
    t25 = *((unsigned int *)t21);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t11) = t27;
    memset(t19, 0, 8);
    t28 = (t20 + 4);
    t29 = *((unsigned int *)t28);
    t30 = (~(t29));
    t31 = *((unsigned int *)t20);
    t32 = (t31 & t30);
    t33 = (t32 & 1U);
    if (t33 != 0)
        goto LAB18;

LAB19:    if (*((unsigned int *)t28) != 0)
        goto LAB20;

LAB21:    t35 = (t19 + 4);
    t36 = *((unsigned int *)t19);
    t37 = *((unsigned int *)t35);
    t38 = (t36 || t37);
    if (t38 > 0)
        goto LAB22;

LAB23:    t42 = *((unsigned int *)t19);
    t43 = (~(t42));
    t44 = *((unsigned int *)t35);
    t45 = (t43 || t44);
    if (t45 > 0)
        goto LAB24;

LAB25:    if (*((unsigned int *)t35) > 0)
        goto LAB26;

LAB27:    if (*((unsigned int *)t19) > 0)
        goto LAB28;

LAB29:    memcpy(t18, t47, 8);

LAB30:    t62 = (t0 + 3048);
    xsi_vlogvar_wait_assign_value(t62, t18, 0, 0, 18, 0LL);
    xsi_set_current_line(83, ng0);
    t2 = (t0 + 1688U);
    t3 = *((char **)t2);
    t2 = (t0 + 3368);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 16, 0LL);
    xsi_set_current_line(84, ng0);
    t2 = (t0 + 1848U);
    t3 = *((char **)t2);
    memcpy(t18, t3, 8);
    t8 = *((unsigned int *)t3);
    t9 = (t8 & 32768U);
    t6 = t9;
    t2 = (t3 + 4);
    t10 = *((unsigned int *)t2);
    t13 = (t10 & 32768U);
    t7 = t13;
    t14 = (t9 != 0);
    if (t14 == 1)
        goto LAB35;

LAB36:    t16 = (t13 != 0);
    if (t16 == 1)
        goto LAB37;

LAB38:    t22 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t22 & 262143U);
    t5 = (t18 + 4);
    t23 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t23 & 262143U);
    t11 = (t0 + 3208);
    xsi_vlogvar_wait_assign_value(t11, t18, 0, 0, 18, 0LL);
    xsi_set_current_line(85, ng0);
    t2 = (t0 + 1848U);
    t3 = *((char **)t2);
    t2 = (t0 + 3528);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 16, 0LL);
    xsi_set_current_line(86, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 19, 0LL);
    goto LAB16;

LAB18:    *((unsigned int *)t19) = 1;
    goto LAB21;

LAB20:    t34 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t34) = 1;
    goto LAB21;

LAB22:    t40 = (t0 + 1688U);
    t41 = *((char **)t40);
    memset(t39, 0, 8);
    xsi_vlog_signed_unary_minus(t39, 18, t41, 16);
    goto LAB23;

LAB24:    t40 = (t0 + 1688U);
    t46 = *((char **)t40);
    memcpy(t47, t46, 8);
    t50 = *((unsigned int *)t46);
    t51 = (t50 & 32768U);
    t48 = t51;
    t40 = (t46 + 4);
    t52 = *((unsigned int *)t40);
    t53 = (t52 & 32768U);
    t49 = t53;
    t54 = (t51 != 0);
    if (t54 == 1)
        goto LAB31;

LAB32:    t56 = (t53 != 0);
    if (t56 == 1)
        goto LAB33;

LAB34:    t59 = *((unsigned int *)t47);
    *((unsigned int *)t47) = (t59 & 262143U);
    t60 = (t47 + 4);
    t61 = *((unsigned int *)t60);
    *((unsigned int *)t60) = (t61 & 262143U);
    goto LAB25;

LAB26:    xsi_vlog_unsigned_bit_combine(t18, 18, t39, 18, t47, 18);
    goto LAB30;

LAB28:    memcpy(t18, t39, 8);
    goto LAB30;

LAB31:    t55 = *((unsigned int *)t47);
    *((unsigned int *)t47) = (t55 | 4294901760U);
    goto LAB32;

LAB33:    t57 = (t47 + 4);
    t58 = *((unsigned int *)t57);
    *((unsigned int *)t57) = (t58 | 4294901760U);
    goto LAB34;

LAB35:    t15 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t15 | 4294901760U);
    goto LAB36;

LAB37:    t4 = (t18 + 4);
    t17 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t17 | 4294901760U);
    goto LAB38;

LAB40:    *((unsigned int *)t20) = 1;
    goto LAB43;

LAB45:    t25 = *((unsigned int *)t20);
    t26 = *((unsigned int *)t34);
    *((unsigned int *)t20) = (t25 | t26);
    t27 = *((unsigned int *)t28);
    t29 = *((unsigned int *)t34);
    *((unsigned int *)t28) = (t27 | t29);
    goto LAB44;

LAB46:    *((unsigned int *)t19) = 1;
    goto LAB49;

LAB48:    t40 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB49;

LAB50:    t46 = (t0 + 3048);
    t57 = (t46 + 56U);
    t60 = *((char **)t57);
    t62 = (t0 + 3208);
    t63 = (t62 + 56U);
    t64 = *((char **)t63);
    t65 = (t0 + 2328U);
    t66 = *((char **)t65);
    memset(t47, 0, 8);
    xsi_vlog_signed_arith_rshift(t47, 18, t64, 18, t66, 4);
    memset(t67, 0, 8);
    xsi_vlog_signed_add(t67, 18, t60, 18, t47, 18);
    goto LAB51;

LAB52:    t65 = (t0 + 3048);
    t68 = (t65 + 56U);
    t69 = *((char **)t68);
    t70 = (t0 + 3208);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    t73 = (t0 + 2328U);
    t74 = *((char **)t73);
    memset(t75, 0, 8);
    xsi_vlog_signed_arith_rshift(t75, 18, t72, 18, t74, 4);
    memset(t76, 0, 8);
    xsi_vlog_signed_minus(t76, 18, t69, 18, t75, 18);
    goto LAB53;

LAB54:    xsi_vlog_unsigned_bit_combine(t18, 18, t67, 18, t76, 18);
    goto LAB58;

LAB56:    memcpy(t18, t67, 8);
    goto LAB58;

LAB59:    *((unsigned int *)t20) = 1;
    goto LAB62;

LAB64:    t25 = *((unsigned int *)t20);
    t26 = *((unsigned int *)t34);
    *((unsigned int *)t20) = (t25 | t26);
    t27 = *((unsigned int *)t28);
    t29 = *((unsigned int *)t34);
    *((unsigned int *)t28) = (t27 | t29);
    goto LAB63;

LAB65:    *((unsigned int *)t19) = 1;
    goto LAB68;

LAB67:    t40 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB68;

LAB69:    t46 = (t0 + 3208);
    t57 = (t46 + 56U);
    t60 = *((char **)t57);
    t62 = (t0 + 3048);
    t63 = (t62 + 56U);
    t64 = *((char **)t63);
    t65 = (t0 + 2328U);
    t66 = *((char **)t65);
    memset(t47, 0, 8);
    xsi_vlog_signed_arith_rshift(t47, 18, t64, 18, t66, 4);
    memset(t67, 0, 8);
    xsi_vlog_signed_minus(t67, 18, t60, 18, t47, 18);
    goto LAB70;

LAB71:    t65 = (t0 + 3208);
    t68 = (t65 + 56U);
    t69 = *((char **)t68);
    t70 = (t0 + 3048);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    t73 = (t0 + 2328U);
    t74 = *((char **)t73);
    memset(t75, 0, 8);
    xsi_vlog_signed_arith_rshift(t75, 18, t72, 18, t74, 4);
    memset(t76, 0, 8);
    xsi_vlog_signed_add(t76, 18, t69, 18, t75, 18);
    goto LAB72;

LAB73:    xsi_vlog_unsigned_bit_combine(t18, 18, t67, 18, t76, 18);
    goto LAB77;

LAB75:    memcpy(t18, t67, 8);
    goto LAB77;

LAB78:    *((unsigned int *)t20) = 1;
    goto LAB81;

LAB83:    t25 = *((unsigned int *)t20);
    t26 = *((unsigned int *)t34);
    *((unsigned int *)t20) = (t25 | t26);
    t27 = *((unsigned int *)t28);
    t29 = *((unsigned int *)t34);
    *((unsigned int *)t28) = (t27 | t29);
    goto LAB82;

LAB84:    *((unsigned int *)t19) = 1;
    goto LAB87;

LAB86:    t40 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB87;

LAB88:    t46 = (t0 + 3688);
    t57 = (t46 + 56U);
    t60 = *((char **)t57);
    t62 = (t0 + 2488U);
    t63 = *((char **)t62);
    t62 = ((char*)((ng1)));
    xsi_vlogtype_concat(t67, 17, 17, 2U, t62, 1, t63, 16);
    xsi_vlogtype_sign_extend(t47, 19, t67, 17);
    memset(t75, 0, 8);
    xsi_vlog_signed_add(t75, 19, t60, 19, t47, 19);
    goto LAB89;

LAB90:    t64 = (t0 + 3688);
    t65 = (t64 + 56U);
    t66 = *((char **)t65);
    t68 = (t0 + 2488U);
    t69 = *((char **)t68);
    t68 = ((char*)((ng1)));
    xsi_vlogtype_concat(t77, 17, 17, 2U, t68, 1, t69, 16);
    xsi_vlogtype_sign_extend(t76, 19, t77, 17);
    memset(t78, 0, 8);
    xsi_vlog_signed_minus(t78, 19, t66, 19, t76, 19);
    goto LAB91;

LAB92:    xsi_vlog_unsigned_bit_combine(t18, 19, t75, 19, t78, 19);
    goto LAB96;

LAB94:    memcpy(t18, t75, 8);
    goto LAB96;

}

static void Cont_114_1(char *t0)
{
    char t3[8];
    char t4[8];
    char t7[8];
    char t27[8];
    char t28[8];
    char t32[8];
    char t56[8];
    char t65[8];
    char *t1;
    char *t2;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t29;
    char *t30;
    char *t31;
    char *t33;
    char *t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    char *t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    char *t47;
    char *t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    unsigned int t78;
    unsigned int t79;
    char *t80;
    unsigned int t81;
    unsigned int t82;
    char *t83;
    unsigned int t84;
    unsigned int t85;
    char *t86;

LAB0:    t1 = (t0 + 4848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(114, ng0);
    t2 = (t0 + 3368);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    memset(t7, 0, 8);
    t8 = (t7 + 4);
    t9 = (t6 + 4);
    t10 = *((unsigned int *)t6);
    t11 = (t10 >> 15);
    t12 = (t11 & 1);
    *((unsigned int *)t7) = t12;
    t13 = *((unsigned int *)t9);
    t14 = (t13 >> 15);
    t15 = (t14 & 1);
    *((unsigned int *)t8) = t15;
    memset(t4, 0, 8);
    t16 = (t7 + 4);
    t17 = *((unsigned int *)t16);
    t18 = (~(t17));
    t19 = *((unsigned int *)t7);
    t20 = (t19 & t18);
    t21 = (t20 & 1U);
    if (t21 != 0)
        goto LAB4;

LAB5:    if (*((unsigned int *)t16) != 0)
        goto LAB6;

LAB7:    t23 = (t4 + 4);
    t24 = *((unsigned int *)t4);
    t25 = *((unsigned int *)t23);
    t26 = (t24 || t25);
    if (t26 > 0)
        goto LAB8;

LAB9:    t66 = *((unsigned int *)t4);
    t67 = (~(t66));
    t68 = *((unsigned int *)t23);
    t69 = (t67 || t68);
    if (t69 > 0)
        goto LAB10;

LAB11:    if (*((unsigned int *)t23) > 0)
        goto LAB12;

LAB13:    if (*((unsigned int *)t4) > 0)
        goto LAB14;

LAB15:    memcpy(t3, t72, 8);

LAB16:    t73 = (t0 + 5528);
    t74 = (t73 + 56U);
    t75 = *((char **)t74);
    t76 = (t75 + 56U);
    t77 = *((char **)t76);
    memset(t77, 0, 8);
    t78 = 524287U;
    t79 = t78;
    t80 = (t3 + 4);
    t81 = *((unsigned int *)t3);
    t78 = (t78 & t81);
    t82 = *((unsigned int *)t80);
    t79 = (t79 & t82);
    t83 = (t77 + 4);
    t84 = *((unsigned int *)t77);
    *((unsigned int *)t77) = (t84 | t78);
    t85 = *((unsigned int *)t83);
    *((unsigned int *)t83) = (t85 | t79);
    xsi_driver_vfirst_trans(t73, 0, 18);
    t86 = (t0 + 5432);
    *((int *)t86) = 1;

LAB1:    return;
LAB4:    *((unsigned int *)t4) = 1;
    goto LAB7;

LAB6:    t22 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB7;

LAB8:    t29 = (t0 + 3528);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    memset(t32, 0, 8);
    t33 = (t32 + 4);
    t34 = (t31 + 4);
    t35 = *((unsigned int *)t31);
    t36 = (t35 >> 15);
    t37 = (t36 & 1);
    *((unsigned int *)t32) = t37;
    t38 = *((unsigned int *)t34);
    t39 = (t38 >> 15);
    t40 = (t39 & 1);
    *((unsigned int *)t33) = t40;
    memset(t28, 0, 8);
    t41 = (t32 + 4);
    t42 = *((unsigned int *)t41);
    t43 = (~(t42));
    t44 = *((unsigned int *)t32);
    t45 = (t44 & t43);
    t46 = (t45 & 1U);
    if (t46 != 0)
        goto LAB17;

LAB18:    if (*((unsigned int *)t41) != 0)
        goto LAB19;

LAB20:    t48 = (t28 + 4);
    t49 = *((unsigned int *)t28);
    t50 = *((unsigned int *)t48);
    t51 = (t49 || t50);
    if (t51 > 0)
        goto LAB21;

LAB22:    t57 = *((unsigned int *)t28);
    t58 = (~(t57));
    t59 = *((unsigned int *)t48);
    t60 = (t58 || t59);
    if (t60 > 0)
        goto LAB23;

LAB24:    if (*((unsigned int *)t48) > 0)
        goto LAB25;

LAB26:    if (*((unsigned int *)t28) > 0)
        goto LAB27;

LAB28:    memcpy(t27, t65, 8);

LAB29:    goto LAB9;

LAB10:    t70 = (t0 + 3688);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    goto LAB11;

LAB12:    xsi_vlog_unsigned_bit_combine(t3, 19, t27, 19, t72, 19);
    goto LAB16;

LAB14:    memcpy(t3, t27, 8);
    goto LAB16;

LAB17:    *((unsigned int *)t28) = 1;
    goto LAB20;

LAB19:    t47 = (t28 + 4);
    *((unsigned int *)t28) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB20;

LAB21:    t52 = ((char*)((ng2)));
    t53 = (t0 + 3688);
    t54 = (t53 + 56U);
    t55 = *((char **)t54);
    memset(t56, 0, 8);
    xsi_vlog_unsigned_minus(t56, 19, t52, 19, t55, 19);
    goto LAB22;

LAB23:    t61 = ((char*)((ng3)));
    t62 = (t0 + 3688);
    t63 = (t62 + 56U);
    t64 = *((char **)t63);
    memset(t65, 0, 8);
    xsi_vlog_unsigned_minus(t65, 19, t61, 19, t64, 19);
    goto LAB24;

LAB25:    xsi_vlog_unsigned_bit_combine(t27, 19, t56, 19, t65, 19);
    goto LAB29;

LAB27:    memcpy(t27, t56, 8);
    goto LAB29;

}

static void Cont_116_2(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;

LAB0:    t1 = (t0 + 5096U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(116, ng0);
    t2 = (t0 + 2648U);
    t4 = *((char **)t2);
    memset(t3, 0, 8);
    t2 = (t3 + 4);
    t5 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 3);
    *((unsigned int *)t3) = t7;
    t8 = *((unsigned int *)t5);
    t9 = (t8 >> 3);
    *((unsigned int *)t2) = t9;
    t10 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t10 & 65535U);
    t11 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t11 & 65535U);
    t12 = (t0 + 5592);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memset(t16, 0, 8);
    t17 = 65535U;
    t18 = t17;
    t19 = (t3 + 4);
    t20 = *((unsigned int *)t3);
    t17 = (t17 & t20);
    t21 = *((unsigned int *)t19);
    t18 = (t18 & t21);
    t22 = (t16 + 4);
    t23 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t23 | t17);
    t24 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t24 | t18);
    xsi_driver_vfirst_trans(t12, 0, 15);
    t25 = (t0 + 5448);
    *((int *)t25) = 1;

LAB1:    return;
}


extern void work_m_03745195260925115542_0393719033_init()
{
	static char *pe[] = {(void *)Always_67_0,(void *)Cont_114_1,(void *)Cont_116_2};
	xsi_register_didat("work_m_03745195260925115542_0393719033", "isim/tb_all_phase_isim_beh.exe.sim/work/m_03745195260925115542_0393719033.didat");
	xsi_register_executes(pe);
}
