Content-Type: multipart/mixed; boundary="===============4509623578131157716=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH 1/4] gprs: Check for LTE in gprs_attached_update
Date: Sun, 18 Aug 2019 15:18:35 +0200
Message-ID: <CAHB-Pj=+OV4QsPSKwaFq2e4kpZzrBcw1XNLbe0t=2ie4dOSHMQ@mail.gmail.com>
In-Reply-To: <6ecf0d74-122b-14bf-c745-5a66280d1c3b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4509623578131157716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den fre 16 aug. 2019 kl 17:55 skrev Denis Kenzior <denkenz@gmail.com>:

> Hi Richard,
>
> On 8/16/19 5:44 AM, Richard R=C3=B6jfors wrote:
> > Hi Denis,
> >
> > Den tors 15 aug. 2019 kl 22:47 skrev Denis Kenzior <denkenz@gmail.com
> > <mailto:denkenz@gmail.com>>:
> >
> >     Hi Richard,
> >
> >     On 8/14/19 1:24 PM, richard.rojfors(a)gmail.com
> >     <mailto:richard.rojfors@gmail.com> wrote:
> >      > From: Richard R=C3=B6jfors <richard@puffinpack.se
> >     <mailto:richard@puffinpack.se>>
> >      >
> >      > Since we have a different condition for the attach state
> >      > when running on LTE, we should consider it in
> gprs_attached_update.
> >      > Previously it's done in some instances. But for instance if
> >      > the driver got detached from GPRS but now running on LTE with a
> >      > context up, we would be deattached.
> >
> >     So are you talking about a hand-over? Do we have logs to help
> visualize
> >     this?
> >
> >
> > Sorry I have no logs.
> > I think an example would be;
> > Let say we are registered on non-LTE, and GPRS do attach.
> > Then we flip to LTE and if GPRS gets de-attached. We would brutally
> > exit the attached state, since LTE is currently not considered in that
> > code path.
>
> Okay, so handover.  It would be helpful to have logs to help visualize
> what is happening.
>

As I said, I'm afraid I have no logs for this. I tried to visualize how it
could happen.

But anyway I think it makes more sense to "calculate" the attached state in
one place,
(gprs_attached_update) and one of the places this gets called from is when
GPRS detaches.


>
> >
> >
> >      > ---
> >      >   src/gprs.c | 52
> >     +++++++++++++++++++++++++++++-----------------------
> >      >   1 file changed, 29 insertions(+), 23 deletions(-)
> >      >
> >      > diff --git a/src/gprs.c b/src/gprs.c
> >      > index bba482cb..94d13f82 100644
> >      > --- a/src/gprs.c
> >      > +++ b/src/gprs.c
> >      > @@ -1571,13 +1571,34 @@ static void
> >     release_active_contexts(struct ofono_gprs *gprs)
> >      >       }
> >      >   }
> >      >
> >      > +static gboolean on_lte(struct ofono_gprs *gprs)
> >      > +{
> >      > +     if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
> >      > +                     ACCESS_TECHNOLOGY_EUTRAN &&
> >     have_read_settings(gprs))
> >      > +             return TRUE;
> >      > +
> >      > +     return FALSE;
> >      > +}
> >      > +
> >      >   static void gprs_attached_update(struct ofono_gprs *gprs)
> >      >   {
> >      >       ofono_bool_t attached;
> >      > +     int status =3D gprs->status;
> >      >
> >      > -     attached =3D gprs->driver_attached &&
> >      > -             (gprs->status =3D=3D
> >     NETWORK_REGISTRATION_STATUS_REGISTERED ||
> >      > -                     gprs->status =3D=3D
> >     NETWORK_REGISTRATION_STATUS_ROAMING);
> >      > +     if (on_lte(gprs))
> >      > +             /*
> >      > +              * For LTE we attached status reflects successful
> >     context
> >      > +              * activation.
> >      > +              * Since we in gprs_netreg_update not even try to
> >     attach
> >      > +              * to GPRS if we are running on LTE, we can on some
> >     modems
> >      > +              * expect the gprs status to be unknown. That must
> not
> >      > +              * result in detaching...
> >      > +              */
> >      > +             attached =3D have_active_contexts(gprs);
> >
> >     On LTE Attached should just be always True.  Someone can correct me
> if
> >     I'm wrong, but a default context is a pre-requisite for E-UTRAN
> >     attachment.
> >
> >
> > I guess this is about race conditions, since we read back settings of
> > the context,
> > so in theory I think we might not consider the context available yet.
> > Should be
> > a very short period of time.
> > In netreg status we do not immediately change to attached in case of
> > LTE, we require the context settings to have been read first.
>
> I think it makes sense to signal Attached right away in the case that we
> know we are on LTE.  But I can accept your argument of not signaling
> Attached until the first context is active.  That is likely more driven
> by ConMan not being updated for LTE, which likely won't work in the end.
>

And I would like to add, that this how things are today, its nothing I have
or
inteded to change.
I just want to make sure we don't get deattached
because we miss to check for LTE in some places in the code.

--===============4509623578131157716==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gZnJlIDE2IGF1Zy4g
MjAxOSBrbCAxNzo1NSBza3JldiBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVu
a2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs6PGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij5IaSBSaWNoYXJkLDxicj4KPGJyPgpPbiA4LzE2LzE5IDU6NDQgQU0sIFJpY2hhcmQgUsO2amZv
cnMgd3JvdGU6PGJyPgomZ3Q7IEhpIERlbmlzLDxicj4KJmd0OyA8YnI+CiZndDsgRGVuIHRvcnMg
MTUgYXVnLiAyMDE5IGtsIDIyOjQ3IHNrcmV2IERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1h
aWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29t
PC9hPiA8YnI+CiZndDsgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5j
b20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0Ozo8YnI+CiZn
dDsgPGJyPgomZ3Q7wqAgwqAgwqBIaSBSaWNoYXJkLDxicj4KJmd0OyA8YnI+CiZndDvCoCDCoCDC
oE9uIDgvMTQvMTkgMToyNCBQTSwgPGEgaHJlZj0ibWFpbHRvOnJpY2hhcmQucm9qZm9yc0BnbWFp
bC5jb20iIHRhcmdldD0iX2JsYW5rIj5yaWNoYXJkLnJvamZvcnNAZ21haWwuY29tPC9hPjxicj4K
Jmd0O8KgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86cmljaGFyZC5yb2pmb3JzQGdt
YWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJpY2hhcmQucm9qZm9yc0BnbWFpbC5jb208L2E+Jmd0
OyB3cm90ZTo8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7IEZyb206IFJpY2hhcmQgUsO2amZvcnMgJmx0
OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkQHB1ZmZpbnBhY2suc2UiIHRhcmdldD0iX2JsYW5rIj5y
aWNoYXJkQHB1ZmZpbnBhY2suc2U8L2E+PGJyPgomZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhy
ZWY9Im1haWx0bzpyaWNoYXJkQHB1ZmZpbnBhY2suc2UiIHRhcmdldD0iX2JsYW5rIj5yaWNoYXJk
QHB1ZmZpbnBhY2suc2U8L2E+Jmd0OyZndDs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7PGJyPgomZ3Q7
wqAgwqAgwqAgJmd0OyBTaW5jZSB3ZSBoYXZlIGEgZGlmZmVyZW50IGNvbmRpdGlvbiBmb3IgdGhl
IGF0dGFjaCBzdGF0ZTxicj4KJmd0O8KgIMKgIMKgICZndDsgd2hlbiBydW5uaW5nIG9uIExURSwg
d2Ugc2hvdWxkIGNvbnNpZGVyIGl0IGluIGdwcnNfYXR0YWNoZWRfdXBkYXRlLjxicj4KJmd0O8Kg
IMKgIMKgICZndDsgUHJldmlvdXNseSBpdCYjMzk7cyBkb25lIGluIHNvbWUgaW5zdGFuY2VzLiBC
dXQgZm9yIGluc3RhbmNlIGlmPGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyB0aGUgZHJpdmVyIGdvdCBk
ZXRhY2hlZCBmcm9tIEdQUlMgYnV0IG5vdyBydW5uaW5nIG9uIExURSB3aXRoIGE8YnI+CiZndDvC
oCDCoCDCoCAmZ3Q7IGNvbnRleHQgdXAsIHdlIHdvdWxkIGJlIGRlYXR0YWNoZWQuPGJyPgomZ3Q7
IDxicj4KJmd0O8KgIMKgIMKgU28gYXJlIHlvdSB0YWxraW5nIGFib3V0IGEgaGFuZC1vdmVyPyBE
byB3ZSBoYXZlIGxvZ3MgdG8gaGVscCB2aXN1YWxpemU8YnI+CiZndDvCoCDCoCDCoHRoaXM/PGJy
PgomZ3Q7IDxicj4KJmd0OyA8YnI+CiZndDsgU29ycnkgSSBoYXZlIG5vIGxvZ3MuPGJyPgomZ3Q7
IEkgdGhpbmsgYW4gZXhhbXBsZSB3b3VsZCBiZTs8YnI+CiZndDsgTGV0IHNheSB3ZSBhcmUgcmVn
aXN0ZXJlZCBvbiBub24tTFRFLCBhbmQgR1BSUyBkbyBhdHRhY2guPGJyPgomZ3Q7IFRoZW4gd2Ug
ZmxpcCB0byBMVEUgYW5kIGlmIEdQUlMgZ2V0cyBkZS1hdHRhY2hlZC4gV2Ugd291bGQgYnJ1dGFs
bHk8YnI+CiZndDsgZXhpdCB0aGUgYXR0YWNoZWQgc3RhdGUsIHNpbmNlIExURSBpcyBjdXJyZW50
bHkgbm90IGNvbnNpZGVyZWQgaW4gdGhhdCA8YnI+CiZndDsgY29kZSBwYXRoLjxicj4KPGJyPgpP
a2F5LCBzbyBoYW5kb3Zlci7CoCBJdCB3b3VsZCBiZSBoZWxwZnVsIHRvIGhhdmUgbG9ncyB0byBo
ZWxwIHZpc3VhbGl6ZSA8YnI+CndoYXQgaXMgaGFwcGVuaW5nLjxicj48L2Jsb2NrcXVvdGU+PGRp
dj48YnI+PC9kaXY+PGRpdj5BcyBJIHNhaWQsIEkmIzM5O20gYWZyYWlkIEkgaGF2ZSBubyBsb2dz
IGZvciB0aGlzLiBJIHRyaWVkIHRvIHZpc3VhbGl6ZSBob3cgaXQgY291bGQgaGFwcGVuLjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+QnV0IGFueXdheSBJIHRoaW5rIGl0IG1ha2VzIG1vcmUgc2Vu
c2UgdG8gJnF1b3Q7Y2FsY3VsYXRlJnF1b3Q7IHRoZSBhdHRhY2hlZCBzdGF0ZSBpbiBvbmUgcGxh
Y2UswqA8L2Rpdj48ZGl2PihncHJzX2F0dGFjaGVkX3VwZGF0ZSkgYW5kIG9uZSBvZiB0aGUgcGxh
Y2VzIHRoaXMgZ2V0cyBjYWxsZWQgZnJvbSBpcyB3aGVuIEdQUlMgZGV0YWNoZXMuPC9kaXY+PGRp
dj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtw
YWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgomZ3Q7IDxicj4KJmd0OyA8YnI+CiZndDvCoCDCoCDCoCAm
Z3Q7IC0tLTxicj4KJmd0O8KgIMKgIMKgICZndDvCoCDCoHNyYy9ncHJzLmMgfCA1Mjxicj4KJmd0
O8KgIMKgIMKgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLTxicj4KJmd0O8KgIMKgIMKgICZndDvCoCDCoDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRp
b25zKCspLCAyMyBkZWxldGlvbnMoLSk8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7PGJyPgomZ3Q7wqAg
wqAgwqAgJmd0OyBkaWZmIC0tZ2l0IGEvc3JjL2dwcnMuYyBiL3NyYy9ncHJzLmM8YnI+CiZndDvC
oCDCoCDCoCAmZ3Q7IGluZGV4IGJiYTQ4MmNiLi45NGQxM2Y4MiAxMDA2NDQ8YnI+CiZndDvCoCDC
oCDCoCAmZ3Q7IC0tLSBhL3NyYy9ncHJzLmM8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICsrKyBiL3Ny
Yy9ncHJzLmM8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7IEBAIC0xNTcxLDEzICsxNTcxLDM0IEBAIHN0
YXRpYyB2b2lkPGJyPgomZ3Q7wqAgwqAgwqByZWxlYXNlX2FjdGl2ZV9jb250ZXh0cyhzdHJ1Y3Qg
b2Zvbm9fZ3BycyAqZ3Bycyk8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqB9PGJyPgom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgfTxicj4KJmd0O8KgIMKgIMKgICZndDs8YnI+CiZndDvCoCDC
oCDCoCAmZ3Q7ICtzdGF0aWMgZ2Jvb2xlYW4gb25fbHRlKHN0cnVjdCBvZm9ub19ncHJzICpncHJz
KTxicj4KJmd0O8KgIMKgIMKgICZndDsgK3s8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDC
oGlmIChvZm9ub19uZXRyZWdfZ2V0X3RlY2hub2xvZ3koZ3Bycy0mZ3Q7bmV0cmVnKSA9PTxicj4K
Jmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQUNDRVNT
X1RFQ0hOT0xPR1lfRVVUUkFOICZhbXA7JmFtcDs8YnI+CiZndDvCoCDCoCDCoGhhdmVfcmVhZF9z
ZXR0aW5ncyhncHJzKSk8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldHVybiBUUlVFOzxicj4KJmd0O8KgIMKgIMKgICZndDsgKzxicj4KJmd0O8KgIMKgIMKgICZn
dDsgK8KgIMKgIMKgcmV0dXJuIEZBTFNFOzxicj4KJmd0O8KgIMKgIMKgICZndDsgK308YnI+CiZn
dDvCoCDCoCDCoCAmZ3Q7ICs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqBzdGF0aWMgdm9pZCBn
cHJzX2F0dGFjaGVkX3VwZGF0ZShzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Bycyk8YnI+CiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqB7PGJyPgomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgIMKgb2Zvbm9fYm9v
bF90IGF0dGFjaGVkOzxicj4KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgaW50IHN0YXR1cyA9
IGdwcnMtJmd0O3N0YXR1czs8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7PGJyPgomZ3Q7wqAgwqAgwqAg
Jmd0OyAtwqAgwqAgwqBhdHRhY2hlZCA9IGdwcnMtJmd0O2RyaXZlcl9hdHRhY2hlZCAmYW1wOyZh
bXA7PGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAoZ3Bycy0mZ3Q7
c3RhdHVzID09PGJyPgomZ3Q7wqAgwqAgwqBORVRXT1JLX1JFR0lTVFJBVElPTl9TVEFUVVNfUkVH
SVNURVJFRCB8fDxicj4KJmd0O8KgIMKgIMKgICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZ3Bycy0mZ3Q7c3RhdHVzID09PGJyPgomZ3Q7wqAgwqAgwqBORVRXT1JLX1JFR0lT
VFJBVElPTl9TVEFUVVNfUk9BTUlORyk7PGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqBp
ZiAob25fbHRlKGdwcnMpKTxicj4KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgLyo8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIEZvciBM
VEUgd2UgYXR0YWNoZWQgc3RhdHVzIHJlZmxlY3RzIHN1Y2Nlc3NmdWw8YnI+CiZndDvCoCDCoCDC
oGNvbnRleHQ8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIGFj
dGl2YXRpb24uPGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBT
aW5jZSB3ZSBpbiBncHJzX25ldHJlZ191cGRhdGUgbm90IGV2ZW4gdHJ5IHRvPGJyPgomZ3Q7wqAg
wqAgwqBhdHRhY2g8YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAq
IHRvIEdQUlMgaWYgd2UgYXJlIHJ1bm5pbmcgb24gTFRFLCB3ZSBjYW4gb24gc29tZTxicj4KJmd0
O8KgIMKgIMKgbW9kZW1zPGJyPgomZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgKiBleHBlY3QgdGhlIGdwcnMgc3RhdHVzIHRvIGJlIHVua25vd24uIFRoYXQgbXVzdCBub3Q8
YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIHJlc3VsdCBpbiBk
ZXRhY2hpbmcuLi48YnI+CiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAq
Lzxicj4KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYXR0YWNoZWQgPSBo
YXZlX2FjdGl2ZV9jb250ZXh0cyhncHJzKTs8YnI+CiZndDsgPGJyPgomZ3Q7wqAgwqAgwqBPbiBM
VEUgQXR0YWNoZWQgc2hvdWxkIGp1c3QgYmUgYWx3YXlzIFRydWUuwqAgU29tZW9uZSBjYW4gY29y
cmVjdCBtZSBpZjxicj4KJmd0O8KgIMKgIMKgSSYjMzk7bSB3cm9uZywgYnV0IGEgZGVmYXVsdCBj
b250ZXh0IGlzIGEgcHJlLXJlcXVpc2l0ZSBmb3IgRS1VVFJBTjxicj4KJmd0O8KgIMKgIMKgYXR0
YWNobWVudC48YnI+CiZndDsgPGJyPgomZ3Q7IDxicj4KJmd0OyBJIGd1ZXNzIHRoaXMgaXMgYWJv
dXQgcmFjZSBjb25kaXRpb25zLCBzaW5jZSB3ZSByZWFkIGJhY2sgc2V0dGluZ3Mgb2YgPGJyPgom
Z3Q7IHRoZSBjb250ZXh0LDxicj4KJmd0OyBzbyBpbiB0aGVvcnkgSSB0aGluayB3ZSBtaWdodCBu
b3QgY29uc2lkZXIgdGhlIGNvbnRleHQgYXZhaWxhYmxlIHlldC4gPGJyPgomZ3Q7IFNob3VsZCBi
ZTxicj4KJmd0OyBhIHZlcnkgc2hvcnQgcGVyaW9kIG9mIHRpbWUuPGJyPgomZ3Q7IEluIG5ldHJl
ZyBzdGF0dXMgd2UgZG8gbm90IGltbWVkaWF0ZWx5IGNoYW5nZSB0byBhdHRhY2hlZCBpbiBjYXNl
IG9mPGJyPgomZ3Q7IExURSwgd2UgcmVxdWlyZSB0aGUgY29udGV4dCBzZXR0aW5ncyB0byBoYXZl
IGJlZW4gcmVhZCBmaXJzdC48YnI+Cjxicj4KSSB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBzaWdu
YWwgQXR0YWNoZWQgcmlnaHQgYXdheSBpbiB0aGUgY2FzZSB0aGF0IHdlIDxicj4Ka25vdyB3ZSBh
cmUgb24gTFRFLsKgIEJ1dCBJIGNhbiBhY2NlcHQgeW91ciBhcmd1bWVudCBvZiBub3Qgc2lnbmFs
aW5nIDxicj4KQXR0YWNoZWQgdW50aWwgdGhlIGZpcnN0IGNvbnRleHQgaXMgYWN0aXZlLsKgIFRo
YXQgaXMgbGlrZWx5IG1vcmUgZHJpdmVuIDxicj4KYnkgQ29uTWFuIG5vdCBiZWluZyB1cGRhdGVk
IGZvciBMVEUsIHdoaWNoIGxpa2VseSB3b24mIzM5O3Qgd29yayBpbiB0aGUgZW5kLjxicj48L2Js
b2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5BbmQgSSB3b3VsZCBsaWtlIHRvIGFkZCwgdGhh
dCB0aGlzIGhvdyB0aGluZ3MgYXJlIHRvZGF5LCBpdHMgbm90aGluZyBJIGhhdmUgb3I8L2Rpdj48
ZGl2PmludGVkZWQgdG8gY2hhbmdlLjwvZGl2PjxkaXY+SSBqdXN0IHdhbnQgdG8gbWFrZSBzdXJl
IHdlIGRvbiYjMzk7dCBnZXQgZGVhdHRhY2hlZDwvZGl2PjxkaXY+YmVjYXVzZSB3ZSBtaXNzIHRv
IGNoZWNrIGZvciBMVEUgaW4gc29tZSBwbGFjZXMgaW4gdGhlIGNvZGUuPC9kaXY+PC9kaXY+PC9k
aXY+Cg==

--===============4509623578131157716==--

