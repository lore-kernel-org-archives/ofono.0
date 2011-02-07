Content-Type: multipart/mixed; boundary="===============8013346528155184521=="
MIME-Version: 1.0
From: andre matos <andre.matos.ste@gmail.com>
Subject: Re: [PATCH] voicecall: fix transfer
Date: Mon, 07 Feb 2011 22:48:25 +0100
Message-ID: <AANLkTik2cQV=xUygaK8Q-5Fdt=UuyyQ93tLAG0kqJEE0@mail.gmail.com>
In-Reply-To: <4D506478.1030907@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8013346528155184521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, Feb 7, 2011 at 10:30 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Andre,
>
> > Are we reading the same code?
> >
> > for this case we have:
> > numactive !=3D 1  =3D=3D> true
> > numheld !=3D 1  =3D=3D> false
> >
> > (numactive !=3D 1) && (numheld !=3D 1)  =3D=3D>  false
> >
>
> Then shouldn't the patch simply be modified to if (numactive !=3D 1 ||
> numheld !=3D 1)?
>

Yes, if you wish to sacrifice readability for simplicity.

I find my version self explanatory.

Best regards,
Andr=C3=A9

--===============8013346528155184521==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gTW9uLCBGZWIgNywg
MjAxMSBhdCAxMDozMCBQTSwgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhy
ZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwv
c3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDox
ZXg7Ij4KSGkgQW5kcmUsPGJyPgo8ZGl2IGNsYXNzPSJpbSI+PGJyPgomZ3Q7IEFyZSB3ZSByZWFk
aW5nIHRoZSBzYW1lIGNvZGU/PGJyPgomZ3Q7PGJyPgomZ3Q7IGZvciB0aGlzIGNhc2Ugd2UgaGF2
ZTo8YnI+CiZndDsgbnVtYWN0aXZlICE9IDEgoD09Jmd0OyB0cnVlPGJyPgomZ3Q7IG51bWhlbGQg
IT0gMSCgPT0mZ3Q7IGZhbHNlPGJyPgomZ3Q7PGJyPgomZ3Q7IChudW1hY3RpdmUgIT0gMSkgJmFt
cDsmYW1wOyAobnVtaGVsZCAhPSAxKSCgPT0mZ3Q7IKBmYWxzZTxicj4KJmd0Ozxicj4KPGJyPgo8
L2Rpdj5UaGVuIHNob3VsZG4mIzM5O3QgdGhlIHBhdGNoIHNpbXBseSBiZSBtb2RpZmllZCB0byBp
ZiAobnVtYWN0aXZlICE9IDEgfHw8YnI+Cm51bWhlbGQgIT0gMSk/PGJyPjwvYmxvY2txdW90ZT48
ZGl2Pjxicj48L2Rpdj48ZGl2PlllcywgaWYgeW91IHdpc2ggdG8gc2FjcmlmaWNlIHJlYWRhYmls
aXR5IGZvciBzaW1wbGljaXR5LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBmaW5kIG15IHZl
cnNpb24gc2VsZiBleHBsYW5hdG9yeS48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0
IHJlZ2FyZHMsPC9kaXY+PGRpdj4KQW5kcuk8L2Rpdj48L2Rpdj4K

--===============8013346528155184521==--

