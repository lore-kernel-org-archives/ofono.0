Content-Type: multipart/mixed; boundary="===============1812078747853135110=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: driver callback naming
Date: Sun, 30 Aug 2009 15:20:55 -0500
Message-ID: <200908301520.56202.denkenz@gmail.com>
In-Reply-To: <a32762a20908301310s4918ba7buf3523d1689704cd2@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1812078747853135110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> 2009/8/30 Denis Kenzior <denkenz@gmail.com>:
> > The reason for this is e.g. airplane mode, where you physically want to
> > turn off the device.  Another case is for battery / power reasons, e.g.=
 a
> > netbook with a USB modem that is not being used.
>
> For airplane mode, you want to turn off the radios. I'm also a bit
> unclear where in the Nokia modem API the enable/disable callbacks
> would map. Offline mode can be set via the modem API, but completely
> powering the modem off is done in HW.

Turning off the radio is the intention.  However, oFono is not only to be u=
sed =

with proper modems, but with Bluetooth HFP, SAP, etc, where poweroff might =
have =

different meaning.  Some hardware supports even more drastic powerdown =

procedures than simply turning off the radio.

>
> On a somewhat related note, I don't quite see what to do with
> deregister in the netreg driver. Is the intended end state of the
> device, in fact, similar to airplane mode?

This maps directly to AT+COPS=3D2, which means completely deregister from =

network, but still be in full-capability mode.  The usefulness of this is o=
f =

course questionable, like many other areas of the spec.  I'm actually willi=
ng =

to drop this from the driver, however there might be some use for this =

functionality when using manual operator selection.

Regards,
-Denis

--===============1812078747853135110==--

