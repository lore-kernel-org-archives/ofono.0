Content-Type: multipart/mixed; boundary="===============4009067382644854616=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] gathdlc: Unset disconnect function in unref
Date: Tue, 06 Jul 2010 11:45:19 -0500
Message-ID: <4C335D9F.5070205@gmail.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B351F6F2277@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4009067382644854616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Here the problem is that disconnect function could be invoked if remote I=
O is disconnected after our ppp instance is freed. So we should avoid to in=
voke io_disconnect() in below case.
> =

> Entering new phase: 5
> PPP: lcp: pppcp_timeout: current state 5:STOPPING
> PPP: lcp: pppcp_generate_event: current state 5:STOPPING
> PPP: event: 5 (TO-), action: 803, new_state: 3 (STOPPED)
> PPP: lcp: pppcp_this_layer_finished: current state 3:STOPPED
> Entering new phase: 0
> ofonod[3114]: src/emulator.c:ppp_disconnect() =

> Server: > \r\nNO CARRIER\r\n
> ofonod[3114]: Pcui:< \r\n^BOOT:20291346,0,0,0,20\r\n
> Server: < AT+CFUN=3D0\r
> ofonod[3114]: src/emulator.c:cfun_cb() set CFUN to 0
> Server: > \r\nOK\r\n
> =

> =

> (gdb) bt
> #0  0x0806faf6 in pppcp_generate_event (data=3D0x95bfde0, event_type=3DDO=
WN, packet=3D0x0, len=3D0)
>     at gatchat/ppp_cp.c:638
> #1  0x0806e9cd in io_disconnect (user_data=3D0x95bfde8) at gatchat/gatppp=
.c:349
> #2  0x001ea504 in g_source_callback_unref (cb_data=3D0x95a8678)
>     at /build/buildd/glib2.0-2.22.3/glib/gmain.c:1077
> #3  0x001eaace in g_source_destroy_internal (source=3D0x95a86b0, context=
=3D<value optimized out>, have_lock=3D1)
>     at /build/buildd/glib2.0-2.22.3/glib/gmain.c:856
> #4  0x001eaedb in g_main_dispatch (context=3D0x95a5f80) at /build/buildd/=
glib2.0-2.22.3/glib/gmain.c:1985
> #5  IA__g_main_context_dispatch (context=3D0x95a5f80) at /build/buildd/gl=
ib2.0-2.22.3/glib/gmain.c:2513
> #6  0x001ee730 in g_main_context_iterate (context=3D0x95a5f80, block=3D<v=
alue optimized out>, dispatch=3D1, =

>     self=3D0x95a6c58) at /build/buildd/glib2.0-2.22.3/glib/gmain.c:2591
> #7  0x001eeb9f in IA__g_main_loop_run (loop=3D0x95a5ef0) at /build/buildd=
/glib2.0-2.22.3/glib/gmain.c:2799
> #8  0x08094548 in main (argc=3D1, argv=3D0xbffb8ba4) at src/main.c:227
> (gdb) frame 1
> #1  0x0806e9cd in io_disconnect (user_data=3D0x95bfde8) at gatchat/gatppp=
.c:349
> 349		pppcp_signal_down(ppp->lcp);
> (gdb) p ppp
> $6 =3D <value optimized out>
> (gdb) info local
> No locals.
> (gdb) =


It seems the real culprit is that GAtServer is not restoring the
io_disconnect on the GAtIO object in g_at_server_resume.  Why are we not
seeing this crash in test-server?

Regards,
-Denis

--===============4009067382644854616==--

