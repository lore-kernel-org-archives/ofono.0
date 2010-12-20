Content-Type: multipart/mixed; boundary="===============2989040557733444773=="
MIME-Version: 1.0
From: Marit Sofie Henriksen <maritsofie.henriksen8@gmail.com>
Subject: Re: [PATCH] stemodem: Fix for MT call not working when caller id is
 hidden.
Date: Mon, 20 Dec 2010 13:59:30 +0100
Message-ID: <AANLkTikvu+7+xBSiZBNaBLBE6VJGzNm1RWu5im-Bo-00@mail.gmail.com>
In-Reply-To: <4D0B8B41.8020801@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2989040557733444773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/12/17 Denis Kenzior <denkenz@gmail.com>

> Hi Marit,
>
> On 12/16/2010 07:56 AM, Marit Henriksen wrote:
> > From: Marit Henriksen <marit.henriksen@stericsson.com>
> >
> > In *ECAV, the number will not be included if caller id is hidden.
> > Set it to an empty string in that case.
> > ---
> >  drivers/stemodem/voicecall.c |   10 +++++++---
> >  1 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
> > index b9d91d2..d900666 100644
> > --- a/drivers/stemodem/voicecall.c
> > +++ b/drivers/stemodem/voicecall.c
> > @@ -442,10 +442,14 @@ static void ecav_notify(GAtResult *result, gpoint=
er
> user_data)
> >       if (status =3D=3D CALL_STATUS_DIALING ||
> >                       status =3D=3D CALL_STATUS_WAITING ||
> >                       status =3D=3D CALL_STATUS_INCOMING) {
> > +             /*
> > +             * If caller uses hidden id, the number and
> > +             * number type might not be present. Don't
> > +             * look for type if number is not present.
> > +             */
> >               if (!g_at_result_iter_next_string(&iter, &num))
> > -                     return;
> > -
> > -             if (!g_at_result_iter_next_number(&iter, &num_type))
> > +                     num =3D "";
> > +             else if (!g_at_result_iter_next_number(&iter, &num_type))
> >                       return;
>
> One small nitpick, but you're not initializing num_type if the number is
> missing.  While this probably works out, I'd rather be a bit more
> pedantic inside the driver.  Can you initialize it to unknown number
> type (I think 128 is preferred by 27.007) in this case?
>
>
  OK, I will fix this and send a new version of the patch.

>       }
> >
>
> I also notice that you're not ever able to report the clip_validity =3D=
=3D 1
> case (e.g. number withheld).  Since oFono does make a distinction
> between the various clip_validity types, it would be nice if there was a
> way around this limitation.
>
>
I will look into that, but I would like to keep it out of this fix, and
rather do it as an improvement, OK?

regards, Marit


Regards,
> -Denis
>

--===============2989040557733444773==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMC8xMi8xNyBEZW5pcyBLZW56aW9y
IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5k
ZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDog
MXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KSGkgTWFy
aXQsPGJyPgo8ZGl2PjxkaXY+PC9kaXY+PGRpdiBjbGFzcz0iaDUiPjxicj4KT24gMTIvMTYvMjAx
MCAwNzo1NiBBTSwgTWFyaXQgSGVucmlrc2VuIHdyb3RlOjxicj4KJmd0OyBGcm9tOiBNYXJpdCBI
ZW5yaWtzZW4gJmx0OzxhIGhyZWY9Im1haWx0bzptYXJpdC5oZW5yaWtzZW5Ac3Rlcmljc3Nvbi5j
b20iPm1hcml0LmhlbnJpa3NlbkBzdGVyaWNzc29uLmNvbTwvYT4mZ3Q7PGJyPgomZ3Q7PGJyPgom
Z3Q7IEluICpFQ0FWLCB0aGUgbnVtYmVyIHdpbGwgbm90IGJlIGluY2x1ZGVkIGlmIGNhbGxlciBp
ZCBpcyBoaWRkZW4uPGJyPgomZ3Q7IFNldCBpdCB0byBhbiBlbXB0eSBzdHJpbmcgaW4gdGhhdCBj
YXNlLjxicj4KJmd0OyAtLS08YnI+CiZndDsgoGRyaXZlcnMvc3RlbW9kZW0vdm9pY2VjYWxsLmMg
fCCgIDEwICsrKysrKystLS08YnI+CiZndDsgoDEgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKTxicj4KJmd0Ozxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zdGVtb2RlbS92b2ljZWNhbGwuYyBiL2RyaXZlcnMvc3RlbW9kZW0vdm9pY2VjYWxsLmM8YnI+
CiZndDsgaW5kZXggYjlkOTFkMi4uZDkwMDY2NiAxMDA2NDQ8YnI+CiZndDsgLS0tIGEvZHJpdmVy
cy9zdGVtb2RlbS92b2ljZWNhbGwuYzxicj4KJmd0OyArKysgYi9kcml2ZXJzL3N0ZW1vZGVtL3Zv
aWNlY2FsbC5jPGJyPgomZ3Q7IEBAIC00NDIsMTAgKzQ0MiwxNCBAQCBzdGF0aWMgdm9pZCBlY2F2
X25vdGlmeShHQXRSZXN1bHQgKnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKTxicj4KJmd0OyCg
IKAgoCBpZiAoc3RhdHVzID09IENBTExfU1RBVFVTX0RJQUxJTkcgfHw8YnI+CiZndDsgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIHN0YXR1cyA9PSBDQUxMX1NUQVRVU19XQUlUSU5HIHx8PGJyPgomZ3Q7
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBzdGF0dXMgPT0gQ0FMTF9TVEFUVVNfSU5DT01JTkcpIHs8
YnI+CiZndDsgKyCgIKAgoCCgIKAgoCAvKjxicj4KJmd0OyArIKAgoCCgIKAgoCCgICogSWYgY2Fs
bGVyIHVzZXMgaGlkZGVuIGlkLCB0aGUgbnVtYmVyIGFuZDxicj4KJmd0OyArIKAgoCCgIKAgoCCg
ICogbnVtYmVyIHR5cGUgbWlnaHQgbm90IGJlIHByZXNlbnQuIERvbiYjMzk7dDxicj4KJmd0OyAr
IKAgoCCgIKAgoCCgICogbG9vayBmb3IgdHlwZSBpZiBudW1iZXIgaXMgbm90IHByZXNlbnQuPGJy
PgomZ3Q7ICsgoCCgIKAgoCCgIKAgKi88YnI+CiZndDsgoCCgIKAgoCCgIKAgoCBpZiAoIWdfYXRf
cmVzdWx0X2l0ZXJfbmV4dF9zdHJpbmcoJmFtcDtpdGVyLCAmYW1wO251bSkpPGJyPgomZ3Q7IC0g
oCCgIKAgoCCgIKAgoCCgIKAgoCByZXR1cm47PGJyPgomZ3Q7IC08YnI+CiZndDsgLSCgIKAgoCCg
IKAgoCBpZiAoIWdfYXRfcmVzdWx0X2l0ZXJfbmV4dF9udW1iZXIoJmFtcDtpdGVyLCAmYW1wO251
bV90eXBlKSk8YnI+CiZndDsgKyCgIKAgoCCgIKAgoCCgIKAgoCCgIG51bSA9ICZxdW90OyZxdW90
Ozs8YnI+CiZndDsgKyCgIKAgoCCgIKAgoCBlbHNlIGlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0
X251bWJlcigmYW1wO2l0ZXIsICZhbXA7bnVtX3R5cGUpKTxicj4KJmd0OyCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgcmV0dXJuOzxicj4KPGJyPgo8L2Rpdj48L2Rpdj5PbmUgc21hbGwgbml0cGljaywg
YnV0IHlvdSYjMzk7cmUgbm90IGluaXRpYWxpemluZyBudW1fdHlwZSBpZiB0aGUgbnVtYmVyIGlz
PGJyPgptaXNzaW5nLiCgV2hpbGUgdGhpcyBwcm9iYWJseSB3b3JrcyBvdXQsIEkmIzM5O2QgcmF0
aGVyIGJlIGEgYml0IG1vcmU8YnI+CnBlZGFudGljIGluc2lkZSB0aGUgZHJpdmVyLiCgQ2FuIHlv
dSBpbml0aWFsaXplIGl0IHRvIHVua25vd24gbnVtYmVyPGJyPgp0eXBlIChJIHRoaW5rIDEyOCBp
cyBwcmVmZXJyZWQgYnkgMjcuMDA3KSBpbiB0aGlzIGNhc2U/PGJyPgo8YnI+PC9ibG9ja3F1b3Rl
PjxkaXY+oDwvZGl2PjxkaXY+oCBPSywgSSB3aWxsIGZpeCB0aGlzIGFuZCBzZW5kIGEgbmV3IHZl
cnNpb24gb2YgdGhlIHBhdGNoLjxicj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVyLWxlZnQ6IDFw
eCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+CgomZ3Q7IKAg
oCCgIH08YnI+CiZndDs8YnI+Cjxicj4KSSBhbHNvIG5vdGljZSB0aGF0IHlvdSYjMzk7cmUgbm90
IGV2ZXIgYWJsZSB0byByZXBvcnQgdGhlIGNsaXBfdmFsaWRpdHkgPT0gMTxicj4KY2FzZSAoZS5n
LiBudW1iZXIgd2l0aGhlbGQpLiCgU2luY2Ugb0Zvbm8gZG9lcyBtYWtlIGEgZGlzdGluY3Rpb248
YnI+CmJldHdlZW4gdGhlIHZhcmlvdXMgY2xpcF92YWxpZGl0eSB0eXBlcywgaXQgd291bGQgYmUg
bmljZSBpZiB0aGVyZSB3YXMgYTxicj4Kd2F5IGFyb3VuZCB0aGlzIGxpbWl0YXRpb24uPGJyPgo8
YnI+PC9ibG9ja3F1b3RlPjxkaXY+oDwvZGl2PjxkaXY+SSB3aWxsIGxvb2sgaW50byB0aGF0LCBi
dXQgSSB3b3VsZCBsaWtlIHRvIGtlZXAgaXQgb3V0IG9mIHRoaXMgZml4LCBhbmQgcmF0aGVyIGRv
IGl0IGFzIGFuIGltcHJvdmVtZW50LCBPSz88YnI+PGJyPnJlZ2FyZHMsIE1hcml0PGJyPqA8YnI+
PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjog
MHB0IDBwdCAwcHQgMC44ZXg7IGJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAy
MDQpOyBwYWRkaW5nLWxlZnQ6IDFleDsiPgoKUmVnYXJkcyw8YnI+Cjxmb250IGNvbG9yPSIjODg4
ODg4Ij4tRGVuaXM8YnI+CjwvZm9udD48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============2989040557733444773==--

