Content-Type: multipart/mixed; boundary="===============8945847433238937120=="
MIME-Version: 1.0
From: JongSeok Won <wjs890204@gmail.com>
Subject: Re: [PATCH] build: require glib >= 2.60
Date: Mon, 08 Mar 2021 18:22:47 +0900
Message-ID: <CAKnLNuTVeg5pN-6w9-GQV=NLYOSf9ajG0V7b8oBbmLogXNH9Hw@mail.gmail.com>
In-Reply-To: <718f5a16-8605-c043-e95b-299eeab44476@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8945847433238937120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Denis

I had a mistake while making patch. So, I'll re-send the patch of V2.

Best regards
JongSeok Won

2021=EB=85=84 3=EC=9B=94 5=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11:49, D=
enis Kenzior <denkenz@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi,
>
> > -PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
> > - AC_MSG_ERROR(GLib >=3D 2.32 is required))
> > +PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.60, dummy=3Dyes,
> > + AC_MSG_ERROR(GLib >=3D 2.60 is required))
>
> This patch doesn't apply:
> denkenz(a)localhost ~/ofono-master $ git am ~/merge/\[PATCH\]\ build\:\
> require\
> glib\ \>\=3D\ 2.60.eml
> Applying: build: require glib >=3D 2.60
> error: corrupt patch at line 12
> Patch failed at 0001 build: require glib >=3D 2.60
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Looks like it is whitespace-mangled or otherwise damaged for some reason.
>
> Regards,
> -Denis
>

--===============8945847433238937120==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+SGksIERlbmlzPGRpdj48YnI+PGRpdj5JIGhhZCBhIG1pc3Rha2Ugd2hp
bGUgbWFraW5nwqBwYXRjaC4gU28sIEkmIzM5O2xsIHJlLXNlbmQgdGhlIHBhdGNoIG9mIFYyLsKg
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IHJlZ2FyZHM8L2Rpdj48ZGl2PkpvbmdTZW9r
IFdvbjwvZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBk
aXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPjIwMjHrhYQgM+yblCA17J28ICjquIgpIOyYpO2b
hCAxMTo0OSwgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwu
Y29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q764uY7J20IOyekeyEsTo8YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAu
OGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDox
ZXgiPkhpLDxicj4KPGJyPgomZ3Q7IC1QS0dfQ0hFQ0tfTU9EVUxFUyhHTElCLCBnbGliLTIuMCAm
Z3Q7PSAyLjMyLCBkdW1teT15ZXMsPGJyPgomZ3Q7IC0gQUNfTVNHX0VSUk9SKEdMaWIgJmd0Oz0g
Mi4zMiBpcyByZXF1aXJlZCkpPGJyPgomZ3Q7ICtQS0dfQ0hFQ0tfTU9EVUxFUyhHTElCLCBnbGli
LTIuMCAmZ3Q7PSAyLjYwLCBkdW1teT15ZXMsPGJyPgomZ3Q7ICsgQUNfTVNHX0VSUk9SKEdMaWIg
Jmd0Oz0gMi42MCBpcyByZXF1aXJlZCkpPGJyPgo8YnI+ClRoaXMgcGF0Y2ggZG9lc24mIzM5O3Qg
YXBwbHk6PGJyPgpkZW5rZW56QGxvY2FsaG9zdCB+L29mb25vLW1hc3RlciAkIGdpdCBhbSB+L21l
cmdlL1xbUEFUQ0hcXVwgYnVpbGRcOlwgcmVxdWlyZVwgPGJyPgpnbGliXCBcJmd0O1w9XCAyLjYw
LmVtbDxicj4KQXBwbHlpbmc6IGJ1aWxkOiByZXF1aXJlIGdsaWIgJmd0Oz0gMi42MDxicj4KZXJy
b3I6IGNvcnJ1cHQgcGF0Y2ggYXQgbGluZSAxMjxicj4KUGF0Y2ggZmFpbGVkIGF0IDAwMDEgYnVp
bGQ6IHJlcXVpcmUgZ2xpYiAmZ3Q7PSAyLjYwPGJyPgpoaW50OiBVc2UgJiMzOTtnaXQgYW0gLS1z
aG93LWN1cnJlbnQtcGF0Y2g9ZGlmZiYjMzk7IHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoPGJyPgpX
aGVuIHlvdSBoYXZlIHJlc29sdmVkIHRoaXMgcHJvYmxlbSwgcnVuICZxdW90O2dpdCBhbSAtLWNv
bnRpbnVlJnF1b3Q7Ljxicj4KSWYgeW91IHByZWZlciB0byBza2lwIHRoaXMgcGF0Y2gsIHJ1biAm
cXVvdDtnaXQgYW0gLS1za2lwJnF1b3Q7IGluc3RlYWQuPGJyPgpUbyByZXN0b3JlIHRoZSBvcmln
aW5hbCBicmFuY2ggYW5kIHN0b3AgcGF0Y2hpbmcsIHJ1biAmcXVvdDtnaXQgYW0gLS1hYm9ydCZx
dW90Oy48YnI+Cjxicj4KTG9va3MgbGlrZSBpdCBpcyB3aGl0ZXNwYWNlLW1hbmdsZWQgb3Igb3Ro
ZXJ3aXNlIGRhbWFnZWQgZm9yIHNvbWUgcmVhc29uLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURl
bmlzPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============8945847433238937120==--

