Content-Type: multipart/mixed; boundary="===============2586562398362853895=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] netreg, gprs: Use -1 as netreg status during init.
Date: Fri, 02 Aug 2019 14:50:06 +0000
Message-ID: <CAHB-Pj=0Usfftstq6CQMgjnQyj5DC5yJhuSBM-=QZbH-J+e--g@mail.gmail.com>
In-Reply-To: <9e4aac2d-c4d8-b1cc-da93-69d798aaa7b0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2586562398362853895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den fre 2 aug. 2019 kl 13:39 skrev Denis Kenzior <denkenz@gmail.com>:

> Hi Richard,
>
> >      > +     gprs->netreg_status =3D -1;
> >      >       gprs->used_pids =3D l_uintset_new(MAX_CONTEXTS);
> >      >
> >
> >     Wouldn't changes to gprs.c be sufficient, without touching netreg.c?
> >
> >
> > No unfortunately not. gprs reads the netreg status when it attaches to
> > the atom. Which would be unknown if we do not touch netreg.c.
> > .. and unknown is a valid status which can not be distinguished from
> > "not yet updated".
>
> Hmm, okay. But then, can't you set gprs->netreg_status to -1 inside
> netreg_watch and just wait until netreg_status_changed to get it set
> properly?
>

That would work in my case.

I was just worried in case any driver would have
updated netreg with status before calling ofono_netreg_register, then
we would not get the status since there wont be any initial callback.
But if that is not allowed/happens anywhere I agree that its better.


>
> That seems to be your real culprit, the gprs->netreg_status assignment
> from ofono_netreg_get_status()
>
> >
> >
> >      >       return gprs;
> >      > diff --git a/src/network.c b/src/network.c
> >      > index 2824eae6..1db01bcf 100644
> >      > --- a/src/network.c
> >      > +++ b/src/network.c
> >      > @@ -1874,7 +1874,7 @@ struct ofono_netreg
> >     *ofono_netreg_create(struct ofono_modem *modem,
> >      >       if (netreg =3D=3D NULL)
> >      >               return NULL;
> >      >
> >      > -     netreg->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
> >      > +     netreg->status =3D -1;
> >
> >     Okay, but a minor problem with this is that there now exists a brief
> >     moment in type where the Status property has a weird value...
> >
> >
> > I looked at this, and most statuses, even some defined results as
> > unknown. Any unhandled values as negative would do that too.
> > If you are refering to the D-Bus property?
>
> Yes.  Most of the time -1 simply means the property is omitted.  In this
> case that is not actually what happens.  Refer to src/common.c
> registration_status_to_string()
>
>
--Richard

--===============2586562398362853895==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gZnJlIDIgYXVnLiAy
MDE5IGtsIDEzOjM5IHNrcmV2IERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5r
ZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozo8YnI+PC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4
O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgi
PkhpIFJpY2hhcmQsPGJyPgo8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoGdwcnMtJmd0
O25ldHJlZ19zdGF0dXMgPSAtMTs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqBncHJz
LSZndDt1c2VkX3BpZHMgPSBsX3VpbnRzZXRfbmV3KE1BWF9DT05URVhUUyk7PGJyPgomZ3Q7wqAg
wqAgwqAgJmd0Ozxicj4KJmd0OyA8YnI+CiZndDvCoCDCoCDCoFdvdWxkbiYjMzk7dCBjaGFuZ2Vz
IHRvIGdwcnMuYyBiZSBzdWZmaWNpZW50LCB3aXRob3V0IHRvdWNoaW5nIG5ldHJlZy5jPzxicj4K
Jmd0OyA8YnI+CiZndDsgPGJyPgomZ3Q7IE5vIHVuZm9ydHVuYXRlbHkgbm90LiBncHJzIHJlYWRz
IHRoZSBuZXRyZWcgc3RhdHVzIHdoZW4gaXQgYXR0YWNoZXMgdG8gPGJyPgomZ3Q7IHRoZSBhdG9t
LiBXaGljaCB3b3VsZCBiZSB1bmtub3duIGlmIHdlIGRvIG5vdCB0b3VjaCBuZXRyZWcuYy48YnI+
CiZndDsgLi4gYW5kIHVua25vd24gaXMgYSB2YWxpZCBzdGF0dXMgd2hpY2ggY2FuIG5vdCBiZSBk
aXN0aW5ndWlzaGVkIGZyb20gPGJyPgomZ3Q7ICZxdW90O25vdCB5ZXQgdXBkYXRlZCZxdW90Oy48
YnI+Cjxicj4KSG1tLCBva2F5LiBCdXQgdGhlbiwgY2FuJiMzOTt0IHlvdSBzZXQgZ3Bycy0mZ3Q7
bmV0cmVnX3N0YXR1cyB0byAtMSBpbnNpZGUgPGJyPgpuZXRyZWdfd2F0Y2ggYW5kIGp1c3Qgd2Fp
dCB1bnRpbCBuZXRyZWdfc3RhdHVzX2NoYW5nZWQgdG8gZ2V0IGl0IHNldCA8YnI+CnByb3Blcmx5
Pzxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGF0IHdvdWxkIHdvcmsgaW4g
bXkgY2FzZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgd2FzIGp1c3Qgd29ycmllZCBpbiBj
YXNlIGFueSBkcml2ZXIgd291bGQgaGF2ZTwvZGl2PjxkaXY+dXBkYXRlZCBuZXRyZWcgd2l0aCBz
dGF0dXMgYmVmb3JlIGNhbGxpbmfCoG9mb25vX25ldHJlZ19yZWdpc3RlciwgdGhlbjwvZGl2Pjxk
aXY+d2Ugd291bGQgbm90IGdldCB0aGUgc3RhdHVzIHNpbmNlIHRoZXJlIHdvbnQgYmUgYW55IGlu
aXRpYWwgY2FsbGJhY2suPC9kaXY+PGRpdj5CdXQgaWYgdGhhdCBpcyBub3QgYWxsb3dlZC9oYXBw
ZW5zIGFueXdoZXJlIEkgYWdyZWUgdGhhdCBpdHMgYmV0dGVyLjwvZGl2PjxkaXY+wqA8L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHgg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0
OjFleCI+Cjxicj4KVGhhdCBzZWVtcyB0byBiZSB5b3VyIHJlYWwgY3VscHJpdCwgdGhlIGdwcnMt
Jmd0O25ldHJlZ19zdGF0dXMgYXNzaWdubWVudCA8YnI+CmZyb20gb2Zvbm9fbmV0cmVnX2dldF9z
dGF0dXMoKTxicj4KPGJyPgomZ3Q7IDxicj4KJmd0OyA8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgwqByZXR1cm4gZ3Byczs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7IGRpZmYgLS1naXQgYS9z
cmMvbmV0d29yay5jIGIvc3JjL25ldHdvcmsuYzxicj4KJmd0O8KgIMKgIMKgICZndDsgaW5kZXgg
MjgyNGVhZTYuLjFkYjAxYmNmIDEwMDY0NDxicj4KJmd0O8KgIMKgIMKgICZndDsgLS0tIGEvc3Jj
L25ldHdvcmsuYzxicj4KJmd0O8KgIMKgIMKgICZndDsgKysrIGIvc3JjL25ldHdvcmsuYzxicj4K
Jmd0O8KgIMKgIMKgICZndDsgQEAgLTE4NzQsNyArMTg3NCw3IEBAIHN0cnVjdCBvZm9ub19uZXRy
ZWc8YnI+CiZndDvCoCDCoCDCoCpvZm9ub19uZXRyZWdfY3JlYXRlKHN0cnVjdCBvZm9ub19tb2Rl
bSAqbW9kZW0sPGJyPgomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgIMKgaWYgKG5ldHJlZyA9PSBO
VUxMKTxicj4KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBO
VUxMOzxicj4KJmd0O8KgIMKgIMKgICZndDs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7IC3CoCDCoCDC
oG5ldHJlZy0mZ3Q7c3RhdHVzID0gTkVUV09SS19SRUdJU1RSQVRJT05fU1RBVFVTX1VOS05PV047
PGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqBuZXRyZWctJmd0O3N0YXR1cyA9IC0xOzxi
cj4KJmd0OyA8YnI+CiZndDvCoCDCoCDCoE9rYXksIGJ1dCBhIG1pbm9yIHByb2JsZW0gd2l0aCB0
aGlzIGlzIHRoYXQgdGhlcmUgbm93IGV4aXN0cyBhIGJyaWVmPGJyPgomZ3Q7wqAgwqAgwqBtb21l
bnQgaW4gdHlwZSB3aGVyZSB0aGUgU3RhdHVzIHByb3BlcnR5IGhhcyBhIHdlaXJkIHZhbHVlLi4u
PGJyPgomZ3Q7IDxicj4KJmd0OyA8YnI+CiZndDsgSSBsb29rZWQgYXQgdGhpcywgYW5kIG1vc3Qg
c3RhdHVzZXMsIGV2ZW4gc29tZSBkZWZpbmVkIHJlc3VsdHMgYXMgPGJyPgomZ3Q7IHVua25vd24u
IEFueSB1bmhhbmRsZWQgdmFsdWVzIGFzIG5lZ2F0aXZlIHdvdWxkIGRvIHRoYXQgdG9vLjxicj4K
Jmd0OyBJZiB5b3UgYXJlIHJlZmVyaW5nIHRvIHRoZSBELUJ1cyBwcm9wZXJ0eT88YnI+Cjxicj4K
WWVzLsKgIE1vc3Qgb2YgdGhlIHRpbWUgLTEgc2ltcGx5IG1lYW5zIHRoZSBwcm9wZXJ0eSBpcyBv
bWl0dGVkLsKgIEluIHRoaXMgPGJyPgpjYXNlIHRoYXQgaXMgbm90IGFjdHVhbGx5IHdoYXQgaGFw
cGVucy7CoCBSZWZlciB0byBzcmMvY29tbW9uLmMgPGJyPgpyZWdpc3RyYXRpb25fc3RhdHVzX3Rv
X3N0cmluZygpPGJyPjxicj48L2Jsb2NrcXVvdGU+PGRpdj7CoDwvZGl2PjxkaXY+LS1SaWNoYXJk
wqA8L2Rpdj48L2Rpdj48L2Rpdj4K

--===============2586562398362853895==--

