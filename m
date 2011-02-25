Content-Type: multipart/mixed; boundary="===============2335549070566269863=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: Re: [PATCH] stk: Add null pointer check
Date: Fri, 25 Feb 2011 15:04:55 +0200
Message-ID: <1298639095.5082.20.camel@lkunnasl-desktop>
In-Reply-To: <AANLkTin=rBFxJ-EbUOKs71nKspQmf6qVXBcCWfCyo8G=@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2335549070566269863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej,

On Fri, 2011-02-25 at 14:39 +0200, Andrzej Zaborowski wrote:
> Hi Lasse,
> =

> On 25 February 2011 11:39, Lasse Kunnasluoto
> <lasse.kunnasluoto@tieto.com> wrote:
> > Fixes a crash when SIM Session End is received while waiting for user r=
esponse to SELECT ITEM command.
> =

> Can you post the ofono debug log for example?  It sounds like
> something else is wrong because stk_respond should not be called when
> the session is ended by the card.

Sure, log below.

For me it looks like modem times out after 1 min if no response given. I
don't think the session was terminated by SIM. Usually SIM cards wait
for TERMINAL RESPONSE basically forever. SIM has no mechanism to
terminate ongoing proactive command (well, except reset itself)

ofonod[3228]: src/stk.c:stk_select_item() =

ofonod[3228]: src/stk.c:stk_select_item() =

ofonod[3228]: src/stk.c:stk_send_envelope() =

ofonod[3228]: drivers/mbmmodem/stk.c:mbm_stk_envelope() =

ofonod[3228]: drivers/mbmmodem/stk.c:mbm_stk_envelope()
AT*STKE=3D"D30782020181900101"
ofonod[3228]: SIM: > AT*STKE=3D"D30782020181900101"\r
ofonod[3228]: SIM: < \r\nOK\r\n
ofonod[3228]: drivers/mbmmodem/stk.c:stke_cb() =

ofonod[3228]: src/stk.c:envelope_cb() length 0
ofonod[3228]: src/stk.c:menu_selection_envelope_cb() =

ofonod[3228]: src/stk.c:menu_selection_envelope_cb() Menu Selection
envelope submission gave no error
ofonod[3228]: SIM: < \r
\n*STKI:"D05681030124808202818205083E507265706169640F1022437265646974207265=
6368617267650F07234372656469740F0B245361756E616C616874690F09254C616E6775616=
7650F072650726963657318052313101324"\r\n
ofonod[3228]: drivers/mbmmodem/stk.c:stki_notify() =

ofonod[3228]: src/stk.c:stk_menu_create() =

ofonod[3228]: SIM: < \r\n*STKEND\r\n
ofonod[3228]: drivers/mbmmodem/stk.c:stkend_notify() =

ofonod[3228]: src/stk.c:session_agent_notify() Session Agent removed
ofonod[3228]: src/stk.c:session_agent_notify() Sending Terminate
response for session agent
ofonod[3228]: src/stk.c:send_simple_response() result 16
ofonod[3228]: src/stk.c:stk_respond() =

ofonod[3228]: Aborting (signal 11)
ofonod[3228]: ++++++++ backtrace ++++++++
ofonod[3228]: [0]: [0x4fe400]
ofonod[3228]: [1]: src/ofonod() [0x80dcfb8]
ofonod[3228]: [2]: src/ofonod() [0x80dd495]
ofonod[3228]: [3]: src/ofonod() [0x80f6e10]
ofonod[3228]: [4]: /lib/libglib-2.0.so.0(g_slist_foreach+0x27)
[0xe6b3d7]
ofonod[3228]: [5]: src/ofonod() [0x806fbe6]
ofonod[3228]: [6]: src/ofonod() [0x8071c17]
ofonod[3228]: [7]: /lib/libglib-2.0.so.0(+0x7fefb) [0xe8fefb]
ofonod[3228]: [8]: /lib/libglib-2.0.so.0(g_main_context_dispatch+0x1d5)
[0xe4b5e5]
ofonod[3228]: [9]: /lib/libglib-2.0.so.0(+0x3f2d8) [0xe4f2d8]
ofonod[3228]: [10]: /lib/libglib-2.0.so.0(g_main_loop_run+0x187)
[0xe4f817]
ofonod[3228]: [11]: src/ofonod() [0x80b5791]
ofonod[3228]: [12]: /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe6)
[0x2d1bd6]
ofonod[3228]: [13]: src/ofonod() [0x8052f91]
ofonod[3228]: +++++++++++++++++++++++++++

BR,
-Lasse


> =

> Best regards



--===============2335549070566269863==--

