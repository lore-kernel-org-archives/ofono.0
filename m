Content-Type: multipart/mixed; boundary="===============3784844679248984262=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatchat: export gatchat at_chat_finish_command
Date: Sat, 20 Oct 2018 12:20:28 -0500
Message-ID: <62ada243-c066-56e9-1f10-f2b1d55fe87d@gmail.com>
In-Reply-To: <CAKSBH7GJN+r88zdqZ=5uMfu-W+ctGt-R0Y8DVW=5qziqZ4TUSw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3784844679248984262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> But it is not a reason to close the door entirely:
> there are strict requirements for starting emergency calls, especially
> ERA/GLONASS and panEuropean eCall.

I'm not though.  I'm just saying that exposing at_finish_command is not =

actually doing what you want in this particular case anyway.  If you =

don't have enough AT ports that you need to cancel ongoing SMS, etc, =

then you need to implement proper AT command abortion.

> =

> Perhaps it should be given in the driver to each manufacturer the
> possibility to do it, but some support from the core would be good.

The core has no concept of cancelation, it is assumed that any proper =

modem would provide 5-6 independent interpreters or supports a fully =

async protocol.  Then any interpreters that can block for a long time =

are independent of the others.  E.g. ATD, AT+COPS, and a few other =

commands can block the port for a fairly long amount of time, depending =

on the firmware implementation.

I'm open to the idea of adding core support for cancelation of these =

commands.  ATD is a particularly common case, but so is available =

operator scanning via COPS, etc.  But this enters into extremely =

complicated and vendor dependent behavior territory.

> via GAtIO / GIOChannel I can do it, even if suspect quite some effort
> for something that is already available.
> =


I've already had this conversation with someone from Gemalto or one of =

your customers.  I don't see a reason why you can't use =

g_at_chat_set_wakeup_command for this.  With perhaps an extension to =

GAtChat API to reset/cancel the wakeup behavior once you don't need it.

Regards,
-Denis

--===============3784844679248984262==--

