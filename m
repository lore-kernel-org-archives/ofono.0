Content-Type: multipart/mixed; boundary="===============3963677045293243456=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jer=C3=B4nimo?= Lopes <lopesjeronimo@gmail.com>
Subject: Re: Ofono not "recognizing" some USB dongles
Date: Tue, 01 Apr 2014 11:03:14 -0300
Message-ID: <CAM5ihG9-F_m2pRQ6LwcKvp_QGBOZV1BVbdxFYRQ+DsrUq6e+aA@mail.gmail.com>
In-Reply-To: <533ABFAB.5000306@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3963677045293243456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ok, but I already have set CONFIG_TUN.

Another information, I don't know if it is relevan, I'm using Buildroot
toolchain, with uClic.


2014-04-01 10:31 GMT-03:00 Daniel Wagner <wagi@monom.org>:

> On 03/31/2014 11:25 PM, Jer=C3=B4nimo Lopes wrote:
> > Long story, I'm trying to setup a system using Buildroot, Beaglebone
> > Black, Connman, Ofono, and 3G USB dongles to connect to the internet.
> >
> > I have 3 usb dongles (names showed at their plastic case):
> >  - ZTE MF-190: not working
> >  - Huawei E173: not working
> >  - Huawei E160: working
> >
> > I'm attaching some log information of the dongles.
> >
> > Both not working ones, are working at a PC with Ubuntu 13.10. Also they
> > are recognized as the same device on Beaglebone and PC.
> >
> > I'm aware that it's probably not a 'Ofono problem'. I'm using buildroot
> > default kernel for the Beaglebone and set some options myself, like USB
> > Serial Converter (not enabled by default), so there is a big probability
> > that something is missing.
>
> FWIW, didn't look at the logs, but one common problem I am aware of is
> the missing support of CONFIG_TUN in the kernel.
>
> HTH,
> daniel
>

--===============3963677045293243456==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OiYjMzk7Y291cmllciBuZXcmIzM5Oyxtb25vc3BhY2UiPk9rLCBidXQgSSBhbHJlYWR5IGhh
dmUgc2V0IENPTkZJR19UVU4uPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9
ImZvbnQtZmFtaWx5OiYjMzk7Y291cmllciBuZXcmIzM5Oyxtb25vc3BhY2UiPjxicj48L2Rpdj4K
PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OiYjMzk7Y291cmll
ciBuZXcmIzM5Oyxtb25vc3BhY2UiPkFub3RoZXIgaW5mb3JtYXRpb24sIEkgZG9uJiMzOTt0IGtu
b3cgaWYgaXQgaXMgcmVsZXZhbiwgSSYjMzk7bSB1c2luZyBCdWlsZHJvb3QgdG9vbGNoYWluLCB3
aXRoIHVDbGljLjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+Cjxicj48
ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxNC0wNC0wMSAxMDozMSBHTVQtMDM6MDAgRGFuaWVs
IFdhZ25lciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzp3YWdpQG1vbm9tLm9y
ZyIgdGFyZ2V0PSJfYmxhbmsiPndhZ2lAbW9ub20ub3JnPC9hPiZndDs8L3NwYW4+Ojxicj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3Jk
ZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGRpdiBjbGFzcz0iSE9F
blpiIj48ZGl2IGNsYXNzPSJoNSI+T24gMDMvMzEvMjAxNCAxMToyNSBQTSwgSmVy9G5pbW8gTG9w
ZXMgd3JvdGU6PGJyPgomZ3Q7IExvbmcgc3RvcnksIEkmIzM5O20gdHJ5aW5nIHRvIHNldHVwIGEg
c3lzdGVtIHVzaW5nIEJ1aWxkcm9vdCwgQmVhZ2xlYm9uZTxicj4KJmd0OyBCbGFjaywgQ29ubm1h
biwgT2Zvbm8sIGFuZCAzRyBVU0IgZG9uZ2xlcyB0byBjb25uZWN0IHRvIHRoZSBpbnRlcm5ldC48
YnI+CiZndDs8YnI+CiZndDsgSSBoYXZlIDMgdXNiIGRvbmdsZXMgKG5hbWVzIHNob3dlZCBhdCB0
aGVpciBwbGFzdGljIGNhc2UpOjxicj4KJmd0OyCgLSBaVEUgTUYtMTkwOiBub3Qgd29ya2luZzxi
cj4KJmd0OyCgLSBIdWF3ZWkgRTE3Mzogbm90IHdvcmtpbmc8YnI+CiZndDsgoC0gSHVhd2VpIEUx
NjA6IHdvcmtpbmc8YnI+CiZndDs8YnI+CiZndDsgSSYjMzk7bSBhdHRhY2hpbmcgc29tZSBsb2cg
aW5mb3JtYXRpb24gb2YgdGhlIGRvbmdsZXMuPGJyPgomZ3Q7PGJyPgomZ3Q7IEJvdGggbm90IHdv
cmtpbmcgb25lcywgYXJlIHdvcmtpbmcgYXQgYSBQQyB3aXRoIFVidW50dSAxMy4xMC4gQWxzbyB0
aGV5PGJyPgomZ3Q7IGFyZSByZWNvZ25pemVkIGFzIHRoZSBzYW1lIGRldmljZSBvbiBCZWFnbGVi
b25lIGFuZCBQQy48YnI+CiZndDs8YnI+CiZndDsgSSYjMzk7bSBhd2FyZSB0aGF0IGl0JiMzOTtz
IHByb2JhYmx5IG5vdCBhICYjMzk7T2Zvbm8gcHJvYmxlbSYjMzk7LiBJJiMzOTttIHVzaW5nIGJ1
aWxkcm9vdDxicj4KJmd0OyBkZWZhdWx0IGtlcm5lbCBmb3IgdGhlIEJlYWdsZWJvbmUgYW5kIHNl
dCBzb21lIG9wdGlvbnMgbXlzZWxmLCBsaWtlIFVTQjxicj4KJmd0OyBTZXJpYWwgQ29udmVydGVy
IChub3QgZW5hYmxlZCBieSBkZWZhdWx0KSwgc28gdGhlcmUgaXMgYSBiaWcgcHJvYmFiaWxpdHk8
YnI+CiZndDsgdGhhdCBzb21ldGhpbmcgaXMgbWlzc2luZy48YnI+Cjxicj4KPC9kaXY+PC9kaXY+
RldJVywgZGlkbiYjMzk7dCBsb29rIGF0IHRoZSBsb2dzLCBidXQgb25lIGNvbW1vbiBwcm9ibGVt
IEkgYW0gYXdhcmUgb2YgaXM8YnI+CnRoZSBtaXNzaW5nIHN1cHBvcnQgb2YgQ09ORklHX1RVTiBp
biB0aGUga2VybmVsLjxicj4KPGJyPgpIVEgsPGJyPgpkYW5pZWw8YnI+CjwvYmxvY2txdW90ZT48
L2Rpdj48YnI+PC9kaXY+Cg==

--===============3963677045293243456==--

