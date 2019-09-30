Content-Type: multipart/mixed; boundary="===============4172380902286563372=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] ublox: netreg: Also subscribe to UREG URC's
Date: Mon, 30 Sep 2019 20:47:39 +0200
Message-ID: <CAHB-Pj=Pd1F7exx+Bh9z7QuE1PrhPRowcGjxFS-+Bjh9PG5YSQ@mail.gmail.com>
In-Reply-To: <f41b0ba9-30f9-0533-7ba7-081e8fa5979e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4172380902286563372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Den m=C3=A5n 30 sep. 2019 kl 19:00 skrev Denis Kenzior <denkenz@gmail.com=
>:

> Hi Richard,
>
> On 9/29/19 2:39 PM, richard.rojfors(a)gmail.com wrote:
> > From: Richard R=C3=B6jfors <richard@puffinpack.se>
> >
> > It turns out that both L2xx and L4xx modems are a bit
> > buggy when it comes to send CREG URC's when the tech changes.
> > Try to overcome this by subscribing to both UREG and CREG,
> > and poll the other when any of the URC's are received.
> > Protect from doing simultanious polls though.
>
> nit: typo, simultaneous
>

Thanks :)


>
> Also, this patch doesn't apply?
>

This is strange, I did a git send-email.

Anyway, I have changes to do according to comments below,  so I will make
sure to rebase on master.


>
> denkenz(a)localhost ~/ofono-master $ git am --3way ~/merge/\[PATCH\]\
> ublox\:\ netreg\:\ Also\ subscribe\ to\ UREG\ URC\'s.eml
> Applying: ublox: netreg: Also subscribe to UREG URC's
> Using index info to reconstruct a base tree...
> error: patch failed: drivers/ubloxmodem/network-registration.c:47
> error: drivers/ubloxmodem/network-registration.c: patch does not apply
> error: Did you hand edit your patch?
> It does not apply to blobs recorded in its index.
> Patch failed at 0001 ublox: netreg: Also subscribe to UREG URC's
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> > ---
> >   drivers/ubloxmodem/network-registration.c | 198 ++++++++++++++++------
> >   1 file changed, 148 insertions(+), 50 deletions(-)
> >
> > diff --git a/drivers/ubloxmodem/network-registration.c
> b/drivers/ubloxmodem/network-registration.c
> > index 69af4644..ad905fb3 100644
> > --- a/drivers/ubloxmodem/network-registration.c
> > +++ b/drivers/ubloxmodem/network-registration.c
> > @@ -47,11 +47,15 @@
> >   static const char *none_prefix[] =3D { NULL };
> >   static const char *cmer_prefix[] =3D { "+CMER:", NULL };
> >   static const char *ureg_prefix[] =3D { "+UREG:", NULL };
> > +static const char *creg_prefix[] =3D { "+CREG:", NULL };
> > +
> > +#define UBLOX_UPDATING_STATUS 0x01
> >
> >   struct netreg_data {
> >       struct at_netreg_data at_data;
> >
> >       const struct ublox_model *model;
> > +     int flags;
>
> Nowadays we prefer to use bool foo : 1 notation to manipulate bit fields.
>
> So maybe something like:
>
> bool updating_status : 1;
>

Will filx.


>
> >   };
> >
> >   struct tech_query {
> > @@ -213,13 +217,72 @@ static void ctze_notify(GAtResult *result,
> gpointer user_data)
> >       ofono_netreg_time_notify(netreg, &nd->time);
> >   }
> >
> > -static void ublox_query_tech_cb(gboolean ok, GAtResult *result,
> > +static int ublox_ureg_state_to_tech(int state)
> > +{
> > +     switch (state) {
> > +     case 1:
> > +             return ACCESS_TECHNOLOGY_GSM;
> > +     case 2:
> > +             return ACCESS_TECHNOLOGY_GSM_EGPRS;
> > +     case 3:
> > +             return ACCESS_TECHNOLOGY_UTRAN;
> > +     case 4:
> > +             return ACCESS_TECHNOLOGY_UTRAN_HSDPA;
> > +     case 5:
> > +             return ACCESS_TECHNOLOGY_UTRAN_HSUPA;
> > +     case 6:
> > +             return ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
> > +     case 7:
> > +             return ACCESS_TECHNOLOGY_EUTRAN;
> > +     case 8:
> > +             return ACCESS_TECHNOLOGY_GSM;
> > +     case 9:
> > +             return ACCESS_TECHNOLOGY_GSM_EGPRS;
> > +     default:
> > +             /* Not registered for PS (0) or something unknown (>9)...
> */
> > +             return -1;
> > +     }
> > +}
> > +
> > +static gboolean is_registered(int status)
> > +{
> > +     return status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
> > +             status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING;
> > +}
> > +
> > +static void ublox_creg_cb(gboolean ok, GAtResult *result,
> > +                             gpointer user_data)
> > +{
> > +     struct tech_query *tq =3D user_data;
> > +     struct netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
> > +     int status, lac, ci, tech;
>
> One variable declaration per line please.
>

Will fix


>
> > +
> > +     nd->flags &=3D ~UBLOX_UPDATING_STATUS;
> > +
> > +     if (!ok)
> > +             return;
> > +
> > +     if (at_util_parse_reg(result, "+CREG:", NULL, &status,
> > +                             &lac, &ci, &tech, OFONO_VENDOR_GENERIC) =
=3D=3D
> FALSE)
> > +             return;
> > +
> > +     /* The query provided a tech, use that */
> > +     if (is_registered(status) && tq->tech !=3D -1)
> > +             tech =3D tq->tech;
> > +
> > +     ofono_netreg_status_notify(tq->netreg, status, lac, ci, tech);
> > +}
> > +
> > +static void ublox_ureg_cb(gboolean ok, GAtResult *result,
> >                                                       gpointer user_dat=
a)
> >   {
> >       struct tech_query *tq =3D user_data;
> > +     struct netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
> >       GAtResultIter iter;
> >       gint enabled, state;
> > -     int tech =3D -1;
> > +     int tech =3D tq->tech;
> > +
> > +     nd->flags &=3D ~UBLOX_UPDATING_STATUS;
> >
> >       if (!ok)
> >               goto error;
>
> <snip>
>
> > +static void ureg_notify(GAtResult *result, gpointer user_data)
> > +{
> > +     struct ofono_netreg *netreg =3D user_data;
> > +     int state;
> > +     struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
> > +     struct tech_query *tq;
> > +     GAtResultIter iter;
> > +
> > +     if (nd->flags & UBLOX_UPDATING_STATUS)
> > +             return;
> > +
> > +     g_at_result_iter_init(&iter, result);
> > +
> > +     if (!g_at_result_iter_next(&iter, "+UREG:"))
> > +             return;
> > +
> > +     if (!g_at_result_iter_next_number(&iter, &state))
> > +             return;
> > +
> > +     tq =3D g_new0(struct tech_query, 1);
> > +
> > +     tq->tech =3D ublox_ureg_state_to_tech(state);
> > +     tq->netreg =3D netreg;
> > +
> > +     if (g_at_chat_send(nd->at_data.chat, "AT+CREG?", creg_prefix,
> > +                     ublox_creg_cb, tq, g_free) > 0) {
> > +             nd->flags |=3D UBLOX_UPDATING_STATUS;
> > +             return;
> > +     }
> > +
> > +     g_free(tq);
> > +}
> > +
>
> So it seems to me you're firing off a CREG? when UREG unsolicited comes
> in but also firing off UREG? when CREG unsolicited comes in.
>

Yes that's the idea, but in case we are already firing off something, at
least we
avoid acting it on the second URC.

The reason for fire off when we get CREG is that the tech is sometimes
incorrect in the CREG.
The reason for fire off when we get UREG is that the CREG is sometimes
missing, so we need to poll CREG to get status, lac, ci.



> Briefly looking at some random ublox docs via google, I understand that
> UREG was meant to tell you what Packet Switching technology was active.
> One can still be connected to Voice Circuit Switched service with no PS
> active.  So I'm not entirely sure whether the two can be assumed to be
> related the way you do it here...?
>

This is completely true. And in that case it will signal UREG status 0, and
we then fall back to use the status from CREG.

I'm afraid this is the best we can do, since I have seen missing CREG's
and CREG's with incorrect status. In those occasions it has fired UREG
URC's at least..


>
> I really see nothing that can go wrong in being paranoid and re-querying
> CREG/UREG, so I'm ok taking this up.  Just wondering whether you'll end
> up fixing this again later.
>

I see your point. All this is to try doing the best to work around bugs in
the
modem.
I'm afraid we have to live with it. Even if it gets fixed in later
FW there will be modems out there that works like this. What I read
from Jonas and comments in the code is that the L4xx seems even worse.
For the L210 it seems like the URC's are missing only sometimes. But
those situation could be annoying. We could switch from E-UTRAN to UTRAN
and should attach and activate context. But ofono will still think we are
on E-UTRAN and just waiting for the context to show up...(if the URCs are
missing)

--Richard

--===============4172380902286563372==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPkRlbiBtw6VuIDMw
IHNlcC4gMjAxOSBrbCAxOTowMCBza3JldiBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWls
dG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs6PGJyPjwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBw
eCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxl
ZnQ6MWV4Ij5IaSBSaWNoYXJkLDxicj4KPGJyPgpPbiA5LzI5LzE5IDI6MzkgUE0sIDxhIGhyZWY9
Im1haWx0bzpyaWNoYXJkLnJvamZvcnNAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+cmljaGFy
ZC5yb2pmb3JzQGdtYWlsLmNvbTwvYT4gd3JvdGU6PGJyPgomZ3Q7IEZyb206IFJpY2hhcmQgUsO2
amZvcnMgJmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkQHB1ZmZpbnBhY2suc2UiIHRhcmdldD0i
X2JsYW5rIj5yaWNoYXJkQHB1ZmZpbnBhY2suc2U8L2E+Jmd0Ozxicj4KJmd0OyA8YnI+CiZndDsg
SXQgdHVybnMgb3V0IHRoYXQgYm90aCBMMnh4IGFuZCBMNHh4IG1vZGVtcyBhcmUgYSBiaXQ8YnI+
CiZndDsgYnVnZ3kgd2hlbiBpdCBjb21lcyB0byBzZW5kIENSRUcgVVJDJiMzOTtzIHdoZW4gdGhl
IHRlY2ggY2hhbmdlcy48YnI+CiZndDsgVHJ5IHRvIG92ZXJjb21lIHRoaXMgYnkgc3Vic2NyaWJp
bmcgdG8gYm90aCBVUkVHIGFuZCBDUkVHLDxicj4KJmd0OyBhbmQgcG9sbCB0aGUgb3RoZXIgd2hl
biBhbnkgb2YgdGhlIFVSQyYjMzk7cyBhcmUgcmVjZWl2ZWQuPGJyPgomZ3Q7IFByb3RlY3QgZnJv
bSBkb2luZyBzaW11bHRhbmlvdXMgcG9sbHMgdGhvdWdoLjxicj4KPGJyPgpuaXQ6IHR5cG8sIHNp
bXVsdGFuZW91czxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MgOik8
L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIw
NCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CkFsc28sIHRoaXMgcGF0Y2ggZG9lc24mIzM5
O3QgYXBwbHk/PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoaXMgaXMgc3Ry
YW5nZSwgSSBkaWQgYSBnaXQgc2VuZC1lbWFpbC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFu
eXdheSwgSSBoYXZlIGNoYW5nZXMgdG8gZG8gYWNjb3JkaW5nIHRvIGNvbW1lbnRzIGJlbG93LMKg
IHNvIEkgd2lsbCBtYWtlIHN1cmUgdG8gcmViYXNlIG9uIG1hc3Rlci48L2Rpdj48ZGl2PsKgPC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPgo8YnI+CmRlbmtlbnpAbG9jYWxob3N0IH4vb2Zvbm8tbWFzdGVyICQgZ2l0IGFt
IC0tM3dheSB+L21lcmdlL1xbUEFUQ0hcXVwgPGJyPgp1YmxveFw6XCBuZXRyZWdcOlwgQWxzb1wg
c3Vic2NyaWJlXCB0b1wgVVJFR1wgVVJDXCYjMzk7cy5lbWw8YnI+CkFwcGx5aW5nOiB1YmxveDog
bmV0cmVnOiBBbHNvIHN1YnNjcmliZSB0byBVUkVHIFVSQyYjMzk7czxicj4KVXNpbmcgaW5kZXgg
aW5mbyB0byByZWNvbnN0cnVjdCBhIGJhc2UgdHJlZS4uLjxicj4KZXJyb3I6IHBhdGNoIGZhaWxl
ZDogZHJpdmVycy91YmxveG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6NDc8YnI+CmVycm9y
OiBkcml2ZXJzL3VibG94bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzogcGF0Y2ggZG9lcyBu
b3QgYXBwbHk8YnI+CmVycm9yOiBEaWQgeW91IGhhbmQgZWRpdCB5b3VyIHBhdGNoPzxicj4KSXQg
ZG9lcyBub3QgYXBwbHkgdG8gYmxvYnMgcmVjb3JkZWQgaW4gaXRzIGluZGV4Ljxicj4KUGF0Y2gg
ZmFpbGVkIGF0IDAwMDEgdWJsb3g6IG5ldHJlZzogQWxzbyBzdWJzY3JpYmUgdG8gVVJFRyBVUkMm
IzM5O3M8YnI+CmhpbnQ6IFVzZSAmIzM5O2dpdCBhbSAtLXNob3ctY3VycmVudC1wYXRjaCYjMzk7
IHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoPGJyPgpXaGVuIHlvdSBoYXZlIHJlc29sdmVkIHRoaXMg
cHJvYmxlbSwgcnVuICZxdW90O2dpdCBhbSAtLWNvbnRpbnVlJnF1b3Q7Ljxicj4KSWYgeW91IHBy
ZWZlciB0byBza2lwIHRoaXMgcGF0Y2gsIHJ1biAmcXVvdDtnaXQgYW0gLS1za2lwJnF1b3Q7IGlu
c3RlYWQuPGJyPgpUbyByZXN0b3JlIHRoZSBvcmlnaW5hbCBicmFuY2ggYW5kIHN0b3AgcGF0Y2hp
bmcsIHJ1biAmcXVvdDtnaXQgYW0gLS1hYm9ydCZxdW90Oy48YnI+Cjxicj4KJmd0OyAtLS08YnI+
CiZndDvCoCDCoGRyaXZlcnMvdWJsb3htb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jIHwgMTk4
ICsrKysrKysrKysrKysrKystLS0tLS08YnI+CiZndDvCoCDCoDEgZmlsZSBjaGFuZ2VkLCAxNDgg
aW5zZXJ0aW9ucygrKSwgNTAgZGVsZXRpb25zKC0pPGJyPgomZ3Q7IDxicj4KJmd0OyBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91YmxveG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmMgYi9kcml2ZXJz
L3VibG94bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzxicj4KJmd0OyBpbmRleCA2OWFmNDY0
NC4uYWQ5MDVmYjMgMTAwNjQ0PGJyPgomZ3Q7IC0tLSBhL2RyaXZlcnMvdWJsb3htb2RlbS9uZXR3
b3JrLXJlZ2lzdHJhdGlvbi5jPGJyPgomZ3Q7ICsrKyBiL2RyaXZlcnMvdWJsb3htb2RlbS9uZXR3
b3JrLXJlZ2lzdHJhdGlvbi5jPGJyPgomZ3Q7IEBAIC00NywxMSArNDcsMTUgQEA8YnI+CiZndDvC
oCDCoHN0YXRpYyBjb25zdCBjaGFyICpub25lX3ByZWZpeFtdID0geyBOVUxMIH07PGJyPgomZ3Q7
wqAgwqBzdGF0aWMgY29uc3QgY2hhciAqY21lcl9wcmVmaXhbXSA9IHsgJnF1b3Q7K0NNRVI6JnF1
b3Q7LCBOVUxMIH07PGJyPgomZ3Q7wqAgwqBzdGF0aWMgY29uc3QgY2hhciAqdXJlZ19wcmVmaXhb
XSA9IHsgJnF1b3Q7K1VSRUc6JnF1b3Q7LCBOVUxMIH07PGJyPgomZ3Q7ICtzdGF0aWMgY29uc3Qg
Y2hhciAqY3JlZ19wcmVmaXhbXSA9IHsgJnF1b3Q7K0NSRUc6JnF1b3Q7LCBOVUxMIH07PGJyPgom
Z3Q7ICs8YnI+CiZndDsgKyNkZWZpbmUgVUJMT1hfVVBEQVRJTkdfU1RBVFVTIDB4MDE8YnI+CiZn
dDvCoCDCoDxicj4KJmd0O8KgIMKgc3RydWN0IG5ldHJlZ19kYXRhIHs8YnI+CiZndDvCoCDCoCDC
oCDCoHN0cnVjdCBhdF9uZXRyZWdfZGF0YSBhdF9kYXRhOzxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7
wqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgdWJsb3hfbW9kZWwgKm1vZGVsOzxicj4KJmd0OyArwqAg
wqAgwqBpbnQgZmxhZ3M7PGJyPgo8YnI+Ck5vd2FkYXlzIHdlIHByZWZlciB0byB1c2UgYm9vbCBm
b28gOiAxIG5vdGF0aW9uIHRvIG1hbmlwdWxhdGUgYml0IGZpZWxkcy48YnI+Cjxicj4KU28gbWF5
YmUgc29tZXRoaW5nIGxpa2U6PGJyPgo8YnI+CmJvb2wgdXBkYXRpbmdfc3RhdHVzIDogMTs8YnI+
PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+V2lsbCBmaWx4LjwvZGl2PjxkaXY+wqA8
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+Cjxicj4KJmd0O8KgIMKgfTs8YnI+CiZndDvCoCDCoDxicj4KJmd0O8KgIMKg
c3RydWN0IHRlY2hfcXVlcnkgezxicj4KJmd0OyBAQCAtMjEzLDEzICsyMTcsNzIgQEAgc3RhdGlj
IHZvaWQgY3R6ZV9ub3RpZnkoR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSk8
YnI+CiZndDvCoCDCoCDCoCDCoG9mb25vX25ldHJlZ190aW1lX25vdGlmeShuZXRyZWcsICZhbXA7
bmQtJmd0O3RpbWUpOzxicj4KJmd0O8KgIMKgfTxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7IC1zdGF0
aWMgdm9pZCB1YmxveF9xdWVyeV90ZWNoX2NiKGdib29sZWFuIG9rLCBHQXRSZXN1bHQgKnJlc3Vs
dCw8YnI+CiZndDsgK3N0YXRpYyBpbnQgdWJsb3hfdXJlZ19zdGF0ZV90b190ZWNoKGludCBzdGF0
ZSk8YnI+CiZndDsgK3s8YnI+CiZndDsgK8KgIMKgIMKgc3dpdGNoIChzdGF0ZSkgezxicj4KJmd0
OyArwqAgwqAgwqBjYXNlIDE6PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBB
Q0NFU1NfVEVDSE5PTE9HWV9HU007PGJyPgomZ3Q7ICvCoCDCoCDCoGNhc2UgMjo8YnI+CiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIEFDQ0VTU19URUNITk9MT0dZX0dTTV9FR1BSUzs8
YnI+CiZndDsgK8KgIMKgIMKgY2FzZSAzOjxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gQUNDRVNTX1RFQ0hOT0xPR1lfVVRSQU47PGJyPgomZ3Q7ICvCoCDCoCDCoGNhc2UgNDo8
YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIEFDQ0VTU19URUNITk9MT0dZX1VU
UkFOX0hTRFBBOzxicj4KJmd0OyArwqAgwqAgwqBjYXNlIDU6PGJyPgomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybiBBQ0NFU1NfVEVDSE5PTE9HWV9VVFJBTl9IU1VQQTs8YnI+CiZndDsg
K8KgIMKgIMKgY2FzZSA2Ojxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQUND
RVNTX1RFQ0hOT0xPR1lfVVRSQU5fSFNEUEFfSFNVUEE7PGJyPgomZ3Q7ICvCoCDCoCDCoGNhc2Ug
Nzo8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIEFDQ0VTU19URUNITk9MT0dZ
X0VVVFJBTjs8YnI+CiZndDsgK8KgIMKgIMKgY2FzZSA4Ojxicj4KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm4gQUNDRVNTX1RFQ0hOT0xPR1lfR1NNOzxicj4KJmd0OyArwqAgwqAgwqBj
YXNlIDk6PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBBQ0NFU1NfVEVDSE5P
TE9HWV9HU01fRUdQUlM7PGJyPgomZ3Q7ICvCoCDCoCDCoGRlZmF1bHQ6PGJyPgomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoC8qIE5vdCByZWdpc3RlcmVkIGZvciBQUyAoMCkgb3Igc29tZXRoaW5n
IHVua25vd24gKCZndDs5KS4uLiAqLzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gLTE7PGJyPgomZ3Q7ICvCoCDCoCDCoH08YnI+CiZndDsgK308YnI+CiZndDsgKzxicj4KJmd0
OyArc3RhdGljIGdib29sZWFuIGlzX3JlZ2lzdGVyZWQoaW50IHN0YXR1cyk8YnI+CiZndDsgK3s8
YnI+CiZndDsgK8KgIMKgIMKgcmV0dXJuIHN0YXR1cyA9PSBORVRXT1JLX1JFR0lTVFJBVElPTl9T
VEFUVVNfUkVHSVNURVJFRCB8fDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMg
PT0gTkVUV09SS19SRUdJU1RSQVRJT05fU1RBVFVTX1JPQU1JTkc7PGJyPgomZ3Q7ICt9PGJyPgom
Z3Q7ICs8YnI+CiZndDsgK3N0YXRpYyB2b2lkIHVibG94X2NyZWdfY2IoZ2Jvb2xlYW4gb2ssIEdB
dFJlc3VsdCAqcmVzdWx0LDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBncG9pbnRlciB1c2VyX2RhdGEpPGJyPgomZ3Q7ICt7PGJyPgomZ3Q7ICvC
oCDCoCDCoHN0cnVjdCB0ZWNoX3F1ZXJ5ICp0cSA9IHVzZXJfZGF0YTs8YnI+CiZndDsgK8KgIMKg
IMKgc3RydWN0IG5ldHJlZ19kYXRhICpuZCA9IG9mb25vX25ldHJlZ19nZXRfZGF0YSh0cS0mZ3Q7
bmV0cmVnKTs8YnI+CiZndDsgK8KgIMKgIMKgaW50IHN0YXR1cywgbGFjLCBjaSwgdGVjaDs8YnI+
Cjxicj4KT25lIHZhcmlhYmxlIGRlY2xhcmF0aW9uIHBlciBsaW5lIHBsZWFzZS48YnI+PC9ibG9j
a3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+V2lsbCBmaXg8L2Rpdj48ZGl2PsKgPC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAu
OGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDox
ZXgiPgo8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBuZC0mZ3Q7ZmxhZ3MgJmFtcDs9IH5V
QkxPWF9VUERBVElOR19TVEFUVVM7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgaWYgKCFv
ayk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOzxicj4KJmd0OyArPGJyPgom
Z3Q7ICvCoCDCoCDCoGlmIChhdF91dGlsX3BhcnNlX3JlZyhyZXN1bHQsICZxdW90OytDUkVHOiZx
dW90OywgTlVMTCwgJmFtcDtzdGF0dXMsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7bGFjLCAmYW1wO2NpLCAmYW1wO3RlY2gsIE9GT05P
X1ZFTkRPUl9HRU5FUklDKSA9PSBGQUxTRSk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0dXJuOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoC8qIFRoZSBxdWVyeSBwcm92aWRl
ZCBhIHRlY2gsIHVzZSB0aGF0ICovPGJyPgomZ3Q7ICvCoCDCoCDCoGlmIChpc19yZWdpc3RlcmVk
KHN0YXR1cykgJmFtcDsmYW1wOyB0cS0mZ3Q7dGVjaCAhPSAtMSk8YnI+CiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgdGVjaCA9IHRxLSZndDt0ZWNoOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDC
oCDCoG9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KHRxLSZndDtuZXRyZWcsIHN0YXR1cywgbGFj
LCBjaSwgdGVjaCk7PGJyPgomZ3Q7ICt9PGJyPgomZ3Q7ICs8YnI+CiZndDsgK3N0YXRpYyB2b2lk
IHVibG94X3VyZWdfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LDxicj4KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ3BvaW50ZXIgdXNlcl9kYXRhKTxicj4KJmd0O8KgIMKg
ezxicj4KJmd0O8KgIMKgIMKgIMKgc3RydWN0IHRlY2hfcXVlcnkgKnRxID0gdXNlcl9kYXRhOzxi
cj4KJmd0OyArwqAgwqAgwqBzdHJ1Y3QgbmV0cmVnX2RhdGEgKm5kID0gb2Zvbm9fbmV0cmVnX2dl
dF9kYXRhKHRxLSZndDtuZXRyZWcpOzxicj4KJmd0O8KgIMKgIMKgIMKgR0F0UmVzdWx0SXRlciBp
dGVyOzxicj4KJmd0O8KgIMKgIMKgIMKgZ2ludCBlbmFibGVkLCBzdGF0ZTs8YnI+CiZndDsgLcKg
IMKgIMKgaW50IHRlY2ggPSAtMTs8YnI+CiZndDsgK8KgIMKgIMKgaW50IHRlY2ggPSB0cS0mZ3Q7
dGVjaDs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBuZC0mZ3Q7ZmxhZ3MgJmFtcDs9IH5V
QkxPWF9VUERBVElOR19TVEFUVVM7PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDCoCDCoCDCoGlm
ICghb2spPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVycm9yOzxicj4KPGJy
PgombHQ7c25pcCZndDs8YnI+Cjxicj4KJmd0OyArc3RhdGljIHZvaWQgdXJlZ19ub3RpZnkoR0F0
UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+CiZndDsgK3s8YnI+CiZndDsg
K8KgIMKgIMKgc3RydWN0IG9mb25vX25ldHJlZyAqbmV0cmVnID0gdXNlcl9kYXRhOzxicj4KJmd0
OyArwqAgwqAgwqBpbnQgc3RhdGU7PGJyPgomZ3Q7ICvCoCDCoCDCoHN0cnVjdCBuZXRyZWdfZGF0
YSAqbmQgPSBvZm9ub19uZXRyZWdfZ2V0X2RhdGEobmV0cmVnKTs8YnI+CiZndDsgK8KgIMKgIMKg
c3RydWN0IHRlY2hfcXVlcnkgKnRxOzxicj4KJmd0OyArwqAgwqAgwqBHQXRSZXN1bHRJdGVyIGl0
ZXI7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgaWYgKG5kLSZndDtmbGFncyAmYW1wOyBV
QkxPWF9VUERBVElOR19TVEFUVVMpPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
bjs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBnX2F0X3Jlc3VsdF9pdGVyX2luaXQoJmFt
cDtpdGVyLCByZXN1bHQpOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGlmICghZ19hdF9y
ZXN1bHRfaXRlcl9uZXh0KCZhbXA7aXRlciwgJnF1b3Q7K1VSRUc6JnF1b3Q7KSk8YnI+CiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDC
oGlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmYW1wO2l0ZXIsICZhbXA7c3RhdGUp
KTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPgomZ3Q7ICs8YnI+CiZn
dDsgK8KgIMKgIMKgdHEgPSBnX25ldzAoc3RydWN0IHRlY2hfcXVlcnksIDEpOzxicj4KJmd0OyAr
PGJyPgomZ3Q7ICvCoCDCoCDCoHRxLSZndDt0ZWNoID0gdWJsb3hfdXJlZ19zdGF0ZV90b190ZWNo
KHN0YXRlKTs8YnI+CiZndDsgK8KgIMKgIMKgdHEtJmd0O25ldHJlZyA9IG5ldHJlZzs8YnI+CiZn
dDsgKzxicj4KJmd0OyArwqAgwqAgwqBpZiAoZ19hdF9jaGF0X3NlbmQobmQtJmd0O2F0X2RhdGEu
Y2hhdCwgJnF1b3Q7QVQrQ1JFRz8mcXVvdDssIGNyZWdfcHJlZml4LDxicj4KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1YmxveF9jcmVnX2NiLCB0cSwgZ19mcmVlKSAmZ3Q7
IDApIHs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgbmQtJmd0O2ZsYWdzIHw9IFVCTE9Y
X1VQREFUSU5HX1NUQVRVUzs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOzxi
cj4KJmd0OyArwqAgwqAgwqB9PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgZ19mcmVlKHRx
KTs8YnI+CiZndDsgK308YnI+CiZndDsgKzxicj4KPGJyPgpTbyBpdCBzZWVtcyB0byBtZSB5b3Um
IzM5O3JlIGZpcmluZyBvZmYgYSBDUkVHPyB3aGVuIFVSRUcgdW5zb2xpY2l0ZWQgY29tZXMgPGJy
PgppbiBidXQgYWxzbyBmaXJpbmcgb2ZmIFVSRUc/IHdoZW4gQ1JFRyB1bnNvbGljaXRlZCBjb21l
cyBpbi48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+WWVzIHRoYXQmIzM5O3Mg
dGhlIGlkZWEsIGJ1dCBpbiBjYXNlIHdlIGFyZSBhbHJlYWR5IGZpcmluZyBvZmYgc29tZXRoaW5n
LCBhdCBsZWFzdCB3ZTwvZGl2PjxkaXY+YXZvaWQgYWN0aW5nIGl0IG9uIHRoZSBzZWNvbmQgVVJD
LjwvZGl2PjxkaXY+wqA8L2Rpdj48ZGl2PlRoZSByZWFzb24gZm9yIGZpcmUgb2ZmIHdoZW4gd2Ug
Z2V0IENSRUcgaXMgdGhhdCB0aGUgdGVjaCBpcyBzb21ldGltZXM8L2Rpdj48ZGl2PmluY29ycmVj
dCBpbiB0aGUgQ1JFRy48L2Rpdj48ZGl2PlRoZSByZWFzb24gZm9yIGZpcmUgb2ZmIHdoZW4gd2Ug
Z2V0IFVSRUcgaXMgdGhhdCB0aGUgQ1JFRyBpcyBzb21ldGltZXM8L2Rpdj48ZGl2Pm1pc3Npbmcs
IHNvIHdlIG5lZWQgdG8gcG9sbCBDUkVHIHRvIGdldCBzdGF0dXMsIGxhYywgY2kuPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CkJyaWVmbHkgbG9va2luZyBh
dCBzb21lIHJhbmRvbSB1YmxveCBkb2NzIHZpYSBnb29nbGUsIEkgdW5kZXJzdGFuZCB0aGF0IDxi
cj4KVVJFRyB3YXMgbWVhbnQgdG8gdGVsbCB5b3Ugd2hhdCBQYWNrZXQgU3dpdGNoaW5nIHRlY2hu
b2xvZ3kgd2FzIGFjdGl2ZS4gPGJyPgpPbmUgY2FuIHN0aWxsIGJlIGNvbm5lY3RlZCB0byBWb2lj
ZSBDaXJjdWl0IFN3aXRjaGVkIHNlcnZpY2Ugd2l0aCBubyBQUyA8YnI+CmFjdGl2ZS7CoCBTbyBJ
JiMzOTttIG5vdCBlbnRpcmVseSBzdXJlIHdoZXRoZXIgdGhlIHR3byBjYW4gYmUgYXNzdW1lZCB0
byBiZSA8YnI+CnJlbGF0ZWQgdGhlIHdheSB5b3UgZG8gaXQgaGVyZS4uLj88YnI+PC9ibG9ja3F1
b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhpcyBpcyBjb21wbGV0ZWx5IHRydWUuIEFuZCBpbiB0
aGF0IGNhc2UgaXQgd2lsbCBzaWduYWwgVVJFRyBzdGF0dXMgMCwgYW5kPC9kaXY+PGRpdj53ZSB0
aGVuIGZhbGwgYmFjayB0byB1c2UgdGhlIHN0YXR1cyBmcm9tIENSRUcuPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5JJiMzOTttIGFmcmFpZCB0aGlzIGlzIHRoZSBiZXN0IHdlIGNhbiBkbywgc2lu
Y2UgSSBoYXZlIHNlZW4gbWlzc2luZyBDUkVHJiMzOTtzPC9kaXY+PGRpdj5hbmQgQ1JFRyYjMzk7
cyB3aXRoIGluY29ycmVjdCBzdGF0dXMuIEluIHRob3NlIG9jY2FzaW9ucyBpdCBoYXMgZmlyZWQg
VVJFRzwvZGl2PjxkaXY+VVJDJiMzOTtzIGF0IGxlYXN0Li48L2Rpdj48ZGl2PsKgPC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAu
OGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDox
ZXgiPgo8YnI+CkkgcmVhbGx5IHNlZSBub3RoaW5nIHRoYXQgY2FuIGdvIHdyb25nIGluIGJlaW5n
IHBhcmFub2lkIGFuZCByZS1xdWVyeWluZyA8YnI+CkNSRUcvVVJFRywgc28gSSYjMzk7bSBvayB0
YWtpbmcgdGhpcyB1cC7CoCBKdXN0IHdvbmRlcmluZyB3aGV0aGVyIHlvdSYjMzk7bGwgZW5kIDxi
cj4KdXAgZml4aW5nIHRoaXMgYWdhaW4gbGF0ZXIuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48
L2Rpdj48ZGl2Pkkgc2VlIHlvdXIgcG9pbnQuIEFsbCB0aGlzIGlzIHRvIHRyeSBkb2luZyB0aGUg
YmVzdCB0byB3b3JrIGFyb3VuZCBidWdzIGluIHRoZTwvZGl2PjxkaXY+bW9kZW0uPC9kaXY+PGRp
dj5JJiMzOTttIGFmcmFpZCB3ZSBoYXZlIHRvIGxpdmUgd2l0aCBpdC4gRXZlbiBpZiBpdCBnZXRz
IGZpeGVkIGluIGxhdGVyPC9kaXY+PGRpdj5GVyB0aGVyZSB3aWxsIGJlIG1vZGVtcyBvdXQgdGhl
cmUgdGhhdCB3b3JrcyBsaWtlIHRoaXMuIFdoYXQgSSByZWFkPC9kaXY+PGRpdj5mcm9tIEpvbmFz
IGFuZCBjb21tZW50cyBpbiB0aGUgY29kZSBpcyB0aGF0IHRoZSBMNHh4IHNlZW1zIGV2ZW4gd29y
c2UuPC9kaXY+PGRpdj5Gb3IgdGhlIEwyMTAgaXQgc2VlbXMgbGlrZSB0aGUgVVJDJiMzOTtzIGFy
ZSBtaXNzaW5nIG9ubHkgc29tZXRpbWVzLiBCdXQ8L2Rpdj48ZGl2PnRob3NlIHNpdHVhdGlvbiBj
b3VsZCBiZSBhbm5veWluZy4gV2UgY291bGQgc3dpdGNoIGZyb20gRS1VVFJBTiB0byBVVFJBTjwv
ZGl2PjxkaXY+YW5kIHNob3VsZCBhdHRhY2ggYW5kIGFjdGl2YXRlIGNvbnRleHQuIEJ1dCBvZm9u
byB3aWxsIHN0aWxsIHRoaW5rIHdlIGFyZTwvZGl2PjxkaXY+b24gRS1VVFJBTiBhbmQganVzdCB3
YWl0aW5nIGZvciB0aGUgY29udGV4dCB0byBzaG93IHVwLi4uKGlmIHRoZSBVUkNzIGFyZSBtaXNz
aW5nKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+LS1SaWNoYXJkPC9kaXY+PC9kaXY+PC9kaXY+
Cg==

--===============4172380902286563372==--

