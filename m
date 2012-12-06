Content-Type: multipart/mixed; boundary="===============0811182670165210010=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: tun interface name conflicts with ppp driver
Date: Thu, 06 Dec 2012 12:50:25 +0100
Message-ID: <1354794625.1815.25.camel@aeonflux>
In-Reply-To: <CABvLYuBUFN+YtPd9=vd4akWfEYZR84xp6TaFrBYY=EUvd7istg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0811182670165210010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

> when a context is active, the interface name is typically ppp0. If you try
> to run pppd for some other device/interface, the kernel ppp driver prints
> an error because it can't register ppp0. It looks like it's assumed that
> ppp* interface names are reserved for the ppp_driver.
> Can the tun interface name be changed to eg. ofono0?

actually we are using ppp%d syntax to assign the network interfaces. So
the kernel does the numbering. This is a bug in pppd and not ours.

Looking at the pppd code, it seems to hardcodes ppp0. So please complain
to them for assuming that a certain device name is owned by them.

Regards

Marcel



--===============0811182670165210010==--

