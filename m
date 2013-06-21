Content-Type: multipart/mixed; boundary="===============5378576766832066720=="
MIME-Version: 1.0
From: Yang TengChou <threefure@hotmail.com>
Subject: RE: CDMA voicecall driver
Date: Sat, 22 Jun 2013 03:44:17 +0800
Message-ID: <BAY164-W607333865215EAC06C7422A58F0@phx.gbl>
In-Reply-To: <51C48784.5040907@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5378576766832066720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Date: Fri, 21 Jun 2013 12:04:04 -0500
> From: denkenz(a)gmail.com
> To: ofono(a)ofono.org
> Subject: Re: CDMA voicecall driver
> =

> Hi,
> =

>  > They do have a lot of differences but not in dbus method layer. For
> > example,
> > ofono_voicecall_driver has methods like dial, answer, hangup all,
> > hold_all_active...etc,
> > I believe cdma will have almost same methods like GSM. When we are using
> > them in
> > application layer, we will call the same method name but different kind
> > of modem driver.
> > I am wondering why ofono created two different interface name and provi=
de
> > the same call method?
> =

> The basics are the same, sure.  However, once you get into the details =

> of three way calls, call waiting, multiparty calls, etc the logic and =

> API becomes vastly different.
> =

> Not to mention the various differences between carriers and their =

> specific extensions.
> =

> Bottom line is, compared to insanity of GSM/UMTS, CDMA is even more of a =

> mess and the API needs to evolve on its own.  In the future, if it makes =

> sense to unify them, then we can do so.  That time is not now.
>> Regards,
> -Denis
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

Hi Denis,I get it. Thanks a lot for your answer.
Sincerely,TengChou Yang 		 	   		 =20

--===============5378576766832066720==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+DQo8aGVhZD4NCjxzdHlsZT48IS0tDQouaG1tZXNzYWdlIFANCnsNCm1hcmdpbjowcHg7
DQpwYWRkaW5nOjBweA0KfQ0KYm9keS5obW1lc3NhZ2UNCnsNCmZvbnQtc2l6ZTogMTJwdDsNCmZv
bnQtZmFtaWx5OrdzstOp+sXpDQp9DQotLT48L3N0eWxlPjwvaGVhZD4NCjxib2R5IGNsYXNzPSdo
bW1lc3NhZ2UnPjxkaXYgZGlyPSdsdHInPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEycHQ7Ij4m
Z3Q7IERhdGU6IEZyaSwgMjEgSnVuIDIwMTMgMTI6MDQ6MDQgLTA1MDA8L3NwYW4+PGJyPjxkaXY+
Jmd0OyBGcm9tOiBkZW5rZW56QGdtYWlsLmNvbTxicj4mZ3Q7IFRvOiBvZm9ub0BvZm9uby5vcmc8
YnI+Jmd0OyBTdWJqZWN0OiBSZTogQ0RNQSB2b2ljZWNhbGwgZHJpdmVyPGJyPiZndDsgPGJyPiZn
dDsgSGksPGJyPiZndDsgPGJyPiZndDsgICZndDsgVGhleSBkbyBoYXZlIGEgbG90IG9mIGRpZmZl
cmVuY2VzIGJ1dCBub3QgaW4gZGJ1cyBtZXRob2QgbGF5ZXIuIEZvcjxicj4mZ3Q7ICZndDsgZXhh
bXBsZSw8YnI+Jmd0OyAmZ3Q7IG9mb25vX3ZvaWNlY2FsbF9kcml2ZXIgaGFzIG1ldGhvZHMgbGlr
ZSBkaWFsLCBhbnN3ZXIsIGhhbmd1cCBhbGwsPGJyPiZndDsgJmd0OyBob2xkX2FsbF9hY3RpdmUu
Li5ldGMsPGJyPiZndDsgJmd0OyBJIGJlbGlldmUgY2RtYSB3aWxsIGhhdmUgYWxtb3N0IHNhbWUg
bWV0aG9kcyBsaWtlIEdTTS4gV2hlbiB3ZSBhcmUgdXNpbmc8YnI+Jmd0OyAmZ3Q7IHRoZW0gaW48
YnI+Jmd0OyAmZ3Q7IGFwcGxpY2F0aW9uIGxheWVyLCB3ZSB3aWxsIGNhbGwgdGhlIHNhbWUgbWV0
aG9kIG5hbWUgYnV0IGRpZmZlcmVudCBraW5kPGJyPiZndDsgJmd0OyBvZiBtb2RlbSBkcml2ZXIu
PGJyPiZndDsgJmd0OyBJIGFtIHdvbmRlcmluZyB3aHkgb2Zvbm8gY3JlYXRlZCB0d28gZGlmZmVy
ZW50IGludGVyZmFjZSBuYW1lIGFuZCBwcm92aWRlPGJyPiZndDsgJmd0OyB0aGUgc2FtZSBjYWxs
IG1ldGhvZD88YnI+Jmd0OyA8YnI+Jmd0OyBUaGUgYmFzaWNzIGFyZSB0aGUgc2FtZSwgc3VyZS4g
IEhvd2V2ZXIsIG9uY2UgeW91IGdldCBpbnRvIHRoZSBkZXRhaWxzIDxicj4mZ3Q7IG9mIHRocmVl
IHdheSBjYWxscywgY2FsbCB3YWl0aW5nLCBtdWx0aXBhcnR5IGNhbGxzLCBldGMgdGhlIGxvZ2lj
IGFuZCA8YnI+Jmd0OyBBUEkgYmVjb21lcyB2YXN0bHkgZGlmZmVyZW50Ljxicj4mZ3Q7IDxicj4m
Z3Q7IE5vdCB0byBtZW50aW9uIHRoZSB2YXJpb3VzIGRpZmZlcmVuY2VzIGJldHdlZW4gY2Fycmll
cnMgYW5kIHRoZWlyIDxicj4mZ3Q7IHNwZWNpZmljIGV4dGVuc2lvbnMuPGJyPiZndDsgPGJyPiZn
dDsgQm90dG9tIGxpbmUgaXMsIGNvbXBhcmVkIHRvIGluc2FuaXR5IG9mIEdTTS9VTVRTLCBDRE1B
IGlzIGV2ZW4gbW9yZSBvZiBhIDxicj4mZ3Q7IG1lc3MgYW5kIHRoZSBBUEkgbmVlZHMgdG8gZXZv
bHZlIG9uIGl0cyBvd24uICBJbiB0aGUgZnV0dXJlLCBpZiBpdCBtYWtlcyA8YnI+Jmd0OyBzZW5z
ZSB0byB1bmlmeSB0aGVtLCB0aGVuIHdlIGNhbiBkbyBzby4gIFRoYXQgdGltZSBpcyBub3Qgbm93
Ljxicj4mZ3Q7PC9kaXY+PGRpdj4mZ3Q7IFJlZ2FyZHMsPGJyPiZndDsgLURlbmlzPGJyPiZndDsg
PGJyPiZndDsgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188
YnI+Jmd0OyBvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+Jmd0OyBvZm9ub0BvZm9uby5vcmc8YnI+Jmd0
OyBodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPGJyPjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+SGkgRGVuaXMsPC9kaXY+PGRpdj5JIGdldCBpdC4gVGhhbmtz
IGEgbG90IGZvciB5b3VyIGFuc3dlci48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlNpbmNlcmVs
eSw8L2Rpdj48ZGl2PlRlbmdDaG91IFlhbmc8L2Rpdj4gCQkgCSAgIAkJICA8L2Rpdj48L2JvZHk+
DQo8L2h0bWw+
--===============5378576766832066720==--

