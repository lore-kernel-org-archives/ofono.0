Content-Type: multipart/mixed; boundary="===============3199837317619393308=="
MIME-Version: 1.0
From: Marit Sofie Henriksen <maritsofie.henriksen8@gmail.com>
Subject: Re: [PATCH 1/2] ste: Add support for multiple pdp contexts.
Date: Wed, 09 Feb 2011 09:37:30 +0100
Message-ID: <AANLkTikZ3TCtJhfWXZqUuwVWOAweqSiQW6LKjKCO=dTT@mail.gmail.com>
In-Reply-To: <1297179721.1520.454.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3199837317619393308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/2/8 Marcel Holtmann <marcel@holtmann.org>

> Hi Marit,
>
> > diff --git a/plugins/ste.c b/plugins/ste.c
> > index cf8aed8..749c4f3 100644
> > --- a/plugins/ste.c
> > +++ b/plugins/ste.c
> > @@ -66,6 +66,7 @@
> >  #include <drivers/stemodem/if_caif.h>
> >
> >  #define NUM_CHAT     1
> > +#define MAX_PDP_CONTEXTS     4
> >
> >  static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
> >
> > @@ -363,6 +364,7 @@ static void ste_post_online(struct ofono_modem
> *modem)
> >       struct ofono_message_waiting *mw;
> >       struct ofono_gprs *gprs;
> >       struct ofono_gprs_context *gc;
> > +     int i;
> >
> >       DBG("%p", modem);
> >
> > @@ -378,13 +380,18 @@ static void ste_post_online(struct ofono_modem
> *modem)
> >
> >       gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
> >                                       "atmodem", data->chat);
> > -     gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat=
);
> > -
> > -     if (gprs && gc)
> > -             ofono_gprs_add_context(gprs, gc);
> > +     if (gprs) {
> > +             for (i =3D 0; i < MAX_PDP_CONTEXTS; i++) {
> > +                     gc =3D ofono_gprs_context_create(
> > +                                     modem, 0, "stemodem", data->chat);
> > +                     if (gc =3D=3D NULL)
> > +                             break;
> > +
> > +                     ofono_gprs_add_context(gprs, gc);
> > +             }
> > +     }
>
> you do not need to create the GPRS context atom multiple times. You can
> just add the gc multiple times.
>
> So I just wanna make sure that you guys wanna have multiple GPRS context
> atom instances. For things like PPP and RawIP we have no other choice,
> but for example ISI is a bit more flexible here. That is the reason why
> we do allow it. Maybe CAIF is as flexible.
>
> It is a bit question about resources that are used. I am fine either
> way, but I need you to at least think about it ;)
>
> Regards
>
> Marcel
>
>
Hi Marcel,
Thanks for your input. We have given this some more thought and discussed
amongst us, and we would like to go for the solution as it is, adding
multiple GPRS context atom instances. I hope this is OK with you.

In the driver our internal gprs_context_data is associated with the
ofono_gprs_context. If we were to have only one gc, we would have to handle
all the activations with the same gprs_context_data, and that would bring us
back to where we were, with a significantly more complex implementation.

Br Marit


>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============3199837317619393308==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMS8yLzggTWFyY2VsIEhvbHRtYW5u
IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOm1hcmNlbEBob2x0bWFubi5vcmci
Pm1hcmNlbEBob2x0bWFubi5vcmc8L2E+Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVyLWxl
ZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+Ckhp
IE1hcml0LDxicj4KPGRpdj48ZGl2PjwvZGl2PjxkaXYgY2xhc3M9Img1Ij48YnI+CiZndDsgZGlm
ZiAtLWdpdCBhL3BsdWdpbnMvc3RlLmMgYi9wbHVnaW5zL3N0ZS5jPGJyPgomZ3Q7IGluZGV4IGNm
OGFlZDguLjc0OWM0ZjMgMTAwNjQ0PGJyPgomZ3Q7IC0tLSBhL3BsdWdpbnMvc3RlLmM8YnI+CiZn
dDsgKysrIGIvcGx1Z2lucy9zdGUuYzxicj4KJmd0OyBAQCAtNjYsNiArNjYsNyBAQDxicj4KJmd0
OyCgI2luY2x1ZGUgJmx0O2RyaXZlcnMvc3RlbW9kZW0vaWZfY2FpZi5oJmd0Ozxicj4KJmd0Ozxi
cj4KJmd0OyCgI2RlZmluZSBOVU1fQ0hBVCCgIKAgMTxicj4KJmd0OyArI2RlZmluZSBNQVhfUERQ
X0NPTlRFWFRTIKAgoCA0PGJyPgomZ3Q7PGJyPgomZ3Q7IKBzdGF0aWMgY29uc3QgY2hhciAqY3Bp
bl9wcmVmaXhbXSA9IHsgJnF1b3Q7K0NQSU46JnF1b3Q7LCBOVUxMIH07PGJyPgomZ3Q7PGJyPgom
Z3Q7IEBAIC0zNjMsNiArMzY0LDcgQEAgc3RhdGljIHZvaWQgc3RlX3Bvc3Rfb25saW5lKHN0cnVj
dCBvZm9ub19tb2RlbSAqbW9kZW0pPGJyPgomZ3Q7IKAgoCCgIHN0cnVjdCBvZm9ub19tZXNzYWdl
X3dhaXRpbmcgKm13Ozxicj4KJmd0OyCgIKAgoCBzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Byczs8YnI+
CiZndDsgoCCgIKAgc3RydWN0IG9mb25vX2dwcnNfY29udGV4dCAqZ2M7PGJyPgomZ3Q7ICsgoCCg
IGludCBpOzxicj4KJmd0Ozxicj4KJmd0OyCgIKAgoCBEQkcoJnF1b3Q7JXAmcXVvdDssIG1vZGVt
KTs8YnI+CiZndDs8YnI+CiZndDsgQEAgLTM3OCwxMyArMzgwLDE4IEBAIHN0YXRpYyB2b2lkIHN0
ZV9wb3N0X29ubGluZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxicj4KJmd0Ozxicj4KJmd0
OyCgIKAgoCBncHJzID0gb2Zvbm9fZ3Byc19jcmVhdGUobW9kZW0sIE9GT05PX1ZFTkRPUl9NQk0s
PGJyPgomZ3Q7IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgJnF1b3Q7YXRt
b2RlbSZxdW90OywgZGF0YS0mZ3Q7Y2hhdCk7PGJyPgomZ3Q7IC0goCCgIGdjID0gb2Zvbm9fZ3By
c19jb250ZXh0X2NyZWF0ZShtb2RlbSwgMCwgJnF1b3Q7c3RlbW9kZW0mcXVvdDssIGRhdGEtJmd0
O2NoYXQpOzxicj4KJmd0OyAtPGJyPgomZ3Q7IC0goCCgIGlmIChncHJzICZhbXA7JmFtcDsgZ2Mp
PGJyPgomZ3Q7IC0goCCgIKAgoCCgIKAgb2Zvbm9fZ3Byc19hZGRfY29udGV4dChncHJzLCBnYyk7
PGJyPgomZ3Q7ICsgoCCgIGlmIChncHJzKSB7PGJyPgomZ3Q7ICsgoCCgIKAgoCCgIKAgZm9yIChp
ID0gMDsgaSAmbHQ7IE1BWF9QRFBfQ09OVEVYVFM7IGkrKykgezxicj4KJmd0OyArIKAgoCCgIKAg
oCCgIKAgoCCgIKAgZ2MgPSBvZm9ub19ncHJzX2NvbnRleHRfY3JlYXRlKDxicj4KJmd0OyArIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIG1vZGVtLCAwLCAmcXVvdDtzdGVtb2Rl
bSZxdW90OywgZGF0YS0mZ3Q7Y2hhdCk7PGJyPgomZ3Q7ICsgoCCgIKAgoCCgIKAgoCCgIKAgoCBp
ZiAoZ2MgPT0gTlVMTCk8YnI+CiZndDsgKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgYnJl
YWs7PGJyPgomZ3Q7ICs8YnI+CiZndDsgKyCgIKAgoCCgIKAgoCCgIKAgoCCgIG9mb25vX2dwcnNf
YWRkX2NvbnRleHQoZ3BycywgZ2MpOzxicj4KJmd0OyArIKAgoCCgIKAgoCCgIH08YnI+CiZndDsg
KyCgIKAgfTxicj4KPGJyPgo8L2Rpdj48L2Rpdj55b3UgZG8gbm90IG5lZWQgdG8gY3JlYXRlIHRo
ZSBHUFJTIGNvbnRleHQgYXRvbSBtdWx0aXBsZSB0aW1lcy4gWW91IGNhbjxicj4KanVzdCBhZGQg
dGhlIGdjIG11bHRpcGxlIHRpbWVzLjxicj4KPGJyPgpTbyBJIGp1c3Qgd2FubmEgbWFrZSBzdXJl
IHRoYXQgeW91IGd1eXMgd2FubmEgaGF2ZSBtdWx0aXBsZSBHUFJTIGNvbnRleHQ8YnI+CmF0b20g
aW5zdGFuY2VzLiBGb3IgdGhpbmdzIGxpa2UgUFBQIGFuZCBSYXdJUCB3ZSBoYXZlIG5vIG90aGVy
IGNob2ljZSw8YnI+CmJ1dCBmb3IgZXhhbXBsZSBJU0kgaXMgYSBiaXQgbW9yZSBmbGV4aWJsZSBo
ZXJlLiBUaGF0IGlzIHRoZSByZWFzb24gd2h5PGJyPgp3ZSBkbyBhbGxvdyBpdC4gTWF5YmUgQ0FJ
RiBpcyBhcyBmbGV4aWJsZS48YnI+Cjxicj4KSXQgaXMgYSBiaXQgcXVlc3Rpb24gYWJvdXQgcmVz
b3VyY2VzIHRoYXQgYXJlIHVzZWQuIEkgYW0gZmluZSBlaXRoZXI8YnI+CndheSwgYnV0IEkgbmVl
ZCB5b3UgdG8gYXQgbGVhc3QgdGhpbmsgYWJvdXQgaXQgOyk8YnI+Cjxicj4KUmVnYXJkczxicj4K
PGJyPgpNYXJjZWw8YnI+Cjxicj48L2Jsb2NrcXVvdGU+PGRpdj6gPC9kaXY+PGRpdj5IaSBNYXJj
ZWwsPGJyPlRoYW5rcyBmb3IgeW91ciBpbnB1dC4gV2UgaGF2ZSBnaXZlbiB0aGlzIHNvbWUgbW9y
ZSB0aG91Z2h0IGFuZCBkaXNjdXNzZWQgYW1vbmdzdCB1cywgYW5kIHdlIHdvdWxkIGxpa2UgdG8g
Z28gZm9yIHRoZSBzb2x1dGlvbiBhcyBpdCBpcywgYWRkaW5nIG11bHRpcGxlIEdQUlMgY29udGV4
dCBhdG9tIGluc3RhbmNlcy4gSSBob3BlIHRoaXMgaXMgT0sgd2l0aCB5b3UuPGJyPgo8YnI+SW4g
dGhlIGRyaXZlciBvdXIgaW50ZXJuYWwgZ3Byc19jb250ZXh0X2RhdGEgaXMgYXNzb2NpYXRlZCB3
aXRoIHRoZSBvZm9ub19ncHJzX2NvbnRleHQuIElmIHdlIHdlcmUgdG8gaGF2ZSBvbmx5IG9uZSBn
Yywgd2Ugd291bGQgaGF2ZSB0byBoYW5kbGUgYWxsIHRoZSBhY3RpdmF0aW9ucyB3aXRoIHRoZSBz
YW1lIGdwcnNfY29udGV4dF9kYXRhLCBhbmQgdGhhdCB3b3VsZCBicmluZyB1cyBiYWNrIHRvIHdo
ZXJlIHdlIHdlcmUsIHdpdGggYSBzaWduaWZpY2FudGx5IG1vcmUgY29tcGxleCBpbXBsZW1lbnRh
dGlvbi4gPGJyPgo8YnI+QnIgTWFyaXQ8YnI+oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IGJvcmRlci1sZWZ0OiAx
cHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxlZnQ6IDFleDsiPgo8YnI+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBt
YWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9m
b25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8v
b2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29m
b25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============3199837317619393308==--

