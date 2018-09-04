Content-Type: multipart/mixed; boundary="===============6847942153341886720=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: ofono fails to compile on gcc-6.3
Date: Tue, 04 Sep 2018 13:01:02 +0200
Message-ID: <CAKSBH7ENCmRznYp61C3bf5ys4s4Xw70B06JbCm61XR4YHfpj8g@mail.gmail.com>
In-Reply-To: <20180904094416.GA17297@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6847942153341886720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi,

I had the same issue.
For now I couldn't spare time to investigate, but I have commented out all
lines with that pragma and worked.

Best regards,
Giacinto


On Tue, Sep 4, 2018 at 11:44 AM Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>
> I'm getting this:
>
>   CC       drivers/rilmodem/network-registration.o
>   drivers/rilmodem/network-registration.c:40:32: error: unknown option
>   after =E2=80=98#pragma GCC diagnostic=E2=80=99 kind [-Werror=3Dpragmas]
>    #pragma GCC diagnostic ignored "-Wrestrict"
> cc1: error: unrecognized command line option =E2=80=98-Wno-format-truncat=
ion=E2=80=99
>   [-Werror]
>   cc1: all warnings being treated as errors
>
> I commented out #pragma, and this allows compilation to
> continue... until I hit same issue in
> drivers/rilmodem/call-forwarding.c:41:32:
>
> Best regards,
>
> Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============6847942153341886720==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+aGksPGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhZCB0aGUgc2FtZSBpc3N1
ZS48L2Rpdj48ZGl2PkZvciBub3cgSSBjb3VsZG4mIzM5O3Qgc3BhcmUgdGltZSB0byBpbnZlc3Rp
Z2F0ZSwgYnV0IEkgaGF2ZSBjb21tZW50ZWQgb3V0IGFsbCBsaW5lcyB3aXRoIHRoYXQgcHJhZ21h
IGFuZCB3b3JrZWQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IHJlZ2FyZHMsPC9kaXY+
PGRpdj5HaWFjaW50bzwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVHVlLCBTZXAgNCwgMjAxOCBhdCAxMTo0NCBB
TSBQYXZlbCBNYWNoZWsgJmx0OzxhIGhyZWY9Im1haWx0bzpwYXZlbEB1Y3cuY3oiPnBhdmVsQHVj
dy5jejwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij5IaSE8YnI+Cjxicj4KSSYjMzk7bSBnZXR0aW5nIHRoaXM6PGJyPgo8
YnI+CsKgIENDwqAgwqAgwqAgwqBkcml2ZXJzL3JpbG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9u
Lm88YnI+CsKgIGRyaXZlcnMvcmlsbW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzo0MDozMjog
ZXJyb3I6IHVua25vd24gb3B0aW9uPGJyPgrCoCBhZnRlciDigJgjcHJhZ21hIEdDQyBkaWFnbm9z
dGlj4oCZIGtpbmQgWy1XZXJyb3I9cHJhZ21hc108YnI+CsKgIMKgI3ByYWdtYSBHQ0MgZGlhZ25v
c3RpYyBpZ25vcmVkICZxdW90Oy1XcmVzdHJpY3QmcXVvdDs8YnI+CmNjMTogZXJyb3I6IHVucmVj
b2duaXplZCBjb21tYW5kIGxpbmUgb3B0aW9uIOKAmC1Xbm8tZm9ybWF0LXRydW5jYXRpb27igJk8
YnI+CsKgIFstV2Vycm9yXTxicj4KwqAgY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBh
cyBlcnJvcnM8YnI+Cjxicj4KSSBjb21tZW50ZWQgb3V0ICNwcmFnbWEsIGFuZCB0aGlzIGFsbG93
cyBjb21waWxhdGlvbiB0bzxicj4KY29udGludWUuLi4gdW50aWwgSSBoaXQgc2FtZSBpc3N1ZSBp
bjxicj4KZHJpdmVycy9yaWxtb2RlbS9jYWxsLWZvcndhcmRpbmcuYzo0MTozMjo8YnI+Cjxicj4K
QmVzdCByZWdhcmRzLDxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgUGF2ZWw8YnI+Ci0tIDxicj4KKGVuZ2xpc2gpIDxhIGhyZWY9Imh0dHA6Ly93
d3cubGl2ZWpvdXJuYWwuY29tL35wYXZlbG1hY2hlayIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9
Il9ibGFuayI+aHR0cDovL3d3dy5saXZlam91cm5hbC5jb20vfnBhdmVsbWFjaGVrPC9hPjxicj4K
KGNlc2t5LCBwaWN0dXJlcykgPGEgaHJlZj0iaHR0cDovL2F0cmV5Lmthcmxpbi5tZmYuY3VuaS5j
ei9+cGF2ZWwvcGljdHVyZS9ob3JzZXMvYmxvZy5odG1sIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdl
dD0iX2JsYW5rIj5odHRwOi8vYXRyZXkua2FybGluLm1mZi5jdW5pLmN6L35wYXZlbC9waWN0dXJl
L2hvcnNlcy9ibG9nLmh0bWw8L2E+PGJyPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWls
dG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxi
cj4KPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9u
byIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy5vZm9uby5v
cmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvYmxvY2txdW90ZT48L2Rpdj4K

--===============6847942153341886720==--

