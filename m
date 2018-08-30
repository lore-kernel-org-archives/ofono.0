Content-Type: multipart/mixed; boundary="===============6149107495196091776=="
MIME-Version: 1.0
From: Julien Tournier <tournier.julien@gmail.com>
Subject: Re: [PATCH 0/1] atmodem: Handle broken +CMT notifications of some
 cinterion modems
Date: Thu, 30 Aug 2018 09:04:33 +0200
Message-ID: <CAEU5X-xGYO7uEdtvn-gC2jAmQ=8_tw+0aJfbtbKj+=nLeHubHg@mail.gmail.com>
In-Reply-To: <2e937792-2132-8bfb-c2d5-092cecedd97f@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6149107495196091776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thank you Denis,
I'm trying to build up my poor git send-mail skill, so, sorry for my
previous email format.
It was ok when sending it to my gmail account for testing, but was
incorrectly displayed in the mailing list.

Le mer. 29 ao=C3=BBt 2018 =C3=A0 23:12, Denis Kenzior <denkenz@gmail.com>=
 a =C3=A9crit :

> Hi Julien,
>
> On 08/29/2018 09:48 AM, tournier.julien(a)gmail.com wrote:
> > From: Julien Tournier <tournier.julien@gmail.com>
> >
> > Hi Denis,
> >
> > Here is the fixed patch for the +CMT notification parsing on some
> cinterion
> > modems that have a leading coma. I hope i took all your remarks into
> account
> >
> >
> >   drivers/atmodem/sms.c | 21 ++++++++++++++++++---
> >   1 file changed, 18 insertions(+), 3 deletions(-)
> >
>
> I reworded the commit description and the comment in the code and
> applied this patch.  Thanks!
>
> Regards,
> -Denis
>

--===============6149107495196091776==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5UaGFuayB5b3UgRGVuaXMsPC9kaXY+PGRpdj5JJiMzOTttIHRy
eWluZyB0byBidWlsZCB1cCBteSBwb29yIGdpdCBzZW5kLW1haWwgc2tpbGwsIHNvLCBzb3JyeSBm
b3IgbXkgcHJldmlvdXMgZW1haWwgZm9ybWF0LiA8YnI+PC9kaXY+PGRpdj5JdCB3YXMgb2sgd2hl
biBzZW5kaW5nIGl0IHRvIG15IGdtYWlsIGFjY291bnQgZm9yIHRlc3RpbmcsIGJ1dCB3YXMgaW5j
b3JyZWN0bHkgZGlzcGxheWVkIGluIHRoZSBtYWlsaW5nIGxpc3QuPGJyPjwvZGl2PjwvZGl2Pjxi
cj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+TGXCoG1lci4gMjkgYW/D
u3QgMjAxOCDDoMKgMjM6MTIsIERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5r
ZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0OyBhIMOpY3JpdMKgOjxicj48
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAg
LjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBKdWxp
ZW4sPGJyPgo8YnI+Ck9uIDA4LzI5LzIwMTggMDk6NDggQU0sIDxhIGhyZWY9Im1haWx0bzp0b3Vy
bmllci5qdWxpZW5AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+dG91cm5pZXIuanVsaWVuQGdt
YWlsLmNvbTwvYT4gd3JvdGU6PGJyPgomZ3Q7IEZyb206IEp1bGllbiBUb3VybmllciAmbHQ7PGEg
aHJlZj0ibWFpbHRvOnRvdXJuaWVyLmp1bGllbkBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj50
b3Vybmllci5qdWxpZW5AZ21haWwuY29tPC9hPiZndDs8YnI+CiZndDsgPGJyPgomZ3Q7IEhpIERl
bmlzLDxicj4KJmd0OyA8YnI+CiZndDsgSGVyZSBpcyB0aGUgZml4ZWQgcGF0Y2ggZm9yIHRoZSAr
Q01UIG5vdGlmaWNhdGlvbiBwYXJzaW5nIG9uIHNvbWUgY2ludGVyaW9uPGJyPgomZ3Q7IG1vZGVt
cyB0aGF0IGhhdmUgYSBsZWFkaW5nIGNvbWEuIEkgaG9wZSBpIHRvb2sgYWxsIHlvdXIgcmVtYXJr
cyBpbnRvIGFjY291bnQ8YnI+CiZndDsgPGJyPgomZ3Q7IDxicj4KJmd0O8KgIMKgZHJpdmVycy9h
dG1vZGVtL3Ntcy5jIHwgMjEgKysrKysrKysrKysrKysrKysrLS0tPGJyPgomZ3Q7wqAgwqAxIGZp
bGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSk8YnI+CiZndDsgPGJy
Pgo8YnI+CkkgcmV3b3JkZWQgdGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBhbmQgdGhlIGNvbW1lbnQg
aW4gdGhlIGNvZGUgYW5kIDxicj4KYXBwbGllZCB0aGlzIHBhdGNoLsKgIFRoYW5rcyE8YnI+Cjxi
cj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============6149107495196091776==--

