Content-Type: multipart/mixed; boundary="===============8588997775044824023=="
MIME-Version: 1.0
From: Markus Hubig <mhubig@imko.de>
Subject: Re: Recommendation for a good Modem
Date: Tue, 27 Aug 2013 13:26:09 +0200
Message-ID: <CAGws1TugTbJOu83m+RU6yo20Kax9k5PC8amCYhQ3zTwbWY106Q@mail.gmail.com>
In-Reply-To: <52199247.9010905@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8588997775044824023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2013 at 7:12 AM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Markus,
>
>
> On 08/26/2013 04:58 AM, Markus Hubig wrote:
>
>> Hi @all,
>>
>> I'm looking for a GPRS/UMTS modem for a small embedded linux
>> appliance I'm building. I want to use ofono to handle the modem.
>>
>> First I thought about the Telit GC864, but unfortunately this seems
>> to be not supported by ofono (at least not out of the box) ...
>>
>>
> How different is the GC864 from say UC864?  Supporting the GC864 might be
> as simple as tweaking some parameters inside the relevant modem detection
> plugin.


The GC864 has the same core as the UC864. The main difference is that the
GC864 can only be connected via a serial port / UART. I looked at the
telit.c plugin and it seems indeed that the required modifications are not
that big. Maybe I can make the adaptions ... but I need some Informations.

   1. How do I get ofono to detect the modem on the serial line? Via the
   ofono.rules file and udev.c?

   2. Do I have to define a new moden plugin e.g telit_serial.c or is it
   possible to extend telit.c

Cheers, Markus

-- =

_______________________________________________________

IMKO Micromodultechnik GmbH
Markus Hubig
Research & Development
Im Stoeck 2
D-76275 Ettlingen / GERMANY

HR: HRB 360936 Amtsgericht Mannheim
President: Dipl.-Ing. (FH) Kurt Koehler

Tel: 0049-(0)7243-5921-26
Fax: 0049-(0)7243-5921-40
e-mail: mhubig(a)imko.de
internet: www.imko.de
_______________________________________________________

--===============8588997775044824023==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+T24gU3VuLCBBdWcgMjUsIDIwMTMgYXQgNzoxMiBBTSwgRGVuaXMgS2Vu
emlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNv
bSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3Rl
Ojxicj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPgo8
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBNYXJrdXMsPGRp
diBjbGFzcz0iaW0iPjxicj4KPGJyPgpPbiAwOC8yNi8yMDEzIDA0OjU4IEFNLCBNYXJrdXMgSHVi
aWcgd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij4KSGkgQGFsbCw8YnI+Cjxicj4KSSYjMzk7bSBsb29raW5nIGZvciBhIEdQUlMvVU1UUyBtb2Rl
bSBmb3IgYSBzbWFsbCBlbWJlZGRlZCBsaW51eDxicj4KYXBwbGlhbmNlIEkmIzM5O20gYnVpbGRp
bmcuIEkgd2FudCB0byB1c2Ugb2Zvbm8gdG8gaGFuZGxlIHRoZSBtb2RlbS48YnI+Cjxicj4KRmly
c3QgSSB0aG91Z2h0IGFib3V0IHRoZSBUZWxpdCBHQzg2NCwgYnV0IHVuZm9ydHVuYXRlbHkgdGhp
cyBzZWVtczxicj4KdG8gYmUgbm90IHN1cHBvcnRlZCBieSBvZm9ubyAoYXQgbGVhc3Qgbm90IG91
dCBvZiB0aGUgYm94KSAuLi48YnI+Cjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9kaXY+CkhvdyBk
aWZmZXJlbnQgaXMgdGhlIEdDODY0IGZyb20gc2F5IFVDODY0PyCgU3VwcG9ydGluZyB0aGUgR0M4
NjQgbWlnaHQgYmUgYXMgc2ltcGxlIGFzIHR3ZWFraW5nIHNvbWUgcGFyYW1ldGVycyBpbnNpZGUg
dGhlIHJlbGV2YW50IG1vZGVtIGRldGVjdGlvbiBwbHVnaW4uPC9ibG9ja3F1b3RlPjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhlIEdDODY0IGhhcyB0aGUgc2FtZSBjb3JlIGFzIHRoZSBVQzg2NC4gVGhl
IG1haW4gZGlmZmVyZW5jZSBpcyB0aGF0IHRoZSBHQzg2NCBjYW4gb25seSBiZSBjb25uZWN0ZWQg
dmlhIGEgc2VyaWFsIHBvcnQgLyBVQVJULiBJIGxvb2tlZCBhdCB0aGUgdGVsaXQuYyBwbHVnaW4g
YW5kIGl0IHNlZW1zIGluZGVlZCB0aGF0IHRoZSByZXF1aXJlZCBtb2RpZmljYXRpb25zIGFyZSBu
b3QgdGhhdCBiaWcuIE1heWJlIEkgY2FuIG1ha2UgdGhlIGFkYXB0aW9ucyAuLi4gYnV0IEkgbmVl
ZCBzb21lIEluZm9ybWF0aW9ucy48L2Rpdj4KPGRpdj48ZGl2PjxvbD48bGk+SG93IGRvIEkgZ2V0
IG9mb25vIHRvIGRldGVjdCB0aGUgbW9kZW0gb24gdGhlIHNlcmlhbCBsaW5lPyBWaWEgdGhlIG9m
b25vLnJ1bGVzIGZpbGUgYW5kIHVkZXYuYz88YnI+PGJyPjwvbGk+PGxpPkRvIEkgaGF2ZSB0byBk
ZWZpbmUgYSBuZXcgbW9kZW4gcGx1Z2luIGUuZyB0ZWxpdF9zZXJpYWwuYyBvciBpcyBpdCBwb3Nz
aWJsZSB0byBleHRlbmQgdGVsaXQuYzwvbGk+Cjwvb2w+PC9kaXY+PC9kaXY+PGRpdj5DaGVlcnMs
IE1hcmt1czwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2Pi0tIDxicj5fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPjxicj5JTUtPIE1pY3Jv
bW9kdWx0ZWNobmlrIEdtYkg8YnI+TWFya3VzIEh1YmlnPGJyPlJlc2VhcmNoICZhbXA7oERldmVs
b3BtZW50PGJyPkltIFN0b2VjayAyPGJyPgpELTc2Mjc1IEV0dGxpbmdlbiAvIEdFUk1BTlk8YnI+
PGJyPkhSOiBIUkIgMzYwOTM2IEFtdHNnZXJpY2h0IE1hbm5oZWltPGJyPlByZXNpZGVudDogRGlw
bC4tSW5nLiAoRkgpIEt1cnQgS29laGxlcjxicj48YnI+VGVsOiAwMDQ5LSgwKTcyNDMtNTkyMS0y
Njxicj5GYXg6IDAwNDktKDApNzI0My01OTIxLTQwPGJyPmUtbWFpbDogPGEgaHJlZj0ibWFpbHRv
Om1odWJpZ0BpbWtvLmRlIiB0YXJnZXQ9Il9ibGFuayI+bWh1YmlnQGlta28uZGU8L2E+PGJyPgpp
bnRlcm5ldDogPGEgaHJlZj0iaHR0cDovL3d3dy5pbWtvLmRlIiB0YXJnZXQ9Il9ibGFuayI+d3d3
Lmlta28uZGU8L2E+PGJyPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPC9kaXY+PC9kaXY+Cg==

--===============8588997775044824023==--

