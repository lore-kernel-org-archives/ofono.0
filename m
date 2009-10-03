Content-Type: multipart/mixed; boundary="===============4003381435759502200=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] modemconf: default to grabbing the "Device" entry from
 the config file
Date: Sat, 03 Oct 2009 04:25:09 +0200
Message-ID: <1254536709.4114.4.camel@localhost.localdomain>
In-Reply-To: <20091002193620.42404dad@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4003381435759502200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andres,

> Previously, we manually listed every driver entry that needed Device;
> this meant that we needed to edit modemconf.c every time we added
> a new modem plugin.  Sjoerd Simons discovered that mbm doesn't work
> because it wasn't listed in modemconf, therefore Device was being
> ignored.  This patch makes modemconf default to setting Device, with
> exceptions made for certain plugin drivers.
> =

> A better way to fix this that I started working on would be to have
> each driver plugin have a table of desired/required strings, and to
> keep any knowledge of drivers out of udev.c and modemconf.c.  This
> may be a bit of a challenge for udev.c, though.  Is this something
> that people would like to see?

actually modemconf is only for static devices inside embedded systems
like a mobile phone. The desktop should auto-discover modems via udev
and MBM is one of them that get auto-discovered nicely when having a
proper libudev in place.

Regards

Marcel



--===============4003381435759502200==--

