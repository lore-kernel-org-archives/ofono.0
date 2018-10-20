Content-Type: multipart/mixed; boundary="===============6447138572314715573=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] gatchat: export gatchat at_chat_finish_command
Date: Sat, 20 Oct 2018 19:47:40 +0200
Message-ID: <CAKSBH7FBDLQf+HrH_EypGD0TT2j_73EXA_wua8bap0OgFQ1T+Q@mail.gmail.com>
In-Reply-To: <62ada243-c066-56e9-1f10-f2b1d55fe87d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6447138572314715573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Sat, Oct 20, 2018 at 7:20 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> > But it is not a reason to close the door entirely:
> > there are strict requirements for starting emergency calls, especially
> > ERA/GLONASS and panEuropean eCall.
>
> I'm not though.  I'm just saying that exposing at_finish_command is not
> actually doing what you want in this particular case anyway.  If you
> don't have enough AT ports that you need to cancel ongoing SMS, etc,
> then you need to implement proper AT command abortion.
>

some chipsets have a single interpreter, even if accessible from
multiple ports, but they allow aborting.
Gemalto modules abort long-running commands simply sending any
character on the line while waiting for a response,
the module returns ERROR, and the flow can be resumed properly.
I don't need this patch for that, I can just use directly GAtIO / GIOChanne=
l.

> >
> > Perhaps it should be given in the driver to each manufacturer the
> > possibility to do it, but some support from the core would be good.
>
> The core has no concept of cancellation, it is assumed that any proper
> modem would provide 5-6 independent interpreters or supports a fully
> async protocol.  Then any interpreters that can block for a long time
> are independent of the others.  E.g. ATD, AT+COPS, and a few other
> commands can block the port for a fairly long amount of time, depending
> on the firmware implementation.
>
> I'm open to the idea of adding core support for cancelation of these
> commands.  ATD is a particularly common case, but so is available
> operator scanning via COPS, etc.  But this enters into extremely
> complicated and vendor dependent behavior territory.
>
> > via GAtIO / GIOChannel I can do it, even if suspect quite some effort
> > for something that is already available.
> >
>
> I've already had this conversation with someone from Gemalto or one of
> your customers.  I don't see a reason why you can't use
> g_at_chat_set_wakeup_command for this.  With perhaps an extension to
> GAtChat API to reset/cancel the wakeup behavior once you don't need it.

g_at_chat_set_wakeup_command is blocking (I think), and it would be
perfect because of that, only would need to add a timeout/number of
attempts, and a return value (success/timed out).
But it seems complicated to do this because it is integrated in the
big state machine of GAtChat.
I prefer to go for GAtIO / GIOChannel instead.

By the way, g_at_chat_set_wakeup_command takes 2 timeouts (the first
one for the period of the wakeup AT command), but the second never
seems to expire, so I don't know if it is already fit.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============6447138572314715573==--

