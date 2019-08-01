Content-Type: multipart/mixed; boundary="===============5099866966366745099=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] gprs: Postpone attach decisions until netreg is finished
Date: Thu, 01 Aug 2019 11:31:51 +0000
Message-ID: <CAHB-PjkM=eRwTu8WGGRuK6eEmxagXJBMwYod+fuyT_Qwp+sO-A@mail.gmail.com>
In-Reply-To: <5082a823-9f02-f117-cc16-aadc1cbf7cf1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5099866966366745099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den tors 25 juli 2019 kl 06:58 skrev Denis Kenzior <denkenz@gmail.com>:

> > +     technology =3D ofono_netreg_get_technology(gprs->netreg);
> > +
> > +     /* If we are called before netreg has updated us, just return
> > +      * we will get called again when the technology is available
> > +      * and we can make better decisions
> > +      */
> > +     if (technology =3D=3D -1)
> > +             return;
>
> You have to be careful here, some modem drivers do not report technology
> at all, and it is an optional property in the API.  So you are probably
> breaking such drivers with this change...
>
>
Unfortunately you are completely correct ;-)
I send another spin. Where i instead set the netreg status to -1 in case
the driver can fetch
the status during startup. This will work with both sms and gprs which
seems to be the users of netreg.
The D-Bus interface will also return "unknown" during this time.
..And the users such as gprs can know if the status is valid or not.

--Richard

--===============5099866966366745099==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPC9kaXY+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+RGVuIHRv
cnMgMjUganVsaSAyMDE5IGtsIDA2OjU4IHNrcmV2IERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9
Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozo8YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPiZndDsgK8KgIMKgIMKgdGVjaG5vbG9neSA9IG9mb25vX25ldHJlZ19nZXRf
dGVjaG5vbG9neShncHJzLSZndDtuZXRyZWcpOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDC
oC8qIElmIHdlIGFyZSBjYWxsZWQgYmVmb3JlIG5ldHJlZyBoYXMgdXBkYXRlZCB1cywganVzdCBy
ZXR1cm48YnI+CiZndDsgK8KgIMKgIMKgICogd2Ugd2lsbCBnZXQgY2FsbGVkIGFnYWluIHdoZW4g
dGhlIHRlY2hub2xvZ3kgaXMgYXZhaWxhYmxlPGJyPgomZ3Q7ICvCoCDCoCDCoCAqIGFuZCB3ZSBj
YW4gbWFrZSBiZXR0ZXIgZGVjaXNpb25zPGJyPgomZ3Q7ICvCoCDCoCDCoCAqLzxicj4KJmd0OyAr
wqAgwqAgwqBpZiAodGVjaG5vbG9neSA9PSAtMSk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0dXJuOzxicj4KPGJyPgpZb3UgaGF2ZSB0byBiZSBjYXJlZnVsIGhlcmUsIHNvbWUgbW9k
ZW0gZHJpdmVycyBkbyBub3QgcmVwb3J0IHRlY2hub2xvZ3kgPGJyPgphdCBhbGwsIGFuZCBpdCBp
cyBhbiBvcHRpb25hbCBwcm9wZXJ0eSBpbiB0aGUgQVBJLsKgIFNvIHlvdSBhcmUgcHJvYmFibHkg
PGJyPgpicmVha2luZyBzdWNoIGRyaXZlcnMgd2l0aCB0aGlzIGNoYW5nZS4uLjxicj4KPGJyPjwv
YmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlVuZm9ydHVuYXRlbHkgeW91IGFyZSBjb21w
bGV0ZWx5IGNvcnJlY3QgOy0pPC9kaXY+PGRpdj5JIHNlbmQgYW5vdGhlciBzcGluLiBXaGVyZSBp
IGluc3RlYWQgc2V0IHRoZSBuZXRyZWcgc3RhdHVzIHRvIC0xIGluIGNhc2UgdGhlIGRyaXZlciBj
YW4gZmV0Y2g8L2Rpdj48ZGl2PnRoZSBzdGF0dXMgZHVyaW5nIHN0YXJ0dXAuIFRoaXMgd2lsbCB3
b3JrIHdpdGggYm90aCBzbXMgYW5kIGdwcnMgd2hpY2ggc2VlbXMgdG8gYmUgdGhlIHVzZXJzIG9m
IG5ldHJlZy48L2Rpdj48ZGl2PlRoZSBELUJ1cyBpbnRlcmZhY2Ugd2lsbCBhbHNvIHJldHVybiAm
cXVvdDt1bmtub3duJnF1b3Q7IGR1cmluZyB0aGlzIHRpbWUuPC9kaXY+PGRpdj4uLkFuZCB0aGUg
dXNlcnMgc3VjaCBhcyBncHJzIGNhbiBrbm93IGlmIHRoZSBzdGF0dXMgaXMgdmFsaWQgb3Igbm90
LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+LS1SaWNoYXJkwqA8L2Rpdj48L2Rpdj48L2Rpdj4K

--===============5099866966366745099==--

