Content-Type: multipart/mixed; boundary="===============3536285882164617740=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: How to talk with FreeRunner?
Date: Mon, 19 Oct 2009 20:22:08 +0200
Message-ID: <fb249edb0910191122sbcf5747i4f937f711dfb5520@mail.gmail.com>
In-Reply-To: <200910191213.02239.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3536285882164617740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2009/10/19 Denis Kenzior <denkenz@gmail.com>:
>> =C2=A0 =C2=A0 =C2=A0 I just got a Openmoko FreeRunner and I wonder how o=
Fono can talk with it.
>> Use ser2net, but how? Can someone help on some simple steps or
>> instructions? Thanks a lot! By the way, the OS installed in it is Android
>> Cupcake. Need I change to other OS?
>
> There are a couple of ways:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Cross compile oFono itself to run directly o=
n the device using the calypso
> driver.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Cross compile ser2net, but run oFono on the =
desktop using the phonesim
> driver.
>
> Either way you will need the cross compiler and toolchain here:
> http://wiki.openmoko.org/wiki/Toolchain
>
> Note that my device came stock with the OpenMoko rootfs, so I have no
> experience with Android.
>
> For ser2net:
> =C2=A0- Cross compile ser2net using the supplied toolchain, I don't remem=
ber
> exactly, but I think this will get you there: ./configure --prefix=3D/usr=
 --
> sysconfdir=3D/etc --host=3Darm-angstrom-linux-gnueabi

You can possibly avoid the cross compiling if you're going to run
oFono on PC anyway, by using netcat instead of ser2net.  Either
"netcat" or "nc" is usually in the packages repo of any distribution.
The command would be
# nc -l -p 2000 < /dev/ttySAC0 > /dev/ttySAC0

All other steps would be same as Denis outlined.

If you find that the port is spitting corrupt data, it's probably not
initialised.  I use picocom to initialise ttys, it's:
# picocom /dev/ttySAC0
then ^a^q to quit picocom without resetting the port and then re-run nc.

Regards

--===============3536285882164617740==--

