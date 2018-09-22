Content-Type: multipart/mixed; boundary="===============4575527488478057629=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/2] gemaltomodem: added Gemalto-specific gprs-context
 atom This atom name is not the same as the driver,
 because it might be necessary to add other grps-context atoms,
 according to the needs. The name is therefore referring to the main command
 used, AT^SWWAN.
Date: Sat, 22 Sep 2018 20:03:25 +0200
Message-ID: <CAKSBH7F2724WP4CKK=rCAEnhUvO8_xKobQN5JpD4vF188BZfyQ@mail.gmail.com>
In-Reply-To: <CAKSBH7GCFk-ZoG9KB-YOOtUV4Xy_m24Syx-B1vOGXo8P_71xog@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4575527488478057629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again Denis,

On Sat, Sep 22, 2018 at 7:47 AM Giacinto Cifelli <gciofono@gmail.com> wro=
te:

> Hi Denis,
>
> On Fri, Sep 21, 2018 at 6:12 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
>> Hi Giacinto,
>>
>>
On 09/19/2018 10:50 PM, Giacinto Cifelli wrote:
>> > ---
>> >   drivers/gemaltomodem/gemaltomodem.c      |   2 +
>> >   drivers/gemaltomodem/gemaltomodem.h      |   3 +
>> >   drivers/gemaltomodem/gprs-context-wwan.c | 446
>> +++++++++++++++++++++++++++++++
>> >   3 files changed, 451 insertions(+)
>> >   create mode 100644 drivers/gemaltomodem/gprs-context-wwan.c
>> >
>> > diff --git a/drivers/gemaltomodem/gemaltomodem.c
>> b/drivers/gemaltomodem/gemaltomodem.c
>> > index 614ca81..7afd3c1 100644
>> > --- a/drivers/gemaltomodem/gemaltomodem.c
>> > +++ b/drivers/gemaltomodem/gemaltomodem.c
>
>
> +
>>
> > +static gboolean gemalto_get_auth_command(struct ofono_modem *modem, int
>> cid,
>> > +                             enum ofono_gprs_auth_method auth_method,
>> > +                             const char *username, const char
>> *password,
>> > +                             char *buf, guint buflen)
>> > +{
>> > +     int gto_auth =3D ofono_modem_get_integer(modem, "Gemalto_Auth");
>>
>> Please use a CamelCase-d variable for this.  E.g. GemaltoAuthType
>>
>
> ok. This is new for this code, because I have always seen only variables
> with underscores, but no problem.
> Personally I would prefer camelCase 'gemaltoAuthType', because it is more
> coherent in case of 1-part names like 'user',
> but I'll do as you say.
>

On a second reading, I think you meant the "Gemalto_Auth" ->
"GemaltoAuthType".
I have renamed it, and also gto_auth -> gemalto_auth, clearer.



>> Regards,
>> -Denis
>>
>
> Regards,
> Giacinto
>
>
Regards,
Giacinto

--===============4575527488478057629==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgYWdhaW4gRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gU2F0LCBTZXAgMjIsIDIwMTggYXQgNzo0NyBBTSBHaWFj
aW50byBDaWZlbGxpICZsdDs8YSBocmVmPSJtYWlsdG86Z2Npb2Zvbm9AZ21haWwuY29tIj5nY2lv
Zm9ub0BnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNj
Y2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+
SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+
T24gRnJpLCBTZXAgMjEsIDIwMTggYXQgNjoxMiBQTSBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVm
PSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWls
LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+SGkgR2lhY2ludG8sPGJyPgo8YnI+
PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rp
dj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhl
eDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0i
bHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRl
ci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjwvYmxv
Y2txdW90ZT48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFk
ZGluZy1sZWZ0OjFleCI+T24gMDkvMTkvMjAxOCAxMDo1MCBQTSwgR2lhY2ludG8gQ2lmZWxsaSB3
cm90ZTo8YnI+CiZndDsgLS0tPGJyPgomZ3Q7wqAgwqBkcml2ZXJzL2dlbWFsdG9tb2RlbS9nZW1h
bHRvbW9kZW0uY8KgIMKgIMKgIHzCoCDCoDIgKzxicj4KJmd0O8KgIMKgZHJpdmVycy9nZW1hbHRv
bW9kZW0vZ2VtYWx0b21vZGVtLmjCoCDCoCDCoCB8wqAgwqAzICs8YnI+CiZndDvCoCDCoGRyaXZl
cnMvZ2VtYWx0b21vZGVtL2dwcnMtY29udGV4dC13d2FuLmMgfCA0NDYgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKzxicj4KJmd0O8KgIMKgMyBmaWxlcyBjaGFuZ2VkLCA0NTEgaW5zZXJ0
aW9ucygrKTxicj4KJmd0O8KgIMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ2VtYWx0b21v
ZGVtL2dwcnMtY29udGV4dC13d2FuLmM8YnI+CiZndDsgPGJyPgomZ3Q7IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dlbWFsdG9tb2RlbS9nZW1hbHRvbW9kZW0uYyBiL2RyaXZlcnMvZ2VtYWx0b21vZGVt
L2dlbWFsdG9tb2RlbS5jPGJyPgomZ3Q7IGluZGV4IDYxNGNhODEuLjdhZmQzYzEgMTAwNjQ0PGJy
PgomZ3Q7IC0tLSBhL2RyaXZlcnMvZ2VtYWx0b21vZGVtL2dlbWFsdG9tb2RlbS5jPGJyPgomZ3Q7
ICsrKyBiL2RyaXZlcnMvZ2VtYWx0b21vZGVtL2dlbWFsdG9tb2RlbS5jPC9ibG9ja3F1b3RlPjwv
ZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDox
cHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0i
bHRyIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xp
ZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPiZndDsgKzxicj48L2Jsb2NrcXVv
dGU+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPgomZ3Q7ICtzdGF0aWMgZ2Jvb2xlYW4gZ2VtYWx0b19nZXRfYXV0aF9jb21tYW5k
KHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sIGludCBjaWQsPGJyPgomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVudW0gb2Zvbm9fZ3Byc19hdXRoX21l
dGhvZCBhdXRoX21ldGhvZCw8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgY29uc3QgY2hhciAqdXNlcm5hbWUsIGNvbnN0IGNoYXIgKnBhc3N3b3Jk
LDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBj
aGFyICpidWYsIGd1aW50IGJ1Zmxlbik8YnI+CiZndDsgK3s8YnI+CiZndDsgK8KgIMKgIMKgaW50
IGd0b19hdXRoID0gb2Zvbm9fbW9kZW1fZ2V0X2ludGVnZXIobW9kZW0sICZxdW90O0dlbWFsdG9f
QXV0aCZxdW90Oyk7PGJyPgo8YnI+ClBsZWFzZSB1c2UgYSBDYW1lbENhc2UtZCB2YXJpYWJsZSBm
b3IgdGhpcy7CoCBFLmcuIEdlbWFsdG9BdXRoVHlwZTxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+
PC9kaXY+PGRpdj5vay4gVGhpcyBpcyBuZXcgZm9yIHRoaXMgY29kZSwgYmVjYXVzZSBJIGhhdmUg
YWx3YXlzIHNlZW4gb25seSB2YXJpYWJsZXMgd2l0aCB1bmRlcnNjb3JlcywgYnV0IG5vIHByb2Js
ZW0uPC9kaXY+PGRpdj5QZXJzb25hbGx5IEkgd291bGQgcHJlZmVyIGNhbWVsQ2FzZSAmIzM5O2dl
bWFsdG9BdXRoVHlwZSYjMzk7LCBiZWNhdXNlIGl0IGlzIG1vcmUgY29oZXJlbnQgaW4gY2FzZSBv
ZiAxLXBhcnQgbmFtZXMgbGlrZSAmIzM5O3VzZXImIzM5Oyw8L2Rpdj48ZGl2PmJ1dCBJJiMzOTts
bCBkbyBhcyB5b3Ugc2F5LjwvZGl2PjxkaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9j
a3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+T24gYSBzZWNvbmQgcmVhZGluZywgSSB0aGluayB5
b3UgbWVhbnQgdGhlICZxdW90O0dlbWFsdG9fQXV0aCZxdW90OyAtJmd0OyAmcXVvdDtHZW1hbHRv
QXV0aFR5cGUmcXVvdDsuPC9kaXY+PGRpdj5JIGhhdmUgcmVuYW1lZCBpdCwgYW5kIGFsc28gZ3Rv
X2F1dGggLSZndDsgZ2VtYWx0b19hdXRoLCBjbGVhcmVyLjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
PjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHgg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0
OjFleCI+PGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48
L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5HaWFjaW50bzwvZGl2PjxkaXY+wqA8L2Rpdj48
L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+R2lh
Y2ludG/CoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============4575527488478057629==--

