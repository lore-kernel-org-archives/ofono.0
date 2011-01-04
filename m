Content-Type: multipart/mixed; boundary="===============0402229376847970673=="
MIME-Version: 1.0
From: Marit Sofie Henriksen <maritsofie.henriksen8@gmail.com>
Subject: Re: [PATCHv3] stemodem: Fix for MT call not working when caller id is
 hidden.
Date: Tue, 04 Jan 2011 09:37:49 +0100
Message-ID: <AANLkTim=e=CiTz_q-nO80kXxRvPTdVDZPjOUG-n-t70a@mail.gmail.com>
In-Reply-To: <1294128377.5852.73.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0402229376847970673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/1/4 Marcel Holtmann <marcel@holtmann.org>

> Hi Marit,
>
> > In *ECAV, the number will not be included if caller id is hidden.
> > Set it to an empty string in that case, and set number type to
> > 128, unknown number type.
> > ---
> >  drivers/stemodem/voicecall.c |   15 ++++++++++-----
> >  1 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
> > index bf68f52..7f0a19f 100644
> > --- a/drivers/stemodem/voicecall.c
> > +++ b/drivers/stemodem/voicecall.c
> > @@ -1,4 +1,4 @@
> > -/*
> > +e/*
>
> What is this ;)
>
> Hmm, certainly something that shouldn't have been there... :( I'll send a
new version. Thank's for your patience, and the reviews.
br Marit

Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============0402229376847970673==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMS8xLzQgTWFyY2VsIEhvbHRtYW5u
IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOm1hcmNlbEBob2x0bWFubi5vcmci
Pm1hcmNlbEBob2x0bWFubi5vcmc8L2E+Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVyLWxl
ZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+Ckhp
IE1hcml0LDxicj4KPGRpdiBjbGFzcz0iaW0iPjxicj4KJmd0OyBJbiAqRUNBViwgdGhlIG51bWJl
ciB3aWxsIG5vdCBiZSBpbmNsdWRlZCBpZiBjYWxsZXIgaWQgaXMgaGlkZGVuLjxicj4KJmd0OyBT
ZXQgaXQgdG8gYW4gZW1wdHkgc3RyaW5nIGluIHRoYXQgY2FzZSwgYW5kIHNldCBudW1iZXIgdHlw
ZSB0bzxicj4KJmd0OyAxMjgsIHVua25vd24gbnVtYmVyIHR5cGUuPGJyPgomZ3Q7IC0tLTxicj4K
Jmd0OyCgZHJpdmVycy9zdGVtb2RlbS92b2ljZWNhbGwuYyB8IKAgMTUgKysrKysrKysrKy0tLS0t
PGJyPgomZ3Q7IKAxIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pPGJyPgomZ3Q7PGJyPgomZ3Q7IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0ZW1vZGVtL3ZvaWNl
Y2FsbC5jIGIvZHJpdmVycy9zdGVtb2RlbS92b2ljZWNhbGwuYzxicj4KJmd0OyBpbmRleCBiZjY4
ZjUyLi43ZjBhMTlmIDEwMDY0NDxicj4KJmd0OyAtLS0gYS9kcml2ZXJzL3N0ZW1vZGVtL3ZvaWNl
Y2FsbC5jPGJyPgomZ3Q7ICsrKyBiL2RyaXZlcnMvc3RlbW9kZW0vdm9pY2VjYWxsLmM8YnI+CiZn
dDsgQEAgLTEsNCArMSw0IEBAPGJyPgomZ3Q7IC0vKjxicj4KJmd0OyArZS8qPGJyPgo8YnI+Cjwv
ZGl2PldoYXQgaXMgdGhpcyA7KTxicj4KPGJyPjwvYmxvY2txdW90ZT48ZGl2PkhtbSwgY2VydGFp
bmx5IHNvbWV0aGluZyB0aGF0IHNob3VsZG4mIzM5O3QgaGF2ZSBiZWVuIHRoZXJlLi4uIDooIEkm
IzM5O2xsIHNlbmQgYSBuZXcgdmVyc2lvbi4gVGhhbmsmIzM5O3MgZm9yIHlvdXIgcGF0aWVuY2Us
IGFuZCB0aGUgcmV2aWV3cy48YnI+YnIgTWFyaXQ8YnI+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IGJvcmRl
ci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxlZnQ6IDFleDsi
PgoKUmVnYXJkczxicj4KPGJyPgpNYXJjZWw8YnI+Cjxicj4KPGJyPgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJy
Pgo8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJy
Pgo8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9
Il9ibGFuayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubzwvYT48YnI+Cjwv
YmxvY2txdW90ZT48L2Rpdj48YnI+Cg==

--===============0402229376847970673==--

