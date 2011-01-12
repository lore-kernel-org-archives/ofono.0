Content-Type: multipart/mixed; boundary="===============2468728469752409873=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: Re: [PATCH] plugins-mbm: Combining mbm_disable and reopen_callback
Date: Wed, 12 Jan 2011 18:50:54 +0100
Message-ID: <AANLkTikAw_Qa1Y6RgQn1jV=UxWX0bZHZ=0RHgYfFO1Vh@mail.gmail.com>
In-Reply-To: <AANLkTin8kasNL6OkGO+pN2=ECKDAoERasAp7UYBL-bn4@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2468728469752409873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur

2011/1/12 Sjur Br=C3=A6ndeland <sjurbren@gmail.com>

> Hi Tomasz, don't worry the tone on the list is quite rough. If you
> like marit or I can review tomorrow, but feel free to send patch as
> well if you like. :) Sjur
>
> 2011/1/12, Tomasz Gregorek <tomasz.gregorek@gmail.com>:
> > Hi Marcel
> > I already had my solution in head and misunderstood you. I will correct
> and
> > retest it.
> > Br
> > Tomasz
> >
> > 2011/1/12 Marcel Holtmann <marcel@holtmann.org>
> >
> >> Hi Tomasz,
> >>
> >> > Combining mbm_disable and reopen_callback into one and removing 1
> second
> >> > delay between them to avoid call to reopen_callback after modem being
> >> > disconnected.
> >>
> >> have you actually tested this? This will not work since you can not
> >> reopen the TTY right away. You need that delay in between.
> >>
> >> From my previous email, I remember saying that the right fix would be =
to
> >> disarm the timer within disable. Why are we not doing that?
> >>
> >> Regards
> >>
> >> Marcel
> >>
> >>
> >> _______________________________________________
> >> ofono mailing list
> >> ofono(a)ofono.org
> >> http://lists.ofono.org/listinfo/ofono
> >>
> >
>

I don't worry ;)
Just assumed things too fast which led me to misunderstanding.
Br
Tomasz

--===============2468728469752409873==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgU2p1cjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTEvMS8xMiBTanVyIEJy
5m5kZWxhbmQgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86c2p1cmJyZW5AZ21h
aWwuY29tIj5zanVyYnJlbkBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPgpIaSBUb21hc3osIGRvbiYjMzk7dCB3
b3JyeSB0aGUgdG9uZSBvbiB0aGUgbGlzdCBpcyBxdWl0ZSByb3VnaC4gSWYgeW91PGJyPgpsaWtl
IG1hcml0IG9yIEkgY2FuIHJldmlldyB0b21vcnJvdywgYnV0IGZlZWwgZnJlZSB0byBzZW5kIHBh
dGNoIGFzPGJyPgp3ZWxsIGlmIHlvdSBsaWtlLiA6KSBTanVyPGJyPgo8YnI+CjIwMTEvMS8xMiwg
VG9tYXN6IEdyZWdvcmVrICZsdDs8YSBocmVmPSJtYWlsdG86dG9tYXN6LmdyZWdvcmVrQGdtYWls
LmNvbSI+dG9tYXN6LmdyZWdvcmVrQGdtYWlsLmNvbTwvYT4mZ3Q7Ojxicj4KPGRpdj48ZGl2Pjwv
ZGl2PjxkaXYgY2xhc3M9Img1Ij4mZ3Q7IEhpIE1hcmNlbDxicj4KJmd0OyBJIGFscmVhZHkgaGFk
IG15IHNvbHV0aW9uIGluIGhlYWQgYW5kIG1pc3VuZGVyc3Rvb2QgeW91LiBJIHdpbGwgY29ycmVj
dCBhbmQ8YnI+CiZndDsgcmV0ZXN0IGl0Ljxicj4KJmd0OyBCcjxicj4KJmd0OyBUb21hc3o8YnI+
CiZndDs8YnI+CiZndDsgMjAxMS8xLzEyIE1hcmNlbCBIb2x0bWFubiAmbHQ7PGEgaHJlZj0ibWFp
bHRvOm1hcmNlbEBob2x0bWFubi5vcmciPm1hcmNlbEBob2x0bWFubi5vcmc8L2E+Jmd0Ozxicj4K
Jmd0Ozxicj4KJmd0OyZndDsgSGkgVG9tYXN6LDxicj4KJmd0OyZndDs8YnI+CiZndDsmZ3Q7ICZn
dDsgQ29tYmluaW5nIG1ibV9kaXNhYmxlIGFuZCByZW9wZW5fY2FsbGJhY2sgaW50byBvbmUgYW5k
IHJlbW92aW5nIDEgc2Vjb25kPGJyPgomZ3Q7Jmd0OyAmZ3Q7IGRlbGF5IGJldHdlZW4gdGhlbSB0
byBhdm9pZCBjYWxsIHRvIHJlb3Blbl9jYWxsYmFjayBhZnRlciBtb2RlbSBiZWluZzxicj4KJmd0
OyZndDsgJmd0OyBkaXNjb25uZWN0ZWQuPGJyPgomZ3Q7Jmd0Ozxicj4KJmd0OyZndDsgaGF2ZSB5
b3UgYWN0dWFsbHkgdGVzdGVkIHRoaXM/IFRoaXMgd2lsbCBub3Qgd29yayBzaW5jZSB5b3UgY2Fu
IG5vdDxicj4KJmd0OyZndDsgcmVvcGVuIHRoZSBUVFkgcmlnaHQgYXdheS4gWW91IG5lZWQgdGhh
dCBkZWxheSBpbiBiZXR3ZWVuLjxicj4KJmd0OyZndDs8YnI+CiZndDsmZ3Q7IEZyb20gbXkgcHJl
dmlvdXMgZW1haWwsIEkgcmVtZW1iZXIgc2F5aW5nIHRoYXQgdGhlIHJpZ2h0IGZpeCB3b3VsZCBi
ZSB0bzxicj4KJmd0OyZndDsgZGlzYXJtIHRoZSB0aW1lciB3aXRoaW4gZGlzYWJsZS4gV2h5IGFy
ZSB3ZSBub3QgZG9pbmcgdGhhdD88YnI+CiZndDsmZ3Q7PGJyPgomZ3Q7Jmd0OyBSZWdhcmRzPGJy
PgomZ3Q7Jmd0Ozxicj4KJmd0OyZndDsgTWFyY2VsPGJyPgomZ3Q7Jmd0Ozxicj4KJmd0OyZndDs8
YnI+CiZndDsmZ3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fPGJyPgomZ3Q7Jmd0OyBvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CiZndDsmZ3Q7IDxhIGhyZWY9
Im1haWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9yZzwvYT48YnI+CiZndDsmZ3Q7
IDxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0i
X2JsYW5rIj5odHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vPC9hPjxicj4KJmd0
OyZndDs8YnI+CiZndDs8YnI+CjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+SSBk
b24mIzM5O3Qgd29ycnkgOyk8YnI+SnVzdCBhc3N1bWVkIHRoaW5ncyB0b28gZmFzdCB3aGljaCBs
ZWQgbWUgdG8gbWlzdW5kZXJzdGFuZGluZy48YnI+QnI8YnI+VG9tYXN6PGJyPgo=

--===============2468728469752409873==--

