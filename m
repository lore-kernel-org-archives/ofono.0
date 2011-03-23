Content-Type: multipart/mixed; boundary="===============3349007609321733776=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: buildroot
Date: Thu, 24 Mar 2011 00:42:04 +0100
Message-ID: <1300923724.2572.76.camel@aeonflux>
In-Reply-To: <AANLkTi=3-+Lkg7xxH3s8uFchA4ZiYhJhHRvqZx2PUjnr@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3349007609321733776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> > first mail, please be gentle. I wish to create a new rootfs for my ARM9=
20T
> > microcontroller based device using BUILDROOT. The device has a serial p=
ort
> > attached huawei 3G modem that could theoretically be used with stock
> > chap/ppp. I do vividly remember though my aggreviance with this before
> > finding wvdial, a simple, easy-to-use package to configure, initialize,
> > start, and monitor the pppd. Unfortunately, wvdial just can not be adde=
d to
> > my buidroot created rootFS. My question to the listmembers is twofold:
> > 1) am I right to assume that ofono is more than capable replacing my old
> > friend vwdial as shown here:
> > http://ofono.org/wiki/how-work-newly-bought-3g-key
> =

> Yes, but make sure to use udev instead of mdev (AFAIR mdev is the
> default in buildroot).

you just need libudev actually, but it does depend on udev.

> Other problem is that buildroot uses uClibc. Denis, do you know if
> there's any problem in building oFono with uClibc?

There might be small problems, but none that can not be fixed. To be
fair, I have not yet tried to get it all compiled with uClibc.

> If there is, you'd need to provide your own toolchain (take one from
> CodeSourcery).
> =

> =

> > 2) if so, is there a makefile I could use to add ofono to my otherwise
> > functional buildroot conf?
> =

> oFono uses autotools for building. If you are using the git
> repository, you need to run './bootstrap && ./configure' first. Then
> you'll have a Makefile.

If you use a packaged tarball, then only ./configure is sufficient.

However this question might be more targeted to a buildroot specific .mk
file and no, we do not have that.

Regards

Marcel



--===============3349007609321733776==--

