Content-Type: multipart/mixed; boundary="===============8830361138697623048=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Crash in ppp_disconnect()
Date: Fri, 11 Jun 2010 14:18:08 +0300
Message-ID: <877hm5yg0f.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8830361138697623048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I saw a crash in ppp_disconnect() when I unplugged my huawei modem while
connected. Also connman crashed at the same time.

(Note to myself: core.1493)

Entering new phase: 5
Entering new phase: 0
ofonod[1439]: drivers/atmodem/gprs-context.c:ppp_disconnect() =


Program received signal SIGSEGV, Segmentation fault.
0x0000000000447d78 in ppp_disconnect (reason=3DG_AT_PPP_REASON_LINK_DEAD, =

    user_data=3D0x6f1680) at drivers/atmodem/gprs-context.c:93
93              g_at_chat_resume(gcd->chat);
(gdb) bt
#0  0x0000000000447d78 in ppp_disconnect (reason=3DG_AT_PPP_REASON_LINK_DEA=
D, =

    user_data=3D0x6f1680) at drivers/atmodem/gprs-context.c:93
#1  0x0000000000431f64 in ppp_dead (ppp=3D0x6e7080) at gatchat/gatppp.c:204
#2  0x0000000000431fa5 in ppp_enter_phase (ppp=3D0x6e7080, phase=3DPPP_PHAS=
E_DEAD)
    at gatchat/gatppp.c:214
#3  0x00000000004322d6 in ppp_lcp_finished_notify (ppp=3D0x6e7080)
    at gatchat/gatppp.c:316
#4  0x00000000004344e6 in lcp_finished (pppcp=3D0x6e7300)
    at gatchat/ppp_lcp.c:140
#5  0x0000000000432d28 in pppcp_this_layer_finished (data=3D0x6e7300)
    at gatchat/ppp_cp.c:340
#6  0x0000000000433990 in pppcp_generate_event (data=3D0x6e7300, =

    event_type=3DCLOSE, packet=3D0x0, len=3D0) at gatchat/ppp_cp.c:688
#7  0x0000000000433a09 in pppcp_signal_close (data=3D0x6e7300)
    at gatchat/ppp_cp.c:703
#8  0x00000000004323a8 in io_disconnect (user_data=3D0x6e7080)
    at gatchat/gatppp.c:349
#9  0x000000000042a856 in read_watcher_destroy_notify (user_data=3D0x6dd170)
    at gatchat/gatio.c:77
#10 0x00007ffff792fe8e in g_source_callback_unref (
    cb_data=3D<value optimized out>)
    at /build/buildd/glib2.0-2.24.1/glib/gmain.c:1077
#11 0x00007ffff79304b5 in g_source_destroy_internal (source=3D0x6e1790, =

    context=3D0x6d9000, have_lock=3D1)
    at /build/buildd/glib2.0-2.24.1/glib/gmain.c:856
#12 0x00007ffff7930933 in g_main_dispatch (context=3D0x6d9000)
    at /build/buildd/glib2.0-2.24.1/glib/gmain.c:1985
#13 IA__g_main_context_dispatch (context=3D0x6d9000)
    at /build/buildd/glib2.0-2.24.1/glib/gmain.c:2513
#14 0x00007ffff7934748 in g_main_context_iterate (context=3D0x6d9000, =

    block=3D<value optimized out>, dispatch=3D<value optimized out>, =

    self=3D<value optimized out>)
    at /build/buildd/glib2.0-2.24.1/glib/gmain.c:2591
#15 0x00007ffff7934c55 in IA__g_main_loop_run (loop=3D0x6d90e0)
    at /build/buildd/glib2.0-2.24.1/glib/gmain.c:2799
#16 0x000000000045ce35 in main (argc=3D1, argv=3D0x7fffffffe668) at src/mai=
n.c:227

-- =

Kalle Valo

--===============8830361138697623048==--

