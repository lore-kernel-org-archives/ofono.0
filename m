Content-Type: multipart/mixed; boundary="===============1721684343541503600=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [fix-isi-udev PATCH 3/3] ofono.rules: assign isigen driver by USB
 ids
Date: Fri, 08 Oct 2010 12:31:33 +0200
Message-ID: <4d47700d3dfead943bb373e7c62bdff5@chewa.net>
In-Reply-To: <1286197866-19572-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1721684343541503600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




On Mon,  4 Oct 2010 16:11:06 +0300, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Now using the USB vendor and product IDs like the rest of the oFono
> drivers.
> =

> For reasons left unclear, the SUBSYSTEMS rule did not work consistently
> in Ubuntu 10.04.

The network device is not part of the USB subsystem, only its parent
device.

> +# Nokia default (with PC Suite)
> +ATTRS{idVendor}=3D=3D"0421", ENV{OFONO_DRIVER}=3D"isigen",
> ENV{OFONO_ISI_ADDRESS}=3D"16"
> +

This will match the whole USB gadget. How do you get the Phonet interface
from that?

I would simply match on Ethernet type 820 and kernel name usbpnXXX.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============1721684343541503600==--

