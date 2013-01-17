Content-Type: multipart/mixed; boundary="===============3282734432410909040=="
MIME-Version: 1.0
From: Andrea Galbusera <gizero@gmail.com>
Subject: Re: [PATCH] Fix build with automake-1.13
Date: Thu, 17 Jan 2013 08:18:18 +0100
Message-ID: <CAC+thW1mwyLNMjh4ZvEr1f_7TpFWXyC_0BPLQq68FvGTsr39Vg@mail.gmail.com>
In-Reply-To: <CAF6bG8eQqF+s1VECb_1fEZHxkdnaDccF0ku0OL0vrQWitJM6jg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3282734432410909040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

On Sat, Jan 12, 2013 at 10:22 AM, Marko Lindqvist <cazfi74@gmail.com> wro=
te:

> Automake-1.13 removed long obsolete AM_CONFIG_HEADER completely (
> http://lists.gnu.org/archive/html/automake/2012-12/msg00038.html ) and
> errors out upon seeing it.
>
> Attached patch replaces it with proper AC_CONFIG_HEADERS.
>
>  I'm not subscribed to mailing list.
>

FYI since I see you are not on the list: a similar patch was recently
submitted by Lucas De Marchi, and just applied by Marcel.

--===============3282734432410909040==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgTWFya28sPGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gU2F0LCBKYW4gMTIsIDIwMTMgYXQgMTA6MjIgQU0sIE1h
cmtvIExpbmRxdmlzdCA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpjYXpmaTc0
QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmNhemZpNzRAZ21haWwuY29tPC9hPiZndDs8L3Nw
YW4+IHdyb3RlOjxicj4KCgoKPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0
OjFleCI+QXV0b21ha2UtMS4xMyByZW1vdmVkIGxvbmcgb2Jzb2xldGUgQU1fQ09ORklHX0hFQURF
UiBjb21wbGV0ZWx5ICg8YnI+CjxhIGhyZWY9Imh0dHA6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUv
aHRtbC9hdXRvbWFrZS8yMDEyLTEyL21zZzAwMDM4Lmh0bWwiIHRhcmdldD0iX2JsYW5rIj5odHRw
Oi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvYXV0b21ha2UvMjAxMi0xMi9tc2cwMDAzOC5o
dG1sPC9hPiApIGFuZDxicj4KZXJyb3JzIG91dCB1cG9uIHNlZWluZyBpdC48YnI+Cjxicj4KQXR0
YWNoZWQgcGF0Y2ggcmVwbGFjZXMgaXQgd2l0aCBwcm9wZXIgQUNfQ09ORklHX0hFQURFUlMuPGJy
Pgo8YnI+CqBJJiMzOTttIG5vdCBzdWJzY3JpYmVkIHRvIG1haWxpbmcgbGlzdC48YnI+PC9ibG9j
a3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+RllJIHNpbmNlIEkgc2VlIHlvdSBhcmUgbm90IG9u
IHRoZSBsaXN0OiBhIHNpbWlsYXIgcGF0Y2ggd2FzIHJlY2VudGx5IHN1Ym1pdHRlZCBieSBMdWNh
cyBEZSBNYXJjaGksIGFuZCBqdXN0IGFwcGxpZWQgYnkgTWFyY2VsLjxicj48L2Rpdj48L2Rpdj4K
PC9kaXY+PC9kaXY+Cg==

--===============3282734432410909040==--

