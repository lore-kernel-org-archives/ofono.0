Content-Type: multipart/mixed; boundary="===============5624962154927566037=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] support for Ericsson N5321 gw
Date: Thu, 16 Jul 2015 14:12:24 -0500
Message-ID: <55A80218.3060503@gmail.com>
In-Reply-To: <20150716183946.17294.70460@win7217.informatik.uni-wuerzburg.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5624962154927566037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On 07/16/2015 01:39 PM, Johannes Schauer wrote:
> Hi,
>
> finally and with lots of help from denkenz in #ofono and jukkar in #connm=
an, I
> now have my Lenovo branded Ericsson N5321 gw modem (usb id 0bdb:193e) wor=
king
> with ofono and connman \o/
>
> Attached patch makes ofono work with the modem.
>
> It turns out that on my system (Thinkpad T450s, Debian Sid, amd64, Linux
> 4.0.0), cdc_ncm was chosen as the driver for the ethernet interface inste=
ad of
> cdc_ether
>
> Also, udev reported:
>
>      ATTRS{interface}=3D=3D"Ericsson N5321 gw"
>
> for the modem which did not match the existing suffixes "Network Adapter"=
 or
> "NetworkAdapter".
>
> Thanks!
>
> cheers, josch
>

Applied, thanks.

Regards,
-Denis


--===============5624962154927566037==--

