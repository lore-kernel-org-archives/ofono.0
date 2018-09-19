Content-Type: multipart/mixed; boundary="===============3252893433443143582=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Wed, 19 Sep 2018 11:24:17 +0200
Message-ID: <CAKSBH7EazwdhvgpN-ZXtZis-7GGnrVQsQg5LN3JM2UzYOBNwPQ@mail.gmail.com>
In-Reply-To: <ff5bb1b4-7b9a-2b9a-c407-8097724781b0@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3252893433443143582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2018 at 10:35 AM Slava Monich <slava.monich@jolla.com>
wrote:

> On 19/09/18 08:37, Giacinto Cifelli wrote:
> > ---
> >   include/gprs-context.h |  1 +
> >   include/lte.h          | 11 +++++++++--
> >   2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/gprs-context.h b/include/gprs-context.h
> > index 20ca9ef..8869c12 100644
> > --- a/include/gprs-context.h
> > +++ b/include/gprs-context.h
> > @@ -57,6 +57,7 @@ enum ofono_gprs_context_type {
> >   enum ofono_gprs_auth_method {
> >       OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
> >       OFONO_GPRS_AUTH_METHOD_PAP,
> > +     OFONO_GPRS_AUTH_METHOD_NONE,
>
> I think there should be OFONO_GPRS_AUTH_METHOD_ANY (or
> OFONO_GPRS_AUTH_METHOD_PAP_CHAP) here as well, for completeness. Many
> modems support that too (and we had to add it in our fork).
>
>
I agree. Let me collect all comments, then I will also add it.
I would favour also renumbering with NONE on top, but I am not sure of the
side effects everywhere, in case the values are used directly in commands.


>
> >   };
> >
> >   struct ofono_gprs_primary_context {
> > diff --git a/include/lte.h b/include/lte.h
> > index ef84ab9..38587c3 100644
> > --- a/include/lte.h
> > +++ b/include/lte.h
> > @@ -3,6 +3,7 @@
> >    *  oFono - Open Source Telephony
> >    *
> >    *  Copyright (C) 2016  Endocode AG. All rights reserved.
> > + *  Copyright (C) 2018 Gemalto M2M
> >    *
> >    *  This program is free software; you can redistribute it and/or
> modify
> >    *  it under the terms of the GNU General Public License version 2 as
> > @@ -28,14 +29,18 @@ extern "C" {
> >
> >   #include <ofono/types.h>
> >
> > -struct ofono_lte;
> > -
> >   struct ofono_lte_default_attach_info {
> >       char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
> > +     enum ofono_gprs_proto proto;
> > +     enum ofono_gprs_auth_method auth_method;
> > +     char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
> > +     char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
> >   };
>
> This is starting to look suspiciously similar to struct
> ofono_gprs_primary_context (the only thing left is cid). Is it really
> necessary to maintain two copies of essentially the same structure or is
> there some room for unification here?
>
>
There is a lot of duplication between gprs and lte, yes, if you look in the
rest of the patches there is a lot in common.
I havent found a way to do it smoothly. I even had to copy the
gprs_proto_to/from_string, gprs_auth_method_to/from_string in src/gprs.c in
src/lte.c, because I could not export them in common.c (without removing
the enums).
If there is a smart way to do it, I am more than willing to recraft the
code. Like this every change is to be duplicated.


> Cheers,
> -Slava
>

Regards,
Giacinto

_______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============3252893433443143582==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9
Imx0ciI+T24gV2VkLCBTZXAgMTksIDIwMTggYXQgMTA6MzUgQU0gU2xhdmEgTW9uaWNoICZsdDs8
YSBocmVmPSJtYWlsdG86c2xhdmEubW9uaWNoQGpvbGxhLmNvbSI+c2xhdmEubW9uaWNoQGpvbGxh
LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij5PbiAxOS8wOS8xOCAwODozNywgR2lhY2ludG8gQ2lmZWxsaSB3cm90
ZTo8YnI+CiZndDsgLS0tPGJyPgomZ3Q7wqAgwqBpbmNsdWRlL2dwcnMtY29udGV4dC5oIHzCoCAx
ICs8YnI+CiZndDvCoCDCoGluY2x1ZGUvbHRlLmjCoCDCoCDCoCDCoCDCoCB8IDExICsrKysrKysr
Ky0tPGJyPgomZ3Q7wqAgwqAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pPGJyPgomZ3Q7PGJyPgomZ3Q7IGRpZmYgLS1naXQgYS9pbmNsdWRlL2dwcnMtY29u
dGV4dC5oIGIvaW5jbHVkZS9ncHJzLWNvbnRleHQuaDxicj4KJmd0OyBpbmRleCAyMGNhOWVmLi44
ODY5YzEyIDEwMDY0NDxicj4KJmd0OyAtLS0gYS9pbmNsdWRlL2dwcnMtY29udGV4dC5oPGJyPgom
Z3Q7ICsrKyBiL2luY2x1ZGUvZ3Bycy1jb250ZXh0Lmg8YnI+CiZndDsgQEAgLTU3LDYgKzU3LDcg
QEAgZW51bSBvZm9ub19ncHJzX2NvbnRleHRfdHlwZSB7PGJyPgomZ3Q7wqAgwqBlbnVtIG9mb25v
X2dwcnNfYXV0aF9tZXRob2Qgezxicj4KJmd0O8KgIMKgIMKgIMKgT0ZPTk9fR1BSU19BVVRIX01F
VEhPRF9DSEFQID0gMCw8YnI+CiZndDvCoCDCoCDCoCDCoE9GT05PX0dQUlNfQVVUSF9NRVRIT0Rf
UEFQLDxicj4KJmd0OyArwqAgwqAgwqBPRk9OT19HUFJTX0FVVEhfTUVUSE9EX05PTkUsPGJyPgo8
YnI+CkkgdGhpbmsgdGhlcmUgc2hvdWxkIGJlIE9GT05PX0dQUlNfQVVUSF9NRVRIT0RfQU5ZIChv
ciA8YnI+Ck9GT05PX0dQUlNfQVVUSF9NRVRIT0RfUEFQX0NIQVApIGhlcmUgYXMgd2VsbCwgZm9y
IGNvbXBsZXRlbmVzcy4gTWFueSA8YnI+Cm1vZGVtcyBzdXBwb3J0IHRoYXQgdG9vIChhbmQgd2Ug
aGFkIHRvIGFkZCBpdCBpbiBvdXIgZm9yaykuPGJyPgo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJy
PjwvZGl2PjxkaXY+SSBhZ3JlZS4gTGV0IG1lIGNvbGxlY3QgYWxsIGNvbW1lbnRzLCB0aGVuIEkg
d2lsbCBhbHNvIGFkZCBpdC48L2Rpdj48ZGl2Pkkgd291bGQgZmF2b3VyIGFsc28gcmVudW1iZXJp
bmcgd2l0aCBOT05FIG9uIHRvcCwgYnV0IEkgYW0gbm90IHN1cmUgb2YgdGhlIHNpZGUgZWZmZWN0
cyBldmVyeXdoZXJlLCBpbiBjYXNlIHRoZSB2YWx1ZXMgYXJlIHVzZWQgZGlyZWN0bHkgaW4gY29t
bWFuZHMuPC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRp
bmctbGVmdDoxZXgiPgo8YnI+CiZndDvCoCDCoH07PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDC
oHN0cnVjdCBvZm9ub19ncHJzX3ByaW1hcnlfY29udGV4dCB7PGJyPgomZ3Q7IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2x0ZS5oIGIvaW5jbHVkZS9sdGUuaDxicj4KJmd0OyBpbmRleCBlZjg0YWI5Li4z
ODU4N2MzIDEwMDY0NDxicj4KJmd0OyAtLS0gYS9pbmNsdWRlL2x0ZS5oPGJyPgomZ3Q7ICsrKyBi
L2luY2x1ZGUvbHRlLmg8YnI+CiZndDsgQEAgLTMsNiArMyw3IEBAPGJyPgomZ3Q7wqAgwqAgKsKg
IG9Gb25vIC0gT3BlbiBTb3VyY2UgVGVsZXBob255PGJyPgomZ3Q7wqAgwqAgKjxicj4KJmd0O8Kg
IMKgICrCoCBDb3B5cmlnaHQgKEMpIDIwMTbCoCBFbmRvY29kZSBBRy4gQWxsIHJpZ2h0cyByZXNl
cnZlZC48YnI+CiZndDsgKyAqwqAgQ29weXJpZ2h0IChDKSAyMDE4IEdlbWFsdG8gTTJNPGJyPgom
Z3Q7wqAgwqAgKjxicj4KJmd0O8KgIMKgICrCoCBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2Fy
ZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeTxicj4KJmd0O8KgIMKgICrC
oCBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZl
cnNpb24gMiBhczxicj4KJmd0OyBAQCAtMjgsMTQgKzI5LDE4IEBAIGV4dGVybiAmcXVvdDtDJnF1
b3Q7IHs8YnI+CiZndDvCoCDCoDxicj4KJmd0O8KgIMKgI2luY2x1ZGUgJmx0O29mb25vL3R5cGVz
LmgmZ3Q7PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDsgLXN0cnVjdCBvZm9ub19sdGU7PGJyPgomZ3Q7
IC08YnI+CiZndDvCoCDCoHN0cnVjdCBvZm9ub19sdGVfZGVmYXVsdF9hdHRhY2hfaW5mbyB7PGJy
PgomZ3Q7wqAgwqAgwqAgwqBjaGFyIGFwbltPRk9OT19HUFJTX01BWF9BUE5fTEVOR1RIICsgMV07
PGJyPgomZ3Q7ICvCoCDCoCDCoGVudW0gb2Zvbm9fZ3Byc19wcm90byBwcm90bzs8YnI+CiZndDsg
K8KgIMKgIMKgZW51bSBvZm9ub19ncHJzX2F1dGhfbWV0aG9kIGF1dGhfbWV0aG9kOzxicj4KJmd0
OyArwqAgwqAgwqBjaGFyIHVzZXJuYW1lW09GT05PX0dQUlNfTUFYX1VTRVJOQU1FX0xFTkdUSCAr
IDFdOzxicj4KJmd0OyArwqAgwqAgwqBjaGFyIHBhc3N3b3JkW09GT05PX0dQUlNfTUFYX1BBU1NX
T1JEX0xFTkdUSCArIDFdOzxicj4KJmd0O8KgIMKgfTs8YnI+Cjxicj4KVGhpcyBpcyBzdGFydGlu
ZyB0byBsb29rIHN1c3BpY2lvdXNseSBzaW1pbGFyIHRvIHN0cnVjdCA8YnI+Cm9mb25vX2dwcnNf
cHJpbWFyeV9jb250ZXh0ICh0aGUgb25seSB0aGluZyBsZWZ0IGlzIGNpZCkuIElzIGl0IHJlYWxs
eSA8YnI+Cm5lY2Vzc2FyeSB0byBtYWludGFpbiB0d28gY29waWVzIG9mIGVzc2VudGlhbGx5IHRo
ZSBzYW1lIHN0cnVjdHVyZSBvciBpcyA8YnI+CnRoZXJlIHNvbWUgcm9vbSBmb3IgdW5pZmljYXRp
b24gaGVyZT88YnI+Cjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGVyZSBp
cyBhIGxvdCBvZiBkdXBsaWNhdGlvbiBiZXR3ZWVuIGdwcnMgYW5kIGx0ZSwgeWVzLCBpZiB5b3Ug
bG9vayBpbiB0aGUgcmVzdCBvZiB0aGUgcGF0Y2hlcyB0aGVyZSBpcyBhIGxvdCBpbiBjb21tb24u
PC9kaXY+PGRpdj5JIGhhdmVudCBmb3VuZCBhIHdheSB0byBkbyBpdCBzbW9vdGhseS4gSSBldmVu
IGhhZCB0byBjb3B5IHRoZSBncHJzX3Byb3RvX3RvL2Zyb21fc3RyaW5nLCBncHJzX2F1dGhfbWV0
aG9kX3RvL2Zyb21fc3RyaW5nIGluIHNyYy9ncHJzLmMgaW4gc3JjL2x0ZS5jLCBiZWNhdXNlIEkg
Y291bGQgbm90IGV4cG9ydCB0aGVtIGluIGNvbW1vbi5jICh3aXRob3V0IHJlbW92aW5nIHRoZSBl
bnVtcykuPC9kaXY+PGRpdj5JZiB0aGVyZSBpcyBhIHNtYXJ0IHdheSB0byBkbyBpdCwgSSBhbSBt
b3JlIHRoYW4gd2lsbGluZyB0byByZWNyYWZ0IHRoZSBjb2RlLiBMaWtlIHRoaXMgZXZlcnkgY2hh
bmdlIGlzIHRvIGJlIGR1cGxpY2F0ZWQuPC9kaXY+PGRpdj7CoDxicj48L2Rpdj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVm
dDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KQ2hlZXJzLDxicj4KLVNsYXZhPGJy
PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5HaWFj
aW50b8KgPC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0Bv
Zm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVm
PSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiByZWw9Im5v
cmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pgo=

--===============3252893433443143582==--

