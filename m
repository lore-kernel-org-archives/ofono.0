Content-Type: multipart/mixed; boundary="===============8834604384660335492=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono with Sagem Hilo GPRS
Date: Tue, 01 Jun 2010 17:13:13 -0500
Message-ID: <201006011713.13937.denkenz@gmail.com>
In-Reply-To: <AANLkTik2eSxX2SKAex706K0m8VHtJ0atXQw-YCfdN578@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8834604384660335492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > Seems we try to read EFmwis and get back a '\0' as a response.  This
> > probably stalls the gatchat queue and causes the sim poll timeout to
> > fire.  Or is there something else going on I'm not seeing?
> =

> Yes, it seems there's not much we can do when the queue gets stuck so
> for each of these modems we need a custom driver.  The sim polling
> code thinks the card is dead because it counts the timeout from the
> moment it submits the STATUS poll to the queue, not the moment the
> command is executed.  We need to either disable the polling or start
> timer when the command is sent to modem.

I'm still of the opinion this is not really relevant with today's hardware.=
  =

The modem will be doing its own polling and it makes no sense for the main =

processor to do so as well (power consumption goes through the roof.)  =

However, it could be some vendor is actually crazy enough to require it.

> =

> If the device doesn't have a removable card, and there's a
> vendor-specific PROACTIVE COMMAND notification then there's no point
> polling.  If the card is removable and modem doesn't support AT+CSIM,
> we can send the status through AT+CRSM instead, maybe
> atmodem/sim-poll.c should have a quirk for that.

I think we should assume that vendor specific STK notifications and non-
removable cards are the default, not the other way around.

We should keep sim polling out of atgen.  Even initializing the stk atom in =

atgen plugin is wrong due to how wildly different the modem implementations =

are.  People use atgen as the first driver to get started with oFono, so le=
ts =

keep its feature set conservative, or at least add more intelligence into t=
he =

atmodem stk driver.  E.g. if CSIM is not supported / allowed, don't bother =

doing anything.

However, this is now getting off-topic from the original discussion.

Regards,
-Denis

--===============8834604384660335492==--

