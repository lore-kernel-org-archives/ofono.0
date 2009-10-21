Content-Type: multipart/mixed; boundary="===============1772441606798674367=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Extend modem.conf
Date: Wed, 21 Oct 2009 17:04:37 -0500
Message-ID: <200910211704.38061.denkenz@gmail.com>
In-Reply-To: <4ADECBE4.1060500@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1772441606798674367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> Hello,
>
> I was wanting to extend the syntax of the modem.conf file. It is extra
> work to maintain a different plugin file for each generic AT modem with
> a different speed, serial settings.
>

I agree that this would be useful.

> I'm not sure on the best syntax for this. Maybe below could be a solution.
>
> [generic]
> Driver=3Datgen
> Device=3D/dev/ttyS0
> DeviceOpts=3Dbaud=3D115200:read=3Don:local:on

I prefer something like:
[generic]
Driver=3Datgen
Device=3D/dev/ttyS0
Baud=3D115200
Read=3Don
Local=3Don

We can even capitalize the values in gattty if it makes things easier.

> Also, shouldn't the "Driver" keyword in the file be named "Plugin"
> instead? It may give a better indication where to read in the source.

Everything is a driver, in this case we mean the modem driver.  These are a=
lso =

generally always plugins of the same name which leads to confusion.

Regards,
-Denis

--===============1772441606798674367==--

