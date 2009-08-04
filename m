Content-Type: multipart/mixed; boundary="===============7441359063443428345=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: segment fault in latest version
Date: Tue, 04 Aug 2009 13:21:34 +0800
Message-ID: <B94C62E7C2870743865418621F040C1302055CD775@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <200908032331.40950.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7441359063443428345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
>Can you post a backtrace as well.

#0  sim_eons_pnn_is_empty (eons=3D0x8088ce0) at simutil.c:253
#1  0x08060dc5 in sim_op_error (modem=3D0x8088ce0) at sim.c:297
#2  0x08061758 in sim_op_info_cb (error=3D0xbfffefcc, length=3D-1, =

    structure=3D4294967295, record_length=3D-1, access=3D0x0, data=3D0x8088=
ce0)
    at sim.c:425
#3  0x0806a4a1 in at_crsm_info_cb (ok=3D1, result=3D0xbffff038, =

    user_data=3D0x808a560) at atmodem/sim.c:83
#4  0x0806fc39 in g_at_chat_finish_command (p=3D0x8087c30, =

    ok=3D<value optimized out>, final=3D0x8089dc8 "OK") at gatchat.c:347
#5  0x080705e7 in g_at_chat_handle_command_response (
    line=3D<value optimized out>, cmd=3D<value optimized out>, =

    p=3D<value optimized out>) at gatchat.c:402
#6  have_line (line=3D<value optimized out>, cmd=3D<value optimized out>, =

    p=3D<value optimized out>) at gatchat.c:481
#7  0x080709d6 in new_bytes (p=3D<value optimized out>) at gatchat.c:671
#8  received_data (p=3D<value optimized out>) at gatchat.c:759
#9  0x006a641b in ?? () from /lib/libglib-2.0.so.0
#10 0x0066f1e8 in g_main_context_dispatch () from /lib/libglib-2.0.so.0
#11 0x006727f8 in ?? () from /lib/libglib-2.0.so.0
#12 0x00672caf in g_main_loop_run () from /lib/libglib-2.0.so.0
#13 0x0804c6ad in main (argc=3D1, argv=3D0xbffff464) at main.c:148

Anything else

>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============7441359063443428345==--

