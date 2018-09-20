Content-Type: multipart/mixed; boundary="===============3050577484902196917=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 2/7] extended support for LTE and NR. Some minor fixes.
 part 2 of 7
Date: Thu, 20 Sep 2018 18:07:38 +0200
Message-ID: <CAKSBH7Ftoq2DPS__76jiucqZ_U179sjWdgNr5s3wzmsHNGD_Ag@mail.gmail.com>
In-Reply-To: <1eb977ba-e4be-b6c8-11fb-9059ad2256cd@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3050577484902196917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

sorry for writing on top, but I don't see a good place in the middle.

The idea would be to just store the values in the driver but not in the
module,
and then send them before attaching, so that the verification can be
consistent and all,
just like for the gprs-context atom.

so the idea would be to check if a new method, that I have tentatively
called set_property(),
exists. If so, use the reviewed stile above, otherwise fallback to the
current function.

Giacinto

On Thu, Sep 20, 2018 at 6:03 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> > static DBusMessage *lte_set_property(DBusConnection *conn,
> > DBusMessage *msg, void *data)
> > {
> > [...]
> > if (lte->driver->set_property)
> > lte->driver->set_property(...);
>

> What is this buying you?
>
> > else if (lte->driver->set_default_attach_info)
> > lte->driver->set_default_attach_info(...);
> > else
> > return __ofono_error_not_implemented(msg);
> > [...]
> >
> > in src/modem.c:
> >
> > static void sim_state_watch(enum ofono_sim_state new_state, void *user)
> > {
> > [...]
> > case OFONO_SIM_STATE_READY:
> > modem_change_state(modem, MODEM_STATE_OFFLINE);
> >
> > ofono_lte_set_reginfo(modem);
>
> How does this help you?  You might be in the OFFLINE state for a while
> and the LTE settings might still be messed with in that time.
>
> >
> > /* Modem is always online, proceed to online state. */
> > if (modem_is_always_online(modem) =3D=3D TRUE)
> > set_online(modem, TRUE);
> >
> > if (modem->online =3D=3D TRUE)
> > modem_change_state(modem, MODEM_STATE_ONLINE);
> > else if (modem->get_online)
> > modem->driver->set_online(modem, 1, common_online_cb,
> > modem);
> >
> > modem->get_online =3D FALSE;
> >
> > break;
> > }
> >
> > I see that if(modem_is_always_online) maybe it will come too late, but
> > in that case also the current solution
> > with set_default_attach_info suffers from the same limitation, so no
> > regression.
>
> The modem_is_always_online case is a bit strange, it is for really
> primitive devices which likely won't have an LTE atom anyway.
>
> >
> > Of course then, again in src/lte.c, the function ofono_lte_set_reginfo
> > will look for an lte atom, if present will call it without parameter for
> > sending the AT+CGDCONT and AT+CGAUTH to the modem.
> >
> > Would this work for you?
> >
>
> I don't see how this helps.
>
> Regards,
> -Denis
>

--===============3050577484902196917==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGRpdj48YnI+PC9kaXY+PGRpdj5zb3JyeSBmb3Igd3Jp
dGluZyBvbiB0b3AsIGJ1dCBJIGRvbiYjMzk7dCBzZWUgYSBnb29kIHBsYWNlIGluIHRoZSBtaWRk
bGUuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgaWRlYSB3b3VsZCBiZSB0byBqdXN0IHN0
b3JlIHRoZSB2YWx1ZXMgaW4gdGhlIGRyaXZlciBidXQgbm90IGluIHRoZSBtb2R1bGUsPC9kaXY+
PGRpdj5hbmQgdGhlbiBzZW5kIHRoZW0gYmVmb3JlIGF0dGFjaGluZywgc28gdGhhdCB0aGUgdmVy
aWZpY2F0aW9uIGNhbiBiZSBjb25zaXN0ZW50IGFuZCBhbGwsPC9kaXY+PGRpdj5qdXN0IGxpa2Ug
Zm9yIHRoZSBncHJzLWNvbnRleHQgYXRvbS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnNvIHRo
ZSBpZGVhIHdvdWxkIGJlIHRvIGNoZWNrIGlmIGEgbmV3IG1ldGhvZCwgdGhhdCBJIGhhdmUgdGVu
dGF0aXZlbHkgY2FsbGVkIHNldF9wcm9wZXJ0eSgpLDwvZGl2PjxkaXY+ZXhpc3RzLiBJZiBzbywg
dXNlIHRoZSByZXZpZXdlZCBzdGlsZSBhYm92ZSwgb3RoZXJ3aXNlIGZhbGxiYWNrIHRvIHRoZSBj
dXJyZW50IGZ1bmN0aW9uLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+R2lhY2ludG88YnI+PGJy
PjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBUaHUsIFNlcCAyMCwg
MjAxOCBhdCA2OjAzIFBNIERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56
QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+SGkgR2lhY2ludG8sPGJy
Pgo8YnI+CiZndDsgc3RhdGljIERCdXNNZXNzYWdlICpsdGVfc2V0X3Byb3BlcnR5KERCdXNDb25u
ZWN0aW9uICpjb25uLDxicj4KJmd0OyBEQnVzTWVzc2FnZSAqbXNnLCB2b2lkICpkYXRhKTxicj4K
Jmd0OyB7PGJyPgomZ3Q7IFsuLi5dPGJyPgomZ3Q7IGlmIChsdGUtJmd0O2RyaXZlci0mZ3Q7c2V0
X3Byb3BlcnR5KTxicj4KJmd0OyBsdGUtJmd0O2RyaXZlci0mZ3Q7c2V0X3Byb3BlcnR5KC4uLik7
PGJyPjwvYmxvY2txdW90ZT48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij48YnI+CldoYXQgaXMgdGhpcyBidXlpbmcgeW91Pzxicj4KPGJyPgomZ3Q7IGVsc2UgaWYg
KGx0ZS0mZ3Q7ZHJpdmVyLSZndDtzZXRfZGVmYXVsdF9hdHRhY2hfaW5mbyk8YnI+CiZndDsgbHRl
LSZndDtkcml2ZXItJmd0O3NldF9kZWZhdWx0X2F0dGFjaF9pbmZvKC4uLik7PGJyPgomZ3Q7IGVs
c2U8YnI+CiZndDsgcmV0dXJuIF9fb2Zvbm9fZXJyb3Jfbm90X2ltcGxlbWVudGVkKG1zZyk7PGJy
PgomZ3Q7IFsuLi5dPGJyPgomZ3Q7IDxicj4KJmd0OyBpbiBzcmMvbW9kZW0uYzo8YnI+CiZndDsg
PGJyPgomZ3Q7IHN0YXRpYyB2b2lkIHNpbV9zdGF0ZV93YXRjaChlbnVtIG9mb25vX3NpbV9zdGF0
ZSBuZXdfc3RhdGUsIHZvaWQgKnVzZXIpPGJyPgomZ3Q7IHs8YnI+CiZndDsgWy4uLl08YnI+CiZn
dDsgY2FzZSBPRk9OT19TSU1fU1RBVEVfUkVBRFk6PGJyPgomZ3Q7IG1vZGVtX2NoYW5nZV9zdGF0
ZShtb2RlbSwgTU9ERU1fU1RBVEVfT0ZGTElORSk7PGJyPgomZ3Q7IDxicj4KJmd0OyBvZm9ub19s
dGVfc2V0X3JlZ2luZm8obW9kZW0pOzxicj4KPGJyPgpIb3cgZG9lcyB0aGlzIGhlbHAgeW91P8Kg
IFlvdSBtaWdodCBiZSBpbiB0aGUgT0ZGTElORSBzdGF0ZSBmb3IgYSB3aGlsZSA8YnI+CmFuZCB0
aGUgTFRFIHNldHRpbmdzIG1pZ2h0IHN0aWxsIGJlIG1lc3NlZCB3aXRoIGluIHRoYXQgdGltZS48
YnI+Cjxicj4KJmd0OyA8YnI+CiZndDsgLyogTW9kZW0gaXMgYWx3YXlzIG9ubGluZSwgcHJvY2Vl
ZCB0byBvbmxpbmUgc3RhdGUuICovPGJyPgomZ3Q7IGlmIChtb2RlbV9pc19hbHdheXNfb25saW5l
KG1vZGVtKSA9PSBUUlVFKTxicj4KJmd0OyBzZXRfb25saW5lKG1vZGVtLCBUUlVFKTs8YnI+CiZn
dDsgPGJyPgomZ3Q7IGlmIChtb2RlbS0mZ3Q7b25saW5lID09IFRSVUUpPGJyPgomZ3Q7IG1vZGVt
X2NoYW5nZV9zdGF0ZShtb2RlbSwgTU9ERU1fU1RBVEVfT05MSU5FKTs8YnI+CiZndDsgZWxzZSBp
ZiAobW9kZW0tJmd0O2dldF9vbmxpbmUpPGJyPgomZ3Q7IG1vZGVtLSZndDtkcml2ZXItJmd0O3Nl
dF9vbmxpbmUobW9kZW0sIDEsIGNvbW1vbl9vbmxpbmVfY2IsPGJyPgomZ3Q7IG1vZGVtKTs8YnI+
CiZndDsgPGJyPgomZ3Q7IG1vZGVtLSZndDtnZXRfb25saW5lID0gRkFMU0U7PGJyPgomZ3Q7IDxi
cj4KJmd0OyBicmVhazs8YnI+CiZndDsgfTxicj4KJmd0OyA8YnI+CiZndDsgSSBzZWUgdGhhdCBp
Zihtb2RlbV9pc19hbHdheXNfb25saW5lKSBtYXliZSBpdCB3aWxsIGNvbWUgdG9vIGxhdGUsIGJ1
dCA8YnI+CiZndDsgaW4gdGhhdCBjYXNlIGFsc28gdGhlIGN1cnJlbnQgc29sdXRpb248YnI+CiZn
dDsgd2l0aCBzZXRfZGVmYXVsdF9hdHRhY2hfaW5mbyBzdWZmZXJzIGZyb20gdGhlIHNhbWUgbGlt
aXRhdGlvbiwgc28gbm8gPGJyPgomZ3Q7IHJlZ3Jlc3Npb24uPGJyPgo8YnI+ClRoZSBtb2RlbV9p
c19hbHdheXNfb25saW5lIGNhc2UgaXMgYSBiaXQgc3RyYW5nZSwgaXQgaXMgZm9yIHJlYWxseSA8
YnI+CnByaW1pdGl2ZSBkZXZpY2VzIHdoaWNoIGxpa2VseSB3b24mIzM5O3QgaGF2ZSBhbiBMVEUg
YXRvbSBhbnl3YXkuPGJyPgo8YnI+CiZndDsgPGJyPgomZ3Q7IE9mIGNvdXJzZSB0aGVuLCBhZ2Fp
biBpbiBzcmMvbHRlLmMsIHRoZSBmdW5jdGlvbiBvZm9ub19sdGVfc2V0X3JlZ2luZm8gPGJyPgom
Z3Q7IHdpbGwgbG9vayBmb3IgYW4gbHRlIGF0b20sIGlmIHByZXNlbnQgd2lsbCBjYWxsIGl0IHdp
dGhvdXQgcGFyYW1ldGVyIGZvciA8YnI+CiZndDsgc2VuZGluZyB0aGUgQVQrQ0dEQ09OVCBhbmQg
QVQrQ0dBVVRIIHRvIHRoZSBtb2RlbS48YnI+CiZndDsgPGJyPgomZ3Q7IFdvdWxkIHRoaXMgd29y
ayBmb3IgeW91Pzxicj4KJmd0OyA8YnI+Cjxicj4KSSBkb24mIzM5O3Qgc2VlIGhvdyB0aGlzIGhl
bHBzLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+
PC9kaXY+PC9kaXY+Cg==

--===============3050577484902196917==--

