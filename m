Content-Type: multipart/mixed; boundary="===============7776882197670548063=="
MIME-Version: 1.0
From: Marit Sofie Henriksen <maritsofie.henriksen8@gmail.com>
Subject: Re: [PATCH 1/2] ste: Add support for multiple pdp contexts.
Date: Fri, 18 Feb 2011 09:29:13 +0100
Message-ID: <AANLkTinOTC27SU+7SpcyYEhiSWpzJrcKNyTHzgxzR-un@mail.gmail.com>
In-Reply-To: <AANLkTikZ3TCtJhfWXZqUuwVWOAweqSiQW6LKjKCO=dTT@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7776882197670548063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/2/9 Marit Sofie Henriksen <maritsofie.henriksen8@gmail.com>

>
>
> 2011/2/8 Marcel Holtmann <marcel@holtmann.org>
>
> Hi Marit,
>>
>> > diff --git a/plugins/ste.c b/plugins/ste.c
>> > index cf8aed8..749c4f3 100644
>> > --- a/plugins/ste.c
>> > +++ b/plugins/ste.c
>> > @@ -66,6 +66,7 @@
>> >  #include <drivers/stemodem/if_caif.h>
>> >
>> >  #define NUM_CHAT     1
>> > +#define MAX_PDP_CONTEXTS     4
>> >
>> >  static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
>> >
>> > @@ -363,6 +364,7 @@ static void ste_post_online(struct ofono_modem
>> *modem)
>> >       struct ofono_message_waiting *mw;
>> >       struct ofono_gprs *gprs;
>> >       struct ofono_gprs_context *gc;
>> > +     int i;
>> >
>> >       DBG("%p", modem);
>> >
>> > @@ -378,13 +380,18 @@ static void ste_post_online(struct ofono_modem
>> *modem)
>> >
>> >       gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
>> >                                       "atmodem", data->chat);
>> > -     gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->cha=
t);
>> > -
>> > -     if (gprs && gc)
>> > -             ofono_gprs_add_context(gprs, gc);
>> > +     if (gprs) {
>> > +             for (i =3D 0; i < MAX_PDP_CONTEXTS; i++) {
>> > +                     gc =3D ofono_gprs_context_create(
>> > +                                     modem, 0, "stemodem", data->chat=
);
>> > +                     if (gc =3D=3D NULL)
>> > +                             break;
>> > +
>> > +                     ofono_gprs_add_context(gprs, gc);
>> > +             }
>> > +     }
>>
>> you do not need to create the GPRS context atom multiple times. You can
>> just add the gc multiple times.
>>
>> So I just wanna make sure that you guys wanna have multiple GPRS context
>> atom instances. For things like PPP and RawIP we have no other choice,
>> but for example ISI is a bit more flexible here. That is the reason why
>> we do allow it. Maybe CAIF is as flexible.
>>
>> It is a bit question about resources that are used. I am fine either
>> way, but I need you to at least think about it ;)
>>
>> Regards
>>
>> Marcel
>>
>>
> Hi Marcel,
> Thanks for your input. We have given this some more thought and discussed
> amongst us, and we would like to go for the solution as it is, adding
> multiple GPRS context atom instances. I hope this is OK with you.
>
> In the driver our internal gprs_context_data is associated with the
> ofono_gprs_context. If we were to have only one gc, we would have to hand=
le
> all the activations with the same gprs_context_data, and that would bring=
 us
> back to where we were, with a significantly more complex implementation.
>
> Br Marit
>

Hi.
Is this approach ok, and has anyone had the chance to look at these pathces?
(this one plus [PATCH 2/2] stemodem: Add support for multiple pdp contexts)

br Marit




>
>
>>
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> http://lists.ofono.org/listinfo/ofono
>>
>
>

--===============7776882197670548063==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMS8yLzkgTWFyaXQgU29maWUgSGVu
cmlrc2VuIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOm1hcml0c29maWUuaGVu
cmlrc2VuOEBnbWFpbC5jb20iPm1hcml0c29maWUuaGVucmlrc2VuOEBnbWFpbC5jb208L2E+Jmd0
Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQs
IDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+Cjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVv
dGUiPjIwMTEvMi84IE1hcmNlbCBIb2x0bWFubiA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9
Im1haWx0bzptYXJjZWxAaG9sdG1hbm4ub3JnIiB0YXJnZXQ9Il9ibGFuayI+bWFyY2VsQGhvbHRt
YW5uLm9yZzwvYT4mZ3Q7PC9zcGFuPjxkaXY+PGRpdj48L2Rpdj48ZGl2IGNsYXNzPSJoNSI+PGJy
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAw
cHQgMC44ZXg7IGJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRk
aW5nLWxlZnQ6IDFleDsiPgoKSGkgTWFyaXQsPGJyPgo8ZGl2PjxkaXY+PC9kaXY+PGRpdj48YnI+
CiZndDsgZGlmZiAtLWdpdCBhL3BsdWdpbnMvc3RlLmMgYi9wbHVnaW5zL3N0ZS5jPGJyPgomZ3Q7
IGluZGV4IGNmOGFlZDguLjc0OWM0ZjMgMTAwNjQ0PGJyPgomZ3Q7IC0tLSBhL3BsdWdpbnMvc3Rl
LmM8YnI+CiZndDsgKysrIGIvcGx1Z2lucy9zdGUuYzxicj4KJmd0OyBAQCAtNjYsNiArNjYsNyBA
QDxicj4KJmd0OyCgI2luY2x1ZGUgJmx0O2RyaXZlcnMvc3RlbW9kZW0vaWZfY2FpZi5oJmd0Ozxi
cj4KJmd0Ozxicj4KJmd0OyCgI2RlZmluZSBOVU1fQ0hBVCCgIKAgMTxicj4KJmd0OyArI2RlZmlu
ZSBNQVhfUERQX0NPTlRFWFRTIKAgoCA0PGJyPgomZ3Q7PGJyPgomZ3Q7IKBzdGF0aWMgY29uc3Qg
Y2hhciAqY3Bpbl9wcmVmaXhbXSA9IHsgJnF1b3Q7K0NQSU46JnF1b3Q7LCBOVUxMIH07PGJyPgom
Z3Q7PGJyPgomZ3Q7IEBAIC0zNjMsNiArMzY0LDcgQEAgc3RhdGljIHZvaWQgc3RlX3Bvc3Rfb25s
aW5lKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pPGJyPgomZ3Q7IKAgoCCgIHN0cnVjdCBvZm9u
b19tZXNzYWdlX3dhaXRpbmcgKm13Ozxicj4KJmd0OyCgIKAgoCBzdHJ1Y3Qgb2Zvbm9fZ3BycyAq
Z3Byczs8YnI+CiZndDsgoCCgIKAgc3RydWN0IG9mb25vX2dwcnNfY29udGV4dCAqZ2M7PGJyPgom
Z3Q7ICsgoCCgIGludCBpOzxicj4KJmd0Ozxicj4KJmd0OyCgIKAgoCBEQkcoJnF1b3Q7JXAmcXVv
dDssIG1vZGVtKTs8YnI+CiZndDs8YnI+CiZndDsgQEAgLTM3OCwxMyArMzgwLDE4IEBAIHN0YXRp
YyB2b2lkIHN0ZV9wb3N0X29ubGluZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxicj4KJmd0
Ozxicj4KJmd0OyCgIKAgoCBncHJzID0gb2Zvbm9fZ3Byc19jcmVhdGUobW9kZW0sIE9GT05PX1ZF
TkRPUl9NQk0sPGJyPgomZ3Q7IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
JnF1b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7Y2hhdCk7PGJyPgomZ3Q7IC0goCCgIGdjID0g
b2Zvbm9fZ3Byc19jb250ZXh0X2NyZWF0ZShtb2RlbSwgMCwgJnF1b3Q7c3RlbW9kZW0mcXVvdDss
IGRhdGEtJmd0O2NoYXQpOzxicj4KJmd0OyAtPGJyPgomZ3Q7IC0goCCgIGlmIChncHJzICZhbXA7
JmFtcDsgZ2MpPGJyPgomZ3Q7IC0goCCgIKAgoCCgIKAgb2Zvbm9fZ3Byc19hZGRfY29udGV4dChn
cHJzLCBnYyk7PGJyPgomZ3Q7ICsgoCCgIGlmIChncHJzKSB7PGJyPgomZ3Q7ICsgoCCgIKAgoCCg
IKAgZm9yIChpID0gMDsgaSAmbHQ7IE1BWF9QRFBfQ09OVEVYVFM7IGkrKykgezxicj4KJmd0OyAr
IKAgoCCgIKAgoCCgIKAgoCCgIKAgZ2MgPSBvZm9ub19ncHJzX2NvbnRleHRfY3JlYXRlKDxicj4K
Jmd0OyArIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIG1vZGVtLCAwLCAmcXVv
dDtzdGVtb2RlbSZxdW90OywgZGF0YS0mZ3Q7Y2hhdCk7PGJyPgomZ3Q7ICsgoCCgIKAgoCCgIKAg
oCCgIKAgoCBpZiAoZ2MgPT0gTlVMTCk8YnI+CiZndDsgKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgYnJlYWs7PGJyPgomZ3Q7ICs8YnI+CiZndDsgKyCgIKAgoCCgIKAgoCCgIKAgoCCgIG9m
b25vX2dwcnNfYWRkX2NvbnRleHQoZ3BycywgZ2MpOzxicj4KJmd0OyArIKAgoCCgIKAgoCCgIH08
YnI+CiZndDsgKyCgIKAgfTxicj4KPGJyPgo8L2Rpdj48L2Rpdj55b3UgZG8gbm90IG5lZWQgdG8g
Y3JlYXRlIHRoZSBHUFJTIGNvbnRleHQgYXRvbSBtdWx0aXBsZSB0aW1lcy4gWW91IGNhbjxicj4K
anVzdCBhZGQgdGhlIGdjIG11bHRpcGxlIHRpbWVzLjxicj4KPGJyPgpTbyBJIGp1c3Qgd2FubmEg
bWFrZSBzdXJlIHRoYXQgeW91IGd1eXMgd2FubmEgaGF2ZSBtdWx0aXBsZSBHUFJTIGNvbnRleHQ8
YnI+CmF0b20gaW5zdGFuY2VzLiBGb3IgdGhpbmdzIGxpa2UgUFBQIGFuZCBSYXdJUCB3ZSBoYXZl
IG5vIG90aGVyIGNob2ljZSw8YnI+CmJ1dCBmb3IgZXhhbXBsZSBJU0kgaXMgYSBiaXQgbW9yZSBm
bGV4aWJsZSBoZXJlLiBUaGF0IGlzIHRoZSByZWFzb24gd2h5PGJyPgp3ZSBkbyBhbGxvdyBpdC4g
TWF5YmUgQ0FJRiBpcyBhcyBmbGV4aWJsZS48YnI+Cjxicj4KSXQgaXMgYSBiaXQgcXVlc3Rpb24g
YWJvdXQgcmVzb3VyY2VzIHRoYXQgYXJlIHVzZWQuIEkgYW0gZmluZSBlaXRoZXI8YnI+CndheSwg
YnV0IEkgbmVlZCB5b3UgdG8gYXQgbGVhc3QgdGhpbmsgYWJvdXQgaXQgOyk8YnI+Cjxicj4KUmVn
YXJkczxicj4KPGJyPgpNYXJjZWw8YnI+Cjxicj48L2Jsb2NrcXVvdGU+PGRpdj6gPC9kaXY+PC9k
aXY+PC9kaXY+PGRpdj5IaSBNYXJjZWwsPGJyPlRoYW5rcyBmb3IgeW91ciBpbnB1dC4gV2UgaGF2
ZSBnaXZlbiB0aGlzIHNvbWUgbW9yZSB0aG91Z2h0IGFuZCBkaXNjdXNzZWQgYW1vbmdzdCB1cywg
YW5kIHdlIHdvdWxkIGxpa2UgdG8gZ28gZm9yIHRoZSBzb2x1dGlvbiBhcyBpdCBpcywgYWRkaW5n
IG11bHRpcGxlIEdQUlMgY29udGV4dCBhdG9tIGluc3RhbmNlcy4gSSBob3BlIHRoaXMgaXMgT0sg
d2l0aCB5b3UuPGJyPgoKPGJyPkluIHRoZSBkcml2ZXIgb3VyIGludGVybmFsIGdwcnNfY29udGV4
dF9kYXRhIGlzIGFzc29jaWF0ZWQgd2l0aCB0aGUgb2Zvbm9fZ3Byc19jb250ZXh0LiBJZiB3ZSB3
ZXJlIHRvIGhhdmUgb25seSBvbmUgZ2MsIHdlIHdvdWxkIGhhdmUgdG8gaGFuZGxlIGFsbCB0aGUg
YWN0aXZhdGlvbnMgd2l0aCB0aGUgc2FtZSBncHJzX2NvbnRleHRfZGF0YSwgYW5kIHRoYXQgd291
bGQgYnJpbmcgdXMgYmFjayB0byB3aGVyZSB3ZSB3ZXJlLCB3aXRoIGEgc2lnbmlmaWNhbnRseSBt
b3JlIGNvbXBsZXggaW1wbGVtZW50YXRpb24uIDxicj4KCjxicj5CciBNYXJpdDxicj48L2Rpdj48
L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+SGkuPGJyPklzIHRoaXMgYXBwcm9hY2ggb2ssIGFu
ZCBoYXMgYW55b25lIGhhZCB0aGUgY2hhbmNlIHRvIGxvb2sgYXQgdGhlc2UgcGF0aGNlcz8gKHRo
aXMgb25lIHBsdXMgW1BBVENIIDIvMl0gc3RlbW9kZW06IEFkZCBzdXBwb3J0IGZvciBtdWx0aXBs
ZSBwZHAgY29udGV4dHMpPGJyPjxicj5iciBNYXJpdDxicj4KPGJyPjxicj6gPC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhl
eDsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVm
dDogMWV4OyI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXY+oDwvZGl2PjxkaXYgY2xhc3M9
ImltIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAw
cHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsg
cGFkZGluZy1sZWZ0OiAxZXg7Ij4KCjxicj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFp
bHRvOm9mb25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9mb25vLm9yZzwvYT48
YnI+CjxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iIHRhcmdl
dD0iX2JsYW5rIj5odHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vPC9hPjxicj4K
PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============7776882197670548063==--

