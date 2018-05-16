Content-Type: multipart/mixed; boundary="===============2820845327244099033=="
MIME-Version: 1.0
From: Harald Welte <laforge@gnumonks.org>
Subject: Re: Voice calls over qmi was Re: Incoming sms problem on Motorola
 Droid 4
Date: Wed, 16 May 2018 18:03:33 +0200
Message-ID: <20180516160333.GZ4369@nataraja>
In-Reply-To: <CACOYK=g9XepWVFAr8Afb6VpOxN7UOGN71aFyogOq=8+BjAsYFA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2820845327244099033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Stanislav,

On Wed, May 16, 2018 at 05:15:07PM +0200, Stanislav Sinyagin wrote:
> also most mPCIE modems deliver PCI voice over dedicated wires on their
> mPCIE socket. These wires are standardized as "reserved" and most
> standard boards with mPCIE don't connect them anywhere.

This is the "PCM" interface I was referring-to.  This means you need
a PCM slave interface to interface with it, as the modems typically all
insist on being a PCM master.  The intention here is that you attach
some external audio codec IC that converts from the PCM to analog audio.

This means you cannot interface this PCM interface e.g. with standard
USB-Audio bridge ICs, as all those USB-Audi bridge ICs (basically "USB
soundcard" ICs) all also only implement the "master" of the PCM
interface and not the slave.

See http://laforge.gnumonks.org/blog/20170902-cellular_modems-voice/

In the end, you have to use something like the SSC (synchronous serial)
peripheal of Atmel SAM3/SAM4/... devices, or an XMOS device in order to
interface with that audio.

Needless to say, the lack of a standard for where PCM lines are on mPCIe
slots means that you cannot build any base board that will interoperate
with mPCIe modules from different vendors.

> But if you develop your own PCB, you can actually retrieve the voice
> signal. It just needs a bit of hacking.

The fact that a PCM bus is present on the hardware pins of the mPCIe socket
or the pads of a LGA module also still doesn't mean that you actually will
have working audio.

Many modem module maker do not obtain patent licenses for audio/voice, as
they know/expect their modems are typically only used in machine2machine
or other data-only applications.

Finally, even if the firmware and hardware interface is present, in many
cases the modem manufacturers make you sign a declaration that you will
only use the voice interface as some kind of "emergency communication"
only, and not as part of your normal product.  Once again, patent
licensing differences for voice vs. data-only use cases are to be blamed
for that.

Oh, and I'm not even touching the question on whether audio will work in
circuit-switched 2G/3G only, or whether it will also work with VoLTE,
and particularly not whether they will do SRVCC, etc.  That adds yet
another dimension to the problem.

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

--===============2820845327244099033==--

