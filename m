Content-Type: multipart/mixed; boundary="===============7728342344971755898=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: IPV6 question
Date: Thu, 06 Oct 2016 09:13:25 +0200
Message-ID: <CAH4ZQwvMbA+quNT5QmdQUM1f5CdjwgVL2k4k45Lo-ZSJC_z72g@mail.gmail.com>
In-Reply-To: <57F53FDF.4020501@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7728342344971755898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Which modem are you using, if its no secret?
>

=E2=80=8BNo secrets, I'm using this:
http://www.telit.com/cellular/4g-modules/xe910-family/
The V2 series.

It looks like IPV6CP was never properly integrated into GAtPPP logic. At
> least I don't see ipv6cp_new() inside gatchat/gatppp.c anywhere.  You mig=
ht
> have to extend gatppp.c to manage IPV6CP as well.


=E2=80=8BI will look into it.
Do you think is a difficult task?=E2=80=8B

=E2=80=8B=E2=80=8B

=E2=80=8BI extended several ofono interfaces fot telit modems.
I will find the time to submit some changes sooner or later=E2=80=8B.

=E2=80=8BRegards,
Enrico=E2=80=8B

--===============7728342344971755898==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SGkgRGVuaXMsPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+PGJyPjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4
O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgi
PgpXaGljaCBtb2RlbSBhcmUgeW91IHVzaW5nLCBpZiBpdHMgbm8gc2VjcmV0Pzxicj48L2Jsb2Nr
cXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHls
ZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj7igItObyBzZWNyZXRzLCBJJiMzOTtt
IHVzaW5nIHRoaXM6IDxhIGhyZWY9Imh0dHA6Ly93d3cudGVsaXQuY29tL2NlbGx1bGFyLzRnLW1v
ZHVsZXMveGU5MTAtZmFtaWx5LyI+aHR0cDovL3d3dy50ZWxpdC5jb20vY2VsbHVsYXIvNGctbW9k
dWxlcy94ZTkxMC1mYW1pbHkvPC9hPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0
eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPlRoZSBWMiBzZXJpZXMuPC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fu
cy1zZXJpZiI+PGJyPjwvZGl2PjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdi
KDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5JdCBsb29rcyBsaWtlIElQVjZDUCB3YXMg
bmV2ZXIgcHJvcGVybHkgaW50ZWdyYXRlZCBpbnRvIEdBdFBQUCBsb2dpYy4gQXQgbGVhc3QgSSBk
b24mIzM5O3Qgc2VlIGlwdjZjcF9uZXcoKSBpbnNpZGUgZ2F0Y2hhdC9nYXRwcHAuYyBhbnl3aGVy
ZS7CoCBZb3UgbWlnaHQgaGF2ZSB0byBleHRlbmQgZ2F0cHBwLmMgdG8gbWFuYWdlIElQVjZDUCBh
cyB3ZWxsLjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWY7ZGlzcGxheTpp
bmxpbmUiPuKAi0kgd2lsbCBsb29rIGludG8gaXQuPC9kaXY+PC9kaXY+PGRpdj48ZGl2IGNsYXNz
PSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmO2Rp
c3BsYXk6aW5saW5lIj5EbyB5b3UgdGhpbmsgaXMgYSBkaWZmaWN1bHQgdGFzaz/igIs8L2Rpdj7C
oDxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNh
bnMtc2VyaWY7ZGlzcGxheTppbmxpbmUiPuKAi+KAizwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRh
bmEsc2Fucy1zZXJpZiI+4oCLSSBleHRlbmRlZCBzZXZlcmFsIG9mb25vIGludGVyZmFjZXMgZm90
IHRlbGl0IG1vZGVtcy48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9u
dC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5JIHdpbGwgZmluZCB0aGUgdGltZSB0byBzdWJt
aXQgc29tZSBjaGFuZ2VzIHNvb25lciBvciBsYXRlcuKAiy48YnI+PC9kaXY+PGJyPjwvZGl2Pjxk
aXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEs
c2Fucy1zZXJpZiI+4oCLUmVnYXJkcyw8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBz
dHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5FbnJpY2/igIs8L2Rpdj48YnI+
PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============7728342344971755898==--

