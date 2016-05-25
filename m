Content-Type: multipart/mixed; boundary="===============3670153554321216346=="
MIME-Version: 1.0
From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Wed, 25 May 2016 19:22:48 +0300
Message-ID: <1464193368.13843.65.camel@iki.fi>
In-Reply-To: <5745BD55.3030108@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3670153554321216346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-05-25 at 09:57 -0500, Denis Kenzior wrote:
> Hi John,
> =

> On 05/25/2016 06:01 AM, Jomon John wrote:
> > Hi,
> > =

> > I am trying to configure HFP=C2=A0with Bluez(5.34), Ofono(1.17) and
> > pulseaudio(6) on a Freescale i.MX6 board using Linux 4.1.15 kernel,
> > the idea is to use the target board in HFP/Handsfree Unit role. The
> > bluetooth controller is a Pluggable USB Bluetooth Dongle (0a5c:21e8
> > - BCM20702A0) with updated firmware.
> > =

> > The procedure followed is,
> > =

> > * Pair & connect with the android mobile phone with the bluetoothctl
> > * Enable modem and dial number using ofono test scripts
> > =

> > After this the call is being made but the audio routing fails with
> > "Reject SCO : Agent not registered" message from oFono. While
> > checking with btmon its found that the SCO Connect Request has been
> > rejected with the reason of limited resources(0x0d).
> > =

> > Can anyone help me to identify the root cause, I spent a lot of
> > time trying different version combinations, loading firmware and
> > checking logs but still nothing.
>=C2=A0
> This looks like a problem with PulseAudio configuration. oFono does not=
=C2=A0
> handle SCO data, PulseAudio does that. In order to do that, PulseAudio=C2=
=A0
> needs to register an agent with oFono. Then the SCO socket will be=C2=A0
> established and the fd handed off to PulseAudio to process the audio data.
> =

> I have no idea how this is accomplished in PulseAudio.=C2=A0=C2=A0This qu=
estion is=C2=A0
> being asked fairly often recently.=C2=A0=C2=A0Does PulseAudio have an=C2=
=A0
> FAQ/documentation for this yet?

In /etc/pulse/default.pa, add parameter headset=3Dofono to module-
bluetooth-discover. That should be all that's needed at PulseAudio
side.

Denis, would you be willing to help me with the oFono parts, if I write
a document explaining how to make bluetooth audio work with
BlueZ5+PA+oFono?

--=C2=A0
Tanu

--===============3670153554321216346==--

