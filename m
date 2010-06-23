Content-Type: multipart/mixed; boundary="===============8935228704247110247=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: Re: Ofono and PPP
Date: Wed, 23 Jun 2010 10:09:15 +0300
Message-ID: <AANLkTimDv2QKGPduaOWRuX_krighq3o_mUr6InMxyFeq@mail.gmail.com>
In-Reply-To: <1277220835.2301.160.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8935228704247110247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Hi Arun,
>
> > I have managed to put together ofono and conn man for an at modem
> > interface.
> >
> > The atmodem is working and here is the detail of a pdp context i
> > created.
> >
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------
> > [ /generic ]
> >     [ /generic/primarycontext1 ]
> >         Username =3D
> >         Name =3D Internet access
> >         Settings =3D { Interface=3Dppp0 Netmask=3D255.255.255.255
> > Method=3Dstatic DomainNameServers=3D192.89.123.231,192.89.123.230,
> > Address=3D109.240.193.169 }
> >         Active =3D 1
> >         AccessPointName =3D internet
> >         Password =3D
> >         Type =3D internet
> >
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------
> >
> > the ifconfig:
> >
> > ppp0      Link encap:UNSPEC  HWaddr
> > 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
> >           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
> >           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:32 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:500
> >           RX bytes:0 (0.0 B)  TX bytes:10944 (10.9 KB)
> >
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------
> >
> > The ifconfig doesn't seem to have all the required information from
> > the ppp link created. why this is so? Is there a way to put these in
> > sync?
>
> try the latest versions of ConnMan and oFono. I have this actually
> working perfectly fine with Novatel and Huawei devices. Maybe the
> atmodem driver has an issue, but in general this works fine.
>
> Regards
>
> Marcel
>
>
I am using atmodem, and i have the latest of both connman and Ofono. The ppp
interface which is made up from Ofono is not usable at all.
As you have seen from my mail, there is no IP address or HW address to it. I
made the change to put those from pri_update_context_settings() function,
but the issue was still there. I can see that when i assign an ip address to
the interface, the comm nan logs are also showing it. When i run any clinet
(dhclinet, or ftp etc) there is only ppp transmit and not receive at all.
But i can see that there is link available as i keep seeing the echo request
coming.

Something is missing and i am still clueless

Regards
Arun



> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============8935228704247110247==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPkhpLDxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0
LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsiPkhp
IEFydW4sPGJyPgo8ZGl2PjxkaXY+PC9kaXY+PGRpdiBjbGFzcz0iaDUiPjxicj4KJmd0OyBJIGhh
dmUgbWFuYWdlZCB0byBwdXQgdG9nZXRoZXIgb2Zvbm8gYW5kIGNvbm4gbWFuIGZvciBhbiBhdCBt
b2RlbTxicj4KJmd0OyBpbnRlcmZhY2UuPGJyPgomZ3Q7PGJyPgomZ3Q7IFRoZSBhdG1vZGVtIGlz
IHdvcmtpbmcgYW5kIGhlcmUgaXMgdGhlIGRldGFpbCBvZiBhIHBkcCBjb250ZXh0IGk8YnI+CiZn
dDsgY3JlYXRlZC48YnI+CiZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CgomZ3Q7IFsgL2dlbmVyaWMgXTxicj4K
Jmd0OyCgIKAgWyAvZ2VuZXJpYy9wcmltYXJ5Y29udGV4dDEgXTxicj4KJmd0OyCgIKAgoCCgIFVz
ZXJuYW1lID08YnI+CiZndDsgoCCgIKAgoCBOYW1lID0gSW50ZXJuZXQgYWNjZXNzPGJyPgomZ3Q7
IKAgoCCgIKAgU2V0dGluZ3MgPSB7IEludGVyZmFjZT1wcHAwIE5ldG1hc2s9MjU1LjI1NS4yNTUu
MjU1PGJyPgomZ3Q7IE1ldGhvZD1zdGF0aWMgRG9tYWluTmFtZVNlcnZlcnM9MTkyLjg5LjEyMy4y
MzEsMTkyLjg5LjEyMy4yMzAsPGJyPgomZ3Q7IEFkZHJlc3M9MTA5LjI0MC4xOTMuMTY5IH08YnI+
CiZndDsgoCCgIKAgoCBBY3RpdmUgPSAxPGJyPgomZ3Q7IKAgoCCgIKAgQWNjZXNzUG9pbnROYW1l
ID0gaW50ZXJuZXQ8YnI+CiZndDsgoCCgIKAgoCBQYXNzd29yZCA9PGJyPgomZ3Q7IKAgoCCgIKAg
VHlwZSA9IGludGVybmV0PGJyPgomZ3Q7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgoKJmd0Ozxicj4KJmd0OyB0aGUg
aWZjb25maWc6PGJyPgomZ3Q7PGJyPgomZ3Q7IHBwcDAgoCCgIKBMaW5rIGVuY2FwOlVOU1BFQyCg
SFdhZGRyPGJyPgomZ3Q7IDAwLTAwLTAwLTAwLTAwLTAwLTAwLTAwLTAwLTAwLTAwLTAwLTAwLTAw
LTAwLTAwPGJyPgomZ3Q7IKAgoCCgIKAgoCBVUCBQT0lOVE9QT0lOVCBSVU5OSU5HIE5PQVJQIE1V
TFRJQ0FTVCCgTVRVOjE1MDAgoE1ldHJpYzoxPGJyPgomZ3Q7IKAgoCCgIKAgoCBSWCBwYWNrZXRz
OjAgZXJyb3JzOjAgZHJvcHBlZDowIG92ZXJydW5zOjAgZnJhbWU6MDxicj4KJmd0OyCgIKAgoCCg
IKAgVFggcGFja2V0czozMiBlcnJvcnM6MCBkcm9wcGVkOjAgb3ZlcnJ1bnM6MCBjYXJyaWVyOjA8
YnI+CiZndDsgoCCgIKAgoCCgIGNvbGxpc2lvbnM6MCB0eHF1ZXVlbGVuOjUwMDxicj4KJmd0OyCg
IKAgoCCgIKAgUlggYnl0ZXM6MCAoMC4wIEIpIKBUWCBieXRlczoxMDk0NCAoMTAuOSBLQik8YnI+
CiZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLTxicj4KCiZndDs8YnI+CiZndDsgVGhlIGlmY29uZmlnIGRvZXNuJiMz
OTt0IHNlZW0gdG8gaGF2ZSBhbGwgdGhlIHJlcXVpcmVkIGluZm9ybWF0aW9uIGZyb208YnI+CiZn
dDsgdGhlIHBwcCBsaW5rIGNyZWF0ZWQuIHdoeSB0aGlzIGlzIHNvPyBJcyB0aGVyZSBhIHdheSB0
byBwdXQgdGhlc2UgaW48YnI+CiZndDsgc3luYz88YnI+Cjxicj4KPC9kaXY+PC9kaXY+dHJ5IHRo
ZSBsYXRlc3QgdmVyc2lvbnMgb2YgQ29ubk1hbiBhbmQgb0Zvbm8uIEkgaGF2ZSB0aGlzIGFjdHVh
bGx5PGJyPgp3b3JraW5nIHBlcmZlY3RseSBmaW5lIHdpdGggTm92YXRlbCBhbmQgSHVhd2VpIGRl
dmljZXMuIE1heWJlIHRoZTxicj4KYXRtb2RlbSBkcml2ZXIgaGFzIGFuIGlzc3VlLCBidXQgaW4g
Z2VuZXJhbCB0aGlzIHdvcmtzIGZpbmUuPGJyPgo8YnI+ClJlZ2FyZHM8YnI+Cjxmb250IGNvbG9y
PSIjODg4ODg4Ij48YnI+Ck1hcmNlbDxicj4KPC9mb250PjxkaXY+PGRpdj48L2Rpdj48ZGl2IGNs
YXNzPSJoNSI+PGJyPgo8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdiBjbGFzcz0iaDUiPjxi
cj5JIGFtIHVzaW5nIGF0bW9kZW0sIGFuZCBpIGhhdmUgdGhlIGxhdGVzdCBvZiBib3RoIGNvbm5t
YW4gYW5kIE9mb25vLgpUaGUgcHBwIGludGVyZmFjZSB3aGljaCBpcyBtYWRlIHVwIGZyb20gT2Zv
bm8gaXMgbm90IHVzYWJsZSBhdCBhbGwuPGJyPgpBcyB5b3UgaGF2ZSBzZWVuIGZyb20gbXkgbWFp
bCwgdGhlcmUgaXMgbm8gSVAgYWRkcmVzcyBvciBIVyBhZGRyZXNzIHRvCml0LiBJIG1hZGUgdGhl
IGNoYW5nZSB0byBwdXQgdGhvc2UgZnJvbSBwcmlfdXBkYXRlX2NvbnRleHRfc2V0dGluZ3MoKQpm
dW5jdGlvbiwgYnV0IHRoZSBpc3N1ZSB3YXMgc3RpbGwgdGhlcmUuIEkgY2FuIHNlZSB0aGF0IHdo
ZW4gaSBhc3NpZ24KYW4gaXAgYWRkcmVzcyB0byB0aGUgaW50ZXJmYWNlLCB0aGUgY29tbSBuYW4g
bG9ncyBhcmUgYWxzbyBzaG93aW5nIGl0LgpXaGVuIGkgcnVuIGFueSBjbGluZXQgKGRoY2xpbmV0
LCBvciBmdHAgZXRjKSB0aGVyZSBpcyBvbmx5IHBwcCB0cmFuc21pdAphbmQgbm90IHJlY2VpdmUg
YXQgYWxsLiBCdXQgaSBjYW4gc2VlIHRoYXQgdGhlcmUgaXMgbGluayBhdmFpbGFibGUgYXMgaQpr
ZWVwIHNlZWluZyB0aGUgZWNobyByZXF1ZXN0IGNvbWluZy48YnI+Cjxicj4KU29tZXRoaW5nIGlz
IG1pc3NpbmcgYW5kIGkgYW0gc3RpbGwgY2x1ZWxlc3M8YnI+oDxicj5SZWdhcmRzPGJyPjwvZGl2
PjxkaXY+QXJ1bjxicj48YnI+oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBtYXJnaW46
IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsiPgo8ZGl2PjxkaXYgY2xhc3M9
Img1Ij4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+
Cm9mb25vIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+
b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KPGEgaHJlZj0iaHR0cDovL2xpc3RzLm9mb25vLm9yZy9s
aXN0aW5mby9vZm9ubyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlz
dGluZm8vb2Zvbm88L2E+PGJyPgo8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============8935228704247110247==--

