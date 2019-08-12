Content-Type: multipart/mixed; boundary="===============7580221081561639252=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] gprs: Do not detach when running LTE and GPRS is
 unavailable.
Date: Mon, 12 Aug 2019 22:03:34 +0200
Message-ID: <CAHB-Pj=tyW3kaNo_-R=s+avRL7p5LTdhwCZ56NqqxtEA0KrB+Q@mail.gmail.com>
In-Reply-To: <2780a75b-5342-bb17-677d-a03c3d613217@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7580221081561639252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den m=C3=A5n 12 aug. 2019 kl 21:57 skrev Denis Kenzior <denkenz@gmail.com=
>:

> Hi Richard,
>
> >     So I don't get this.  We have CREG telling us: "we're on LTE" and
> CGREG
> >     telling us "Oh we don't know what our status is".  Why do you trust
> one
> >     and not the other?  Are you sure this doesn't belong in a driver
> quirk
> >     somewhere?
> >
> >
> > When CREG tells us we are on LTE, we will probably not even try attach
> > to gprs (CGATT),
> > refer to gprs_netreg_update.
> > In my understanding that means that its natural that CGREG reports
> > unknown or similar.
> > CEREG would be the interesting one... but since the code is built around
> > using activated context as condition when running on LTE I think we
> should
> > use the same condition here.
>
> Ah, so you're on one of those modems that started using CEREG instead of
> CGREG for reporting LTE.  So in that case I'm fine with this (maybe add
> a more clarifying comment).  But I suspect that we also need to consider
> adding ofono_gprs_lte_status as well and taking both into account.
>

I will refine the comment, and yes I think we need lte_status at some point.
There might be a chance we can do it without, but only when LTE is the
"other case", when more techologies are introduced we definitely need
a status per tech.

I have more in the pipeline regarding this, I'm kind of working step by step
to get LTE to work properly and with hand over to come.

--Richard

--===============7580221081561639252==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gbcOlbiAxMiBhdWcu
IDIwMTkga2wgMjE6NTcgc2tyZXYgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRl
bmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7Ojxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+SGkgUmljaGFyZCw8YnI+Cjxicj4KJmd0O8KgIMKgIMKgU28gSSBkb24mIzM5O3QgZ2V0IHRo
aXMuwqAgV2UgaGF2ZSBDUkVHIHRlbGxpbmcgdXM6ICZxdW90O3dlJiMzOTtyZSBvbiBMVEUmcXVv
dDsgYW5kIENHUkVHPGJyPgomZ3Q7wqAgwqAgwqB0ZWxsaW5nIHVzICZxdW90O09oIHdlIGRvbiYj
Mzk7dCBrbm93IHdoYXQgb3VyIHN0YXR1cyBpcyZxdW90Oy7CoCBXaHkgZG8geW91IHRydXN0IG9u
ZTxicj4KJmd0O8KgIMKgIMKgYW5kIG5vdCB0aGUgb3RoZXI/wqAgQXJlIHlvdSBzdXJlIHRoaXMg
ZG9lc24mIzM5O3QgYmVsb25nIGluIGEgZHJpdmVyIHF1aXJrPGJyPgomZ3Q7wqAgwqAgwqBzb21l
d2hlcmU/PGJyPgomZ3Q7IDxicj4KJmd0OyA8YnI+CiZndDsgV2hlbiBDUkVHIHRlbGxzIHVzIHdl
IGFyZSBvbiBMVEUsIHdlIHdpbGwgcHJvYmFibHkgbm90IGV2ZW4gdHJ5IGF0dGFjaCA8YnI+CiZn
dDsgdG8gZ3BycyAoQ0dBVFQpLDxicj4KJmd0OyByZWZlciB0b8KgZ3Byc19uZXRyZWdfdXBkYXRl
Ljxicj4KJmd0OyBJbiBteSB1bmRlcnN0YW5kaW5nIHRoYXQgbWVhbnMgdGhhdCBpdHMgbmF0dXJh
bCB0aGF0IENHUkVHIHJlcG9ydHMgPGJyPgomZ3Q7IHVua25vd24gb3Igc2ltaWxhci48YnI+CiZn
dDsgQ0VSRUcgd291bGQgYmUgdGhlIGludGVyZXN0aW5nIG9uZS4uLiBidXQgc2luY2UgdGhlIGNv
ZGUgaXMgYnVpbHQgYXJvdW5kPGJyPgomZ3Q7IHVzaW5nIGFjdGl2YXRlZCBjb250ZXh0IGFzIGNv
bmRpdGlvbiB3aGVuIHJ1bm5pbmcgb24gTFRFIEkgdGhpbmsgd2Ugc2hvdWxkPGJyPgomZ3Q7IHVz
ZSB0aGUgc2FtZSBjb25kaXRpb24gaGVyZS48YnI+Cjxicj4KQWgsIHNvIHlvdSYjMzk7cmUgb24g
b25lIG9mIHRob3NlIG1vZGVtcyB0aGF0IHN0YXJ0ZWQgdXNpbmcgQ0VSRUcgaW5zdGVhZCBvZiA8
YnI+CkNHUkVHIGZvciByZXBvcnRpbmcgTFRFLsKgIFNvIGluIHRoYXQgY2FzZSBJJiMzOTttIGZp
bmUgd2l0aCB0aGlzIChtYXliZSBhZGQgPGJyPgphIG1vcmUgY2xhcmlmeWluZyBjb21tZW50KS7C
oCBCdXQgSSBzdXNwZWN0IHRoYXQgd2UgYWxzbyBuZWVkIHRvIGNvbnNpZGVyIDxicj4KYWRkaW5n
IG9mb25vX2dwcnNfbHRlX3N0YXR1cyBhcyB3ZWxsIGFuZCB0YWtpbmcgYm90aCBpbnRvIGFjY291
bnQuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgd2lsbCByZWZpbmUgdGhl
IGNvbW1lbnQsIGFuZCB5ZXMgSSB0aGluayB3ZSBuZWVkIGx0ZV9zdGF0dXMgYXQgc29tZSBwb2lu
dC48L2Rpdj48ZGl2PlRoZXJlIG1pZ2h0IGJlIGEgY2hhbmNlIHdlIGNhbiBkbyBpdCB3aXRob3V0
LCBidXQgb25seSB3aGVuIExURSBpcyB0aGU8L2Rpdj48ZGl2PiZxdW90O290aGVyIGNhc2UmcXVv
dDssIHdoZW4gbW9yZSB0ZWNob2xvZ2llcyBhcmUgaW50cm9kdWNlZCB3ZSBkZWZpbml0ZWx5IG5l
ZWQ8L2Rpdj48ZGl2PmEgc3RhdHVzIHBlciB0ZWNoLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
SSBoYXZlIG1vcmUgaW4gdGhlIHBpcGVsaW5lIHJlZ2FyZGluZyB0aGlzLCBJJiMzOTttIGtpbmQg
b2Ygd29ya2luZyBzdGVwIGJ5IHN0ZXA8L2Rpdj48ZGl2PnRvIGdldCBMVEUgdG8gd29yayBwcm9w
ZXJseSBhbmQgd2l0aCBoYW5kIG92ZXIgdG8gY29tZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
Pi0tUmljaGFyZMKgPC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============7580221081561639252==--

