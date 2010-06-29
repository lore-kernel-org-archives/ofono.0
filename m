Content-Type: multipart/mixed; boundary="===============7216444375945576819=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Crash in at_gprs_context_remove()
Date: Tue, 29 Jun 2010 16:15:30 +0300
Message-ID: <87eifqugi5.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7216444375945576819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I was testing my huawei disconnect patch on top of commit ca41d63a305c.
Basically I was just connecting and disconnecting in a row from connman
and ofono crashed:

Entering new phase: 0
ofonod[2365]: drivers/atmodem/gprs-context.c:ppp_disconnect() =

ofonod[2365]: Pcui:< \r\n^BOOT:38645652,0,0,0,87\r\n
ofonod[2365]: Modem:> AT+CGDCONT=3D1,"IP","internet"\r
ofonod[2365]: plugins/huawei.c:huawei_disconnect() =

ofonod[2365]: src/gprs.c:gprs_context_remove() atom: 0x6e4460
ofonod[2365]: drivers/atmodem/gprs-context.c:at_gprs_context_remove() =


Program received signal SIGSEGV, Segmentation fault.
0x00007ffff790b642 in IA__g_atomic_int_exchange_and_add (atomic=3D0x0, val=
=3D-1)
    at /build/buildd/glib2.0-2.25.8/glib/gatomic-gcc.c:30
30      /build/buildd/glib2.0-2.25.8/glib/gatomic-gcc.c: No such file or di=
rectory.
        in /build/buildd/glib2.0-2.25.8/glib/gatomic-gcc.c
(gdb) =



(gdb) bt
#0  0x00007ffff790b642 in IA__g_atomic_int_exchange_and_add (atomic=3D0x0, =

    val=3D-1) at /build/buildd/glib2.0-2.25.8/glib/gatomic-gcc.c:30
#1  0x00000000004325a3 in g_at_ppp_unref (ppp=3D0x0) at gatchat/gatppp.c:448
#2  0x0000000000448e12 in at_gprs_context_remove (gc=3D0x6e2f50)
    at drivers/atmodem/gprs-context.c:260
#3  0x00000000004923c9 in gprs_context_remove (atom=3D0x6e4460)
    at src/gprs.c:1418
#4  0x000000000045eacd in __ofono_atom_free (atom=3D0x6e4460) at src/modem.=
c:319
#5  0x00000000004924e8 in ofono_gprs_context_remove (gc=3D0x6e2f50)
    at src/gprs.c:1459
#6  0x0000000000457b4d in huawei_disconnect (user_data=3D0x6ee010)
    at plugins/huawei.c:233
#7  0x0000000000427369 in io_disconnect (user_data=3D0x6e49a0)
    at gatchat/gatchat.c:290
#8  0x000000000042a87a in read_watcher_destroy_notify (user_data=3D0x6ea760)
    at gatchat/gatio.c:77
#9  0x00007ffff792f82e in g_source_callback_unref (
    cb_data=3D<value optimized out>)
    at /build/buildd/glib2.0-2.25.8/glib/gmain.c:1077
#10 0x00007ffff792fe65 in g_source_destroy_internal (source=3D0x6efdb0, =

    context=3D0x6e1000, have_lock=3D1)
    at /build/buildd/glib2.0-2.25.8/glib/gmain.c:856
#11 0x00007ffff79302e3 in g_main_dispatch (context=3D0x6e1000)
---Type <return> to continue, or q <return> to quit---
    at /build/buildd/glib2.0-2.25.8/glib/gmain.c:2069
#12 IA__g_main_context_dispatch (context=3D0x6e1000)
    at /build/buildd/glib2.0-2.25.8/glib/gmain.c:2597
#13 0x00007ffff79341b8 in g_main_context_iterate (context=3D0x6e1000, =

    block=3D<value optimized out>, dispatch=3D<value optimized out>, =

    self=3D<value optimized out>)
    at /build/buildd/glib2.0-2.25.8/glib/gmain.c:2675
#14 0x00007ffff79346c5 in IA__g_main_loop_run (loop=3D0x6e10e0)
    at /build/buildd/glib2.0-2.25.8/glib/gmain.c:2883
#15 0x000000000045db7d in main (argc=3D1, argv=3D0x7fffffffe668) at src/mai=
n.c:227
(gdb) =


(gdb) info locals
is_zero =3D 0
(gdb) up
#2  0x0000000000448e12 in at_gprs_context_remove (gc=3D0x6e2f50)
    at drivers/atmodem/gprs-context.c:260
260                     g_at_ppp_unref(gcd->ppp);
(gdb) info locals
gcd =3D 0x6ee1d0
__FUNCTION__ =3D "at_gprs_context_remove"
(gdb) p *gc
$1 =3D {gprs =3D 0x0, pending =3D 0x6e43c0, driver =3D 0x6d80a0, =

  driver_data =3D 0x6ee1d0, atom =3D 0x6e4460}
(gdb) p *gcd
$2 =3D {chat =3D 0x6e49a0, active_context =3D 1, =

  username =3D '\000' <repeats 63 times>, password =3D '\000' <repeats 255 =
times>, =

  ppp =3D 0x0, state =3D STATE_ENABLING, {
    down_cb =3D 0x48fc7f <pri_activate_callback>, =

    up_cb =3D 0x48fc7f <pri_activate_callback>}, cb_data =3D 0x6f0c00}
(gdb) =


-- =

Kalle Valo

--===============7216444375945576819==--

