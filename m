Content-Type: multipart/mixed; boundary="===============0557936153308072953=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: driver callback naming
Date: Sun, 30 Aug 2009 23:10:52 +0300
Message-ID: <a32762a20908301310s4918ba7buf3523d1689704cd2@mail.gmail.com>
In-Reply-To: <200908301345.45643.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0557936153308072953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/8/30 Denis Kenzior <denkenz@gmail.com>:
> The reason for this is e.g. airplane mode, where you physically want to t=
urn
> off the device. =C2=A0Another case is for battery / power reasons, e.g. a=
 netbook
> with a USB modem that is not being used.

For airplane mode, you want to turn off the radios. I'm also a bit
unclear where in the Nokia modem API the enable/disable callbacks
would map. Offline mode can be set via the modem API, but completely
powering the modem off is done in HW.

On a somewhat related note, I don't quite see what to do with
deregister in the netreg driver. Is the intended end state of the
device, in fact, similar to airplane mode?

Cheers,
Aki

--===============0557936153308072953==--

