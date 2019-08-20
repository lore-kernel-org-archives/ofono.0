Content-Type: multipart/mixed; boundary="===============0020416505959169971=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH 1/4] gprs: Check for LTE in gprs_attached_update
Date: Tue, 20 Aug 2019 02:58:21 +0200
Message-ID: <CAHB-Pj=MGqvog=2ox_RvfGhsOx4EceRykeBa_cX-vEihc0zLVg@mail.gmail.com>
In-Reply-To: <73112d6e-fe83-aa60-b8d3-7c1a13b7e3df@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0020416505959169971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den m=C3=A5n 19 aug. 2019 kl 21:48 skrev Denis Kenzior <denkenz@gmail.com=
>:

> Hi Richard,
>
> > As I said, I'm afraid I have no logs for this. I tried to visualize how
> > it could happen.
>
> Sorry for the repeat.  Just take it as a strong hint for the "next time" =
:)
>

I got the hint ;-)


>
> >
> > But anyway I think it makes more sense to "calculate" the attached state
> > in one place,
> > (gprs_attached_update) and one of the places this gets called from is
> > when GPRS detaches.
>
> Care to resend a cleaned up patch? I'm fine taking at least 1/4.
>
> Will do. I think we can skip 2/4. But I think 3 and 4/4 should be applied
too. But we can start with the first.

--Richard

--===============0020416505959169971==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gbcOlbiAxOSBhdWcu
IDIwMTkga2wgMjE6NDggc2tyZXYgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRl
bmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7Ojxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+SGkgUmljaGFyZCw8YnI+Cjxicj4KJmd0OyBBcyBJIHNhaWQsIEkmIzM5O20gYWZyYWlkIEkg
aGF2ZSBubyBsb2dzIGZvciB0aGlzLiBJIHRyaWVkIHRvIHZpc3VhbGl6ZSBob3cgPGJyPgomZ3Q7
IGl0IGNvdWxkIGhhcHBlbi48YnI+Cjxicj4KU29ycnkgZm9yIHRoZSByZXBlYXQuwqAgSnVzdCB0
YWtlIGl0IGFzIGEgc3Ryb25nIGhpbnQgZm9yIHRoZSAmcXVvdDtuZXh0IHRpbWUmcXVvdDsgOik8
YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBnb3QgdGhlIGhpbnQgOy0pPC9k
aXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQs
MjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgomZ3Q7IDxicj4KJmd0OyBCdXQgYW55d2F5IEkg
dGhpbmsgaXQgbWFrZXMgbW9yZSBzZW5zZSB0byAmcXVvdDtjYWxjdWxhdGUmcXVvdDsgdGhlIGF0
dGFjaGVkIHN0YXRlIDxicj4KJmd0OyBpbiBvbmUgcGxhY2UsPGJyPgomZ3Q7IChncHJzX2F0dGFj
aGVkX3VwZGF0ZSkgYW5kIG9uZSBvZiB0aGUgcGxhY2VzIHRoaXMgZ2V0cyBjYWxsZWQgZnJvbSBp
cyA8YnI+CiZndDsgd2hlbiBHUFJTIGRldGFjaGVzLjxicj4KPGJyPgpDYXJlIHRvIHJlc2VuZCBh
IGNsZWFuZWQgdXAgcGF0Y2g/IEkmIzM5O20gZmluZSB0YWtpbmcgYXQgbGVhc3QgMS80Ljxicj48
YnI+PC9ibG9ja3F1b3RlPjxkaXY+V2lsbCBkby4gSSB0aGluayB3ZSBjYW4gc2tpcCAyLzQuIEJ1
dCBJIHRoaW5rIDMgYW5kIDQvNCBzaG91bGQgYmUgYXBwbGllZCB0b28uIEJ1dCB3ZSBjYW4gc3Rh
cnQgd2l0aCB0aGUgZmlyc3QuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4tLVJpY2hhcmTCoDwv
ZGl2PjwvZGl2PjwvZGl2Pgo=

--===============0020416505959169971==--

