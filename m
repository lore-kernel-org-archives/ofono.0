Content-Type: multipart/mixed; boundary="===============1259591116468303916=="
MIME-Version: 1.0
From: Pawlak, KubaX T <kubax.t.pawlak@intel.com>
Subject: RE: Ofono 1.17 over bluez5 Bluetooth : A2DP and AVRCP is working fine
 , but HFP- No sound -Mic/Speaker ?
Date: Tue, 02 Feb 2016 11:13:52 +0000
Message-ID: <088CC8BACB3382439E91D9919CE350245032CE1A@IRSMSX108.ger.corp.intel.com>
In-Reply-To: <PS1PR0401MB1529B21FDEEF3F6BA57B0423E4DF0@PS1PR0401MB1529.apcprd04.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1259591116468303916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Samiran,

> I 'm using an Intel IVI development board,
> =

> Configuration is like this,  using Bluez -5.37, Pulseaudio 6.0 , ofono 1.=
17,
> Bluetooth A2DP and AVRCP is working fine , HFP is showing working but no
> sound -

Connect a phone and do 'pactl list cards'. Your phone should be there as a =
card.
If not then edit /etc/pulse/default.conf , find line saying:
load-module module-bluetooth-discover
and add "headset=3Dofono" at the end of it, so it looks like this:
load-module module-bluetooth-discover headset=3Dofono

Reboot, reconnect and check again. Virtual audio card should be there.

Regards,
Kuba
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

--===============1259591116468303916==--

