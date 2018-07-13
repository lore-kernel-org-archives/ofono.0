Content-Type: multipart/mixed; boundary="===============7273370394868960881=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: no connection after ofono restart while huawei modem connected
Date: Fri, 13 Jul 2018 11:09:40 -0500
Message-ID: <1e0d2d28-f836-7e7a-77b2-dd21bf9e661d@gmail.com>
In-Reply-To: <9dd62fbc-ec70-3216-62da-63d3aafc0005@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7273370394868960881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 07/13/2018 02:47 AM, Christophe Ronco wrote:
> Hi,
> =

> I use a Huawei MS2372h-607. It is a classical AT+PPP modem. I have a
> problem when I stop ofono while context is activated. When I restart
> ofono (without unplugging the modem), I am not able to send any AT
> command on Modem channel because this channel is still in data mode.

Interesting.  Isn't AT+CFUN=3D0 initiated in the modem.disable() driver =

method taking care of taking the port out of data mode?

> =

> I made a patch to send escape sequence when gprs-context atom is
> removed. It fixes the problem but I don't know if this is the right
> thing to do.

The biggest problem with PPP is that it needs some time to work.  When =

ofono is shutting down, the modem driver is the only thing that is =

afforded a grace period.  The atoms & related drivers are removed =

immediately.  Hence the modem driver is the preferred place to handle this.

> =

> Attached to this mail:
> =

> I/ reconnectError_01: traces of complete test (with debug and AT debug).
> Test done:
> =

> 1) board boot
> =

> 2) Connection (success), start at line 1058:
> =

> connmanctl connect cellular...
> =

> 3) stop ofono, start at line 1109:
> =

> /etc/init.d/ofono stop
> =

> 4) start ofono, start at line 1348:
> =

> /etc/init.d/ofono start
> =

> 5) Connection (error), start at line 2018:
> =

> connmanctl connect cellular...
> =

> =

> I don't have PPP debug in this trace but here is what happens at PPP
> level when Ofono is stopped:
> =

> ofonod[944]:
> ../ofono-1.24/drivers/atmodem/gprs-context.c:at_gprs_detach_shutdown() ci=
d 0

This is really just a side-effect of the netreg atom being removed =

first.  See gprs_netreg_removed().  This code path might not even =

actually be triggered in all situations...

> ofonod[944]: PPP: lcp: pppcp_generate_event: current state 9:OPENED
> ofonod[944]: PPP: event: 3 (Close), action: 8224, new_state: 4 (CLOSING)
> ofonod[944]: PPP: lcp: pppcp_initialize_restart_count: current state
> 9:OPENED
> ofonod[944]: PPP: lcp: pppcp_send_terminate_request: current state 9:OPEN=
ED
> ofonod[944]: PPP: ipcp: pppcp_generate_event: current state 9:OPENED
> ofonod[944]: PPP: event: 1 (Down), action: 201, new_state: 1 (STARTING)
> ofonod[944]: PPP: ../ofono-1.24/gatchat/gatppp.c:ppp_enter_phase() 5
> =

> ofonod[944]: ../ofono-1.24/src/gprs.c:gprs_context_unregister()

gprs context is removed right after...

> 0xc10ed0, 0xc10d90
> ofonod[944]: ../ofono-1.24/src/gprs.c:gprs_context_remove() atom: 0xc10ef0
> ofonod[944]:
> ../ofono-1.24/drivers/atmodem/gprs-context.c:at_gprs_context_remove()
> ofonod[944]: ../ofono-1.24/src/gprs.c:gprs_unregister() 0xc10d90
> =

> Terminate request is sent and then gprs-context atom is removed before
> Terminate Ack is received.
> =

> =

> II/ 0001-PPP-send-escape-sequence-when-ofono-dies.patch
> =

> The patch I made to fix the problem. The idea is to immediately send
> escape sequence when removing gprs-context atom. This patch is not ready
> to be sent (at least it must be split in two patches). Can you tell me
> what you think about this patch?
> =


In theory we already have the suspend functionality on GAtPPP (e.g. =

g_at_ppp_suspend).  But I dimly recall some sort of guard timeout must =

be used.  Since PPP is created in the gprs-context driver and it is =

destroyed immediately, this probably doesn't help you.

The best course of action would be to have modem.disable() issue a =

CFUN=3D0 equivalent that resets everything properly.  If that's not =

possible, then a solution along the lines of what you propose is needed. =

  E.g. sending a '+++' in at_gprs_context_remove if the state isn't IDLE.

Regards,
-Denis

--===============7273370394868960881==--

