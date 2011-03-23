Content-Type: multipart/mixed; boundary="===============4447479594630040688=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: buildroot
Date: Wed, 23 Mar 2011 18:08:40 -0300
Message-ID: <AANLkTi=3-+Lkg7xxH3s8uFchA4ZiYhJhHRvqZx2PUjnr@mail.gmail.com>
In-Reply-To: <AANLkTi=MRsBechiLLBeG9pcKQ+dG5ViZY04x5QwOmZrW@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4447479594630040688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2011 at 1:01 PM, Jerry Casette <gjerryboi@gmail.com> wrot=
e:
> Hello List,
>
> first mail, please be gentle. I wish to create a new rootfs for my ARM920T
> microcontroller based device using BUILDROOT. The device has a serial port
> attached huawei 3G modem that could theoretically be used with stock
> chap/ppp. I do vividly remember though my aggreviance with this before
> finding wvdial, a simple, easy-to-use package to configure, initialize,
> start, and monitor the pppd. Unfortunately, wvdial just can not be added =
to
> my buidroot created rootFS. My question to the listmembers is twofold:
> 1) am I right to assume that ofono is more than capable replacing my old
> friend vwdial as shown here:
> http://ofono.org/wiki/how-work-newly-bought-3g-key

Yes, but make sure to use udev instead of mdev (AFAIR mdev is the
default in buildroot).

Other problem is that buildroot uses uClibc. Denis, do you know if
there's any problem in building oFono with uClibc?

If there is, you'd need to provide your own toolchain (take one from
CodeSourcery).


> 2) if so, is there a makefile I could use to add ofono to my otherwise
> functional buildroot conf?

oFono uses autotools for building. If you are using the git
repository, you need to run './bootstrap && ./configure' first. Then
you'll have a Makefile.


regards,

Lucas De Marchi

--===============4447479594630040688==--

