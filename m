Content-Type: multipart/mixed; boundary="===============6560074268051444254=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: Re: [PATCH 1/6] include: Add ofono_emulator_create_card()
Date: Thu, 25 Apr 2013 14:36:27 -0300
Message-ID: <CAG7KCREbwOR3eAyLeXigF=O6OqZzdtJT37BL4drb3Uw9foKtTw@mail.gmail.com>
In-Reply-To: <5178EAE0.8060208@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6560074268051444254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Apr 25, 2013 at 5:35 AM, Denis Kenzior <denkenz@gmail.com> wrote:
>
>
> Why do you need the fd argument?  It can be obtained from the g_at_server
> object.  e.g.
> GIOChannel *channel =3D g_at_server_get_channel(**server);
> fd =3D g_io_channel_get_unix_fd(**channel);
>

You are right, I'll fix it.


> Also, what is the purpose of the version parameter?


In the next patch series I'll need this parameter to set the correct card
driver. So I already put the parameter here to prevent breaking the build.

-- =

Cheers,
Paulo.

--===============6560074268051444254==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVGh1LCBBcHIgMjUsIDIwMTMgYXQgNTozNSBBTSwgRGVu
aXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdt
YWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs8L3NwYW4+
IHdyb3RlOjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6cmdi
KDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4K
PGRpdiBjbGFzcz0iaW0iPgo8YnI+PC9kaXY+CldoeSBkbyB5b3UgbmVlZCB0aGUgZmQgYXJndW1l
bnQ/IKBJdCBjYW4gYmUgb2J0YWluZWQgZnJvbSB0aGUgZ19hdF9zZXJ2ZXIgb2JqZWN0LiCgZS5n
Ljxicj4KR0lPQ2hhbm5lbCAqY2hhbm5lbCA9IGdfYXRfc2VydmVyX2dldF9jaGFubmVsKDx1Pjwv
dT5zZXJ2ZXIpOzxicj4KZmQgPSBnX2lvX2NoYW5uZWxfZ2V0X3VuaXhfZmQoPHU+PC91PmNoYW5u
ZWwpOzxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdiBzdHlsZT5Zb3UgYXJlIHJp
Z2h0LCBJJiMzOTtsbCBmaXggaXQuPC9kaXY+PGRpdj6gPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0
LXdpZHRoOjFweDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0
LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgoKQWxzbywgd2hhdCBpcyB0aGUgcHVycG9z
ZSBvZiB0aGUgdmVyc2lvbiBwYXJhbWV0ZXI/CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+SW4gdGhl
IG5leHQgcGF0Y2ggc2VyaWVzIEkmIzM5O2xsIG5lZWQgdGhpcyBwYXJhbWV0ZXIgdG8gc2V0IHRo
ZSBjb3JyZWN0IGNhcmQgZHJpdmVyLiBTbyBJIGFscmVhZHkgcHV0IHRoZSBwYXJhbWV0ZXIgaGVy
ZSB0byBwcmV2ZW50IGJyZWFraW5nIHRoZSBidWlsZC48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9l
eHRyYSI+PGRpdj48YnI+PC9kaXY+Ci0tIDxicj48ZGl2IGRpcj0ibHRyIj5DaGVlcnMsPGRpdj5Q
YXVsby48L2Rpdj48L2Rpdj4KPC9kaXY+PC9kaXY+Cg==

--===============6560074268051444254==--

