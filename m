Content-Type: multipart/mixed; boundary="===============1142154867401645099=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH 1/2] gprs: Ignore activated contexts during init,
 list them later
Date: Mon, 12 Aug 2019 20:41:54 +0200
Message-ID: <CAHB-Pjnq8mGvJKYZY_j-0eQtbtd3VDfo_YuLk0PhYB-P8B-HOw@mail.gmail.com>
In-Reply-To: <1ddfad22-c661-0faf-11e3-d4f107fdfc37@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1142154867401645099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den m=C3=A5n 12 aug. 2019 kl 19:10 skrev Denis Kenzior <denkenz@gmail.com=
>:

> Hi Richard,
>
> On 8/11/19 11:46 AM, richard.rojfors(a)gmail.com wrote:
> > From: Richard R=C3=B6jfors <richard@puffinpack.se>
> >
> > There is an issue if an context gets auto activated early,
> > then provisioning might not have run yet for instance,
> > so a "new" context is created, which might be duplicated
> > by a provisioning context later.
> > So ignore the activated contexts until gprs is ready,
> > then it calls the driver to list active contexts.
> > ---
> >   include/gprs.h |  7 +++++++
> >   src/gprs.c     | 24 ++++++++++++++++++++++++
> >   2 files changed, 31 insertions(+)
> >
> > diff --git a/include/gprs.h b/include/gprs.h
> > index 988d6102..38e3c508 100644
> > --- a/include/gprs.h
> > +++ b/include/gprs.h
> > @@ -36,6 +36,10 @@ typedef void (*ofono_gprs_status_cb_t)(const struct
> ofono_error *error,
> >
> >   typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void
> *data);
> >
> > +typedef void (*ofono_gprs_active_context_cb_t)(const struct ofono_error
> *error,
> > +                                             int cid, const char *apn,
> > +                                             void *data);
>
> This assumes just one is active?  That doesn't have to be the case...
>

Well I was thinking of that. But can more that one get auto activated?
But I agree its more generic to support more than one. Then it could
be used in other cases too.


>
> > +
> >   struct ofono_gprs_driver {
> >       const char *name;
> >       int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
> > @@ -45,6 +49,9 @@ struct ofono_gprs_driver {
> >                               ofono_gprs_cb_t cb, void *data);
> >       void (*attached_status)(struct ofono_gprs *gprs,
> >                                       ofono_gprs_status_cb_t cb, void
> *data);
> > +     void (*get_active_auto_context)(struct ofono_gprs *gprs,
> > +                                     ofono_gprs_active_context_cb_t cb,
> > +                                     void *data);
>
> list_active_contexts?  Also, since there can in theory be multiple ones
> of these, I'd do something like:
>
> typedef void (*ofono_gprs_active_context_cb_t)(int cid, const char *apn,
>                                                 void *data);
>
> void (*list_active_contexts)(struct ofono_gprs *gprs,
>                         ofono_gprs_active_context_cb_t active_cb,
>                         ofono_gprs_cb_t finished_cb);
>
> Nice solution, I assume we call the callback multiple times.
And if none is found we still call it once with -1 and null, right?


> >   };
> >
>
> The include/ portion should be a separate commit.
>
> >   enum gprs_suspend_cause {
> > diff --git a/src/gprs.c b/src/gprs.c
> > index 9cb69d14..05b413c5 100644
> > --- a/src/gprs.c
> > +++ b/src/gprs.c
> > @@ -1959,6 +1959,11 @@ void ofono_gprs_cid_activated(struct ofono_gprs
> *gprs, unsigned int cid,
> >
> >       DBG("");
> >
> > +     if (!__ofono_atom_get_registered(gprs->atom)) {
> > +             DBG("cid %u activated before atom registered", cid);
> > +             return;
> > +     }
> > +
> >       if (l_uintset_contains(gprs->used_cids, cid)) {
> >               DBG("cid %u already activated", cid);
> >               return;
> > @@ -3338,11 +3343,24 @@ remove:
> >               storage_sync(imsi, SETTINGS_STORE, gprs->settings);
> >   }
> >
> > +static void gprs_get_active_context_callback(const struct ofono_error
> *error,
> > +                                             int cid, const char *apn,
> > +                                             void *data)
> > +{
> > +     struct ofono_gprs *gprs =3D data;
> > +
> > +     DBG("error =3D %d", error->type);
> > +
> > +     if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR && apn !=3D NULL=
 && cid
> > 0)
> > +             ofono_gprs_cid_activated(gprs, cid, apn);
> > +}
> > +
> >   static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
> >   {
> >       DBusConnection *conn =3D ofono_dbus_get_connection();
> >       struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
> >       const char *path =3D __ofono_atom_get_path(gprs->atom);
> > +     const struct ofono_gprs_driver *drv =3D gprs->driver;
> >
> >       if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed =
*/
> >               add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
> > @@ -3366,6 +3384,12 @@ static void ofono_gprs_finish_register(struct
> ofono_gprs *gprs)
> >                                       netreg_watch, gprs, NULL);
> >
> >       __ofono_atom_register(gprs->atom, gprs_unregister);
> > +
> > +     /* Find any context activated during init */
> > +     if (drv->get_active_auto_context)
> > +             drv->get_active_auto_context(gprs,
> > +
>  gprs_get_active_context_callback,
> > +                                           gprs);
> >   }
> >
> >   static void spn_read_cb(const char *spn, const char *dc, void *data)
> >
>
> Regards,
> -Denis
>

--===============1142154867401645099==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPC9kaXY+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+RGVuIG3D
pW4gMTIgYXVnLiAyMDE5IGtsIDE5OjEwIHNrcmV2IERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9
Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozo8YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPkhpIFJpY2hhcmQsPGJyPgo8YnI+Ck9uIDgvMTEvMTkgMTE6NDYgQU0sIDxh
IGhyZWY9Im1haWx0bzpyaWNoYXJkLnJvamZvcnNAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+
cmljaGFyZC5yb2pmb3JzQGdtYWlsLmNvbTwvYT4gd3JvdGU6PGJyPgomZ3Q7IEZyb206IFJpY2hh
cmQgUsO2amZvcnMgJmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkQHB1ZmZpbnBhY2suc2UiIHRh
cmdldD0iX2JsYW5rIj5yaWNoYXJkQHB1ZmZpbnBhY2suc2U8L2E+Jmd0Ozxicj4KJmd0OyA8YnI+
CiZndDsgVGhlcmUgaXMgYW4gaXNzdWUgaWYgYW4gY29udGV4dCBnZXRzIGF1dG8gYWN0aXZhdGVk
IGVhcmx5LDxicj4KJmd0OyB0aGVuIHByb3Zpc2lvbmluZyBtaWdodCBub3QgaGF2ZSBydW4geWV0
IGZvciBpbnN0YW5jZSw8YnI+CiZndDsgc28gYSAmcXVvdDtuZXcmcXVvdDsgY29udGV4dCBpcyBj
cmVhdGVkLCB3aGljaCBtaWdodCBiZSBkdXBsaWNhdGVkPGJyPgomZ3Q7IGJ5IGEgcHJvdmlzaW9u
aW5nIGNvbnRleHQgbGF0ZXIuPGJyPgomZ3Q7IFNvIGlnbm9yZSB0aGUgYWN0aXZhdGVkIGNvbnRl
eHRzIHVudGlsIGdwcnMgaXMgcmVhZHksPGJyPgomZ3Q7IHRoZW4gaXQgY2FsbHMgdGhlIGRyaXZl
ciB0byBsaXN0IGFjdGl2ZSBjb250ZXh0cy48YnI+CiZndDsgLS0tPGJyPgomZ3Q7wqAgwqBpbmNs
dWRlL2dwcnMuaCB8wqAgNyArKysrKysrPGJyPgomZ3Q7wqAgwqBzcmMvZ3Bycy5jwqAgwqAgwqB8
IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKzxicj4KJmd0O8KgIMKgMiBmaWxlcyBjaGFuZ2Vk
LCAzMSBpbnNlcnRpb25zKCspPGJyPgomZ3Q7IDxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ncHJzLmggYi9pbmNsdWRlL2dwcnMuaDxicj4KJmd0OyBpbmRleCA5ODhkNjEwMi4uMzhlM2M1
MDggMTAwNjQ0PGJyPgomZ3Q7IC0tLSBhL2luY2x1ZGUvZ3Bycy5oPGJyPgomZ3Q7ICsrKyBiL2lu
Y2x1ZGUvZ3Bycy5oPGJyPgomZ3Q7IEBAIC0zNiw2ICszNiwxMCBAQCB0eXBlZGVmIHZvaWQgKCpv
Zm9ub19ncHJzX3N0YXR1c19jYl90KShjb25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLDxi
cj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqB0eXBlZGVmIHZvaWQgKCpvZm9ub19ncHJzX2NiX3Qp
KGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJyb3IsIHZvaWQgKmRhdGEpOzxicj4KJmd0O8Kg
IMKgPGJyPgomZ3Q7ICt0eXBlZGVmIHZvaWQgKCpvZm9ub19ncHJzX2FjdGl2ZV9jb250ZXh0X2Ni
X3QpKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJyb3IsPGJyPgomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGludCBjaWQsIGNvbnN0IGNoYXIgKmFwbiw8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdm9pZCAqZGF0
YSk7PGJyPgo8YnI+ClRoaXMgYXNzdW1lcyBqdXN0IG9uZSBpcyBhY3RpdmU/wqAgVGhhdCBkb2Vz
biYjMzk7dCBoYXZlIHRvIGJlIHRoZSBjYXNlLi4uPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48
L2Rpdj48ZGl2PldlbGwgSSB3YXMgdGhpbmtpbmcgb2YgdGhhdC4gQnV0IGNhbiBtb3JlIHRoYXQg
b25lIGdldCBhdXRvIGFjdGl2YXRlZD88L2Rpdj48ZGl2PkJ1dCBJIGFncmVlIGl0cyBtb3JlIGdl
bmVyaWMgdG8gc3VwcG9ydCBtb3JlIHRoYW4gb25lLiBUaGVuIGl0IGNvdWxkPC9kaXY+PGRpdj5i
ZSB1c2VkIGluIG90aGVyIGNhc2VzIHRvby48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRl
ci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+
CiZndDsgKzxicj4KJmd0O8KgIMKgc3RydWN0IG9mb25vX2dwcnNfZHJpdmVyIHs8YnI+CiZndDvC
oCDCoCDCoCDCoGNvbnN0IGNoYXIgKm5hbWU7PGJyPgomZ3Q7wqAgwqAgwqAgwqBpbnQgKCpwcm9i
ZSkoc3RydWN0IG9mb25vX2dwcnMgKmdwcnMsIHVuc2lnbmVkIGludCB2ZW5kb3IsPGJyPgomZ3Q7
IEBAIC00NSw2ICs0OSw5IEBAIHN0cnVjdCBvZm9ub19ncHJzX2RyaXZlciB7PGJyPgomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvZm9ub19ncHJzX2Ni
X3QgY2IsIHZvaWQgKmRhdGEpOzxicj4KJmd0O8KgIMKgIMKgIMKgdm9pZCAoKmF0dGFjaGVkX3N0
YXR1cykoc3RydWN0IG9mb25vX2dwcnMgKmdwcnMsPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvZm9ub19ncHJzX3N0YXR1
c19jYl90IGNiLCB2b2lkICpkYXRhKTs8YnI+CiZndDsgK8KgIMKgIMKgdm9pZCAoKmdldF9hY3Rp
dmVfYXV0b19jb250ZXh0KShzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Bycyw8YnI+CiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb2Zvbm9f
Z3Byc19hY3RpdmVfY29udGV4dF9jYl90IGNiLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2b2lkICpkYXRhKTs8YnI+Cjxi
cj4KbGlzdF9hY3RpdmVfY29udGV4dHM/wqAgQWxzbywgc2luY2UgdGhlcmUgY2FuIGluIHRoZW9y
eSBiZSBtdWx0aXBsZSBvbmVzIDxicj4Kb2YgdGhlc2UsIEkmIzM5O2QgZG8gc29tZXRoaW5nIGxp
a2U6PGJyPgo8YnI+CnR5cGVkZWYgdm9pZCAoKm9mb25vX2dwcnNfYWN0aXZlX2NvbnRleHRfY2Jf
dCkoaW50IGNpZCwgY29uc3QgY2hhciAqYXBuLDxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdm9pZCAqZGF0
YSk7PGJyPgo8YnI+CnZvaWQgKCpsaXN0X2FjdGl2ZV9jb250ZXh0cykoc3RydWN0IG9mb25vX2dw
cnMgKmdwcnMsPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBvZm9ub19n
cHJzX2FjdGl2ZV9jb250ZXh0X2NiX3QgYWN0aXZlX2NiLDxicj4KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgb2Zvbm9fZ3Byc19jYl90IGZpbmlzaGVkX2NiKTs8YnI+Cjxicj48
L2Jsb2NrcXVvdGU+PGRpdj5OaWNlIHNvbHV0aW9uLCBJIGFzc3VtZSB3ZSBjYWxsIHRoZSBjYWxs
YmFjayBtdWx0aXBsZSB0aW1lcy48L2Rpdj48ZGl2PkFuZCBpZiBub25lIGlzIGZvdW5kIHdlIHN0
aWxsIGNhbGwgaXQgb25jZSB3aXRoIC0xIGFuZCBudWxsLCByaWdodD88L2Rpdj48ZGl2PsKgPC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPgomZ3Q7wqAgwqB9Ozxicj4KJmd0O8KgIMKgPGJyPgo8YnI+ClRoZSBpbmNsdWRl
LyBwb3J0aW9uIHNob3VsZCBiZSBhIHNlcGFyYXRlIGNvbW1pdC48YnI+Cjxicj4KJmd0O8KgIMKg
ZW51bSBncHJzX3N1c3BlbmRfY2F1c2Ugezxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvc3JjL2dwcnMu
YyBiL3NyYy9ncHJzLmM8YnI+CiZndDsgaW5kZXggOWNiNjlkMTQuLjA1YjQxM2M1IDEwMDY0NDxi
cj4KJmd0OyAtLS0gYS9zcmMvZ3Bycy5jPGJyPgomZ3Q7ICsrKyBiL3NyYy9ncHJzLmM8YnI+CiZn
dDsgQEAgLTE5NTksNiArMTk1OSwxMSBAQCB2b2lkIG9mb25vX2dwcnNfY2lkX2FjdGl2YXRlZChz
dHJ1Y3Qgb2Zvbm9fZ3Byc8KgICpncHJzLCB1bnNpZ25lZCBpbnQgY2lkLDxicj4KJmd0O8KgIMKg
PGJyPgomZ3Q7wqAgwqAgwqAgwqBEQkcoJnF1b3Q7JnF1b3Q7KTs8YnI+CiZndDvCoCDCoDxicj4K
Jmd0OyArwqAgwqAgwqBpZiAoIV9fb2Zvbm9fYXRvbV9nZXRfcmVnaXN0ZXJlZChncHJzLSZndDth
dG9tKSkgezxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBEQkcoJnF1b3Q7Y2lkICV1IGFj
dGl2YXRlZCBiZWZvcmUgYXRvbSByZWdpc3RlcmVkJnF1b3Q7LCBjaWQpOzxicj4KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPgomZ3Q7ICvCoCDCoCDCoH08YnI+CiZndDsgKzxi
cj4KJmd0O8KgIMKgIMKgIMKgaWYgKGxfdWludHNldF9jb250YWlucyhncHJzLSZndDt1c2VkX2Np
ZHMsIGNpZCkpIHs8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERCRygmcXVvdDtjaWQg
JXUgYWxyZWFkeSBhY3RpdmF0ZWQmcXVvdDssIGNpZCk7PGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm47PGJyPgomZ3Q7IEBAIC0zMzM4LDExICszMzQzLDI0IEBAIHJlbW92ZTo8
YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0b3JhZ2Vfc3luYyhpbXNpLCBTRVRUSU5H
U19TVE9SRSwgZ3Bycy0mZ3Q7c2V0dGluZ3MpOzxicj4KJmd0O8KgIMKgfTxicj4KJmd0O8KgIMKg
PGJyPgomZ3Q7ICtzdGF0aWMgdm9pZCBncHJzX2dldF9hY3RpdmVfY29udGV4dF9jYWxsYmFjayhj
b25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQg
Y2lkLCBjb25zdCBjaGFyICphcG4sPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZvaWQgKmRhdGEpPGJy
PgomZ3Q7ICt7PGJyPgomZ3Q7ICvCoCDCoCDCoHN0cnVjdCBvZm9ub19ncHJzICpncHJzID0gZGF0
YTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBEQkcoJnF1b3Q7ZXJyb3IgPSAlZCZxdW90
OywgZXJyb3ItJmd0O3R5cGUpOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGlmIChlcnJv
ci0mZ3Q7dHlwZSA9PSBPRk9OT19FUlJPUl9UWVBFX05PX0VSUk9SICZhbXA7JmFtcDsgYXBuICE9
IE5VTEwgJmFtcDsmYW1wOyBjaWQgJmd0OyAwKTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqBvZm9ub19ncHJzX2NpZF9hY3RpdmF0ZWQoZ3BycywgY2lkLCBhcG4pOzxicj4KJmd0OyArfTxi
cj4KJmd0OyArPGJyPgomZ3Q7wqAgwqBzdGF0aWMgdm9pZCBvZm9ub19ncHJzX2ZpbmlzaF9yZWdp
c3RlcihzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Bycyk8YnI+CiZndDvCoCDCoHs8YnI+CiZndDvCoCDC
oCDCoCDCoERCdXNDb25uZWN0aW9uICpjb25uID0gb2Zvbm9fZGJ1c19nZXRfY29ubmVjdGlvbigp
Ozxicj4KJmd0O8KgIMKgIMKgIMKgc3RydWN0IG9mb25vX21vZGVtICptb2RlbSA9IF9fb2Zvbm9f
YXRvbV9nZXRfbW9kZW0oZ3Bycy0mZ3Q7YXRvbSk7PGJyPgomZ3Q7wqAgwqAgwqAgwqBjb25zdCBj
aGFyICpwYXRoID0gX19vZm9ub19hdG9tX2dldF9wYXRoKGdwcnMtJmd0O2F0b20pOzxicj4KJmd0
OyArwqAgwqAgwqBjb25zdCBzdHJ1Y3Qgb2Zvbm9fZ3Byc19kcml2ZXIgKmRydiA9IGdwcnMtJmd0
O2RyaXZlcjs8YnI+CiZndDvCoCDCoDxicj4KJmd0O8KgIMKgIMKgIMKgaWYgKGdwcnMtJmd0O2Nv
bnRleHRzID09IE5VTEwpIC8qIEF1dG9tYXRpYyBwcm92aXNpb25pbmcgZmFpbGVkICovPGJyPgom
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhZGRfY29udGV4dChncHJzLCBOVUxMLCBPRk9OT19H
UFJTX0NPTlRFWFRfVFlQRV9JTlRFUk5FVCk7PGJyPgomZ3Q7IEBAIC0zMzY2LDYgKzMzODQsMTIg
QEAgc3RhdGljIHZvaWQgb2Zvbm9fZ3Byc19maW5pc2hfcmVnaXN0ZXIoc3RydWN0IG9mb25vX2dw
cnMgKmdwcnMpPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBuZXRyZWdfd2F0Y2gsIGdwcnMsIE5VTEwpOzxicj4KJmd0O8Kg
IMKgPGJyPgomZ3Q7wqAgwqAgwqAgwqBfX29mb25vX2F0b21fcmVnaXN0ZXIoZ3Bycy0mZ3Q7YXRv
bSwgZ3Byc191bnJlZ2lzdGVyKTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAvKiBGaW5k
IGFueSBjb250ZXh0IGFjdGl2YXRlZCBkdXJpbmcgaW5pdCAqLzxicj4KJmd0OyArwqAgwqAgwqBp
ZiAoZHJ2LSZndDtnZXRfYWN0aXZlX2F1dG9fY29udGV4dCk8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgZHJ2LSZndDtnZXRfYWN0aXZlX2F1dG9fY29udGV4dChncHJzLDxicj4KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBncHJzX2dldF9hY3RpdmVfY29udGV4dF9jYWxsYmFjayw8YnI+CiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZ3Bycyk7PGJyPgomZ3Q7wqAgwqB9PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDCoHN0YXRp
YyB2b2lkIHNwbl9yZWFkX2NiKGNvbnN0IGNoYXIgKnNwbiwgY29uc3QgY2hhciAqZGMsIHZvaWQg
KmRhdGEpPGJyPgomZ3Q7IDxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Jsb2Nr
cXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============1142154867401645099==--

