Content-Type: multipart/mixed; boundary="===============4004041500823128417=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH 2/4] gprs: Always call gprs_attached_update on context
 deactivation.
Date: Fri, 16 Aug 2019 13:14:17 +0200
Message-ID: <CAHB-PjkmAqc3OATbEaAXhM_DCS7TvvMe7hAj0ATGrLAzXEtAHw@mail.gmail.com>
In-Reply-To: <9d49806c-3f3f-498b-5e93-bbfa9e620cf1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4004041500823128417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den tors 15 aug. 2019 kl 22:41 skrev Denis Kenzior <denkenz@gmail.com>:

> Hi Richard,
>
> On 8/14/19 1:24 PM, richard.rojfors(a)gmail.com wrote:
> > From: Richard R=C3=B6jfors <richard@puffinpack.se>
> >
> > Since its registered context is a condition for being attached
> > when running LTE, we might need to update the attached state
> > when a context is deactivated. Otherwise we might remain
>
> Well, by definition if we're on LTE then we're attached.  So I'm not
> quite sure what you mean here?
>

OK, maybe this is overkill. And about the order things are happening in
reporting from the modem.


>
> > attached, and connection managers (at least connman) start
> > to hammer us to connect a context, eventhough it happens
> > automatically in LTE.
>
> What happens automatically?  Yes, it is true that you need a default
> context to attach to LTE.  So activating a context is basically a part
> of the LTE attach procedure.
>
> But that default context does not need to be an internet context (e.g.
> Verizon uses (or used to) use an ims context for this). So ConnMan still
> might need to activate an Internet context even if we're on LTE.
>

To do that wouldn't we need to be able to flag attached even without
registered context for LTE?
Or will the modem not attach to 4G until the context is configured?
I can not test that case with my modems.


> I'm also not sure that the heuristic of 0 active contexts means not
> attached is a good one.  Shouldn't you be using +CREG or +CEREG status
> for this?
>

As you say that is probably more correct :)
First I wanted to get things running with the current solution which uses
an active
context as condition.


>
> > ---
> >   src/gprs.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/src/gprs.c b/src/gprs.c
> > index 94d13f82..cb31e2d2 100644
> > --- a/src/gprs.c
> > +++ b/src/gprs.c
> > @@ -2738,11 +2738,12 @@ void ofono_gprs_context_deactivated(struct
> ofono_gprs_context *gc,
> >        * If "Attached" property was about to be signalled as TRUE but
> there
> >        * were still active contexts, try again to signal "Attached"
> property
> >        * to registered applications after active contexts have been
> released.
> > +      *
> > +      * ... or in the case of LTE where the attached state were a
> registered
> > +      * context is a condition for being attached
> >        */
> > -     if (gc->gprs->flags & GPRS_FLAG_ATTACHED_UPDATE) {
> > -             gc->gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
> > -             gprs_attached_update(gc->gprs);
> > -     }
> > +     gc->gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
> > +     gprs_attached_update(gc->gprs);
> >   }
> >
> >   int ofono_gprs_context_driver_register(
> >
>
> Regards,
> -Denis
>

--===============4004041500823128417==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gdG9ycyAxNSBhdWcu
IDIwMTkga2wgMjI6NDEgc2tyZXYgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRl
bmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7Ojxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+SGkgUmljaGFyZCw8YnI+Cjxicj4KT24gOC8xNC8xOSAxOjI0IFBNLCA8YSBocmVmPSJtYWls
dG86cmljaGFyZC5yb2pmb3JzQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJpY2hhcmQucm9q
Zm9yc0BnbWFpbC5jb208L2E+IHdyb3RlOjxicj4KJmd0OyBGcm9tOiBSaWNoYXJkIFLDtmpmb3Jz
ICZsdDs8YSBocmVmPSJtYWlsdG86cmljaGFyZEBwdWZmaW5wYWNrLnNlIiB0YXJnZXQ9Il9ibGFu
ayI+cmljaGFyZEBwdWZmaW5wYWNrLnNlPC9hPiZndDs8YnI+CiZndDsgPGJyPgomZ3Q7IFNpbmNl
IGl0cyByZWdpc3RlcmVkIGNvbnRleHQgaXMgYSBjb25kaXRpb24gZm9yIGJlaW5nIGF0dGFjaGVk
PGJyPgomZ3Q7IHdoZW4gcnVubmluZyBMVEUsIHdlIG1pZ2h0IG5lZWQgdG8gdXBkYXRlIHRoZSBh
dHRhY2hlZCBzdGF0ZTxicj4KJmd0OyB3aGVuIGEgY29udGV4dCBpcyBkZWFjdGl2YXRlZC4gT3Ro
ZXJ3aXNlIHdlIG1pZ2h0IHJlbWFpbjxicj4KPGJyPgpXZWxsLCBieSBkZWZpbml0aW9uIGlmIHdl
JiMzOTtyZSBvbiBMVEUgdGhlbiB3ZSYjMzk7cmUgYXR0YWNoZWQuwqAgU28gSSYjMzk7bSBub3Qg
PGJyPgpxdWl0ZSBzdXJlIHdoYXQgeW91IG1lYW4gaGVyZT88YnI+PC9ibG9ja3F1b3RlPjxkaXY+
PGJyPjwvZGl2PjxkaXY+T0ssIG1heWJlIHRoaXMgaXMgb3ZlcmtpbGwuIEFuZCBhYm91dCB0aGUg
b3JkZXIgdGhpbmdzIGFyZSBoYXBwZW5pbmcgaW4gcmVwb3J0aW5nIGZyb20gdGhlIG1vZGVtLjwv
ZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0
LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KJmd0OyBhdHRhY2hlZCwgYW5kIGNvbm5lY3Rp
b24gbWFuYWdlcnMgKGF0IGxlYXN0IGNvbm5tYW4pIHN0YXJ0PGJyPgomZ3Q7IHRvIGhhbW1lciB1
cyB0byBjb25uZWN0IGEgY29udGV4dCwgZXZlbnRob3VnaCBpdCBoYXBwZW5zPGJyPgomZ3Q7IGF1
dG9tYXRpY2FsbHkgaW4gTFRFLjxicj4KPGJyPgpXaGF0IGhhcHBlbnMgYXV0b21hdGljYWxseT/C
oCBZZXMsIGl0IGlzIHRydWUgdGhhdCB5b3UgbmVlZCBhIGRlZmF1bHQgPGJyPgpjb250ZXh0IHRv
IGF0dGFjaCB0byBMVEUuwqAgU28gYWN0aXZhdGluZyBhIGNvbnRleHQgaXMgYmFzaWNhbGx5IGEg
cGFydCA8YnI+Cm9mIHRoZSBMVEUgYXR0YWNoIHByb2NlZHVyZS48YnI+Cjxicj4KQnV0IHRoYXQg
ZGVmYXVsdCBjb250ZXh0IGRvZXMgbm90IG5lZWQgdG8gYmUgYW4gaW50ZXJuZXQgY29udGV4dCAo
ZS5nLiA8YnI+ClZlcml6b24gdXNlcyAob3IgdXNlZCB0bykgdXNlIGFuIGltcyBjb250ZXh0IGZv
ciB0aGlzKS4gU28gQ29ubk1hbiBzdGlsbCA8YnI+Cm1pZ2h0IG5lZWQgdG8gYWN0aXZhdGUgYW4g
SW50ZXJuZXQgY29udGV4dCBldmVuIGlmIHdlJiMzOTtyZSBvbiBMVEUuPGJyPjwvYmxvY2txdW90
ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRvIGRvIHRoYXQgd291bGRuJiMzOTt0IHdlIG5lZWQgdG8g
YmUgYWJsZSB0byBmbGFnIGF0dGFjaGVkIGV2ZW4gd2l0aG91dDwvZGl2PjxkaXY+cmVnaXN0ZXJl
ZCBjb250ZXh0IGZvciBMVEU/PC9kaXY+PGRpdj5PciB3aWxsIHRoZSBtb2RlbSBub3QgYXR0YWNo
IHRvIDRHIHVudGlsIHRoZSBjb250ZXh0IGlzIGNvbmZpZ3VyZWQ/PC9kaXY+PGRpdj5JIGNhbiBu
b3QgdGVzdCB0aGF0IGNhc2Ugd2l0aCBteSBtb2RlbXMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAu
OGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDox
ZXgiPgo8YnI+CkkmIzM5O20gYWxzbyBub3Qgc3VyZSB0aGF0IHRoZSBoZXVyaXN0aWMgb2YgMCBh
Y3RpdmUgY29udGV4dHMgbWVhbnMgbm90IDxicj4KYXR0YWNoZWQgaXMgYSBnb29kIG9uZS7CoCBT
aG91bGRuJiMzOTt0IHlvdSBiZSB1c2luZyArQ1JFRyBvciArQ0VSRUcgc3RhdHVzIDxicj4KZm9y
IHRoaXM/PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkFzIHlvdSBzYXkgdGhh
dCBpcyBwcm9iYWJseSBtb3JlIGNvcnJlY3QgOik8L2Rpdj48ZGl2PkZpcnN0IEkgd2FudGVkIHRv
IGdldCB0aGluZ3MgcnVubmluZyB3aXRoIHRoZSBjdXJyZW50IHNvbHV0aW9uIHdoaWNoIHVzZXMg
YW4gYWN0aXZlPC9kaXY+PGRpdj5jb250ZXh0IGFzIGNvbmRpdGlvbi48L2Rpdj48ZGl2PsKgPC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPgo8YnI+CiZndDsgLS0tPGJyPgomZ3Q7wqAgwqBzcmMvZ3Bycy5jIHwgOSArKysr
Ky0tLS08YnI+CiZndDvCoCDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pPGJyPgomZ3Q7IDxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvc3JjL2dwcnMuYyBiL3Ny
Yy9ncHJzLmM8YnI+CiZndDsgaW5kZXggOTRkMTNmODIuLmNiMzFlMmQyIDEwMDY0NDxicj4KJmd0
OyAtLS0gYS9zcmMvZ3Bycy5jPGJyPgomZ3Q7ICsrKyBiL3NyYy9ncHJzLmM8YnI+CiZndDsgQEAg
LTI3MzgsMTEgKzI3MzgsMTIgQEAgdm9pZCBvZm9ub19ncHJzX2NvbnRleHRfZGVhY3RpdmF0ZWQo
c3RydWN0IG9mb25vX2dwcnNfY29udGV4dCAqZ2MsPGJyPgomZ3Q7wqAgwqAgwqAgwqAgKiBJZiAm
cXVvdDtBdHRhY2hlZCZxdW90OyBwcm9wZXJ0eSB3YXMgYWJvdXQgdG8gYmUgc2lnbmFsbGVkIGFz
IFRSVUUgYnV0IHRoZXJlPGJyPgomZ3Q7wqAgwqAgwqAgwqAgKiB3ZXJlIHN0aWxsIGFjdGl2ZSBj
b250ZXh0cywgdHJ5IGFnYWluIHRvIHNpZ25hbCAmcXVvdDtBdHRhY2hlZCZxdW90OyBwcm9wZXJ0
eTxicj4KJmd0O8KgIMKgIMKgIMKgICogdG8gcmVnaXN0ZXJlZCBhcHBsaWNhdGlvbnMgYWZ0ZXIg
YWN0aXZlIGNvbnRleHRzIGhhdmUgYmVlbiByZWxlYXNlZC48YnI+CiZndDsgK8KgIMKgIMKgICo8
YnI+CiZndDsgK8KgIMKgIMKgICogLi4uIG9yIGluIHRoZSBjYXNlIG9mIExURSB3aGVyZSB0aGUg
YXR0YWNoZWQgc3RhdGUgd2VyZSBhIHJlZ2lzdGVyZWQ8YnI+CiZndDsgK8KgIMKgIMKgICogY29u
dGV4dCBpcyBhIGNvbmRpdGlvbiBmb3IgYmVpbmcgYXR0YWNoZWQ8YnI+CiZndDvCoCDCoCDCoCDC
oCAqLzxicj4KJmd0OyAtwqAgwqAgwqBpZiAoZ2MtJmd0O2dwcnMtJmd0O2ZsYWdzICZhbXA7IEdQ
UlNfRkxBR19BVFRBQ0hFRF9VUERBVEUpIHs8YnI+CiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
Z2MtJmd0O2dwcnMtJmd0O2ZsYWdzICZhbXA7PSB+R1BSU19GTEFHX0FUVEFDSEVEX1VQREFURTs8
YnI+CiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgZ3Byc19hdHRhY2hlZF91cGRhdGUoZ2MtJmd0
O2dwcnMpOzxicj4KJmd0OyAtwqAgwqAgwqB9PGJyPgomZ3Q7ICvCoCDCoCDCoGdjLSZndDtncHJz
LSZndDtmbGFncyAmYW1wOz0gfkdQUlNfRkxBR19BVFRBQ0hFRF9VUERBVEU7PGJyPgomZ3Q7ICvC
oCDCoCDCoGdwcnNfYXR0YWNoZWRfdXBkYXRlKGdjLSZndDtncHJzKTs8YnI+CiZndDvCoCDCoH08
YnI+CiZndDvCoCDCoDxicj4KJmd0O8KgIMKgaW50IG9mb25vX2dwcnNfY29udGV4dF9kcml2ZXJf
cmVnaXN0ZXIoPGJyPgomZ3Q7IDxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Js
b2NrcXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============4004041500823128417==--

