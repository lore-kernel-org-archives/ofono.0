Content-Type: multipart/mixed; boundary="===============1856569225861875245=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono with Sagem Hilo GPRS
Date: Tue, 01 Jun 2010 16:17:30 -0500
Message-ID: <201006011617.30618.denkenz@gmail.com>
In-Reply-To: <AANLkTikGb7A1owSRix_siZnFOvAiFYisw6pm5ujwJdF7@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1856569225861875245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Hi,
> =

> On 1 June 2010 21:11, Denis Kenzior <denkenz@gmail.com> wrote:
> > Hi Yoann,
> >
> > <snip>
> >
> >> ofonod[3221]: src/modem.c:get_modem_property() modem 0x8142058 property
> >>  status-poll-interval ofonod[3221]: > AT+CSIM=3D8,A0F200C0\r
> >> ofonod[3221]: < AT+CSIM=3D8,A0F200C0\r\r\n+CME ERROR: 3\r\n
> >
> > The culprit was sim polling which performs CSIM pdus to detect a dead
> > SIM. Your modem doesn't seem to support CSIM command, so returns an err=
or
> > and oFono foolishly thinks the SIM has been removed.
> =

> Not if the +CME ERROR is sent withing 5 seconds.  Only if there is a 5
> second or longer lag between the AT+CSIM=3D... and the response (success
> or error), it decides the card is dead.

Thanks for the correction.  I was hitting a slightly different issue with H=
SO =

modem and atgen that was also resulting in sim removal.

Looking at the logs again, it seems that this response causes the poll to =

signal sim removal:

ofonod[3253]: > AT+CRSM=3D192,28618\r
ofonod[3253]: < A
ofonod[3253]: < T+CRSM=3D192,28618\r
ofonod[3253]: < \000
ofonod[3253]: src/message-waiting.c:mw_remove() atom: 0x9ac6c00
ofonod[3253]: src/phonebook.c:phonebook_remove() atom: 0x9ac6a98
ofonod[3253]: src/sms.c:sms_remove() atom: 0x9ac69c0
ofonod[3253]: src/ssn.c:ssn_remove() atom: 0x9ac68f0
ofonod[3253]: src/call-barring.c:call_barring_remove() atom: 0x9ac6880
ofonod[3253]: src/call-meter.c:call_meter_remove() atom: 0x9ac6780
ofonod[3253]: src/network.c:netreg_remove() atom: 0x9ac62e8
ofonod[3253]: src/call-settings.c:call_settings_remove() atom: 0x9ac64f8
ofonod[3253]: src/call-forwarding.c:call_forwarding_remove() atom: 0x9ac6418
ofonod[3253]: src/ussd.c:ussd_remove() atom: 0x9ac4e70
ofonod[3253]: src/modem.c:set_modem_property() modem 0x9ac4058 property =

status-poll-interval
ofonod[3253]: src/modem.c:unregister_property() property 0x9ac49d8

Seems we try to read EFmwis and get back a '\0' as a response.  This probab=
ly =

stalls the gatchat queue and causes the sim poll timeout to fire.  Or is th=
ere =

something else going on I'm not seeing?

There is another issue:
When we send the CPIN to unlock the PIN, the modem actually takes some time=
 to =

initialize the SIM and our CIMI request fails.  This means that we don't =

proceed with the initialization procedure.  Disabling / Enabling the modem =

skips the PIN entry and we initialize properly.

This modem's firmware is wonderful :)

Regards,
-Denis

--===============1856569225861875245==--

