Content-Type: multipart/mixed; boundary="===============4174443561842627072=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] gprs: Do not detach when running LTE and GPRS is
 unavailable.
Date: Mon, 12 Aug 2019 20:37:47 +0200
Message-ID: <CAHB-Pjmp4Jxz5ezRscKS8_wErmrPhAL8o6X0H6Gv4ru4djjDpw@mail.gmail.com>
In-Reply-To: <a128be49-4aa7-8f03-1068-708dbd4154b4@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4174443561842627072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den m=C3=A5n 12 aug. 2019 kl 18:58 skrev Denis Kenzior <denkenz@gmail.com=
>:

> Hi Richard,
>
> On 8/11/19 9:58 AM, richard.rojfors(a)gmail.com wrote:
> > From: Richard R=C3=B6jfors <richard@puffinpack.se>
> >
> > There are cases where the gprs status might updated to for instance
> > "unknown" while LTE is the bearer.
> > In that case we should not set the attach state to FALSE,
> > since then running LTE the conext activation reflects the attached
> > state.
>
> It might be nice to include a log snippet of how the current behavior
> fails...
>

I'm not sure I can dig one up right now.

The case is that we are running LTE a context gets auto activated,
we don't bother to attach to GPRS (since we are on LTE), we get notified
that the
status is unknown -> BAM, we get detached, eventhough we are on LTE and the
context is up.


>
> > ---
> >   src/gprs.c | 19 ++++++++++++++++---
> >   1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/src/gprs.c b/src/gprs.c
> > index 9cb69d14..1a9b234d 100644
> > --- a/src/gprs.c
> > +++ b/src/gprs.c
> > @@ -1660,6 +1660,15 @@ static void gprs_netreg_removed(struct ofono_gprs
> *gprs)
> >       gprs_attached_update(gprs);
> >   }
> >
> > +static gboolean expect_lte_context_auto_activation(struct ofono_gprs
> *gprs)
>
> I'm not thrilled about the name?  Isn't this just 'on_lte?' or something
> like that?
>

Sounds better.


>
> > +{
> > +     if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
> > +                     ACCESS_TECHNOLOGY_EUTRAN &&
> have_read_settings(gprs))
> > +             return TRUE;
> > +
> > +     return FALSE;
> > +}
> > +
> >   static void gprs_netreg_update(struct ofono_gprs *gprs)
> >   {
> >       ofono_bool_t attach;
> > @@ -1682,8 +1691,7 @@ static void gprs_netreg_update(struct ofono_gprs
> *gprs)
> >
> >       DBG("attach: %u, driver_attached: %u", attach,
> gprs->driver_attached);
> >
> > -     if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
> > -                     ACCESS_TECHNOLOGY_EUTRAN &&
> have_read_settings(gprs))
> > +     if (expect_lte_context_auto_activation(gprs))
> >               /*
> >                * For LTE we set attached status only on successful
> >                * context activation.
> > @@ -2560,7 +2568,12 @@ void ofono_gprs_status_notify(struct ofono_gprs
> *gprs, int status)
> >
> >       if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
> >                       status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
> > -             gprs_attached_update(gprs);
> > +             /*
> > +              * For LTE we attached status reflects successful context
> > +              * activation.
> > +              */
>
> So I don't get this.  We have CREG telling us: "we're on LTE" and CGREG
> telling us "Oh we don't know what our status is".  Why do you trust one
> and not the other?  Are you sure this doesn't belong in a driver quirk
> somewhere?
>

When CREG tells us we are on LTE, we will probably not even try attach to
gprs (CGATT),
refer to gprs_netreg_update.
In my understanding that means that its natural that CGREG reports unknown
or similar.
CEREG would be the interesting one... but since the code is built around
using activated context as condition when running on LTE I think we should
use the same condition here.


>
> > +             if (!expect_lte_context_auto_activation(gprs))
> > +                     gprs_attached_update(gprs);
> >               return;
> >       }
> >
> >
>
> Regards,
> -Denis
>

--===============4174443561842627072==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gbcOlbiAxMiBhdWcu
IDIwMTkga2wgMTg6NTggc2tyZXYgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRl
bmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7Ojxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+SGkgUmljaGFyZCw8YnI+Cjxicj4KT24gOC8xMS8xOSA5OjU4IEFNLCA8YSBocmVmPSJtYWls
dG86cmljaGFyZC5yb2pmb3JzQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJpY2hhcmQucm9q
Zm9yc0BnbWFpbC5jb208L2E+IHdyb3RlOjxicj4KJmd0OyBGcm9tOiBSaWNoYXJkIFLDtmpmb3Jz
ICZsdDs8YSBocmVmPSJtYWlsdG86cmljaGFyZEBwdWZmaW5wYWNrLnNlIiB0YXJnZXQ9Il9ibGFu
ayI+cmljaGFyZEBwdWZmaW5wYWNrLnNlPC9hPiZndDs8YnI+CiZndDsgPGJyPgomZ3Q7IFRoZXJl
IGFyZSBjYXNlcyB3aGVyZSB0aGUgZ3BycyBzdGF0dXMgbWlnaHQgdXBkYXRlZCB0byBmb3IgaW5z
dGFuY2U8YnI+CiZndDsgJnF1b3Q7dW5rbm93biZxdW90OyB3aGlsZSBMVEUgaXMgdGhlIGJlYXJl
ci48YnI+CiZndDsgSW4gdGhhdCBjYXNlIHdlIHNob3VsZCBub3Qgc2V0IHRoZSBhdHRhY2ggc3Rh
dGUgdG8gRkFMU0UsPGJyPgomZ3Q7IHNpbmNlIHRoZW4gcnVubmluZyBMVEUgdGhlIGNvbmV4dCBh
Y3RpdmF0aW9uIHJlZmxlY3RzIHRoZSBhdHRhY2hlZDxicj4KJmd0OyBzdGF0ZS48YnI+Cjxicj4K
SXQgbWlnaHQgYmUgbmljZSB0byBpbmNsdWRlIGEgbG9nIHNuaXBwZXQgb2YgaG93IHRoZSBjdXJy
ZW50IGJlaGF2aW9yIDxicj4KZmFpbHMuLi48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2
PjxkaXY+SSYjMzk7bSBub3Qgc3VyZSBJIGNhbiBkaWcgb25lIHVwIHJpZ2h0IG5vdy48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBjYXNlIGlzIHRoYXQgd2UgYXJlIHJ1bm5pbmcgTFRFIGEg
Y29udGV4dCBnZXRzIGF1dG8gYWN0aXZhdGVkLDwvZGl2PjxkaXY+d2UgZG9uJiMzOTt0IGJvdGhl
ciB0byBhdHRhY2ggdG8gR1BSUyAoc2luY2Ugd2UgYXJlIG9uIExURSksIHdlIGdldCBub3RpZmll
ZCB0aGF0IHRoZTwvZGl2PjxkaXY+c3RhdHVzIGlzIHVua25vd24gLSZndDsgQkFNLCB3ZSBnZXQg
ZGV0YWNoZWQsIGV2ZW50aG91Z2ggd2UgYXJlIG9uIExURSBhbmQgdGhlPC9kaXY+PGRpdj5jb250
ZXh0IGlzIHVwLjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KJmd0OyAtLS08YnI+CiZn
dDvCoCDCoHNyYy9ncHJzLmMgfCAxOSArKysrKysrKysrKysrKysrLS0tPGJyPgomZ3Q7wqAgwqAx
IGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSk8YnI+CiZndDsg
PGJyPgomZ3Q7IGRpZmYgLS1naXQgYS9zcmMvZ3Bycy5jIGIvc3JjL2dwcnMuYzxicj4KJmd0OyBp
bmRleCA5Y2I2OWQxNC4uMWE5YjIzNGQgMTAwNjQ0PGJyPgomZ3Q7IC0tLSBhL3NyYy9ncHJzLmM8
YnI+CiZndDsgKysrIGIvc3JjL2dwcnMuYzxicj4KJmd0OyBAQCAtMTY2MCw2ICsxNjYwLDE1IEBA
IHN0YXRpYyB2b2lkIGdwcnNfbmV0cmVnX3JlbW92ZWQoc3RydWN0IG9mb25vX2dwcnMgKmdwcnMp
PGJyPgomZ3Q7wqAgwqAgwqAgwqBncHJzX2F0dGFjaGVkX3VwZGF0ZShncHJzKTs8YnI+CiZndDvC
oCDCoH08YnI+CiZndDvCoCDCoDxicj4KJmd0OyArc3RhdGljIGdib29sZWFuIGV4cGVjdF9sdGVf
Y29udGV4dF9hdXRvX2FjdGl2YXRpb24oc3RydWN0IG9mb25vX2dwcnMgKmdwcnMpPGJyPgo8YnI+
CkkmIzM5O20gbm90IHRocmlsbGVkIGFib3V0IHRoZSBuYW1lP8KgIElzbiYjMzk7dCB0aGlzIGp1
c3QgJiMzOTtvbl9sdGU/JiMzOTsgb3Igc29tZXRoaW5nIDxicj4KbGlrZSB0aGF0Pzxicj48L2Js
b2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5Tb3VuZHMgYmV0dGVyLjwvZGl2PjxkaXY+wqA8
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+Cjxicj4KJmd0OyArezxicj4KJmd0OyArwqAgwqAgwqBpZiAob2Zvbm9fbmV0
cmVnX2dldF90ZWNobm9sb2d5KGdwcnMtJmd0O25ldHJlZykgPT08YnI+CiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQUNDRVNTX1RFQ0hOT0xPR1lfRVVUUkFOICZhbXA7JmFt
cDsgaGF2ZV9yZWFkX3NldHRpbmdzKGdwcnMpKTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm4gVFJVRTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqByZXR1cm4gRkFMU0U7
PGJyPgomZ3Q7ICt9PGJyPgomZ3Q7ICs8YnI+CiZndDvCoCDCoHN0YXRpYyB2b2lkIGdwcnNfbmV0
cmVnX3VwZGF0ZShzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Bycyk8YnI+CiZndDvCoCDCoHs8YnI+CiZn
dDvCoCDCoCDCoCDCoG9mb25vX2Jvb2xfdCBhdHRhY2g7PGJyPgomZ3Q7IEBAIC0xNjgyLDggKzE2
OTEsNyBAQCBzdGF0aWMgdm9pZCBncHJzX25ldHJlZ191cGRhdGUoc3RydWN0IG9mb25vX2dwcnMg
KmdwcnMpPGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDCoCDCoCDCoERCRygmcXVvdDthdHRhY2g6
ICV1LCBkcml2ZXJfYXR0YWNoZWQ6ICV1JnF1b3Q7LCBhdHRhY2gsIGdwcnMtJmd0O2RyaXZlcl9h
dHRhY2hlZCk7PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDsgLcKgIMKgIMKgaWYgKG9mb25vX25ldHJl
Z19nZXRfdGVjaG5vbG9neShncHJzLSZndDtuZXRyZWcpID09PGJyPgomZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoEFDQ0VTU19URUNITk9MT0dZX0VVVFJBTiAmYW1wOyZhbXA7
IGhhdmVfcmVhZF9zZXR0aW5ncyhncHJzKSk8YnI+CiZndDsgK8KgIMKgIMKgaWYgKGV4cGVjdF9s
dGVfY29udGV4dF9hdXRvX2FjdGl2YXRpb24oZ3BycykpPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAvKjxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogRm9yIExURSB3ZSBz
ZXQgYXR0YWNoZWQgc3RhdHVzIG9ubHkgb24gc3VjY2Vzc2Z1bDxicj4KJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICogY29udGV4dCBhY3RpdmF0aW9uLjxicj4KJmd0OyBAQCAtMjU2MCw3ICsy
NTY4LDEyIEBAIHZvaWQgb2Zvbm9fZ3Byc19zdGF0dXNfbm90aWZ5KHN0cnVjdCBvZm9ub19ncHJz
ICpncHJzLCBpbnQgc3RhdHVzKTxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqAgwqAgwqBpZiAo
c3RhdHVzICE9IE5FVFdPUktfUkVHSVNUUkFUSU9OX1NUQVRVU19SRUdJU1RFUkVEICZhbXA7JmFt
cDs8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyAhPSBO
RVRXT1JLX1JFR0lTVFJBVElPTl9TVEFUVVNfUk9BTUlORykgezxicj4KJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqBncHJzX2F0dGFjaGVkX3VwZGF0ZShncHJzKTs8YnI+CiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgLyo8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICogRm9yIExURSB3
ZSBhdHRhY2hlZCBzdGF0dXMgcmVmbGVjdHMgc3VjY2Vzc2Z1bCBjb250ZXh0PGJyPgomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCAqIGFjdGl2YXRpb24uPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCAqLzxicj4KPGJyPgpTbyBJIGRvbiYjMzk7dCBnZXQgdGhpcy7CoCBXZSBoYXZlIENS
RUcgdGVsbGluZyB1czogJnF1b3Q7d2UmIzM5O3JlIG9uIExURSZxdW90OyBhbmQgQ0dSRUcgPGJy
Pgp0ZWxsaW5nIHVzICZxdW90O09oIHdlIGRvbiYjMzk7dCBrbm93IHdoYXQgb3VyIHN0YXR1cyBp
cyZxdW90Oy7CoCBXaHkgZG8geW91IHRydXN0IG9uZSA8YnI+CmFuZCBub3QgdGhlIG90aGVyP8Kg
IEFyZSB5b3Ugc3VyZSB0aGlzIGRvZXNuJiMzOTt0IGJlbG9uZyBpbiBhIGRyaXZlciBxdWlyayA8
YnI+CnNvbWV3aGVyZT88YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+V2hlbiBD
UkVHIHRlbGxzIHVzIHdlIGFyZSBvbiBMVEUsIHdlIHdpbGwgcHJvYmFibHkgbm90IGV2ZW4gdHJ5
IGF0dGFjaCB0byBncHJzIChDR0FUVCksPC9kaXY+PGRpdj5yZWZlciB0b8KgZ3Byc19uZXRyZWdf
dXBkYXRlLjwvZGl2PjxkaXY+SW4gbXkgdW5kZXJzdGFuZGluZyB0aGF0IG1lYW5zIHRoYXQgaXRz
IG5hdHVyYWwgdGhhdCBDR1JFRyByZXBvcnRzIHVua25vd24gb3Igc2ltaWxhci48L2Rpdj48ZGl2
PkNFUkVHIHdvdWxkIGJlIHRoZSBpbnRlcmVzdGluZyBvbmUuLi4gYnV0IHNpbmNlIHRoZSBjb2Rl
IGlzIGJ1aWx0IGFyb3VuZDwvZGl2PjxkaXY+dXNpbmcgYWN0aXZhdGVkIGNvbnRleHQgYXMgY29u
ZGl0aW9uIHdoZW4gcnVubmluZyBvbiBMVEUgSSB0aGluayB3ZSBzaG91bGQ8L2Rpdj48ZGl2PnVz
ZSB0aGUgc2FtZSBjb25kaXRpb24gaGVyZS48L2Rpdj48ZGl2PsKgPGJyPjwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4K
PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghZXhwZWN0X2x0ZV9jb250ZXh0X2F1
dG9fYWN0aXZhdGlvbihncHJzKSk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZ3Byc19hdHRhY2hlZF91cGRhdGUoZ3Bycyk7PGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm47PGJyPgomZ3Q7wqAgwqAgwqAgwqB9PGJyPgomZ3Q7wqAgwqA8YnI+CiZn
dDsgPGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+CjwvYmxvY2txdW90ZT48L2Rpdj48
L2Rpdj4K

--===============4174443561842627072==--

