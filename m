Content-Type: multipart/mixed; boundary="===============8023175449352778896=="
MIME-Version: 1.0
From: Harald Welte <laforge@gnumonks.org>
Subject: Re: Voice calls over qmi was Re: Incoming sms problem on Motorola
 Droid 4
Date: Wed, 16 May 2018 18:12:27 +0200
Message-ID: <20180516161227.GA4369@nataraja>
In-Reply-To: <717eeff6-6c39-5475-c3ab-7588cf7e2def@puri.sm>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8023175449352778896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bob,

On Wed, May 16, 2018 at 04:10:55PM +0100, Bob Ham wrote:
> On 12/05/18 08:37, Harald Welte wrote:
> =

> > As there are no modems that reliably can deliver the actual audio data =
via USB
> > (aside some non-supported outdated experimental firmwares), we're only =
testing
> > the signaling plane so far.
> =

> I'm alarmed to see this statement.  Can I ask what you mean here when you
> say "no modems"? :-)  Do you mean on the market in general?

I mean on the market in general, yes.  Sure you can find the odd outlier he=
re or
there, but overall, I would estimate 90% or more modems do not support audi=
o in the
first place, and 98% do not support it over USB.

The only "proper" approach I've ever seen was by Sierra Wireless, whose Qua=
lcomm
based 3G modems for some time had an experimental firmware branch you could=
 ask for,
which would then offer a composite USB device that had an USB audio class d=
evice
next to the usual other (cdc-ethernet, AT-command, QMI, MBIM, ...) interfac=
es.

However, that is discontinued and not supported for years, and there is no =
replacement.
FAEs are still handing it out on request, though.

> I've been using the SIMCom SIM7100E which is specified as supporting audio
> data over a USB serial connection.  Unfortunately I've had a lot of troub=
le
> getting it to work but I've been collaborating with Stanislav Sinyagin
> (CC'd) who has a SIM7100E with an earlier firmware and who can reliably g=
et
> audio by dd'ing /dev/ttyUSBX.  I'm waiting on our supplier to get the same
> firmware version.

Which exactly reflects my statement:  It's very hard to get reliable,
working audio with commitment from a vendor.  Sure, you may find it more
or less accidentially working for some products in some firmware
version, but I yet have to find any vendor who would actually say "this
is a supported feature, we test it before every release, and we will
maintain it for every future firmware update".

> There are earlier SIMCom modems with application notes describing how to =
get
> audio over USB too, for example the SIM5360.

Yes, there have always been some (few) modules that offered audio codec
frames over (usb) serial.  You could find some Gemalto 3G modules that
also did this.  I find this a horrible hack, and at least on those
modules wehre I remember it always had some kind of side-effect, like
you had to give up the [virtual] UART that was normally used for GPS and
re-purpose that for the codec frames over serial.

With most of those modern 4G modems running Linux inside the modem, I
really cannot understand why none of them goes the extra mile and
enables a USB audio gadget so it simply shows up as usb-audio device on
the host.  I mean, USB audio profile is 1990ies... and we have 2018.

While doing reverse engineering on some Qualcomm LE based modems before,
I saw that the Qualcomm reference source code even appeared to include
usb-audio composite device capabilities.

Regards,
	Harald
-- =

- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.o=
rg/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--===============8023175449352778896==--

