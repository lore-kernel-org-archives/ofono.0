Content-Type: multipart/mixed; boundary="===============7772660887065872908=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] mbim driver: call the release function in case MBIM OPEN
 fails
Date: Fri, 21 Sep 2018 16:13:12 +0200
Message-ID: <CAKSBH7F7R7=FoLCa6T91WbkxudBdBr3CoaraB=Q2MFsSxpOQUA@mail.gmail.com>
In-Reply-To: <775b6f5d-2d8d-f54d-9c5b-b77ff337668a@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7772660887065872908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Sep 21, 2018 at 12:01 AM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> > I will check about the is_ready false, but definitely the
> > disconnect_handler is not called, I can tell you,
> > because on a special condition I have received a OPEN DONE with failure,
> > and the driver remained hanging.
> > However, after calling it, there is a second call to disconnect_handler,
> > but not if it is not done here.
> > Maybe the code should be verified somewhere else? Any other suggestions?
>
> Okay, I played with this a bit and indeed there was an issue.  It should
> be fixed in ell upstream now.
>
> See commit 0294175cff974ae9aae93e3609c5f6502db410ee.
>

It works with this ell patch, and the disconnect_handler is called once.
Thank you very much.


>
> Regards,
> -Denis
>

Regards,
Giacinto

--===============7772660887065872908==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGRpdiBkaXI9Imx0ciI+T24gRnJpLCBTZXAgMjEsIDIwMTggYXQgMTI6MDEgQU0gRGVuaXMgS2Vu
emlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWls
LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij5IaSBHaWFjaW50byw8YnI+Cjxicj4KJmd0OyBJIHdpbGwgY2hlY2sg
YWJvdXQgdGhlIGlzX3JlYWR5IGZhbHNlLCBidXQgZGVmaW5pdGVseSB0aGUgPGJyPgomZ3Q7IGRp
c2Nvbm5lY3RfaGFuZGxlciBpcyBub3QgY2FsbGVkLCBJIGNhbiB0ZWxsIHlvdSw8YnI+CiZndDsg
YmVjYXVzZSBvbiBhIHNwZWNpYWwgY29uZGl0aW9uIEkgaGF2ZSByZWNlaXZlZCBhIE9QRU4gRE9O
RSB3aXRoIGZhaWx1cmUsIDxicj4KJmd0OyBhbmQgdGhlIGRyaXZlciByZW1haW5lZCBoYW5naW5n
Ljxicj4KJmd0OyBIb3dldmVyLCBhZnRlciBjYWxsaW5nIGl0LCB0aGVyZSBpcyBhIHNlY29uZCBj
YWxsIHRvIGRpc2Nvbm5lY3RfaGFuZGxlciwgPGJyPgomZ3Q7IGJ1dCBub3QgaWYgaXQgaXMgbm90
IGRvbmUgaGVyZS48YnI+CiZndDsgTWF5YmUgdGhlIGNvZGUgc2hvdWxkIGJlIHZlcmlmaWVkIHNv
bWV3aGVyZSBlbHNlPyBBbnkgb3RoZXIgc3VnZ2VzdGlvbnM/PGJyPgo8YnI+Ck9rYXksIEkgcGxh
eWVkIHdpdGggdGhpcyBhIGJpdCBhbmQgaW5kZWVkIHRoZXJlIHdhcyBhbiBpc3N1ZS7CoCBJdCBz
aG91bGQgPGJyPgpiZSBmaXhlZCBpbiBlbGwgdXBzdHJlYW0gbm93Ljxicj4KPGJyPgpTZWUgY29t
bWl0IDAyOTQxNzVjZmY5NzRhZTlhYWU5M2UzNjA5YzVmNjUwMmRiNDEwZWUuPGJyPjwvYmxvY2tx
dW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pkl0IHdvcmtzIHdpdGggdGhpcyBlbGwgcGF0Y2gsIGFu
ZCB0aGUgZGlzY29ubmVjdF9oYW5kbGVyIGlzIGNhbGxlZCBvbmNlLjwvZGl2PjxkaXY+VGhhbmsg
eW91IHZlcnkgbXVjaC48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29s
aWQ7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj48L2Jsb2Nr
cXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+R2lhY2ludG88L2Rp
dj48ZGl2PsKgPC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============7772660887065872908==--

