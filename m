Content-Type: multipart/mixed; boundary="===============8025723413233547005=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 2/2] gathdlc: Unset disconnect function in unref
Date: Tue, 06 Jul 2010 18:03:15 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F6F2277@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1278410258-3077-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8025723413233547005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Zhenhua Zhang wrote:
> If we destroy PPP instance from g_at_ppp_unref, we should not invoke
> io disconnect function. ---
> gatchat/gathdlc.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
> index 08a1939..0186e46 100644
> --- a/gatchat/gathdlc.c
> +++ b/gatchat/gathdlc.c
> @@ -278,6 +278,7 @@ void g_at_hdlc_unref(GAtHDLC *hdlc)
> 	hdlc->record_fd =3D -1; }
> =

> +	g_at_io_set_disconnect_function(hdlc->io, NULL, NULL);
> 	g_at_io_unref(hdlc->io); hdlc->io =3D NULL;

Here the problem is that disconnect function could be invoked if remote IO =
is disconnected after our ppp instance is freed. So we should avoid to invo=
ke io_disconnect() in below case.

Entering new phase: 5
PPP: lcp: pppcp_timeout: current state 5:STOPPING
PPP: lcp: pppcp_generate_event: current state 5:STOPPING
PPP: event: 5 (TO-), action: 803, new_state: 3 (STOPPED)
PPP: lcp: pppcp_this_layer_finished: current state 3:STOPPED
Entering new phase: 0
ofonod[3114]: src/emulator.c:ppp_disconnect() =

Server: > \r\nNO CARRIER\r\n
ofonod[3114]: Pcui:< \r\n^BOOT:20291346,0,0,0,20\r\n
Server: < AT+CFUN=3D0\r
ofonod[3114]: src/emulator.c:cfun_cb() set CFUN to 0
Server: > \r\nOK\r\n


(gdb) bt
#0  0x0806faf6 in pppcp_generate_event (data=3D0x95bfde0, event_type=3DDOWN=
, packet=3D0x0, len=3D0)
    at gatchat/ppp_cp.c:638
#1  0x0806e9cd in io_disconnect (user_data=3D0x95bfde8) at gatchat/gatppp.c=
:349
#2  0x001ea504 in g_source_callback_unref (cb_data=3D0x95a8678)
    at /build/buildd/glib2.0-2.22.3/glib/gmain.c:1077
#3  0x001eaace in g_source_destroy_internal (source=3D0x95a86b0, context=3D=
<value optimized out>, have_lock=3D1)
    at /build/buildd/glib2.0-2.22.3/glib/gmain.c:856
#4  0x001eaedb in g_main_dispatch (context=3D0x95a5f80) at /build/buildd/gl=
ib2.0-2.22.3/glib/gmain.c:1985
#5  IA__g_main_context_dispatch (context=3D0x95a5f80) at /build/buildd/glib=
2.0-2.22.3/glib/gmain.c:2513
#6  0x001ee730 in g_main_context_iterate (context=3D0x95a5f80, block=3D<val=
ue optimized out>, dispatch=3D1, =

    self=3D0x95a6c58) at /build/buildd/glib2.0-2.22.3/glib/gmain.c:2591
#7  0x001eeb9f in IA__g_main_loop_run (loop=3D0x95a5ef0) at /build/buildd/g=
lib2.0-2.22.3/glib/gmain.c:2799
#8  0x08094548 in main (argc=3D1, argv=3D0xbffb8ba4) at src/main.c:227
(gdb) frame 1
#1  0x0806e9cd in io_disconnect (user_data=3D0x95bfde8) at gatchat/gatppp.c=
:349
349		pppcp_signal_down(ppp->lcp);
(gdb) p ppp
$6 =3D <value optimized out>
(gdb) info local
No locals.
(gdb) =


> --
> 1.6.3.3
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============8025723413233547005==--

