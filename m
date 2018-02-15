Content-Type: multipart/mixed; boundary="===============8579005893343619759=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: Re: [PATCH] add syspath property to modem properties
Date: Thu, 15 Feb 2018 13:09:12 +0100
Message-ID: <fa7c1f7d-86bc-cad8-85c2-846c7fc359f3@sysmocom.de>
In-Reply-To: <1518684623-11944-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8579005893343619759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

Thanks for providing feedback on the topic. As I expected, I'm not alone =

and other people also have this requirement of being able to easily =

identify modems.

The patch you provide is enough for my needs, as I can easily identify a =

modem from the list without having to change its state (powering them =

on). I tested it and seems to be working fine:

  mdbus2 -s org.ofono / org.ofono.Manager.GetModems
([('/mbm_1', {'Online': <false>, 'Powered': <false>, 'Lockdown': =

<false>, 'Emergency': <false>, 'ModemSyspath': =

<'/sys/devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.4'>, 'Interfaces': =

<@as []>, 'Features': <@as []>, 'Type': <'hardware'>}), ('/gobi_0', =

{'Online': <false>, 'Powered': <false>, 'Lockdown': <false>, =

'Emergency': <false>, 'ModemSyspath': =

<'/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2'>, 'Interfaces': =

<@as []>, 'Features': <@as []>, 'Type': <'hardware'>})],)

So I'd like seeing merged either something Christophe patch or mine (or =

both). I'll send a v2 of my patch as suggested and let you deliver on =

the best approach. If not good solution is provided, I'd need to keep it =

in a separate fork, which imho would be really sad as it seems other =

people may potentially use this kind of feature.

Regards,

-- =

- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
* sysmocom - systems for mobile communications GmbH
* Alt-Moabit 93
* 10559 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte

--===============8579005893343619759==--

