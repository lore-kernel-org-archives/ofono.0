Content-Type: multipart/mixed; boundary="===============0782962918944579256=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] ublox: network-registration: Handle UREG unsolicited
 during poll
Date: Fri, 14 Feb 2020 10:07:40 +0100
Message-ID: <CAHB-Pj=Nb2_tcBHYwJTVAhZsMN_0v8H9i6mKoVh8Z6sP9LOTsw@mail.gmail.com>
In-Reply-To: <340f70ab-cd3e-242c-ed1c-d09f32b41dc0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0782962918944579256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den tors 13 feb. 2020 kl 17:44 skrev Denis Kenzior <denkenz@gmail.com>:

> >
> > -     if (!g_at_result_iter_next_number(&iter, &state))
> > -             return;
> > +             goto parsed_state;
>
> Wouldn't it look nicer to just perform the ublox_ureg_state_to_tech
> steps here (i.e within the loop) without the goto?
>

Yes, its a good suggestion! I have sent a v2.

--Richard

--===============0782962918944579256==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gdG9ycyAxMyBmZWIu
IDIwMjAga2wgMTc6NDQgc2tyZXYgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRl
bmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7Ojxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+Jmd0O8KgIMKgPGJyPgomZ3Q7IC3CoCDCoCDCoGlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0
X251bWJlcigmYW1wO2l0ZXIsICZhbXA7c3RhdGUpKTxicj4KJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXR1cm47PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gcGFyc2VkX3N0
YXRlOzxicj4KPGJyPgpXb3VsZG4mIzM5O3QgaXQgbG9vayBuaWNlciB0byBqdXN0IHBlcmZvcm0g
dGhlIHVibG94X3VyZWdfc3RhdGVfdG9fdGVjaCA8YnI+CnN0ZXBzIGhlcmUgKGkuZSB3aXRoaW4g
dGhlIGxvb3ApIHdpdGhvdXQgdGhlIGdvdG8/PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rp
dj48ZGl2PlllcywgaXRzIGEgZ29vZCBzdWdnZXN0aW9uISBJIGhhdmUgc2VudCBhIHYyLjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+LS1SaWNoYXJkPC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============0782962918944579256==--

