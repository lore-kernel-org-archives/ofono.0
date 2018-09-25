Content-Type: multipart/mixed; boundary="===============2436535980035563783=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] location-reporting.h: driver properties handling
Date: Tue, 25 Sep 2018 05:49:27 +0200
Message-ID: <CAKSBH7HGHzUxWobiG=BzuRak=nQoff7fGR8nyir8Nhc5c55+Gw@mail.gmail.com>
In-Reply-To: <c8c8e4a5-f86c-7f9e-c89e-d4c25a2d30fb@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2436535980035563783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, Sep 24, 2018 at 11:07 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> On 09/23/2018 01:19 AM, Giacinto Cifelli wrote:
> > The GNSS receiver configuration is highly proprietary.
> > Some are configured through the GNSS port itself, some through other
> > ports. The properties themselves vary among the manufacturers, with no
> > standard available. Besides, ofono doesn't handle any state for a GNSS
> > receiver.
> >
> > Therefore, this extensions allows to get and set directly D-Bus
> > properties by the driver.
> > ---
> >   include/location-reporting.h | 3 +++
> >   1 file changed, 3 insertions(+)
> >
>
> No.  We're never going to do stuff like this.  Drivers are never going
> to get D-Bus messages.  They don't even know anything about D-Bus.
>
> Either properly support the format you have in
> doc/location-reporting-api.txt or feel free to create a vendor specific
> D-Bus API for Gemalto inside plugins/gemalto.c
>

ok, another vendor-specific extension.
Note that the location-reporting as it is is pretty much useless, because
it cannot configure anything,
and doesn't work well with gpsd (that requires a port, not a fd).


>
> Regards,
> -Denis
>

Regards,
Giacinto

--===============2436535980035563783==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGRpdiBkaXI9Imx0ciI+T24gTW9uLCBTZXAgMjQsIDIwMTggYXQgMTE6MDcgUE0gRGVuaXMgS2Vu
emlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWls
LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij5IaSBHaWFjaW50byw8YnI+Cjxicj4KT24gMDkvMjMvMjAxOCAwMTox
OSBBTSwgR2lhY2ludG8gQ2lmZWxsaSB3cm90ZTo8YnI+CiZndDsgVGhlIEdOU1MgcmVjZWl2ZXIg
Y29uZmlndXJhdGlvbiBpcyBoaWdobHkgcHJvcHJpZXRhcnkuPGJyPgomZ3Q7IFNvbWUgYXJlIGNv
bmZpZ3VyZWQgdGhyb3VnaCB0aGUgR05TUyBwb3J0IGl0c2VsZiwgc29tZSB0aHJvdWdoIG90aGVy
PGJyPgomZ3Q7IHBvcnRzLiBUaGUgcHJvcGVydGllcyB0aGVtc2VsdmVzIHZhcnkgYW1vbmcgdGhl
IG1hbnVmYWN0dXJlcnMsIHdpdGggbm88YnI+CiZndDsgc3RhbmRhcmQgYXZhaWxhYmxlLiBCZXNp
ZGVzLCBvZm9ubyBkb2VzbiYjMzk7dCBoYW5kbGUgYW55IHN0YXRlIGZvciBhIEdOU1M8YnI+CiZn
dDsgcmVjZWl2ZXIuPGJyPgomZ3Q7IDxicj4KJmd0OyBUaGVyZWZvcmUsIHRoaXMgZXh0ZW5zaW9u
cyBhbGxvd3MgdG8gZ2V0IGFuZCBzZXQgZGlyZWN0bHkgRC1CdXM8YnI+CiZndDsgcHJvcGVydGll
cyBieSB0aGUgZHJpdmVyLjxicj4KJmd0OyAtLS08YnI+CiZndDvCoCDCoGluY2x1ZGUvbG9jYXRp
b24tcmVwb3J0aW5nLmggfCAzICsrKzxicj4KJmd0O8KgIMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKTxicj4KJmd0Ozxicj4KPGJyPgpOby7CoCBXZSYjMzk7cmUgbmV2ZXIgZ29pbmcg
dG8gZG8gc3R1ZmYgbGlrZSB0aGlzLsKgIERyaXZlcnMgYXJlIG5ldmVyIGdvaW5nIDxicj4KdG8g
Z2V0IEQtQnVzIG1lc3NhZ2VzLsKgIFRoZXkgZG9uJiMzOTt0IGV2ZW4ga25vdyBhbnl0aGluZyBh
Ym91dCBELUJ1cy48YnI+Cjxicj4KRWl0aGVyIHByb3Blcmx5IHN1cHBvcnQgdGhlIGZvcm1hdCB5
b3UgaGF2ZSBpbiA8YnI+CmRvYy9sb2NhdGlvbi1yZXBvcnRpbmctYXBpLnR4dCBvciBmZWVsIGZy
ZWUgdG8gY3JlYXRlIGEgdmVuZG9yIHNwZWNpZmljIDxicj4KRC1CdXMgQVBJIGZvciBHZW1hbHRv
IGluc2lkZSBwbHVnaW5zL2dlbWFsdG8uYzxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+
PGRpdj5vaywgYW5vdGhlciB2ZW5kb3Itc3BlY2lmaWMgZXh0ZW5zaW9uLjwvZGl2PjxkaXY+Tm90
ZSB0aGF0IHRoZSBsb2NhdGlvbi1yZXBvcnRpbmcgYXMgaXQgaXMgaXMgcHJldHR5IG11Y2ggdXNl
bGVzcywgYmVjYXVzZSBpdCBjYW5ub3QgY29uZmlndXJlIGFueXRoaW5nLDwvZGl2PjxkaXY+YW5k
IGRvZXNuJiMzOTt0IHdvcmsgd2VsbCB3aXRoIGdwc2QgKHRoYXQgcmVxdWlyZXMgYSBwb3J0LCBu
b3QgYSBmZCkuPC9kaXY+PGRpdj7CoDxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPjwvYmxvY2tx
dW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5HaWFjaW50bzwvZGl2
PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============2436535980035563783==--

