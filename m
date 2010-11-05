Content-Type: multipart/mixed; boundary="===============2249944108774278247=="
MIME-Version: 1.0
From: Marit Sofie Henriksen <maritsofie.henriksen8@gmail.com>
Subject: Re: [PATCH] sim: Check SIM pin status after changing pin.
Date: Fri, 05 Nov 2010 15:25:45 +0100
Message-ID: <AANLkTimcZCHkLiyiwKOOxnT_kC1cAwS7J=A8-SaeozRg@mail.gmail.com>
In-Reply-To: <4CD02CC6.30201@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2249944108774278247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis.
OK, I can see that this approach was rather too simplistic... Maybe checking
the returned CME error would be a better idea?
I=E2=80=99m a bit unsure how (or if) to proceed with this. As this is in th=
e core,
and not our driver, it might be more on your table? If you think it is
important.



Br Marit




2010/11/2 Denis Kenzior <denkenz@gmail.com>

> Hi Marit,
>
> On 11/02/2010 10:08 AM, Marit Henriksen wrote:
> > From: Marit Henriksen <marit.henriksen@stericsson.com>
> >
> > When changing pin, it is possible to get in a state where the modem
> requests puk
> > (if incorrect pin is entered too many times). Need to check the SIM pin
> status
> > to discover this.
> > ---
> >  src/sim.c |   15 ++++++++-------
> >  1 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/src/sim.c b/src/sim.c
> > index 699ebe9..b2277c5 100644
> > --- a/src/sim.c
> > +++ b/src/sim.c
> > @@ -628,15 +628,16 @@ static DBusMessage *sim_unlock_pin(DBusConnection
> *conn, DBusMessage *msg,
> >  static void sim_change_pin_cb(const struct ofono_error *error, void
> *data)
> >  {
> >       struct ofono_sim *sim =3D data;
> > +     DBusMessage *reply;
> >
> > -     if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> > -             __ofono_dbus_pending_reply(&sim->pending,
> > -                             __ofono_error_failed(sim->pending));
> > -             return;
> > -     }
> > +     if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
> > +             reply =3D __ofono_error_failed(sim->pending);
> > +     else
> > +             reply =3D dbus_message_new_method_return(sim->pending);
> >
> > -     __ofono_dbus_pending_reply(&sim->pending,
> > -
> dbus_message_new_method_return(sim->pending));
> > +     __ofono_dbus_pending_reply(&sim->pending, reply);
> > +
> > +     sim_pin_check(sim);
>
> I don't think that running sim_pin_check is such a good idea.  That
> function initializes the sim interface when +CPIN returns READY.
>
> You also need to tear down the modem state back to pre-sim if the modem
> asks for a PUK after change pin fails.  That entails removing all
> post_sim/post_online atoms and bring the modem back to the offline state =
;)
>
> >  }
> >
> >  static DBusMessage *sim_change_pin(DBusConnection *conn, DBusMessage
> *msg,
>
> Regards,
> -Denis
>

--===============2249944108774278247==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0iTUFSR0lOOiAwY20gMGNtIDBwdCI+PHNwYW4g
bGFuZz0iRU4tVVMiIHN0eWxlPSJtc28tYW5zaS1sYW5ndWFnZTogRU4tVVMiPjxmb250IHNpemU9
IjMiPjxmb250IGZhY2U9IkNhbGlicmkiPkhpIERlbmlzLjwvZm9udD48L2ZvbnQ+PC9zcGFuPjwv
ZGl2Pgo8ZGl2IGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJNQVJHSU46IDBjbSAwY20gMHB0Ij48
c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9Im1zby1hbnNpLWxhbmd1YWdlOiBFTi1VUyI+PGZvbnQg
c2l6ZT0iKzAiPjxmb250IGZhY2U9IkNhbGlicmkiPjxmb250IHNpemU9IjMiPk9LLCBJIGNhbiBz
ZWUgdGhhdCB0aGlzIGFwcHJvYWNoIHdhcyByYXRoZXIgdG9vIHNpbXBsaXN0aWMuLi4gPC9mb250
Pjxmb250IHNpemU9IjMiPjxzcGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0ibXNvLWFuc2ktbGFuZ3Vh
Z2U6IEVOLVVTOyBtc28tYXNjaWktZm9udC1mYW1pbHk6IENhbGlicmk7IG1zby1oYW5zaS1mb250
LWZhbWlseTogQ2FsaWJyaSI+TWF5YmUgY2hlY2tpbmcgdGhlIHJldHVybmVkIENNRSBlcnJvciB3
b3VsZCBiZSBhIGJldHRlciBpZGVhPzwvc3Bhbj48L2ZvbnQ+PC9mb250PjwvZm9udD48L3NwYW4+
PC9kaXY+Cgo8ZGl2IGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJNQVJHSU46IDBjbSAwY20gMHB0
Ij48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9Im1zby1hbnNpLWxhbmd1YWdlOiBFTi1VUyI+PC9z
cGFuPjxzcGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0ibXNvLWFuc2ktbGFuZ3VhZ2U6IEVOLVVTIj48
Zm9udCBzaXplPSIzIj48Zm9udCBmYWNlPSJDYWxpYnJpIj5Jkm0gYSBiaXQgdW5zdXJlIGhvdyAo
b3IgaWYpIHRvIHByb2NlZWQgd2l0aCB0aGlzLiBBcyB0aGlzIGlzIGluIHRoZSBjb3JlLCBhbmQg
bm90IG91ciBkcml2ZXIsIGl0IG1pZ2h0IGJlIG1vcmUgb24geW91ciB0YWJsZT8gSWYgeW91IHRo
aW5rIGl0IGlzIGltcG9ydGFudC48L2ZvbnQ+PC9mb250Pjwvc3Bhbj48L2Rpdj4KCjxwIGNsYXNz
PSJNc29Ob3JtYWwiIHN0eWxlPSJNQVJHSU46IDBjbSAwY20gMHB0Ij48c3BhbiBsYW5nPSJFTi1V
UyIgc3R5bGU9Im1zby1hbnNpLWxhbmd1YWdlOiBFTi1VUyI+PGZvbnQgZmFjZT0iQ2FsaWJyaSIg
c2l6ZT0iMyI+oDwvZm9udD48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0i
TUFSR0lOOiAwY20gMGNtIDBwdCI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJtc28tYW5zaS1s
YW5ndWFnZTogRU4tVVMiPjxmb250IHNpemU9IjMiPjxmb250IGZhY2U9IkNhbGlicmkiPkJyIE1h
cml0PC9mb250PjwvZm9udD48L3NwYW4+PC9wPgo8ZGl2PqA8L2Rpdj4KPGRpdj48YnI+PGJyPqA8
L2Rpdj4KPGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTAvMTEvMiBEZW5pcyBLZW56aW9yIDxz
cGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5r
ZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0iUEFERElORy1MRUZUOiAxZXg7IE1BUkdJTjogMHB4IDBweCAwcHggMC44
ZXg7IEJPUkRFUi1MRUZUOiAjY2NjIDFweCBzb2xpZCI+SGkgTWFyaXQsPGJyPgo8ZGl2Pgo8ZGl2
PjwvZGl2Pgo8ZGl2IGNsYXNzPSJoNSI+PGJyPk9uIDExLzAyLzIwMTAgMTA6MDggQU0sIE1hcml0
IEhlbnJpa3NlbiB3cm90ZTo8YnI+Jmd0OyBGcm9tOiBNYXJpdCBIZW5yaWtzZW4gJmx0OzxhIGhy
ZWY9Im1haWx0bzptYXJpdC5oZW5yaWtzZW5Ac3Rlcmljc3Nvbi5jb20iPm1hcml0LmhlbnJpa3Nl
bkBzdGVyaWNzc29uLmNvbTwvYT4mZ3Q7PGJyPiZndDs8YnI+Jmd0OyBXaGVuIGNoYW5naW5nIHBp
biwgaXQgaXMgcG9zc2libGUgdG8gZ2V0IGluIGEgc3RhdGUgd2hlcmUgdGhlIG1vZGVtIHJlcXVl
c3RzIHB1azxicj4KJmd0OyAoaWYgaW5jb3JyZWN0IHBpbiBpcyBlbnRlcmVkIHRvbyBtYW55IHRp
bWVzKS4gTmVlZCB0byBjaGVjayB0aGUgU0lNIHBpbiBzdGF0dXM8YnI+Jmd0OyB0byBkaXNjb3Zl
ciB0aGlzLjxicj4mZ3Q7IC0tLTxicj4mZ3Q7IKBzcmMvc2ltLmMgfCCgIDE1ICsrKysrKysrLS0t
LS0tLTxicj4mZ3Q7IKAxIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSk8YnI+CiZndDs8YnI+Jmd0OyBkaWZmIC0tZ2l0IGEvc3JjL3NpbS5jIGIvc3JjL3NpbS5j
PGJyPiZndDsgaW5kZXggNjk5ZWJlOS4uYjIyNzdjNSAxMDA2NDQ8YnI+Jmd0OyAtLS0gYS9zcmMv
c2ltLmM8YnI+Jmd0OyArKysgYi9zcmMvc2ltLmM8YnI+Jmd0OyBAQCAtNjI4LDE1ICs2MjgsMTYg
QEAgc3RhdGljIERCdXNNZXNzYWdlICpzaW1fdW5sb2NrX3BpbihEQnVzQ29ubmVjdGlvbiAqY29u
biwgREJ1c01lc3NhZ2UgKm1zZyw8YnI+CiZndDsgoHN0YXRpYyB2b2lkIHNpbV9jaGFuZ2VfcGlu
X2NiKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJyb3IsIHZvaWQgKmRhdGEpPGJyPiZndDsg
oHs8YnI+Jmd0OyCgIKAgoCBzdHJ1Y3Qgb2Zvbm9fc2ltICpzaW0gPSBkYXRhOzxicj4mZ3Q7ICsg
oCCgIERCdXNNZXNzYWdlICpyZXBseTs8YnI+Jmd0Ozxicj4mZ3Q7IC0goCCgIGlmIChlcnJvci0m
Z3Q7dHlwZSAhPSBPRk9OT19FUlJPUl9UWVBFX05PX0VSUk9SKSB7PGJyPgomZ3Q7IC0goCCgIKAg
oCCgIKAgX19vZm9ub19kYnVzX3BlbmRpbmdfcmVwbHkoJmFtcDtzaW0tJmd0O3BlbmRpbmcsPGJy
PiZndDsgLSCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgX19vZm9ub19lcnJvcl9mYWlsZWQo
c2ltLSZndDtwZW5kaW5nKSk7PGJyPiZndDsgLSCgIKAgoCCgIKAgoCByZXR1cm47PGJyPiZndDsg
LSCgIKAgfTxicj4mZ3Q7ICsgoCCgIGlmIChlcnJvci0mZ3Q7dHlwZSAhPSBPRk9OT19FUlJPUl9U
WVBFX05PX0VSUk9SKTxicj4KJmd0OyArIKAgoCCgIKAgoCCgIHJlcGx5ID0gX19vZm9ub19lcnJv
cl9mYWlsZWQoc2ltLSZndDtwZW5kaW5nKTs8YnI+Jmd0OyArIKAgoCBlbHNlPGJyPiZndDsgKyCg
IKAgoCCgIKAgoCByZXBseSA9IGRidXNfbWVzc2FnZV9uZXdfbWV0aG9kX3JldHVybihzaW0tJmd0
O3BlbmRpbmcpOzxicj4mZ3Q7PGJyPiZndDsgLSCgIKAgX19vZm9ub19kYnVzX3BlbmRpbmdfcmVw
bHkoJmFtcDtzaW0tJmd0O3BlbmRpbmcsPGJyPgomZ3Q7IC0goCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIGRidXNfbWVzc2FnZV9uZXdfbWV0aG9kX3JldHVybihzaW0tJmd0O3BlbmRpbmcpKTs8
YnI+Jmd0OyArIKAgoCBfX29mb25vX2RidXNfcGVuZGluZ19yZXBseSgmYW1wO3NpbS0mZ3Q7cGVu
ZGluZywgcmVwbHkpOzxicj4mZ3Q7ICs8YnI+Jmd0OyArIKAgoCBzaW1fcGluX2NoZWNrKHNpbSk7
PGJyPjxicj48L2Rpdj48L2Rpdj5JIGRvbiYjMzk7dCB0aGluayB0aGF0IHJ1bm5pbmcgc2ltX3Bp
bl9jaGVjayBpcyBzdWNoIGEgZ29vZCBpZGVhLiCgVGhhdDxicj4KZnVuY3Rpb24gaW5pdGlhbGl6
ZXMgdGhlIHNpbSBpbnRlcmZhY2Ugd2hlbiArQ1BJTiByZXR1cm5zIFJFQURZLjxicj48YnI+WW91
IGFsc28gbmVlZCB0byB0ZWFyIGRvd24gdGhlIG1vZGVtIHN0YXRlIGJhY2sgdG8gcHJlLXNpbSBp
ZiB0aGUgbW9kZW08YnI+YXNrcyBmb3IgYSBQVUsgYWZ0ZXIgY2hhbmdlIHBpbiBmYWlscy4goFRo
YXQgZW50YWlscyByZW1vdmluZyBhbGw8YnI+cG9zdF9zaW0vcG9zdF9vbmxpbmUgYXRvbXMgYW5k
IGJyaW5nIHRoZSBtb2RlbSBiYWNrIHRvIHRoZSBvZmZsaW5lIHN0YXRlIDspPGJyPgoKPGRpdiBj
bGFzcz0iaW0iPjxicj4mZ3Q7IKB9PGJyPiZndDs8YnI+Jmd0OyCgc3RhdGljIERCdXNNZXNzYWdl
ICpzaW1fY2hhbmdlX3BpbihEQnVzQ29ubmVjdGlvbiAqY29ubiwgREJ1c01lc3NhZ2UgKm1zZyw8
YnI+PGJyPjwvZGl2PlJlZ2FyZHMsPGJyPjxmb250IGNvbG9yPSIjODg4ODg4Ij4tRGVuaXM8YnI+
PC9mb250PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+Cg==

--===============2249944108774278247==--

