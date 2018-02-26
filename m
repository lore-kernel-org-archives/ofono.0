Content-Type: multipart/mixed; boundary="===============4202089019382558221=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Issue with service reporting on a 4G modem
Date: Mon, 26 Feb 2018 13:25:08 +0100
Message-ID: <0709669a-f90f-e00b-b796-b05a47fc9cbf@monom.org>
In-Reply-To: <AM4PR01MB1873371B219961C9D091856A9CC10@AM4PR01MB1873.eurprd01.prod.exchangelabs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4202089019382558221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bassem,

On 26.02.2018 13:16, Bassem BOUBAKER wrote:
> Issue is fixed. Thank you for your help.

Glad to hear you could fix it.

> I used to have this:
> # cat /sys/class/net/usb0/uevent =

> INTERFACE=3Dusb0
> IFINDEX=3D7
> =

> I changed my driver in the kernel to probe it as a wwan info device based=
 on vid and pid . =

> =

> Now I have the DEVTYPE correct:
> # cat /sys/class/net/wwan0/uevent =

> DEVTYPE=3Dwwan
> INTERFACE=3Dwwan0
> IFINDEX=3D7
> =

> =

> Below my kernel patch in case of anyone having the same issue.
> =

> PS: I'm using a Cinterion PLS8 modem.

Please also create a patch for Linux upstream. You are almost there.
Just add a commit message and send it to the right mailing list :)

Thanks,
Daniel

--===============4202089019382558221==--

