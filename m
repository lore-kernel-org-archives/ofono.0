Content-Type: multipart/mixed; boundary="===============1334563842029097728=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH 1/4] gprs: Check for LTE in gprs_attached_update
Date: Fri, 16 Aug 2019 12:44:11 +0200
Message-ID: <CAHB-PjkGTSJDmhCg8gGFwRGez=cCEGJYdGUNVm8jf4viv1jwrA@mail.gmail.com>
In-Reply-To: <d8e48101-068c-4994-759d-e985f4ecd062@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1334563842029097728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den tors 15 aug. 2019 kl 22:47 skrev Denis Kenzior <denkenz@gmail.com>:

> Hi Richard,
>
> On 8/14/19 1:24 PM, richard.rojfors(a)gmail.com wrote:
> > From: Richard R=C3=B6jfors <richard@puffinpack.se>
> >
> > Since we have a different condition for the attach state
> > when running on LTE, we should consider it in gprs_attached_update.
> > Previously it's done in some instances. But for instance if
> > the driver got detached from GPRS but now running on LTE with a
> > context up, we would be deattached.
>
> So are you talking about a hand-over? Do we have logs to help visualize
> this?
>

Sorry I have no logs.
I think an example would be;
Let say we are registered on non-LTE, and GPRS do attach.
Then we flip to LTE and if GPRS gets de-attached. We would brutally
exit the attached state, since LTE is currently not considered in that code
path.


>
> > ---
> >   src/gprs.c | 52 +++++++++++++++++++++++++++++-----------------------
> >   1 file changed, 29 insertions(+), 23 deletions(-)
> >
> > diff --git a/src/gprs.c b/src/gprs.c
> > index bba482cb..94d13f82 100644
> > --- a/src/gprs.c
> > +++ b/src/gprs.c
> > @@ -1571,13 +1571,34 @@ static void release_active_contexts(struct
> ofono_gprs *gprs)
> >       }
> >   }
> >
> > +static gboolean on_lte(struct ofono_gprs *gprs)
> > +{
> > +     if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
> > +                     ACCESS_TECHNOLOGY_EUTRAN &&
> have_read_settings(gprs))
> > +             return TRUE;
> > +
> > +     return FALSE;
> > +}
> > +
> >   static void gprs_attached_update(struct ofono_gprs *gprs)
> >   {
> >       ofono_bool_t attached;
> > +     int status =3D gprs->status;
> >
> > -     attached =3D gprs->driver_attached &&
> > -             (gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTER=
ED ||
> > -                     gprs->status =3D=3D
> NETWORK_REGISTRATION_STATUS_ROAMING);
> > +     if (on_lte(gprs))
> > +             /*
> > +              * For LTE we attached status reflects successful context
> > +              * activation.
> > +              * Since we in gprs_netreg_update not even try to attach
> > +              * to GPRS if we are running on LTE, we can on some modems
> > +              * expect the gprs status to be unknown. That must not
> > +              * result in detaching...
> > +              */
> > +             attached =3D have_active_contexts(gprs);
>
> On LTE Attached should just be always True.  Someone can correct me if
> I'm wrong, but a default context is a pre-requisite for E-UTRAN attachmen=
t.
>

I guess this is about race conditions, since we read back settings of the
context,
so in theory I think we might not consider the context available yet.
Should be
a very short period of time.
In netreg status we do not immediately change to attached in case of
LTE, we require the context settings to have been read first.


>
> > +     else
> > +             attached =3D gprs->driver_attached &&
> > +                     (status =3D=3D NETWORK_REGISTRATION_STATUS_REGIST=
ERED
> ||
> > +                             status =3D=3D
> NETWORK_REGISTRATION_STATUS_ROAMING);
> >
> >       if (attached =3D=3D gprs->attached)
> >               return;
> > @@ -1591,11 +1612,14 @@ static void gprs_attached_update(struct
> ofono_gprs *gprs)
> >       if (attached =3D=3D FALSE) {
> >               release_active_contexts(gprs);
> >               gprs->bearer =3D -1;
> > -     } else if (have_active_contexts(gprs) =3D=3D TRUE) {
> > +     } else if (have_active_contexts(gprs) =3D=3D TRUE &&
> > +             !on_lte(gprs)) {
>
> Not our style.  See item M4.  Might want to see if it fits on the
> previous line.
>

Will updat!


>
> >               /*
> >                * Some times the context activates after a detach event
> and
> >                * right before an attach. We close it to avoid unexpected
> open
> >                * contexts.
> > +              * Skip that for LTE since the condition to be attached on
> LTE
> > +              * is that a context gets activated
> >                */
> >               release_active_contexts(gprs);
> >               gprs->flags |=3D GPRS_FLAG_ATTACHED_UPDATE;
> > @@ -1660,15 +1684,6 @@ static void gprs_netreg_removed(struct ofono_gprs
> *gprs)
> >       gprs_attached_update(gprs);
> >   }
> >
> > -static gboolean on_lte(struct ofono_gprs *gprs)
> > -{
> > -     if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
> > -                     ACCESS_TECHNOLOGY_EUTRAN &&
> have_read_settings(gprs))
> > -             return TRUE;
> > -
> > -     return FALSE;
> > -}
> > -
> >   static void gprs_netreg_update(struct ofono_gprs *gprs)
> >   {
> >       ofono_bool_t attach;
> > @@ -2573,16 +2588,7 @@ void ofono_gprs_status_notify(struct ofono_gprs
> *gprs, int status)
> >
> >       if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
> >                       status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
> > -             /*
> > -              * For LTE we attached status reflects successful context
> > -              * activation.
> > -              * Since we in gprs_netreg_update not even try to attach
> > -              * to GPRS if we are running on LTE, we can on some modems
> > -              * expect the gprs status to be unknown. That must not
> > -              * result in detaching...
> > -              */
> > -             if (!on_lte(gprs))
> > -                     gprs_attached_update(gprs);
> > +             gprs_attached_update(gprs);
> >               return;
> >       }
> >
> >
>
> Otherwise I'm fine moving the on_lte logic into gprs_attached_update
> itself...
>
> Regards,
> -Denis
>

--===============1334563842029097728==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gdG9ycyAxNSBhdWcu
IDIwMTkga2wgMjI6NDcgc2tyZXYgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRl
bmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7Ojxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+SGkgUmljaGFyZCw8YnI+Cjxicj4KT24gOC8xNC8xOSAxOjI0IFBNLCA8YSBocmVmPSJtYWls
dG86cmljaGFyZC5yb2pmb3JzQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJpY2hhcmQucm9q
Zm9yc0BnbWFpbC5jb208L2E+IHdyb3RlOjxicj4KJmd0OyBGcm9tOiBSaWNoYXJkIFLDtmpmb3Jz
ICZsdDs8YSBocmVmPSJtYWlsdG86cmljaGFyZEBwdWZmaW5wYWNrLnNlIiB0YXJnZXQ9Il9ibGFu
ayI+cmljaGFyZEBwdWZmaW5wYWNrLnNlPC9hPiZndDs8YnI+CiZndDsgPGJyPgomZ3Q7IFNpbmNl
IHdlIGhhdmUgYSBkaWZmZXJlbnQgY29uZGl0aW9uIGZvciB0aGUgYXR0YWNoIHN0YXRlPGJyPgom
Z3Q7IHdoZW4gcnVubmluZyBvbiBMVEUsIHdlIHNob3VsZCBjb25zaWRlciBpdCBpbiBncHJzX2F0
dGFjaGVkX3VwZGF0ZS48YnI+CiZndDsgUHJldmlvdXNseSBpdCYjMzk7cyBkb25lIGluIHNvbWUg
aW5zdGFuY2VzLiBCdXQgZm9yIGluc3RhbmNlIGlmPGJyPgomZ3Q7IHRoZSBkcml2ZXIgZ290IGRl
dGFjaGVkIGZyb20gR1BSUyBidXQgbm93IHJ1bm5pbmcgb24gTFRFIHdpdGggYTxicj4KJmd0OyBj
b250ZXh0IHVwLCB3ZSB3b3VsZCBiZSBkZWF0dGFjaGVkLjxicj4KPGJyPgpTbyBhcmUgeW91IHRh
bGtpbmcgYWJvdXQgYSBoYW5kLW92ZXI/IERvIHdlIGhhdmUgbG9ncyB0byBoZWxwIHZpc3VhbGl6
ZSA8YnI+CnRoaXM/PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlNvcnJ5IEkg
aGF2ZSBubyBsb2dzLjwvZGl2PjxkaXY+SSB0aGluayBhbiBleGFtcGxlIHdvdWxkIGJlOzwvZGl2
PjxkaXY+TGV0IHNheSB3ZSBhcmUgcmVnaXN0ZXJlZCBvbiBub24tTFRFLCBhbmQgR1BSUyBkbyBh
dHRhY2guPC9kaXY+PGRpdj5UaGVuIHdlIGZsaXAgdG8gTFRFIGFuZCBpZiBHUFJTIGdldHMgZGUt
YXR0YWNoZWQuIFdlIHdvdWxkIGJydXRhbGx5PC9kaXY+PGRpdj5leGl0IHRoZSBhdHRhY2hlZCBz
dGF0ZSwgc2luY2UgTFRFIGlzIGN1cnJlbnRseSBub3QgY29uc2lkZXJlZCBpbiB0aGF0IGNvZGUg
cGF0aC48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CiZndDsgLS0tPGJyPgomZ3Q7wqAg
wqBzcmMvZ3Bycy5jIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLTxicj4KJmd0O8KgIMKgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMo
KyksIDIzIGRlbGV0aW9ucygtKTxicj4KJmd0OyA8YnI+CiZndDsgZGlmZiAtLWdpdCBhL3NyYy9n
cHJzLmMgYi9zcmMvZ3Bycy5jPGJyPgomZ3Q7IGluZGV4IGJiYTQ4MmNiLi45NGQxM2Y4MiAxMDA2
NDQ8YnI+CiZndDsgLS0tIGEvc3JjL2dwcnMuYzxicj4KJmd0OyArKysgYi9zcmMvZ3Bycy5jPGJy
PgomZ3Q7IEBAIC0xNTcxLDEzICsxNTcxLDM0IEBAIHN0YXRpYyB2b2lkIHJlbGVhc2VfYWN0aXZl
X2NvbnRleHRzKHN0cnVjdCBvZm9ub19ncHJzICpncHJzKTxicj4KJmd0O8KgIMKgIMKgIMKgfTxi
cj4KJmd0O8KgIMKgfTxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7ICtzdGF0aWMgZ2Jvb2xlYW4gb25f
bHRlKHN0cnVjdCBvZm9ub19ncHJzICpncHJzKTxicj4KJmd0OyArezxicj4KJmd0OyArwqAgwqAg
wqBpZiAob2Zvbm9fbmV0cmVnX2dldF90ZWNobm9sb2d5KGdwcnMtJmd0O25ldHJlZykgPT08YnI+
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQUNDRVNTX1RFQ0hOT0xPR1lf
RVVUUkFOICZhbXA7JmFtcDsgaGF2ZV9yZWFkX3NldHRpbmdzKGdwcnMpKTxicj4KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gVFJVRTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAg
wqByZXR1cm4gRkFMU0U7PGJyPgomZ3Q7ICt9PGJyPgomZ3Q7ICs8YnI+CiZndDvCoCDCoHN0YXRp
YyB2b2lkIGdwcnNfYXR0YWNoZWRfdXBkYXRlKHN0cnVjdCBvZm9ub19ncHJzICpncHJzKTxicj4K
Jmd0O8KgIMKgezxicj4KJmd0O8KgIMKgIMKgIMKgb2Zvbm9fYm9vbF90IGF0dGFjaGVkOzxicj4K
Jmd0OyArwqAgwqAgwqBpbnQgc3RhdHVzID0gZ3Bycy0mZ3Q7c3RhdHVzOzxicj4KJmd0O8KgIMKg
PGJyPgomZ3Q7IC3CoCDCoCDCoGF0dGFjaGVkID0gZ3Bycy0mZ3Q7ZHJpdmVyX2F0dGFjaGVkICZh
bXA7JmFtcDs8YnI+CiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgKGdwcnMtJmd0O3N0YXR1cyA9
PSBORVRXT1JLX1JFR0lTVFJBVElPTl9TVEFUVVNfUkVHSVNURVJFRCB8fDxicj4KJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBncHJzLSZndDtzdGF0dXMgPT0gTkVUV09SS19S
RUdJU1RSQVRJT05fU1RBVFVTX1JPQU1JTkcpOzxicj4KJmd0OyArwqAgwqAgwqBpZiAob25fbHRl
KGdwcnMpKTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAvKjxicj4KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgKiBGb3IgTFRFIHdlIGF0dGFjaGVkIHN0YXR1cyByZWZsZWN0cyBzdWNj
ZXNzZnVsIGNvbnRleHQ8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICogYWN0aXZhdGlv
bi48YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICogU2luY2Ugd2UgaW4gZ3Byc19uZXRy
ZWdfdXBkYXRlIG5vdCBldmVuIHRyeSB0byBhdHRhY2g8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgICogdG8gR1BSUyBpZiB3ZSBhcmUgcnVubmluZyBvbiBMVEUsIHdlIGNhbiBvbiBzb21l
IG1vZGVtczxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBleHBlY3QgdGhlIGdwcnMg
c3RhdHVzIHRvIGJlIHVua25vd24uIFRoYXQgbXVzdCBub3Q8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgICogcmVzdWx0IGluIGRldGFjaGluZy4uLjxicj4KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqAgKi88YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYXR0YWNoZWQgPSBoYXZl
X2FjdGl2ZV9jb250ZXh0cyhncHJzKTs8YnI+Cjxicj4KT24gTFRFIEF0dGFjaGVkIHNob3VsZCBq
dXN0IGJlIGFsd2F5cyBUcnVlLsKgIFNvbWVvbmUgY2FuIGNvcnJlY3QgbWUgaWYgPGJyPgpJJiMz
OTttIHdyb25nLCBidXQgYSBkZWZhdWx0IGNvbnRleHQgaXMgYSBwcmUtcmVxdWlzaXRlIGZvciBF
LVVUUkFOIGF0dGFjaG1lbnQuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkg
Z3Vlc3MgdGhpcyBpcyBhYm91dCByYWNlIGNvbmRpdGlvbnMsIHNpbmNlIHdlIHJlYWQgYmFjayBz
ZXR0aW5ncyBvZiB0aGUgY29udGV4dCw8L2Rpdj48ZGl2PnNvIGluIHRoZW9yeSBJIHRoaW5rIHdl
IG1pZ2h0IG5vdCBjb25zaWRlciB0aGUgY29udGV4dCBhdmFpbGFibGUgeWV0LiBTaG91bGQgYmU8
L2Rpdj48ZGl2PmEgdmVyeSBzaG9ydCBwZXJpb2Qgb2YgdGltZS48L2Rpdj48ZGl2PkluIG5ldHJl
ZyBzdGF0dXMgd2UgZG8gbm90IGltbWVkaWF0ZWx5IGNoYW5nZSB0byBhdHRhY2hlZCBpbiBjYXNl
IG9mPC9kaXY+PGRpdj5MVEUsIHdlIHJlcXVpcmUgdGhlIGNvbnRleHQgc2V0dGluZ3MgdG8gaGF2
ZSBiZWVuIHJlYWQgZmlyc3QuPC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDox
cHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgomZ3Q7ICvC
oCDCoCDCoGVsc2U8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYXR0YWNoZWQgPSBncHJz
LSZndDtkcml2ZXJfYXR0YWNoZWQgJmFtcDsmYW1wOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAoc3RhdHVzID09IE5FVFdPUktfUkVHSVNUUkFUSU9OX1NUQVRVU19S
RUdJU1RFUkVEIHx8PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHN0YXR1cyA9PSBORVRXT1JLX1JFR0lTVFJBVElPTl9TVEFUVVNfUk9BTUlORyk7
PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDCoCDCoCDCoGlmIChhdHRhY2hlZCA9PSBncHJzLSZn
dDthdHRhY2hlZCk8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjs8YnI+CiZn
dDsgQEAgLTE1OTEsMTEgKzE2MTIsMTQgQEAgc3RhdGljIHZvaWQgZ3Byc19hdHRhY2hlZF91cGRh
dGUoc3RydWN0IG9mb25vX2dwcnMgKmdwcnMpPGJyPgomZ3Q7wqAgwqAgwqAgwqBpZiAoYXR0YWNo
ZWQgPT0gRkFMU0UpIHs8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlbGVhc2VfYWN0
aXZlX2NvbnRleHRzKGdwcnMpOzxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ3Bycy0m
Z3Q7YmVhcmVyID0gLTE7PGJyPgomZ3Q7IC3CoCDCoCDCoH0gZWxzZSBpZiAoaGF2ZV9hY3RpdmVf
Y29udGV4dHMoZ3BycykgPT0gVFJVRSkgezxicj4KJmd0OyArwqAgwqAgwqB9IGVsc2UgaWYgKGhh
dmVfYWN0aXZlX2NvbnRleHRzKGdwcnMpID09IFRSVUUgJmFtcDsmYW1wOzxicj4KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAhb25fbHRlKGdwcnMpKSB7PGJyPgo8YnI+Ck5vdCBvdXIgc3R5bGUu
wqAgU2VlIGl0ZW0gTTQuwqAgTWlnaHQgd2FudCB0byBzZWUgaWYgaXQgZml0cyBvbiB0aGUgPGJy
PgpwcmV2aW91cyBsaW5lLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5XaWxs
IHVwZGF0ITwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJn
YigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgLyo8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIFNvbWUgdGltZXMg
dGhlIGNvbnRleHQgYWN0aXZhdGVzIGFmdGVyIGEgZGV0YWNoIGV2ZW50IGFuZDxicj4KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICogcmlnaHQgYmVmb3JlIGFuIGF0dGFjaC4gV2UgY2xvc2Ug
aXQgdG8gYXZvaWQgdW5leHBlY3RlZCBvcGVuPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgKiBjb250ZXh0cy48YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICogU2tpcCB0aGF0
IGZvciBMVEUgc2luY2UgdGhlIGNvbmRpdGlvbiB0byBiZSBhdHRhY2hlZCBvbiBMVEU8YnI+CiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICogaXMgdGhhdCBhIGNvbnRleHQgZ2V0cyBhY3RpdmF0
ZWQ8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqLzxicj4KJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmVsZWFzZV9hY3RpdmVfY29udGV4dHMoZ3Bycyk7PGJyPgomZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBncHJzLSZndDtmbGFncyB8PSBHUFJTX0ZMQUdfQVRUQUNIRURfVVBE
QVRFOzxicj4KJmd0OyBAQCAtMTY2MCwxNSArMTY4NCw2IEBAIHN0YXRpYyB2b2lkIGdwcnNfbmV0
cmVnX3JlbW92ZWQoc3RydWN0IG9mb25vX2dwcnMgKmdwcnMpPGJyPgomZ3Q7wqAgwqAgwqAgwqBn
cHJzX2F0dGFjaGVkX3VwZGF0ZShncHJzKTs8YnI+CiZndDvCoCDCoH08YnI+CiZndDvCoCDCoDxi
cj4KJmd0OyAtc3RhdGljIGdib29sZWFuIG9uX2x0ZShzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Bycyk8
YnI+CiZndDsgLXs8YnI+CiZndDsgLcKgIMKgIMKgaWYgKG9mb25vX25ldHJlZ19nZXRfdGVjaG5v
bG9neShncHJzLSZndDtuZXRyZWcpID09PGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoEFDQ0VTU19URUNITk9MT0dZX0VVVFJBTiAmYW1wOyZhbXA7IGhhdmVfcmVhZF9z
ZXR0aW5ncyhncHJzKSk8YnI+CiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIFRSVUU7
PGJyPgomZ3Q7IC08YnI+CiZndDsgLcKgIMKgIMKgcmV0dXJuIEZBTFNFOzxicj4KJmd0OyAtfTxi
cj4KJmd0OyAtPGJyPgomZ3Q7wqAgwqBzdGF0aWMgdm9pZCBncHJzX25ldHJlZ191cGRhdGUoc3Ry
dWN0IG9mb25vX2dwcnMgKmdwcnMpPGJyPgomZ3Q7wqAgwqB7PGJyPgomZ3Q7wqAgwqAgwqAgwqBv
Zm9ub19ib29sX3QgYXR0YWNoOzxicj4KJmd0OyBAQCAtMjU3MywxNiArMjU4OCw3IEBAIHZvaWQg
b2Zvbm9fZ3Byc19zdGF0dXNfbm90aWZ5KHN0cnVjdCBvZm9ub19ncHJzICpncHJzLCBpbnQgc3Rh
dHVzKTxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqAgwqAgwqBpZiAoc3RhdHVzICE9IE5FVFdP
UktfUkVHSVNUUkFUSU9OX1NUQVRVU19SRUdJU1RFUkVEICZhbXA7JmFtcDs8YnI+CiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyAhPSBORVRXT1JLX1JFR0lTVFJB
VElPTl9TVEFUVVNfUk9BTUlORykgezxicj4KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAvKjxi
cj4KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBGb3IgTFRFIHdlIGF0dGFjaGVkIHN0YXR1
cyByZWZsZWN0cyBzdWNjZXNzZnVsIGNvbnRleHQ8YnI+CiZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IMKgICogYWN0aXZhdGlvbi48YnI+CiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgICogU2luY2Ug
d2UgaW4gZ3Byc19uZXRyZWdfdXBkYXRlIG5vdCBldmVuIHRyeSB0byBhdHRhY2g8YnI+CiZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgICogdG8gR1BSUyBpZiB3ZSBhcmUgcnVubmluZyBvbiBMVEUs
IHdlIGNhbiBvbiBzb21lIG1vZGVtczxicj4KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBl
eHBlY3QgdGhlIGdwcnMgc3RhdHVzIHRvIGJlIHVua25vd24uIFRoYXQgbXVzdCBub3Q8YnI+CiZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgICogcmVzdWx0IGluIGRldGFjaGluZy4uLjxicj4KJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi88YnI+CiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgKCFvbl9sdGUoZ3BycykpPGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGdwcnNfYXR0YWNoZWRfdXBkYXRlKGdwcnMpOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqBncHJzX2F0dGFjaGVkX3VwZGF0ZShncHJzKTs8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybjs8YnI+CiZndDvCoCDCoCDCoCDCoH08YnI+CiZndDvCoCDCoDxicj4KJmd0
OyA8YnI+Cjxicj4KT3RoZXJ3aXNlIEkmIzM5O20gZmluZSBtb3ZpbmcgdGhlIG9uX2x0ZSBsb2dp
YyBpbnRvIGdwcnNfYXR0YWNoZWRfdXBkYXRlIDxicj4KaXRzZWxmLi4uPGJyPgo8YnI+ClJlZ2Fy
ZHMsPGJyPgotRGVuaXM8YnI+CjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4K

--===============1334563842029097728==--

