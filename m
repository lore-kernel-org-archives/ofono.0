Content-Type: multipart/mixed; boundary="===============6797000134639260135=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Wed, 19 Sep 2018 17:42:19 +0200
Message-ID: <CAKSBH7F47veJBM_mnU2tzb+c3MoHPdiomMav7tcO4GRtgFr35w@mail.gmail.com>
In-Reply-To: <329f2615-c165-dddc-c9b6-3b7b4e149a68@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6797000134639260135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2018 at 4:09 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> Your patch series has 7 commits with the same header.  That is nonsense.
> Each commit header should be specific to what is contained inside and
> preferably followed by a commit description.
>
> Read any one of the many 'How to submit a kernel patch' howtos in order
> to understand the best practices here.  oFono does not use Signed-off-by
> lines and a few things are different, but the commit header/description
> requirements and the overall patch submission process are the same.
>

Hi Denis,

I will break down things further. This series of patches is only the first
one to support our modules.
I have submitted this first part also to gather comments.
From the ./HACKING file I understood that the requirement is to
split according to the top-level directories only, and to make sure not to
break compilation.
Definitely I will add more comments to the commits, too.


>
> On 09/19/2018 12:37 AM, Giacinto Cifelli wrote:
> > ---
> >   include/gprs-context.h |  1 +
> >   include/lte.h          | 11 +++++++++--
> >   2 files changed, 10 insertions(+), 2 deletions(-)
>
> This really should be two patches because you're changing unrelated thing=
s.
>

well, this is the interesting part of this series of patches.
What the lte atom does is really parallel to the gprs-context, at the end
is a big code duplication.
Isn't there a smart way to reduce this?


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
> So strictly speaking we already support NONE as a method if username is
> empty. I don't have a problem with this change, but it does imply that
> you need to fix up the existing code depending on this enumeration to
> behave properly.
>

already fixed in the rest of this patch series. But this implies that I
will have to submit again a multi-part patch for this change.


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
>
> So why are you changing the order seemingly randomly?  And anyway, this
> is wrong.  See doc/coding-style.txt item M9.
>
> >   struct ofono_lte_default_attach_info {
> >       char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
> > +     enum ofono_gprs_proto proto;
> > +     enum ofono_gprs_auth_method auth_method;
> > +     char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
> > +     char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
>
> Okay, but you might want to start at the D-Bus API level first...
>

this means submitting a patch for the D-Bus API before the others ?
In any case it has to go with the rest if it has to compile.
I still haven't figured out completely how to split properly to ensure
compilation.


> >   };
> >
> >   typedef void (*ofono_lte_cb_t)(const struct ofono_error *error, void
> *data);
> >
> > +struct ofono_lte;
> > +
> >   struct ofono_lte_driver {
> >       const char *name;
> >       int (*probe)(struct ofono_lte *lte, unsigned int vendor, void
> *data);
> > @@ -61,6 +66,8 @@ void ofono_lte_set_data(struct ofono_lte *lte, void
> *data);
> >
> >   void *ofono_lte_get_data(const struct ofono_lte *lte);
> >
> > +struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *lte);
> > + >   #ifdef __cplusplus
> >   }
> >   #endif
> >
>
> Regards,
> -Denis
>

Regards,
Giacinto

--===============6797000134639260135==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9
Imx0ciI+T24gV2VkLCBTZXAgMTksIDIwMTggYXQgNDowOSBQTSBEZW5pcyBLZW56aW9yICZsdDs8
YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZn
dDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVm
dDoxZXgiPkhpIEdpYWNpbnRvLDxicj4KPGJyPgpZb3VyIHBhdGNoIHNlcmllcyBoYXMgNyBjb21t
aXRzIHdpdGggdGhlIHNhbWUgaGVhZGVyLsKgIFRoYXQgaXMgbm9uc2Vuc2UuPGJyPgpFYWNoIGNv
bW1pdCBoZWFkZXIgc2hvdWxkIGJlIHNwZWNpZmljIHRvIHdoYXQgaXMgY29udGFpbmVkIGluc2lk
ZSBhbmQgPGJyPgpwcmVmZXJhYmx5IGZvbGxvd2VkIGJ5IGEgY29tbWl0IGRlc2NyaXB0aW9uLjxi
cj4KPGJyPgpSZWFkIGFueSBvbmUgb2YgdGhlIG1hbnkgJiMzOTtIb3cgdG8gc3VibWl0IGEga2Vy
bmVsIHBhdGNoJiMzOTsgaG93dG9zIGluIG9yZGVyIDxicj4KdG8gdW5kZXJzdGFuZCB0aGUgYmVz
dCBwcmFjdGljZXMgaGVyZS7CoCBvRm9ubyBkb2VzIG5vdCB1c2UgU2lnbmVkLW9mZi1ieSA8YnI+
CmxpbmVzIGFuZCBhIGZldyB0aGluZ3MgYXJlIGRpZmZlcmVudCwgYnV0IHRoZSBjb21taXQgaGVh
ZGVyL2Rlc2NyaXB0aW9uIDxicj4KcmVxdWlyZW1lbnRzIGFuZCB0aGUgb3ZlcmFsbCBwYXRjaCBz
dWJtaXNzaW9uIHByb2Nlc3MgYXJlIHRoZSBzYW1lLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+
PC9kaXY+PGRpdj5IaSBEZW5pcyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgd2lsbCBicmVh
ayBkb3duIHRoaW5ncyBmdXJ0aGVyLiBUaGlzIHNlcmllcyBvZiBwYXRjaGVzIGlzIG9ubHkgdGhl
IGZpcnN0IG9uZSB0byBzdXBwb3J0IG91ciBtb2R1bGVzLjwvZGl2PjxkaXY+SSBoYXZlIHN1Ym1p
dHRlZCB0aGlzIGZpcnN0IHBhcnQgYWxzbyB0byBnYXRoZXIgY29tbWVudHMuPC9kaXY+PGRpdj5G
cm9tIHRoZSAuL0hBQ0tJTkcgZmlsZSBJIHVuZGVyc3Rvb2QgdGhhdCB0aGUgcmVxdWlyZW1lbnQg
aXMgdG8gc3BsaXTCoGFjY29yZGluZyB0byB0aGUgdG9wLWxldmVsIGRpcmVjdG9yaWVzIG9ubHks
IGFuZCB0byBtYWtlIHN1cmUgbm90IHRvIGJyZWFrIGNvbXBpbGF0aW9uLjwvZGl2PkRlZmluaXRl
bHkgSSB3aWxsIGFkZCBtb3JlIGNvbW1lbnRzIHRvIHRoZSBjb21taXRzLCB0b28uPGJyIGNsYXNz
PSJnbWFpbC1BcHBsZS1pbnRlcmNoYW5nZS1uZXdsaW5lIj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxl
ZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KT24gMDkvMTkvMjAxOCAx
MjozNyBBTSwgR2lhY2ludG8gQ2lmZWxsaSB3cm90ZTo8YnI+CiZndDsgLS0tPGJyPgomZ3Q7wqAg
wqBpbmNsdWRlL2dwcnMtY29udGV4dC5oIHzCoCAxICs8YnI+CiZndDvCoCDCoGluY2x1ZGUvbHRl
LmjCoCDCoCDCoCDCoCDCoCB8IDExICsrKysrKysrKy0tPGJyPgomZ3Q7wqAgwqAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pPGJyPgo8YnI+ClRoaXMgcmVh
bGx5IHNob3VsZCBiZSB0d28gcGF0Y2hlcyBiZWNhdXNlIHlvdSYjMzk7cmUgY2hhbmdpbmcgdW5y
ZWxhdGVkIHRoaW5ncy48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+d2VsbCwg
dGhpcyBpcyB0aGUgaW50ZXJlc3RpbmcgcGFydCBvZiB0aGlzIHNlcmllcyBvZiBwYXRjaGVzLjwv
ZGl2PjxkaXY+V2hhdCB0aGUgbHRlIGF0b20gZG9lcyBpcyByZWFsbHkgcGFyYWxsZWwgdG8gdGhl
IGdwcnMtY29udGV4dCwgYXQgdGhlIGVuZCBpcyBhIGJpZyBjb2RlIGR1cGxpY2F0aW9uLjwvZGl2
PjxkaXY+SXNuJiMzOTt0IHRoZXJlIGEgc21hcnQgd2F5IHRvIHJlZHVjZSB0aGlzPzwvZGl2Pjxk
aXY+wqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+Jmd0OyA8YnI+CiZndDsgZGlmZiAtLWdpdCBhL2luY2x1ZGUvZ3Bycy1jb250ZXh0LmggYi9p
bmNsdWRlL2dwcnMtY29udGV4dC5oPGJyPgomZ3Q7IGluZGV4IDIwY2E5ZWYuLjg4NjljMTIgMTAw
NjQ0PGJyPgomZ3Q7IC0tLSBhL2luY2x1ZGUvZ3Bycy1jb250ZXh0Lmg8YnI+CiZndDsgKysrIGIv
aW5jbHVkZS9ncHJzLWNvbnRleHQuaDxicj4KJmd0OyBAQCAtNTcsNiArNTcsNyBAQCBlbnVtIG9m
b25vX2dwcnNfY29udGV4dF90eXBlIHs8YnI+CiZndDvCoCDCoGVudW0gb2Zvbm9fZ3Byc19hdXRo
X21ldGhvZCB7PGJyPgomZ3Q7wqAgwqAgwqAgwqBPRk9OT19HUFJTX0FVVEhfTUVUSE9EX0NIQVAg
PSAwLDxicj4KJmd0O8KgIMKgIMKgIMKgT0ZPTk9fR1BSU19BVVRIX01FVEhPRF9QQVAsPGJyPgom
Z3Q7ICvCoCDCoCDCoE9GT05PX0dQUlNfQVVUSF9NRVRIT0RfTk9ORSw8YnI+Cjxicj4KU28gc3Ry
aWN0bHkgc3BlYWtpbmcgd2UgYWxyZWFkeSBzdXBwb3J0IE5PTkUgYXMgYSBtZXRob2QgaWYgdXNl
cm5hbWUgaXMgPGJyPgplbXB0eS4gSSBkb24mIzM5O3QgaGF2ZSBhIHByb2JsZW0gd2l0aCB0aGlz
IGNoYW5nZSwgYnV0IGl0IGRvZXMgaW1wbHkgdGhhdCA8YnI+CnlvdSBuZWVkIHRvIGZpeCB1cCB0
aGUgZXhpc3RpbmcgY29kZSBkZXBlbmRpbmcgb24gdGhpcyBlbnVtZXJhdGlvbiB0byA8YnI+CmJl
aGF2ZSBwcm9wZXJseS48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+YWxyZWFk
eSBmaXhlZCBpbiB0aGUgcmVzdCBvZiB0aGlzIHBhdGNoIHNlcmllcy4gQnV0IHRoaXMgaW1wbGll
cyB0aGF0IEkgd2lsbCBoYXZlIHRvIHN1Ym1pdCBhZ2FpbiBhIG11bHRpLXBhcnQgcGF0Y2ggZm9y
IHRoaXMgY2hhbmdlLjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij4mZ3Q7wqAgwqB9Ozxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAg
wqBzdHJ1Y3Qgb2Zvbm9fZ3Byc19wcmltYXJ5X2NvbnRleHQgezxicj4KJmd0OyBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9sdGUuaCBiL2luY2x1ZGUvbHRlLmg8YnI+CiZndDsgaW5kZXggZWY4NGFiOS4u
Mzg1ODdjMyAxMDA2NDQ8YnI+CiZndDsgLS0tIGEvaW5jbHVkZS9sdGUuaDxicj4KJmd0OyArKysg
Yi9pbmNsdWRlL2x0ZS5oPGJyPgomZ3Q7IEBAIC0zLDYgKzMsNyBAQDxicj4KJmd0O8KgIMKgICrC
oCBvRm9ubyAtIE9wZW4gU291cmNlIFRlbGVwaG9ueTxicj4KJmd0O8KgIMKgICo8YnI+CiZndDvC
oCDCoCAqwqAgQ29weXJpZ2h0IChDKSAyMDE2wqAgRW5kb2NvZGUgQUcuIEFsbCByaWdodHMgcmVz
ZXJ2ZWQuPGJyPgomZ3Q7ICsgKsKgIENvcHlyaWdodCAoQykgMjAxOCBHZW1hbHRvIE0yTTxicj4K
Jmd0O8KgIMKgICo8YnI+CiZndDvCoCDCoCAqwqAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdh
cmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnk8YnI+CiZndDvCoCDCoCAq
wqAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2
ZXJzaW9uIDIgYXM8YnI+CiZndDsgQEAgLTI4LDE0ICsyOSwxOCBAQCBleHRlcm4gJnF1b3Q7QyZx
dW90OyB7PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDCoCNpbmNsdWRlICZsdDtvZm9uby90eXBl
cy5oJmd0Ozxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7IC1zdHJ1Y3Qgb2Zvbm9fbHRlOzxicj4KJmd0
OyAtPGJyPgo8YnI+ClNvIHdoeSBhcmUgeW91IGNoYW5naW5nIHRoZSBvcmRlciBzZWVtaW5nbHkg
cmFuZG9tbHk/wqAgQW5kIGFueXdheSwgdGhpcyA8YnI+CmlzIHdyb25nLsKgIFNlZSBkb2MvY29k
aW5nLXN0eWxlLnR4dCBpdGVtIE05Ljxicj4KPGJyPgomZ3Q7wqAgwqBzdHJ1Y3Qgb2Zvbm9fbHRl
X2RlZmF1bHRfYXR0YWNoX2luZm8gezxicj4KJmd0O8KgIMKgIMKgIMKgY2hhciBhcG5bT0ZPTk9f
R1BSU19NQVhfQVBOX0xFTkdUSCArIDFdOzxicj4KJmd0OyArwqAgwqAgwqBlbnVtIG9mb25vX2dw
cnNfcHJvdG8gcHJvdG87PGJyPgomZ3Q7ICvCoCDCoCDCoGVudW0gb2Zvbm9fZ3Byc19hdXRoX21l
dGhvZCBhdXRoX21ldGhvZDs8YnI+CiZndDsgK8KgIMKgIMKgY2hhciB1c2VybmFtZVtPRk9OT19H
UFJTX01BWF9VU0VSTkFNRV9MRU5HVEggKyAxXTs8YnI+CiZndDsgK8KgIMKgIMKgY2hhciBwYXNz
d29yZFtPRk9OT19HUFJTX01BWF9QQVNTV09SRF9MRU5HVEggKyAxXTs8YnI+Cjxicj4KT2theSwg
YnV0IHlvdSBtaWdodCB3YW50IHRvIHN0YXJ0IGF0IHRoZSBELUJ1cyBBUEkgbGV2ZWwgZmlyc3Qu
Li48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+dGhpcyBtZWFucyBzdWJtaXR0
aW5nIGEgcGF0Y2ggZm9yIHRoZSBELUJ1cyBBUEkgYmVmb3JlIHRoZSBvdGhlcnMgPzwvZGl2Pjxk
aXY+SW4gYW55IGNhc2UgaXQgaGFzIHRvIGdvIHdpdGggdGhlIHJlc3QgaWYgaXQgaGFzIHRvIGNv
bXBpbGUuPC9kaXY+PGRpdj5JIHN0aWxsIGhhdmVuJiMzOTt0IGZpZ3VyZWQgb3V0IGNvbXBsZXRl
bHkgaG93IHRvIHNwbGl0IHByb3Blcmx5IHRvIGVuc3VyZSBjb21waWxhdGlvbi48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4K
PGJyPgomZ3Q7wqAgwqB9Ozxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqB0eXBlZGVmIHZvaWQg
KCpvZm9ub19sdGVfY2JfdCkoY29uc3Qgc3RydWN0IG9mb25vX2Vycm9yICplcnJvciwgdm9pZCAq
ZGF0YSk7PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDsgK3N0cnVjdCBvZm9ub19sdGU7PGJyPgomZ3Q7
ICs8YnI+CiZndDvCoCDCoHN0cnVjdCBvZm9ub19sdGVfZHJpdmVyIHs8YnI+CiZndDvCoCDCoCDC
oCDCoGNvbnN0IGNoYXIgKm5hbWU7PGJyPgomZ3Q7wqAgwqAgwqAgwqBpbnQgKCpwcm9iZSkoc3Ry
dWN0IG9mb25vX2x0ZSAqbHRlLCB1bnNpZ25lZCBpbnQgdmVuZG9yLCB2b2lkICpkYXRhKTs8YnI+
CiZndDsgQEAgLTYxLDYgKzY2LDggQEAgdm9pZCBvZm9ub19sdGVfc2V0X2RhdGEoc3RydWN0IG9m
b25vX2x0ZSAqbHRlLCB2b2lkICpkYXRhKTs8YnI+CiZndDvCoCDCoDxicj4KJmd0O8KgIMKgdm9p
ZCAqb2Zvbm9fbHRlX2dldF9kYXRhKGNvbnN0IHN0cnVjdCBvZm9ub19sdGUgKmx0ZSk7PGJyPgom
Z3Q7wqAgwqA8YnI+CiZndDsgK3N0cnVjdCBvZm9ub19tb2RlbSAqb2Zvbm9fbHRlX2dldF9tb2Rl
bShjb25zdCBzdHJ1Y3Qgb2Zvbm9fbHRlICpsdGUpOzxicj4KJmd0OyArICZndDvCoCDCoCNpZmRl
ZiBfX2NwbHVzcGx1czxicj4KJmd0O8KgIMKgfTxicj4KJmd0O8KgIMKgI2VuZGlmPGJyPgomZ3Q7
IDxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48
L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5HaWFjaW50bzwvZGl2PjxkaXY+wqA8L2Rpdj48
L2Rpdj48L2Rpdj4K

--===============6797000134639260135==--

