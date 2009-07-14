Content-Type: multipart/mixed; boundary="===============1072243263820522069=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems with voice call.
Date: Tue, 14 Jul 2009 10:34:18 -0500
Message-ID: <200907141034.19444.denkenz@gmail.com>
In-Reply-To: <4A5C1CA4.8060204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1072243263820522069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> Hi denkenz,
>
> thanks for the reply. I was not sure about the voice call features of
> the modem. Now when I searched the answer I found out that the modem
> does not in fact support voice calls.

Yes, oFono's current implementation does not understand hardware specifics.=
  =

The current atmodem driver assumes a fully featured modem with perfect flue=
ncy =

in 27.007 & 27.005.  Obviously this is wrong for real modems.  Mostly this =
is =

because we were concentrating on getting the high level features working, =

before delving into hardware specifics.

>
> I did not realize this at first, because ofono offered the possibility
> for voice calls (loaded for example the VoiceCallManager interface). For
> SMS ofonod says
>
> ofonod[7906]: SMS not supported by this modem.  If this is in error
> please submit patches to support this hardware
>
> however the modem has a support for SMS, which I also tested with the
> windows drivers that were delivered with the modem.
>

I've seen this reported at least twice now.  Which means that my SMS suppor=
t =

detection in atmodem driver is probably not quite correct.  Would you be ab=
le =

to report at which point in the drivers/atmodem/sms.c initialization that t=
his =

fails?

> Maybe there could be similar "not supported" feature for the voice call
> plugins?

27.005 defines at least some rudimentary way to detect whether SMS is suppo=
rted =

by the modem or not.  Unfortunately 27.007 doesn't have an equivalent for =

voice calls.  The generic driver will do its best to figure out what is =

supported or not supported, but it will be up to the device-specific driver=
 to =

have the final say.

Regards,
-Denis

--===============1072243263820522069==--

