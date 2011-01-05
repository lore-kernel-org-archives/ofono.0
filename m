Content-Type: multipart/mixed; boundary="===============9170920903752686359=="
MIME-Version: 1.0
From: Marit Sofie Henriksen <maritsofie.henriksen8@gmail.com>
Subject: Re: [PATCHv2] network: query signal strength
Date: Wed, 05 Jan 2011 16:10:27 +0100
Message-ID: <AANLkTimXz8yj79r1MTyA=4jnfnuCR9MGC+D9gtJu0XLA@mail.gmail.com>
In-Reply-To: <AANLkTikxRG7QNtbDbDyofL-ouC1J8eq9=av=W2+O7516@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9170920903752686359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/1/5 Aki Niemi <aki@protocolpolice.com>

> Hi Marit,
>
> 2010/12/17 Marit Henriksen <maritsofie.henriksen8@gmail.com>:
> > From: Marit Henriksen <marit.henriksen@stericsson.com>
> >
> > Signal strength is set to -1 whenever registration status changes
> > and differs from registered or roaming. When registration status
> > changes again to registered or roaming, the signal strength needs to
> > be updated, added query towards driver to get it.
>
> Typically the modem updates signal strength along with registration
> status.  What are you trying to achieve here?  Is this to avoid
> problems caused by reordering, i.e., ofono_netreg_strength_notify()
> getting called before ofono_netreg_status_notify()?
>
>
The STE modem does not seem to behave like you describe, updating
signal strength along with registration status. We use CIEV for
signal strength updates, and when testing I observed that registration
status was often changed without signal strength being updated (got CREG
but not CIEV from modem). So ofono_netreg_status_notify() was called
several times (and with states different from registered or roaming) without

ofono_netreg_strength_notify() being called. Thus signal_strength was set
to -1, and the Strength property was not reported.



<snip>
>
> > @@ -1319,6 +1332,9 @@ void ofono_netreg_status_notify(struct ofono_netr=
eg
> *netreg, int status,
> >                if (netreg->driver->current_operator)
> >                        netreg->driver->current_operator(netreg,
> >                                        current_operator_callback,
> netreg);
>
> Add extra line feed here.
>

I'll send a new patch.

regards, Marit

>
> > +               if (netreg->driver->strength)
> > +                       netreg->driver->strength(netreg,
> > +                                       signal_strength_callback,
> netreg);
> >        } else {
> >                struct ofono_error error;
> >
>
> Cheers,
> Aki
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============9170920903752686359==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMS8xLzUgQWtpIE5pZW1pIDxzcGFu
IGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmFraUBwcm90b2NvbHBvbGljZS5jb20iPmFr
aUBwcm90b2NvbHBvbGljZS5jb208L2E+Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVyLWxl
ZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+Ckhp
IE1hcml0LDxicj4KPGJyPgoyMDEwLzEyLzE3IE1hcml0IEhlbnJpa3NlbiAmbHQ7PGEgaHJlZj0i
bWFpbHRvOm1hcml0c29maWUuaGVucmlrc2VuOEBnbWFpbC5jb20iPm1hcml0c29maWUuaGVucmlr
c2VuOEBnbWFpbC5jb208L2E+Jmd0Ozo8YnI+CjxkaXYgY2xhc3M9ImltIj4mZ3Q7IEZyb206IE1h
cml0IEhlbnJpa3NlbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1hcml0LmhlbnJpa3NlbkBzdGVyaWNz
c29uLmNvbSI+bWFyaXQuaGVucmlrc2VuQHN0ZXJpY3Nzb24uY29tPC9hPiZndDs8YnI+CiZndDs8
YnI+CiZndDsgU2lnbmFsIHN0cmVuZ3RoIGlzIHNldCB0byAtMSB3aGVuZXZlciByZWdpc3RyYXRp
b24gc3RhdHVzIGNoYW5nZXM8YnI+CiZndDsgYW5kIGRpZmZlcnMgZnJvbSByZWdpc3RlcmVkIG9y
IHJvYW1pbmcuIFdoZW4gcmVnaXN0cmF0aW9uIHN0YXR1czxicj4KJmd0OyBjaGFuZ2VzIGFnYWlu
IHRvIHJlZ2lzdGVyZWQgb3Igcm9hbWluZywgdGhlIHNpZ25hbCBzdHJlbmd0aCBuZWVkcyB0bzxi
cj4KJmd0OyBiZSB1cGRhdGVkLCBhZGRlZCBxdWVyeSB0b3dhcmRzIGRyaXZlciB0byBnZXQgaXQu
PGJyPgo8YnI+CjwvZGl2PlR5cGljYWxseSB0aGUgbW9kZW0gdXBkYXRlcyBzaWduYWwgc3RyZW5n
dGggYWxvbmcgd2l0aCByZWdpc3RyYXRpb248YnI+CnN0YXR1cy4goFdoYXQgYXJlIHlvdSB0cnlp
bmcgdG8gYWNoaWV2ZSBoZXJlPyCgSXMgdGhpcyB0byBhdm9pZDxicj4KcHJvYmxlbXMgY2F1c2Vk
IGJ5IHJlb3JkZXJpbmcsIGkuZS4sIG9mb25vX25ldHJlZ19zdHJlbmd0aF9ub3RpZnkoKTxicj4K
Z2V0dGluZyBjYWxsZWQgYmVmb3JlIG9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KCk/PGJyPgo8
YnI+PC9ibG9ja3F1b3RlPjxkaXY+oDwvZGl2PjxkaXY+VGhlIFNURSBtb2RlbSBkb2VzIG5vdCBz
ZWVtIHRvIGJlaGF2ZSBsaWtlIHlvdSBkZXNjcmliZSwgdXBkYXRpbmcgPGJyPnNpZ25hbCBzdHJl
bmd0aCBhbG9uZyB3aXRoIHJlZ2lzdHJhdGlvbiBzdGF0dXMuIFdlIHVzZSBDSUVWIGZvciA8YnI+
c2lnbmFsIHN0cmVuZ3RoIHVwZGF0ZXMsIGFuZCB3aGVuIHRlc3RpbmcgSSBvYnNlcnZlZCB0aGF0
IHJlZ2lzdHJhdGlvbiA8YnI+CnN0YXR1cyB3YXMgb2Z0ZW4gY2hhbmdlZCB3aXRob3V0IHNpZ25h
bCBzdHJlbmd0aCBiZWluZyB1cGRhdGVkIChnb3QgQ1JFRzxicj5idXQgbm90IENJRVYgZnJvbSBt
b2RlbSkuIFNvIG9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KCkgd2FzIGNhbGxlZCA8YnI+c2V2
ZXJhbCB0aW1lcyAoYW5kIHdpdGggc3RhdGVzIGRpZmZlcmVudCBmcm9tIHJlZ2lzdGVyZWQgb3Ig
cm9hbWluZykgd2l0aG91dCA8YnI+Cm9mb25vX25ldHJlZ19zdHJlbmd0aF9ub3RpZnkoKSBiZWlu
ZyBjYWxsZWQuIFRodXMgc2lnbmFsX3N0cmVuZ3RoIHdhcyBzZXQgPGJyPnRvIC0xLCBhbmQgdGhl
IFN0cmVuZ3RoIHByb3BlcnR5IHdhcyBub3QgcmVwb3J0ZWQuPGJyPjxicj48YnI+PGJyPjwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAw
cHQgMC44ZXg7IGJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRk
aW5nLWxlZnQ6IDFleDsiPgoKJmx0O3NuaXAmZ3Q7PGJyPgo8ZGl2IGNsYXNzPSJpbSI+PGJyPgom
Z3Q7IEBAIC0xMzE5LDYgKzEzMzIsOSBAQCB2b2lkIG9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5
KHN0cnVjdCBvZm9ub19uZXRyZWcgKm5ldHJlZywgaW50IHN0YXR1cyw8YnI+CiZndDsgoCCgIKAg
oCCgIKAgoCCgaWYgKG5ldHJlZy0mZ3Q7ZHJpdmVyLSZndDtjdXJyZW50X29wZXJhdG9yKTxicj4K
Jmd0OyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoG5ldHJlZy0mZ3Q7ZHJpdmVyLSZndDtjdXJyZW50
X29wZXJhdG9yKG5ldHJlZyw8YnI+CiZndDsgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgY3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaywgbmV0cmVnKTs8YnI+Cjxicj4KPC9k
aXY+QWRkIGV4dHJhIGxpbmUgZmVlZCBoZXJlLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+SSYj
Mzk7bGwgc2VuZCBhIG5ldyBwYXRjaC4gPGJyPjxicj5yZWdhcmRzLCBNYXJpdDxicj48L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0
IDAuOGV4OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFkZGlu
Zy1sZWZ0OiAxZXg7Ij4KCjxicj4KJmd0OyArIKAgoCCgIKAgoCCgIKAgaWYgKG5ldHJlZy0mZ3Q7
ZHJpdmVyLSZndDtzdHJlbmd0aCk8YnI+CjxkaXYgY2xhc3M9ImltIj4mZ3Q7ICsgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIG5ldHJlZy0mZ3Q7ZHJpdmVyLSZndDtzdHJlbmd0aChuZXRyZWcsPGJyPgom
Z3Q7ICsgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBzaWduYWxfc3RyZW5n
dGhfY2FsbGJhY2ssIG5ldHJlZyk7PGJyPgomZ3Q7IKAgoCCgIKB9IGVsc2Ugezxicj4KJmd0OyCg
IKAgoCCgIKAgoCCgIKBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgZXJyb3I7PGJyPgomZ3Q7PGJyPgo8YnI+
CjwvZGl2PkNoZWVycyw8YnI+CkFraTxicj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFp
bHRvOm9mb25vQG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KPGEgaHJlZj0iaHR0
cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6
Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9k
aXY+PGJyPgo=

--===============9170920903752686359==--

