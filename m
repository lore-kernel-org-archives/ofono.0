Content-Type: multipart/mixed; boundary="===============6160293918387523926=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] gatchat: export gatchat at_chat_finish_command
Date: Sat, 20 Oct 2018 18:53:19 +0200
Message-ID: <CAKSBH7GJN+r88zdqZ=5uMfu-W+ctGt-R0Y8DVW=5qziqZ4TUSw@mail.gmail.com>
In-Reply-To: <96075ac8-b6bb-5219-91b1-10f1c88df9df@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6160293918387523926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Sat, Oct 20, 2018 at 6:40 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/20/2018 11:28 AM, Giacinto Cifelli wrote:
> > Hi Denis,
> >
> > On Sat, Oct 20, 2018 at 6:23 PM Denis Kenzior <denkenz@gmail.com> wro=
te:
> >>
> >> Hi Giacinto,
> >>
> >>> I need to probe with 'AT' once per second the modem and the
> >>> application port, one after the other.
> >>> It needs to be repeated a few times, because the device might be
> >>> booting up, but it could also be that the device is not responding
> >>> (because, for example, mapped on the RS232).
> >>
> >> Ugh.  Doesn't your firmware provide some sort of ready notification?
> >
> > yes, but what if the modem has already booted up?
>
> But then your query AT command will succeed no?
>
> See how plugins/mbm.c does this with EMRDY for example.  If your modem
> is completely unresponsive for a certain amount of time then you might
> need to send AT\r or something directly via GAtIO/GIOChannel bypassing
> GAtChat.
>
> >
> >>
> >> But anyway, you can still accomplish this with
> >> g_at_chat_send/g_timeout_add/g_at_chat_cancel...
> >
> > I have tried but it doesn't abort the current 'AT' waiting for an answe=
r.
>
> As I said, we don't support AT command aborts.  You can't simply start
> writing the next AT command to the serial port.  There are special rules
> for this with weird timings.  See V.250 for details.  Also many AT
> command interpreter implementations simply don't support this at all or
> support aborts for a limited subset of commands.

Gemalto supports for a limited subset of commands, it is right, and it
is not standardized.

But it is not a reason to close the door entirely:
there are strict requirements for starting emergency calls, especially
ERA/GLONASS and panEuropean eCall.

Perhaps it should be given in the driver to each manufacturer the
possibility to do it, but some support from the core would be good.

I will come back to this in a few months when I need to focus just on
eCall. But it is good that we started talking about it.

>
> You're doing something extremely specific, so you can either try and
> abuse the g_at_chat_set_wakeup_command (which was added specifically for
> one extremely insane modem) or do this manually via GAtIO / GIOChannel.

via GAtIO / GIOChannel I can do it, even if suspect quite some effort
for something that is already available.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============6160293918387523926==--

