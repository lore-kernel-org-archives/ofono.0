Content-Type: multipart/mixed; boundary="===============6317440758498214903=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] mbim driver: call the release function in case MBIM OPEN
 fails
Date: Thu, 20 Sep 2018 17:57:27 +0200
Message-ID: <CAKSBH7HYAZ5Um79jzM__=uBa_7H7fTzqQXN9a=j23do5Yam4cw@mail.gmail.com>
In-Reply-To: <f1794d9a-1edc-6c45-7667-5d29144e6186@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6317440758498214903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Sep 20, 2018 at 5:48 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> An actual description of what is happening would be helpful
>
> On 09/19/2018 11:47 PM, Giacinto Cifelli wrote:
> > ---
> >   drivers/mbimmodem/mbim.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
> > index 9fcf44b..f4132d0 100644
> > --- a/drivers/mbimmodem/mbim.c
> > +++ b/drivers/mbimmodem/mbim.c
> > @@ -781,6 +781,9 @@ static bool open_read_handler(struct l_io *io, void
> *user_data)
> >       /* Grab OPEN_DONE Status field */
> >       if (l_get_le32(buf) !=3D 0) {
> >               close(fd);
> > +             if (device->disconnect_handler)
> > +                     device->disconnect_handler(device->ready_data);
> > +             device->is_ready =3D false


>
I don't get this part.  So device->is_ready =3D false assignment is
> pointless.  It is already false.
>
> Also, aren't we going to call device->disconnect_handler anyway by
> virtue of closing the fd?  l_io_set_disconnect_handler which we set in
> mbim_device_new should already be taking care of this.
>
>
I will check about the is_ready false, but definitely the
disconnect_handler is not called, I can tell you,
because on a special condition I have received a OPEN DONE with failure,
and the driver remained hanging.
However, after calling it, there is a second call to disconnect_handler,
but not if it is not done here.
Maybe the code should be verified somewhere else? Any other suggestions?

Regards,
> -Denis
>

Regards,
Giacinto

--===============6317440758498214903==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGRpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUi
PjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgU2VwIDIwLCAyMDE4IGF0IDU6NDggUE0gRGVuaXMgS2Vu
emlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWls
LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij5IaSBHaWFjaW50byw8YnI+Cjxicj4KQW4gYWN0dWFsIGRlc2NyaXB0
aW9uIG9mIHdoYXQgaXMgaGFwcGVuaW5nIHdvdWxkIGJlIGhlbHBmdWw8YnI+Cjxicj4KT24gMDkv
MTkvMjAxOCAxMTo0NyBQTSwgR2lhY2ludG8gQ2lmZWxsaSB3cm90ZTo8YnI+CiZndDsgLS0tPGJy
PgomZ3Q7wqAgwqBkcml2ZXJzL21iaW1tb2RlbS9tYmltLmMgfCAzICsrKzxicj4KJmd0O8KgIMKg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKTxicj4KJmd0OyA8YnI+CiZndDsgZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWJpbW1vZGVtL21iaW0uYyBiL2RyaXZlcnMvbWJpbW1vZGVtL21iaW0u
Yzxicj4KJmd0OyBpbmRleCA5ZmNmNDRiLi5mNDEzMmQwIDEwMDY0NDxicj4KJmd0OyAtLS0gYS9k
cml2ZXJzL21iaW1tb2RlbS9tYmltLmM8YnI+CiZndDsgKysrIGIvZHJpdmVycy9tYmltbW9kZW0v
bWJpbS5jPGJyPgomZ3Q7IEBAIC03ODEsNiArNzgxLDkgQEAgc3RhdGljIGJvb2wgb3Blbl9yZWFk
X2hhbmRsZXIoc3RydWN0IGxfaW8gKmlvLCB2b2lkICp1c2VyX2RhdGEpPGJyPgomZ3Q7wqAgwqAg
wqAgwqAvKiBHcmFiIE9QRU5fRE9ORSBTdGF0dXMgZmllbGQgKi88YnI+CiZndDvCoCDCoCDCoCDC
oGlmIChsX2dldF9sZTMyKGJ1ZikgIT0gMCkgezxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgY2xvc2UoZmQpOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZGV2aWNlLSZn
dDtkaXNjb25uZWN0X2hhbmRsZXIpPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGRldmljZS0mZ3Q7ZGlzY29ubmVjdF9oYW5kbGVyKGRldmljZS0mZ3Q7cmVhZHlfZGF0
YSk7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGRldmljZS0mZ3Q7aXNfcmVhZHkgPSBm
YWxzZTwvYmxvY2txdW90ZT48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij7CoDxicj48L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+CkkgZG9uJiMzOTt0IGdldCB0aGlzIHBhcnQuwqAgU28gZGV2aWNlLSZndDtp
c19yZWFkeSA9IGZhbHNlIGFzc2lnbm1lbnQgaXMgPGJyPgpwb2ludGxlc3MuwqAgSXQgaXMgYWxy
ZWFkeSBmYWxzZS48YnI+Cjxicj4KQWxzbywgYXJlbiYjMzk7dCB3ZSBnb2luZyB0byBjYWxsIGRl
dmljZS0mZ3Q7ZGlzY29ubmVjdF9oYW5kbGVyIGFueXdheSBieSA8YnI+CnZpcnR1ZSBvZiBjbG9z
aW5nIHRoZSBmZD/CoCBsX2lvX3NldF9kaXNjb25uZWN0X2hhbmRsZXIgd2hpY2ggd2Ugc2V0IGlu
IDxicj4KbWJpbV9kZXZpY2VfbmV3IHNob3VsZCBhbHJlYWR5IGJlIHRha2luZyBjYXJlIG9mIHRo
aXMuPGJyPgo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSB3aWxsIGNoZWNr
IGFib3V0IHRoZSBpc19yZWFkeSBmYWxzZSwgYnV0IGRlZmluaXRlbHkgdGhlIGRpc2Nvbm5lY3Rf
aGFuZGxlciBpcyBub3QgY2FsbGVkLCBJIGNhbiB0ZWxsIHlvdSw8L2Rpdj48ZGl2PmJlY2F1c2Ug
b24gYSBzcGVjaWFsIGNvbmRpdGlvbiBJIGhhdmUgcmVjZWl2ZWQgYSBPUEVOIERPTkUgd2l0aCBm
YWlsdXJlLCBhbmQgdGhlIGRyaXZlciByZW1haW5lZCBoYW5naW5nLjwvZGl2PjxkaXY+SG93ZXZl
ciwgYWZ0ZXIgY2FsbGluZyBpdCwgdGhlcmUgaXMgYSBzZWNvbmQgY2FsbCB0byBkaXNjb25uZWN0
X2hhbmRsZXIsIGJ1dCBub3QgaWYgaXQgaXMgbm90IGRvbmUgaGVyZS48L2Rpdj48ZGl2Pk1heWJl
IHRoZSBjb2RlIHNob3VsZCBiZSB2ZXJpZmllZCBzb21ld2hlcmUgZWxzZT8gQW55IG90aGVyIHN1
Z2dlc3Rpb25zPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPjwvYmxvY2txdW90ZT48
ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5HaWFjaW50bzwvZGl2PjxkaXY+
PGJyPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============6317440758498214903==--

