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
static const char *ng0 = "/home/ise/EDAtools/proj_v2/src/verilog-rtl/phasemean.v";
static int ng1[] = {1, 0};
static unsigned int ng2[] = {0U, 0U};
static int ng3[] = {0, 0};
static unsigned int ng4[] = {0U, 0U, 0U, 0U};
static unsigned int ng5[] = {1U, 0U};
static unsigned int ng6[] = {2U, 0U};
static unsigned int ng7[] = {3U, 0U};
static unsigned int ng8[] = {4U, 0U};
static unsigned int ng9[] = {5U, 0U};
static unsigned int ng10[] = {6U, 0U};



static void Cont_73_0(char *t0)
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
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 7448U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(73, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2616U);
    t4 = *((char **)t3);
    memset(t5, 0, 8);
    xsi_vlog_signed_lshift(t5, 32, t2, 32, t4, 10);
    t3 = (t0 + 8376);
    t6 = (t3 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 8191U;
    t11 = t10;
    t12 = (t5 + 4);
    t13 = *((unsigned int *)t5);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t3, 0, 12);
    t18 = (t0 + 8264);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Always_76_1(char *t0)
{
    char t14[8];
    char t24[8];
    char t32[8];
    char t68[16];
    char t69[16];
    char t70[16];
    char t71[8];
    char t72[8];
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
    int t13;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t31;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    char *t46;
    char *t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    char *t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    char *t66;
    char *t67;
    unsigned int t73;
    char *t74;
    char *t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    char *t83;
    char *t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    unsigned int t98;
    char *t99;
    unsigned int t100;
    unsigned int t101;
    unsigned int t102;
    unsigned int t103;
    unsigned int t104;
    char *t105;
    char *t106;

LAB0:    t1 = (t0 + 7696U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(76, ng0);
    t2 = (t0 + 8280);
    *((int *)t2) = 1;
    t3 = (t0 + 7728);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(77, ng0);

LAB5:    xsi_set_current_line(78, ng0);
    t4 = (t0 + 2296U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(99, ng0);

LAB10:    xsi_set_current_line(101, ng0);
    t2 = (t0 + 5096);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB11:    t5 = ((char*)((ng2)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t5, 3);
    if (t13 == 1)
        goto LAB12;

LAB13:    t2 = ((char*)((ng5)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t13 == 1)
        goto LAB14;

LAB15:    t2 = ((char*)((ng6)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t13 == 1)
        goto LAB16;

LAB17:    t2 = ((char*)((ng7)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t13 == 1)
        goto LAB18;

LAB19:    t2 = ((char*)((ng8)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t13 == 1)
        goto LAB20;

LAB21:    t2 = ((char*)((ng9)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t13 == 1)
        goto LAB22;

LAB23:    t2 = ((char*)((ng10)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t13 == 1)
        goto LAB24;

LAB25:
LAB26:    xsi_set_current_line(193, ng0);
    t2 = (t0 + 6376);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    memset(t14, 0, 8);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 & 1U);
    if (t10 != 0)
        goto LAB108;

LAB109:    if (*((unsigned int *)t11) != 0)
        goto LAB110;

LAB111:    t15 = (t14 + 4);
    t17 = *((unsigned int *)t14);
    t18 = *((unsigned int *)t15);
    t19 = (t17 || t18);
    if (t19 > 0)
        goto LAB112;

LAB113:    memcpy(t32, t14, 8);

LAB114:    t60 = (t32 + 4);
    t64 = *((unsigned int *)t60);
    t65 = (~(t64));
    t73 = *((unsigned int *)t32);
    t76 = (t73 & t65);
    t77 = (t76 != 0);
    if (t77 > 0)
        goto LAB122;

LAB123:
LAB124:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(78, ng0);

LAB9:    xsi_set_current_line(79, ng0);
    t11 = ((char*)((ng2)));
    t12 = (t0 + 5096);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 3, 0LL);
    xsi_set_current_line(81, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 6376);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(83, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 6536);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(85, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 5256);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    xsi_set_current_line(86, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 5416);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    xsi_set_current_line(87, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 5576);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    xsi_set_current_line(88, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 5736);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    xsi_set_current_line(89, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 5896);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    xsi_set_current_line(90, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 6056);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    xsi_set_current_line(92, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4136);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    xsi_set_current_line(93, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4296);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    xsi_set_current_line(94, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4456);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    xsi_set_current_line(95, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4616);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    xsi_set_current_line(96, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4776);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    xsi_set_current_line(97, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4936);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    goto LAB8;

LAB12:    xsi_set_current_line(103, ng0);

LAB27:    xsi_set_current_line(104, ng0);
    t11 = (t0 + 2456U);
    t12 = *((char **)t11);
    memset(t14, 0, 8);
    t11 = (t12 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (~(t6));
    t8 = *((unsigned int *)t12);
    t9 = (t8 & t7);
    t10 = (t9 & 1U);
    if (t10 != 0)
        goto LAB28;

LAB29:    if (*((unsigned int *)t11) != 0)
        goto LAB30;

LAB31:    t16 = (t14 + 4);
    t17 = *((unsigned int *)t14);
    t18 = (!(t17));
    t19 = *((unsigned int *)t16);
    t20 = (t18 || t19);
    if (t20 > 0)
        goto LAB32;

LAB33:    memcpy(t32, t14, 8);

LAB34:    t60 = (t32 + 4);
    t61 = *((unsigned int *)t60);
    t62 = (~(t61));
    t63 = *((unsigned int *)t32);
    t64 = (t63 & t62);
    t65 = (t64 != 0);
    if (t65 > 0)
        goto LAB42;

LAB43:
LAB44:    goto LAB26;

LAB14:    xsi_set_current_line(111, ng0);

LAB46:    xsi_set_current_line(112, ng0);
    t3 = ((char*)((ng6)));
    t5 = (t0 + 5096);
    xsi_vlogvar_wait_assign_value(t5, t3, 0, 0, 3, 0LL);
    xsi_set_current_line(113, ng0);
    t2 = (t0 + 6376);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB47;

LAB48:    xsi_set_current_line(117, ng0);

LAB51:    xsi_set_current_line(119, ng0);
    t2 = (t0 + 5256);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t0 + 2776U);
    t12 = *((char **)t11);
    xsi_vlogtype_sign_extend(t69, 36, t12, 16);
    xsi_vlog_signed_add(t70, 36, t5, 36, t69, 36);
    t11 = (t0 + 5256);
    xsi_vlogvar_wait_assign_value(t11, t70, 0, 0, 36, 0LL);

LAB49:    goto LAB26;

LAB16:    xsi_set_current_line(124, ng0);

LAB52:    xsi_set_current_line(125, ng0);
    t3 = ((char*)((ng7)));
    t5 = (t0 + 5096);
    xsi_vlogvar_wait_assign_value(t5, t3, 0, 0, 3, 0LL);
    xsi_set_current_line(126, ng0);
    t2 = (t0 + 6376);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB53;

LAB54:    xsi_set_current_line(130, ng0);

LAB57:    xsi_set_current_line(132, ng0);
    t2 = (t0 + 5416);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t0 + 2936U);
    t12 = *((char **)t11);
    xsi_vlogtype_sign_extend(t69, 36, t12, 16);
    xsi_vlog_signed_add(t70, 36, t5, 36, t69, 36);
    t11 = (t0 + 5416);
    xsi_vlogvar_wait_assign_value(t11, t70, 0, 0, 36, 0LL);

LAB55:    goto LAB26;

LAB18:    xsi_set_current_line(137, ng0);

LAB58:    xsi_set_current_line(138, ng0);
    t3 = ((char*)((ng8)));
    t5 = (t0 + 5096);
    xsi_vlogvar_wait_assign_value(t5, t3, 0, 0, 3, 0LL);
    xsi_set_current_line(139, ng0);
    t2 = (t0 + 6376);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB59;

LAB60:    xsi_set_current_line(143, ng0);

LAB63:    xsi_set_current_line(144, ng0);
    t2 = (t0 + 5576);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t0 + 3096U);
    t12 = *((char **)t11);
    xsi_vlogtype_sign_extend(t69, 36, t12, 16);
    xsi_vlog_signed_add(t70, 36, t5, 36, t69, 36);
    t11 = (t0 + 5576);
    xsi_vlogvar_wait_assign_value(t11, t70, 0, 0, 36, 0LL);

LAB61:    goto LAB26;

LAB20:    xsi_set_current_line(149, ng0);

LAB64:    xsi_set_current_line(150, ng0);
    t3 = ((char*)((ng9)));
    t5 = (t0 + 5096);
    xsi_vlogvar_wait_assign_value(t5, t3, 0, 0, 3, 0LL);
    xsi_set_current_line(151, ng0);
    t2 = (t0 + 6376);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB65;

LAB66:    xsi_set_current_line(155, ng0);

LAB69:    xsi_set_current_line(157, ng0);
    t2 = (t0 + 5736);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t0 + 3256U);
    t12 = *((char **)t11);
    xsi_vlogtype_sign_extend(t69, 36, t12, 16);
    xsi_vlog_signed_add(t70, 36, t5, 36, t69, 36);
    t11 = (t0 + 5736);
    xsi_vlogvar_wait_assign_value(t11, t70, 0, 0, 36, 0LL);

LAB67:    goto LAB26;

LAB22:    xsi_set_current_line(162, ng0);

LAB70:    xsi_set_current_line(163, ng0);
    t3 = ((char*)((ng10)));
    t5 = (t0 + 5096);
    xsi_vlogvar_wait_assign_value(t5, t3, 0, 0, 3, 0LL);
    xsi_set_current_line(164, ng0);
    t2 = (t0 + 6376);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB71;

LAB72:    xsi_set_current_line(168, ng0);

LAB75:    xsi_set_current_line(170, ng0);
    t2 = (t0 + 5896);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t0 + 3416U);
    t12 = *((char **)t11);
    xsi_vlogtype_sign_extend(t69, 36, t12, 16);
    xsi_vlog_signed_add(t70, 36, t5, 36, t69, 36);
    t11 = (t0 + 5896);
    xsi_vlogvar_wait_assign_value(t11, t70, 0, 0, 36, 0LL);

LAB73:    goto LAB26;

LAB24:    xsi_set_current_line(175, ng0);

LAB76:    xsi_set_current_line(176, ng0);
    t3 = ((char*)((ng2)));
    t5 = (t0 + 5096);
    xsi_vlogvar_wait_assign_value(t5, t3, 0, 0, 3, 0LL);
    xsi_set_current_line(177, ng0);
    t2 = (t0 + 6376);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB77;

LAB78:    xsi_set_current_line(181, ng0);

LAB81:    xsi_set_current_line(183, ng0);
    t2 = (t0 + 6056);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = (t0 + 3576U);
    t12 = *((char **)t11);
    xsi_vlogtype_sign_extend(t69, 36, t12, 16);
    xsi_vlog_signed_add(t70, 36, t5, 36, t69, 36);
    t11 = (t0 + 6056);
    xsi_vlogvar_wait_assign_value(t11, t70, 0, 0, 36, 0LL);
    xsi_set_current_line(184, ng0);
    t2 = (t0 + 6216);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = ((char*)((ng3)));
    memset(t14, 0, 8);
    t12 = (t5 + 4);
    t15 = (t11 + 4);
    t6 = *((unsigned int *)t5);
    t7 = *((unsigned int *)t11);
    t8 = (t6 ^ t7);
    t9 = *((unsigned int *)t12);
    t10 = *((unsigned int *)t15);
    t17 = (t9 ^ t10);
    t18 = (t8 | t17);
    t19 = *((unsigned int *)t12);
    t20 = *((unsigned int *)t15);
    t26 = (t19 | t20);
    t27 = (~(t26));
    t28 = (t18 & t27);
    if (t28 != 0)
        goto LAB85;

LAB82:    if (t26 != 0)
        goto LAB84;

LAB83:    *((unsigned int *)t14) = 1;

LAB85:    memset(t24, 0, 8);
    t21 = (t14 + 4);
    t29 = *((unsigned int *)t21);
    t30 = (~(t29));
    t33 = *((unsigned int *)t14);
    t34 = (t33 & t30);
    t35 = (t34 & 1U);
    if (t35 != 0)
        goto LAB86;

LAB87:    if (*((unsigned int *)t21) != 0)
        goto LAB88;

LAB89:    t23 = (t24 + 4);
    t39 = *((unsigned int *)t24);
    t40 = *((unsigned int *)t23);
    t41 = (t39 || t40);
    if (t41 > 0)
        goto LAB90;

LAB91:    memcpy(t72, t24, 8);

LAB92:    t99 = (t72 + 4);
    t100 = *((unsigned int *)t99);
    t101 = (~(t100));
    t102 = *((unsigned int *)t72);
    t103 = (t102 & t101);
    t104 = (t103 != 0);
    if (t104 > 0)
        goto LAB104;

LAB105:
LAB106:
LAB79:    goto LAB26;

LAB28:    *((unsigned int *)t14) = 1;
    goto LAB31;

LAB30:    t15 = (t14 + 4);
    *((unsigned int *)t14) = 1;
    *((unsigned int *)t15) = 1;
    goto LAB31;

LAB32:    t21 = (t0 + 6376);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memset(t24, 0, 8);
    t25 = (t23 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t23);
    t29 = (t28 & t27);
    t30 = (t29 & 1U);
    if (t30 != 0)
        goto LAB35;

LAB36:    if (*((unsigned int *)t25) != 0)
        goto LAB37;

LAB38:    t33 = *((unsigned int *)t14);
    t34 = *((unsigned int *)t24);
    t35 = (t33 | t34);
    *((unsigned int *)t32) = t35;
    t36 = (t14 + 4);
    t37 = (t24 + 4);
    t38 = (t32 + 4);
    t39 = *((unsigned int *)t36);
    t40 = *((unsigned int *)t37);
    t41 = (t39 | t40);
    *((unsigned int *)t38) = t41;
    t42 = *((unsigned int *)t38);
    t43 = (t42 != 0);
    if (t43 == 1)
        goto LAB39;

LAB40:
LAB41:    goto LAB34;

LAB35:    *((unsigned int *)t24) = 1;
    goto LAB38;

LAB37:    t31 = (t24 + 4);
    *((unsigned int *)t24) = 1;
    *((unsigned int *)t31) = 1;
    goto LAB38;

LAB39:    t44 = *((unsigned int *)t32);
    t45 = *((unsigned int *)t38);
    *((unsigned int *)t32) = (t44 | t45);
    t46 = (t14 + 4);
    t47 = (t24 + 4);
    t48 = *((unsigned int *)t46);
    t49 = (~(t48));
    t50 = *((unsigned int *)t14);
    t51 = (t50 & t49);
    t52 = *((unsigned int *)t47);
    t53 = (~(t52));
    t54 = *((unsigned int *)t24);
    t55 = (t54 & t53);
    t56 = (~(t51));
    t57 = (~(t55));
    t58 = *((unsigned int *)t38);
    *((unsigned int *)t38) = (t58 & t56);
    t59 = *((unsigned int *)t38);
    *((unsigned int *)t38) = (t59 & t57);
    goto LAB41;

LAB42:    xsi_set_current_line(104, ng0);

LAB45:    xsi_set_current_line(105, ng0);
    t66 = ((char*)((ng5)));
    t67 = (t0 + 5096);
    xsi_vlogvar_wait_assign_value(t67, t66, 0, 0, 3, 0LL);
    xsi_set_current_line(106, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 6536);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB44;

LAB47:    xsi_set_current_line(113, ng0);

LAB50:    xsi_set_current_line(114, ng0);
    t12 = (t0 + 5256);
    t15 = (t12 + 56U);
    t16 = *((char **)t15);
    t21 = (t0 + 2616U);
    t22 = *((char **)t21);
    xsi_vlog_signed_arith_rshift(t68, 36, t16, 36, t22, 10);
    t21 = (t0 + 4136);
    xsi_vlogvar_wait_assign_value(t21, t68, 0, 0, 16, 0LL);
    xsi_set_current_line(115, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 5256);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    goto LAB49;

LAB53:    xsi_set_current_line(126, ng0);

LAB56:    xsi_set_current_line(127, ng0);
    t12 = (t0 + 5416);
    t15 = (t12 + 56U);
    t16 = *((char **)t15);
    t21 = (t0 + 2616U);
    t22 = *((char **)t21);
    xsi_vlog_signed_arith_rshift(t68, 36, t16, 36, t22, 10);
    t21 = (t0 + 4296);
    xsi_vlogvar_wait_assign_value(t21, t68, 0, 0, 16, 0LL);
    xsi_set_current_line(128, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 5416);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    goto LAB55;

LAB59:    xsi_set_current_line(139, ng0);

LAB62:    xsi_set_current_line(140, ng0);
    t12 = (t0 + 5576);
    t15 = (t12 + 56U);
    t16 = *((char **)t15);
    t21 = (t0 + 2616U);
    t22 = *((char **)t21);
    xsi_vlog_signed_arith_rshift(t68, 36, t16, 36, t22, 10);
    t21 = (t0 + 4456);
    xsi_vlogvar_wait_assign_value(t21, t68, 0, 0, 16, 0LL);
    xsi_set_current_line(141, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 5576);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    goto LAB61;

LAB65:    xsi_set_current_line(151, ng0);

LAB68:    xsi_set_current_line(152, ng0);
    t12 = (t0 + 5736);
    t15 = (t12 + 56U);
    t16 = *((char **)t15);
    t21 = (t0 + 2616U);
    t22 = *((char **)t21);
    xsi_vlog_signed_arith_rshift(t68, 36, t16, 36, t22, 10);
    t21 = (t0 + 4616);
    xsi_vlogvar_wait_assign_value(t21, t68, 0, 0, 16, 0LL);
    xsi_set_current_line(153, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 5736);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    goto LAB67;

LAB71:    xsi_set_current_line(164, ng0);

LAB74:    xsi_set_current_line(165, ng0);
    t12 = (t0 + 5896);
    t15 = (t12 + 56U);
    t16 = *((char **)t15);
    t21 = (t0 + 2616U);
    t22 = *((char **)t21);
    xsi_vlog_signed_arith_rshift(t68, 36, t16, 36, t22, 10);
    t21 = (t0 + 4776);
    xsi_vlogvar_wait_assign_value(t21, t68, 0, 0, 16, 0LL);
    xsi_set_current_line(166, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 5896);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    goto LAB73;

LAB77:    xsi_set_current_line(177, ng0);

LAB80:    xsi_set_current_line(178, ng0);
    t12 = (t0 + 6056);
    t15 = (t12 + 56U);
    t16 = *((char **)t15);
    t21 = (t0 + 2616U);
    t22 = *((char **)t21);
    xsi_vlog_signed_arith_rshift(t68, 36, t16, 36, t22, 10);
    t21 = (t0 + 4936);
    xsi_vlogvar_wait_assign_value(t21, t68, 0, 0, 16, 0LL);
    xsi_set_current_line(179, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 6056);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 36, 0LL);
    goto LAB79;

LAB84:    t16 = (t14 + 4);
    *((unsigned int *)t14) = 1;
    *((unsigned int *)t16) = 1;
    goto LAB85;

LAB86:    *((unsigned int *)t24) = 1;
    goto LAB89;

LAB88:    t22 = (t24 + 4);
    *((unsigned int *)t24) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB89;

LAB90:    t25 = (t0 + 6536);
    t31 = (t25 + 56U);
    t36 = *((char **)t31);
    t37 = ((char*)((ng3)));
    memset(t32, 0, 8);
    t38 = (t36 + 4);
    t46 = (t37 + 4);
    t42 = *((unsigned int *)t36);
    t43 = *((unsigned int *)t37);
    t44 = (t42 ^ t43);
    t45 = *((unsigned int *)t38);
    t48 = *((unsigned int *)t46);
    t49 = (t45 ^ t48);
    t50 = (t44 | t49);
    t52 = *((unsigned int *)t38);
    t53 = *((unsigned int *)t46);
    t54 = (t52 | t53);
    t56 = (~(t54));
    t57 = (t50 & t56);
    if (t57 != 0)
        goto LAB96;

LAB93:    if (t54 != 0)
        goto LAB95;

LAB94:    *((unsigned int *)t32) = 1;

LAB96:    memset(t71, 0, 8);
    t60 = (t32 + 4);
    t58 = *((unsigned int *)t60);
    t59 = (~(t58));
    t61 = *((unsigned int *)t32);
    t62 = (t61 & t59);
    t63 = (t62 & 1U);
    if (t63 != 0)
        goto LAB97;

LAB98:    if (*((unsigned int *)t60) != 0)
        goto LAB99;

LAB100:    t64 = *((unsigned int *)t24);
    t65 = *((unsigned int *)t71);
    t73 = (t64 & t65);
    *((unsigned int *)t72) = t73;
    t67 = (t24 + 4);
    t74 = (t71 + 4);
    t75 = (t72 + 4);
    t76 = *((unsigned int *)t67);
    t77 = *((unsigned int *)t74);
    t78 = (t76 | t77);
    *((unsigned int *)t75) = t78;
    t79 = *((unsigned int *)t75);
    t80 = (t79 != 0);
    if (t80 == 1)
        goto LAB101;

LAB102:
LAB103:    goto LAB92;

LAB95:    t47 = (t32 + 4);
    *((unsigned int *)t32) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB96;

LAB97:    *((unsigned int *)t71) = 1;
    goto LAB100;

LAB99:    t66 = (t71 + 4);
    *((unsigned int *)t71) = 1;
    *((unsigned int *)t66) = 1;
    goto LAB100;

LAB101:    t81 = *((unsigned int *)t72);
    t82 = *((unsigned int *)t75);
    *((unsigned int *)t72) = (t81 | t82);
    t83 = (t24 + 4);
    t84 = (t71 + 4);
    t85 = *((unsigned int *)t24);
    t86 = (~(t85));
    t87 = *((unsigned int *)t83);
    t88 = (~(t87));
    t89 = *((unsigned int *)t71);
    t90 = (~(t89));
    t91 = *((unsigned int *)t84);
    t92 = (~(t91));
    t13 = (t86 & t88);
    t51 = (t90 & t92);
    t93 = (~(t13));
    t94 = (~(t51));
    t95 = *((unsigned int *)t75);
    *((unsigned int *)t75) = (t95 & t93);
    t96 = *((unsigned int *)t75);
    *((unsigned int *)t75) = (t96 & t94);
    t97 = *((unsigned int *)t72);
    *((unsigned int *)t72) = (t97 & t93);
    t98 = *((unsigned int *)t72);
    *((unsigned int *)t72) = (t98 & t94);
    goto LAB103;

LAB104:    xsi_set_current_line(184, ng0);

LAB107:    xsi_set_current_line(185, ng0);
    t105 = ((char*)((ng1)));
    t106 = (t0 + 6376);
    xsi_vlogvar_wait_assign_value(t106, t105, 0, 0, 1, 0LL);
    goto LAB106;

LAB108:    *((unsigned int *)t14) = 1;
    goto LAB111;

LAB110:    t12 = (t14 + 4);
    *((unsigned int *)t14) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB111;

LAB112:    t16 = (t0 + 5896);
    t21 = (t16 + 56U);
    t22 = *((char **)t21);
    t23 = ((char*)((ng4)));
    xsi_vlog_unsigned_equal(t68, 36, t22, 36, t23, 36);
    memset(t24, 0, 8);
    t25 = (t68 + 4);
    t20 = *((unsigned int *)t25);
    t26 = (~(t20));
    t27 = *((unsigned int *)t68);
    t28 = (t27 & t26);
    t29 = (t28 & 1U);
    if (t29 != 0)
        goto LAB115;

LAB116:    if (*((unsigned int *)t25) != 0)
        goto LAB117;

LAB118:    t30 = *((unsigned int *)t14);
    t33 = *((unsigned int *)t24);
    t34 = (t30 & t33);
    *((unsigned int *)t32) = t34;
    t36 = (t14 + 4);
    t37 = (t24 + 4);
    t38 = (t32 + 4);
    t35 = *((unsigned int *)t36);
    t39 = *((unsigned int *)t37);
    t40 = (t35 | t39);
    *((unsigned int *)t38) = t40;
    t41 = *((unsigned int *)t38);
    t42 = (t41 != 0);
    if (t42 == 1)
        goto LAB119;

LAB120:
LAB121:    goto LAB114;

LAB115:    *((unsigned int *)t24) = 1;
    goto LAB118;

LAB117:    t31 = (t24 + 4);
    *((unsigned int *)t24) = 1;
    *((unsigned int *)t31) = 1;
    goto LAB118;

LAB119:    t43 = *((unsigned int *)t32);
    t44 = *((unsigned int *)t38);
    *((unsigned int *)t32) = (t43 | t44);
    t46 = (t14 + 4);
    t47 = (t24 + 4);
    t45 = *((unsigned int *)t14);
    t48 = (~(t45));
    t49 = *((unsigned int *)t46);
    t50 = (~(t49));
    t52 = *((unsigned int *)t24);
    t53 = (~(t52));
    t54 = *((unsigned int *)t47);
    t56 = (~(t54));
    t13 = (t48 & t50);
    t51 = (t53 & t56);
    t57 = (~(t13));
    t58 = (~(t51));
    t59 = *((unsigned int *)t38);
    *((unsigned int *)t38) = (t59 & t57);
    t61 = *((unsigned int *)t38);
    *((unsigned int *)t38) = (t61 & t58);
    t62 = *((unsigned int *)t32);
    *((unsigned int *)t32) = (t62 & t57);
    t63 = *((unsigned int *)t32);
    *((unsigned int *)t32) = (t63 & t58);
    goto LAB121;

LAB122:    xsi_set_current_line(193, ng0);

LAB125:    xsi_set_current_line(194, ng0);
    t66 = ((char*)((ng3)));
    t67 = (t0 + 6376);
    xsi_vlogvar_wait_assign_value(t67, t66, 0, 0, 1, 0LL);
    xsi_set_current_line(195, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 6536);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB124;

}

static void Always_202_2(char *t0)
{
    char t13[8];
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
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    char *t35;
    char *t36;

LAB0:    t1 = (t0 + 7944U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(202, ng0);
    t2 = (t0 + 8296);
    *((int *)t2) = 1;
    t3 = (t0 + 7976);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(203, ng0);

LAB5:    xsi_set_current_line(204, ng0);
    t4 = (t0 + 2296U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(207, ng0);

LAB10:    xsi_set_current_line(209, ng0);
    t2 = (t0 + 2456U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB11;

LAB12:
LAB13:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(204, ng0);

LAB9:    xsi_set_current_line(205, ng0);
    t11 = (t0 + 3736U);
    t12 = *((char **)t11);
    t11 = (t0 + 6216);
    xsi_vlogvar_wait_assign_value(t11, t12, 0, 0, 11, 0LL);
    goto LAB8;

LAB11:    xsi_set_current_line(209, ng0);

LAB14:    xsi_set_current_line(211, ng0);
    t4 = (t0 + 6216);
    t5 = (t4 + 56U);
    t11 = *((char **)t5);
    t12 = ((char*)((ng3)));
    memset(t13, 0, 8);
    t14 = (t11 + 4);
    t15 = (t12 + 4);
    t16 = *((unsigned int *)t11);
    t17 = *((unsigned int *)t12);
    t18 = (t16 ^ t17);
    t19 = *((unsigned int *)t14);
    t20 = *((unsigned int *)t15);
    t21 = (t19 ^ t20);
    t22 = (t18 | t21);
    t23 = *((unsigned int *)t14);
    t24 = *((unsigned int *)t15);
    t25 = (t23 | t24);
    t26 = (~(t25));
    t27 = (t22 & t26);
    if (t27 != 0)
        goto LAB18;

LAB15:    if (t25 != 0)
        goto LAB17;

LAB16:    *((unsigned int *)t13) = 1;

LAB18:    t29 = (t13 + 4);
    t30 = *((unsigned int *)t29);
    t31 = (~(t30));
    t32 = *((unsigned int *)t13);
    t33 = (t32 & t31);
    t34 = (t33 != 0);
    if (t34 > 0)
        goto LAB19;

LAB20:    xsi_set_current_line(215, ng0);

LAB23:    xsi_set_current_line(216, ng0);
    t2 = (t0 + 6216);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng1)));
    memset(t13, 0, 8);
    xsi_vlog_unsigned_minus(t13, 32, t4, 11, t5, 32);
    t11 = (t0 + 6216);
    xsi_vlogvar_wait_assign_value(t11, t13, 0, 0, 11, 0LL);

LAB21:    goto LAB13;

LAB17:    t28 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB18;

LAB19:    xsi_set_current_line(211, ng0);

LAB22:    xsi_set_current_line(212, ng0);
    t35 = (t0 + 3736U);
    t36 = *((char **)t35);
    t35 = (t0 + 6216);
    xsi_vlogvar_wait_assign_value(t35, t36, 0, 0, 11, 0LL);
    goto LAB21;

}


extern void work_m_08531643148410067382_4279713327_init()
{
	static char *pe[] = {(void *)Cont_73_0,(void *)Always_76_1,(void *)Always_202_2};
	xsi_register_didat("work_m_08531643148410067382_4279713327", "isim/tb_all_phase_isim_beh.exe.sim/work/m_08531643148410067382_4279713327.didat");
	xsi_register_executes(pe);
}
