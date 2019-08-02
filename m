Content-Type: multipart/mixed; boundary="===============7341183298860148375=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] netreg, gprs: Use -1 as netreg status during init.
Date: Fri, 02 Aug 2019 13:33:13 +0000
Message-ID: <CAHB-Pjkop6uD2zqQe5ychdacApJiKFHATTSPbmYWswsjA+1VVw@mail.gmail.com>
In-Reply-To: <726bbb5d-1ef2-9d91-112e-7e5cafb12ead@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7341183298860148375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den fre 2 aug. 2019 kl 13:04 skrev Denis Kenzior <denkenz@gmail.com>:

> Hi Richard,
>
> On 8/1/19 6:48 AM, richard.rojfors(a)gmail.com wrote:
> > From: Richard R=C3=B6jfors <richard@puffinpack.se>
> >
> > Previously the valid "unknown" registration status was set
> > during startup, but its a bit problematic for gprs.
> > There might be cases where a LTE context is activated
> > before netreg is finished updating its status.
> > And then gprs could make faulty actions.
> > Instead we set the status to -1 when the drivers supports
> > fetching the status manually, which is done during startup.
> > During the time the status is -1, gprs postpones actions until
> > the status is valid (>=3D 0).
> > ---
> >   src/gprs.c    | 12 ++++++++++--
> >   src/network.c |  5 ++++-
> >   2 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/src/gprs.c b/src/gprs.c
> > index bdb8c8a2..07802c36 100644
> > --- a/src/gprs.c
> > +++ b/src/gprs.c
> > @@ -1661,6 +1661,14 @@ static void gprs_netreg_update(struct ofono_gprs
> *gprs)
> >   {
> >       ofono_bool_t attach;
> >
> > +     /* This function can get called by other reasons than netreg
> > +      * updating its status. So check if we have a valid netreg status
> yet.
> > +      * The only reason for not having a valid status is basically
> during
> > +      * startup while the netreg atom is fetching the status.
> > +      */
>
> Note doc/coding-style.txt item M2 for our commenting style...
>

Will fix the comment!


>
> > +     if (gprs->netreg_status < 0)
> > +             return;
> > +
> >       attach =3D gprs->netreg_status =3D=3D
> NETWORK_REGISTRATION_STATUS_REGISTERED;
> >
> >       attach =3D attach || (gprs->roaming_allowed &&
> > @@ -3083,8 +3091,8 @@ struct ofono_gprs *ofono_gprs_create(struct
> ofono_modem *modem,
> >               break;
> >       }
> >
> > -     gprs->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
> > -     gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
> > +     gprs->status =3D -1;
>
> Why do you need to mess with this?  It seems to be not used
>

This was just of convenience reasons so it would look the same for gprs and
netreg status.


>
> > +     gprs->netreg_status =3D -1;
> >       gprs->used_pids =3D l_uintset_new(MAX_CONTEXTS);
> >
>
> Wouldn't changes to gprs.c be sufficient, without touching netreg.c?
>

No unfortunately not. gprs reads the netreg status when it attaches to the
atom. Which would be unknown if we do not touch netreg.c.
.. and unknown is a valid status which can not be distinguished from "not
yet updated".


>
> >       return gprs;
> > diff --git a/src/network.c b/src/network.c
> > index 2824eae6..1db01bcf 100644
> > --- a/src/network.c
> > +++ b/src/network.c
> > @@ -1874,7 +1874,7 @@ struct ofono_netreg *ofono_netreg_create(struct
> ofono_modem *modem,
> >       if (netreg =3D=3D NULL)
> >               return NULL;
> >
> > -     netreg->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
> > +     netreg->status =3D -1;
>
> Okay, but a minor problem with this is that there now exists a brief
> moment in type where the Status property has a weird value...
>

I looked at this, and most statuses, even some defined results as unknown.
Any unhandled values as negative would do that too.
If you are refering to the D-Bus property?


>
> >       netreg->location =3D -1;
> >       netreg->cellid =3D -1;
> >       netreg->technology =3D -1;
> > @@ -1893,6 +1893,9 @@ struct ofono_netreg *ofono_netreg_create(struct
> ofono_modem *modem,
> >                       continue;
> >
> >               netreg->driver =3D drv;
> > +             /* Check if we can init the status properly using the
> driver */
> > +             if (netreg->driver->registration_status =3D=3D NULL)
> > +                     netreg->status =3D
> NETWORK_REGISTRATION_STATUS_UNKNOWN;
> >               break;
> >       }
> >
> >
>

--Richard

--===============7341183298860148375==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gZnJlIDIgYXVnLiAy
MDE5IGtsIDEzOjA0IHNrcmV2IERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5r
ZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozo8YnI+PC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4
O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgi
PkhpIFJpY2hhcmQsPGJyPgo8YnI+Ck9uIDgvMS8xOSA2OjQ4IEFNLCA8YSBocmVmPSJtYWlsdG86
cmljaGFyZC5yb2pmb3JzQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJpY2hhcmQucm9qZm9y
c0BnbWFpbC5jb208L2E+IHdyb3RlOjxicj4KJmd0OyBGcm9tOiBSaWNoYXJkIFLDtmpmb3JzICZs
dDs8YSBocmVmPSJtYWlsdG86cmljaGFyZEBwdWZmaW5wYWNrLnNlIiB0YXJnZXQ9Il9ibGFuayI+
cmljaGFyZEBwdWZmaW5wYWNrLnNlPC9hPiZndDs8YnI+CiZndDsgPGJyPgomZ3Q7IFByZXZpb3Vz
bHkgdGhlIHZhbGlkICZxdW90O3Vua25vd24mcXVvdDsgcmVnaXN0cmF0aW9uIHN0YXR1cyB3YXMg
c2V0PGJyPgomZ3Q7IGR1cmluZyBzdGFydHVwLCBidXQgaXRzIGEgYml0IHByb2JsZW1hdGljIGZv
ciBncHJzLjxicj4KJmd0OyBUaGVyZSBtaWdodCBiZSBjYXNlcyB3aGVyZSBhIExURSBjb250ZXh0
IGlzIGFjdGl2YXRlZDxicj4KJmd0OyBiZWZvcmUgbmV0cmVnIGlzIGZpbmlzaGVkIHVwZGF0aW5n
IGl0cyBzdGF0dXMuPGJyPgomZ3Q7IEFuZCB0aGVuIGdwcnMgY291bGQgbWFrZSBmYXVsdHkgYWN0
aW9ucy48YnI+CiZndDsgSW5zdGVhZCB3ZSBzZXQgdGhlIHN0YXR1cyB0byAtMSB3aGVuIHRoZSBk
cml2ZXJzIHN1cHBvcnRzPGJyPgomZ3Q7IGZldGNoaW5nIHRoZSBzdGF0dXMgbWFudWFsbHksIHdo
aWNoIGlzIGRvbmUgZHVyaW5nIHN0YXJ0dXAuPGJyPgomZ3Q7IER1cmluZyB0aGUgdGltZSB0aGUg
c3RhdHVzIGlzIC0xLCBncHJzIHBvc3Rwb25lcyBhY3Rpb25zIHVudGlsPGJyPgomZ3Q7IHRoZSBz
dGF0dXMgaXMgdmFsaWQgKCZndDs9IDApLjxicj4KJmd0OyAtLS08YnI+CiZndDvCoCDCoHNyYy9n
cHJzLmPCoCDCoCB8IDEyICsrKysrKysrKystLTxicj4KJmd0O8KgIMKgc3JjL25ldHdvcmsuYyB8
wqAgNSArKysrLTxicj4KJmd0O8KgIMKgMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKTxicj4KJmd0OyA8YnI+CiZndDsgZGlmZiAtLWdpdCBhL3NyYy9ncHJz
LmMgYi9zcmMvZ3Bycy5jPGJyPgomZ3Q7IGluZGV4IGJkYjhjOGEyLi4wNzgwMmMzNiAxMDA2NDQ8
YnI+CiZndDsgLS0tIGEvc3JjL2dwcnMuYzxicj4KJmd0OyArKysgYi9zcmMvZ3Bycy5jPGJyPgom
Z3Q7IEBAIC0xNjYxLDYgKzE2NjEsMTQgQEAgc3RhdGljIHZvaWQgZ3Byc19uZXRyZWdfdXBkYXRl
KHN0cnVjdCBvZm9ub19ncHJzICpncHJzKTxicj4KJmd0O8KgIMKgezxicj4KJmd0O8KgIMKgIMKg
IMKgb2Zvbm9fYm9vbF90IGF0dGFjaDs8YnI+CiZndDvCoCDCoDxicj4KJmd0OyArwqAgwqAgwqAv
KiBUaGlzIGZ1bmN0aW9uIGNhbiBnZXQgY2FsbGVkIGJ5IG90aGVyIHJlYXNvbnMgdGhhbiBuZXRy
ZWc8YnI+CiZndDsgK8KgIMKgIMKgICogdXBkYXRpbmcgaXRzIHN0YXR1cy4gU28gY2hlY2sgaWYg
d2UgaGF2ZSBhIHZhbGlkIG5ldHJlZyBzdGF0dXMgeWV0Ljxicj4KJmd0OyArwqAgwqAgwqAgKiBU
aGUgb25seSByZWFzb24gZm9yIG5vdCBoYXZpbmcgYSB2YWxpZCBzdGF0dXMgaXMgYmFzaWNhbGx5
IGR1cmluZzxicj4KJmd0OyArwqAgwqAgwqAgKiBzdGFydHVwIHdoaWxlIHRoZSBuZXRyZWcgYXRv
bSBpcyBmZXRjaGluZyB0aGUgc3RhdHVzLjxicj4KJmd0OyArwqAgwqAgwqAgKi88YnI+Cjxicj4K
Tm90ZSBkb2MvY29kaW5nLXN0eWxlLnR4dCBpdGVtIE0yIGZvciBvdXIgY29tbWVudGluZyBzdHls
ZS4uLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5XaWxsIGZpeCB0aGUgY29t
bWVudCE8L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CiZndDsgK8KgIMKgIMKgaWYgKGdw
cnMtJmd0O25ldHJlZ19zdGF0dXMgJmx0OyAwKTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm47PGJyPgomZ3Q7ICs8YnI+CiZndDvCoCDCoCDCoCDCoGF0dGFjaCA9IGdwcnMtJmd0
O25ldHJlZ19zdGF0dXMgPT0gTkVUV09SS19SRUdJU1RSQVRJT05fU1RBVFVTX1JFR0lTVEVSRUQ7
PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDCoCDCoCDCoGF0dGFjaCA9IGF0dGFjaCB8fCAoZ3By
cy0mZ3Q7cm9hbWluZ19hbGxvd2VkICZhbXA7JmFtcDs8YnI+CiZndDsgQEAgLTMwODMsOCArMzA5
MSw4IEBAIHN0cnVjdCBvZm9ub19ncHJzICpvZm9ub19ncHJzX2NyZWF0ZShzdHJ1Y3Qgb2Zvbm9f
bW9kZW0gKm1vZGVtLDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPgom
Z3Q7wqAgwqAgwqAgwqB9PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDsgLcKgIMKgIMKgZ3Bycy0mZ3Q7
c3RhdHVzID0gTkVUV09SS19SRUdJU1RSQVRJT05fU1RBVFVTX1VOS05PV047PGJyPgomZ3Q7IC3C
oCDCoCDCoGdwcnMtJmd0O25ldHJlZ19zdGF0dXMgPSBORVRXT1JLX1JFR0lTVFJBVElPTl9TVEFU
VVNfVU5LTk9XTjs8YnI+CiZndDsgK8KgIMKgIMKgZ3Bycy0mZ3Q7c3RhdHVzID0gLTE7PGJyPgo8
YnI+CldoeSBkbyB5b3UgbmVlZCB0byBtZXNzIHdpdGggdGhpcz/CoCBJdCBzZWVtcyB0byBiZSBu
b3QgdXNlZDxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGlzIHdhcyBqdXN0
IG9mIGNvbnZlbmllbmNlIHJlYXNvbnMgc28gaXQgd291bGQgbG9vayB0aGUgc2FtZSBmb3IgZ3By
cyBhbmQgbmV0cmVnIHN0YXR1cy48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0
OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CiZndDsg
K8KgIMKgIMKgZ3Bycy0mZ3Q7bmV0cmVnX3N0YXR1cyA9IC0xOzxicj4KJmd0O8KgIMKgIMKgIMKg
Z3Bycy0mZ3Q7dXNlZF9waWRzID0gbF91aW50c2V0X25ldyhNQVhfQ09OVEVYVFMpOzxicj4KJmd0
O8KgIMKgPGJyPgo8YnI+CldvdWxkbiYjMzk7dCBjaGFuZ2VzIHRvIGdwcnMuYyBiZSBzdWZmaWNp
ZW50LCB3aXRob3V0IHRvdWNoaW5nIG5ldHJlZy5jPzxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+
PC9kaXY+PGRpdj5ObyB1bmZvcnR1bmF0ZWx5IG5vdC4gZ3BycyByZWFkcyB0aGUgbmV0cmVnIHN0
YXR1cyB3aGVuIGl0IGF0dGFjaGVzIHRvIHRoZSBhdG9tLiBXaGljaCB3b3VsZCBiZSB1bmtub3du
IGlmIHdlIGRvIG5vdCB0b3VjaCBuZXRyZWcuYy48L2Rpdj48ZGl2Pi4uIGFuZCB1bmtub3duIGlz
IGEgdmFsaWQgc3RhdHVzIHdoaWNoIGNhbiBub3QgYmUgZGlzdGluZ3Vpc2hlZCBmcm9tICZxdW90
O25vdCB5ZXQgdXBkYXRlZCZxdW90Oy48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1s
ZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CiZn
dDvCoCDCoCDCoCDCoHJldHVybiBncHJzOzxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvc3JjL25ldHdv
cmsuYyBiL3NyYy9uZXR3b3JrLmM8YnI+CiZndDsgaW5kZXggMjgyNGVhZTYuLjFkYjAxYmNmIDEw
MDY0NDxicj4KJmd0OyAtLS0gYS9zcmMvbmV0d29yay5jPGJyPgomZ3Q7ICsrKyBiL3NyYy9uZXR3
b3JrLmM8YnI+CiZndDsgQEAgLTE4NzQsNyArMTg3NCw3IEBAIHN0cnVjdCBvZm9ub19uZXRyZWcg
Km9mb25vX25ldHJlZ19jcmVhdGUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSw8YnI+CiZndDvC
oCDCoCDCoCDCoGlmIChuZXRyZWcgPT0gTlVMTCk8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybiBOVUxMOzxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7IC3CoCDCoCDCoG5ldHJlZy0m
Z3Q7c3RhdHVzID0gTkVUV09SS19SRUdJU1RSQVRJT05fU1RBVFVTX1VOS05PV047PGJyPgomZ3Q7
ICvCoCDCoCDCoG5ldHJlZy0mZ3Q7c3RhdHVzID0gLTE7PGJyPgo8YnI+Ck9rYXksIGJ1dCBhIG1p
bm9yIHByb2JsZW0gd2l0aCB0aGlzIGlzIHRoYXQgdGhlcmUgbm93IGV4aXN0cyBhIGJyaWVmIDxi
cj4KbW9tZW50IGluIHR5cGUgd2hlcmUgdGhlIFN0YXR1cyBwcm9wZXJ0eSBoYXMgYSB3ZWlyZCB2
YWx1ZS4uLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGxvb2tlZCBhdCB0
aGlzLCBhbmQgbW9zdCBzdGF0dXNlcywgZXZlbiBzb21lIGRlZmluZWQgcmVzdWx0cyBhcyB1bmtu
b3duLiBBbnkgdW5oYW5kbGVkIHZhbHVlcyBhcyBuZWdhdGl2ZSB3b3VsZCBkbyB0aGF0IHRvby48
L2Rpdj48ZGl2PklmIHlvdSBhcmUgcmVmZXJpbmcgdG8gdGhlIEQtQnVzIHByb3BlcnR5PzwvZGl2
PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIw
NCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KJmd0O8KgIMKgIMKgIMKgbmV0cmVnLSZndDtsb2Nh
dGlvbiA9IC0xOzxicj4KJmd0O8KgIMKgIMKgIMKgbmV0cmVnLSZndDtjZWxsaWQgPSAtMTs8YnI+
CiZndDvCoCDCoCDCoCDCoG5ldHJlZy0mZ3Q7dGVjaG5vbG9neSA9IC0xOzxicj4KJmd0OyBAQCAt
MTg5Myw2ICsxODkzLDkgQEAgc3RydWN0IG9mb25vX25ldHJlZyAqb2Zvbm9fbmV0cmVnX2NyZWF0
ZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtLDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgY29udGludWU7PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoG5ldHJlZy0mZ3Q7ZHJpdmVyID0gZHJ2Ozxicj4KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAvKiBDaGVjayBpZiB3ZSBjYW4gaW5pdCB0aGUgc3RhdHVzIHByb3Blcmx5IHVz
aW5nIHRoZSBkcml2ZXIgKi88YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG5ldHJl
Zy0mZ3Q7ZHJpdmVyLSZndDtyZWdpc3RyYXRpb25fc3RhdHVzID09IE5VTEwpPGJyPgomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5ldHJlZy0mZ3Q7c3RhdHVzID0gTkVUV09S
S19SRUdJU1RSQVRJT05fU1RBVFVTX1VOS05PV047PGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBicmVhazs8YnI+CiZndDvCoCDCoCDCoCDCoH08YnI+CiZndDvCoCDCoDxicj4KJmd0OyA8
YnI+PC9ibG9ja3F1b3RlPjxkaXY+wqA8L2Rpdj48ZGl2Pi0tUmljaGFyZDwvZGl2PjwvZGl2Pjwv
ZGl2Pgo=

--===============7341183298860148375==--

