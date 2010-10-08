Content-Type: multipart/mixed; boundary="===============2425973128364210815=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [fix-isi-udev PATCH 3/3] ofono.rules: assign isigen driver by USB
 ids
Date: Fri, 08 Oct 2010 15:43:43 +0300
Message-ID: <AANLkTi=qRA_ZniO=mO70+9q6x7ks=W5Sz1woA49SCaSE@mail.gmail.com>
In-Reply-To: <4d47700d3dfead943bb373e7c62bdff5@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2425973128364210815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/10/8 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
>> Now using the USB vendor and product IDs like the rest of the oFono
>> drivers.
>>
>> For reasons left unclear, the SUBSYSTEMS rule did not work consistently
>> in Ubuntu 10.04.
>
> The network device is not part of the USB subsystem, only its parent
> device.

Yes, the last S in SUBSYSTEMS refer to a SUBSYSTEM of a parent.

>> +# Nokia default (with PC Suite)
>> +ATTRS{idVendor}=3D=3D"0421", ENV{OFONO_DRIVER}=3D"isigen",
>> ENV{OFONO_ISI_ADDRESS}=3D"16"
>> +
>
> This will match the whole USB gadget.

That is the point. We don't want one modem with at command tty and
another with phonet interface.

> How do you get the Phonet interface
> from that?

> I would simply match on Ethernet type 820 and

isi_add() does the Ethernet type matching. For a reason or another
Lucid udev rules fails to match the type sysattr when enumerating
existing devices.

> kernel name usbpnXXX.

The interface name is ignored as an expert earlier advised. ;)

-- =

Pekka.Pessi mail at nokia.com

--===============2425973128364210815==--

