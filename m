Content-Type: multipart/mixed; boundary="===============6049303085182137623=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] atmodem/sim: added vendor Gemalto
Date: Tue, 25 Sep 2018 05:24:48 +0200
Message-ID: <CAKSBH7HFnSiO=JbvFkOJEd+dfZBsLWyDv_41aDmkLj=_Pt6kOQ@mail.gmail.com>
In-Reply-To: <1997e5ff-3076-9d2f-95df-479f03e7b38a@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6049303085182137623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 11:00 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> On 09/23/2018 12:28 AM, Giacinto Cifelli wrote:
> > also renamed the cinterion_* functions in gemalto_*.
> > Eventually, the vendor cinterion will be removed.
> > ---
> >   drivers/atmodem/sim.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
>
> This is all great and all, but where are my patches for actually fixing
> the use of VENDOR_CINTERION for plugins/gemalto.c?
>

Patience, I need to prepare everything beforehand.

VENDOR_CINTERION is selected in udevng it is for serial modems, it is
mainly based on the TC65i model,
and apparently not properly tested for ages: back to our discussion about
AT+VTS with quotes, I have discovered that
it was with quotes in ofono atmodem at the beginning, most likely for the
TC65i, and then removed, but not entirely:
the string allocation in atmodem/voicecall.c still takes into account the
room for the quotes in the code:
buf =3D g_try_new(char, len * 9 + 3);
the 9 in this command is the length of "+VTS=3D\"n\";".
(but the command above it has been updated!)

Most Gemalto modems have a serial port, that can be used in complement or
instead of USB ports, and
in my code I have merged VENDOR_CINTERION and VENDOR_GEMALTO.

The plugin is the final part I am going to push. There are quite a few
topics to discuss before I can do it.

In the meanwhile, will you take this change (and related ones)?

With this change, VENDOR_CINTERION works as before for now, but the
internal prefixes need update.


> Regards,
> -Denis
>

--===============6049303085182137623==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gTW9uLCBTZXAgMjQsIDIwMTggYXQgMTE6MDAgUE0gRGVu
aXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56
QGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+SGkgR2lhY2ludG8sPGJy
Pgo8YnI+Ck9uIDA5LzIzLzIwMTggMTI6MjggQU0sIEdpYWNpbnRvIENpZmVsbGkgd3JvdGU6PGJy
PgomZ3Q7IGFsc28gcmVuYW1lZCB0aGUgY2ludGVyaW9uXyogZnVuY3Rpb25zIGluIGdlbWFsdG9f
Ki48YnI+CiZndDsgRXZlbnR1YWxseSwgdGhlIHZlbmRvciBjaW50ZXJpb24gd2lsbCBiZSByZW1v
dmVkLjxicj4KJmd0OyAtLS08YnI+CiZndDvCoCDCoGRyaXZlcnMvYXRtb2RlbS9zaW0uYyB8IDkg
KysrKystLS0tPGJyPgomZ3Q7wqAgwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKTxicj4KJmd0OyA8YnI+Cjxicj4KVGhpcyBpcyBhbGwgZ3JlYXQgYW5kIGFs
bCwgYnV0IHdoZXJlIGFyZSBteSBwYXRjaGVzIGZvciBhY3R1YWxseSBmaXhpbmcgPGJyPgp0aGUg
dXNlIG9mIFZFTkRPUl9DSU5URVJJT04gZm9yIHBsdWdpbnMvZ2VtYWx0by5jPzxicj48L2Jsb2Nr
cXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5QYXRpZW5jZSwgSSBuZWVkIHRvIHByZXBhcmUgZXZl
cnl0aGluZyBiZWZvcmVoYW5kLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VkVORE9SX0NJTlRF
UklPTiBpcyBzZWxlY3RlZCBpbiB1ZGV2bmcgaXQgaXMgZm9yIHNlcmlhbCBtb2RlbXMsIGl0IGlz
IG1haW5seSBiYXNlZCBvbiB0aGUgVEM2NWkgbW9kZWwsPC9kaXY+PGRpdj5hbmQgYXBwYXJlbnRs
eSBub3QgcHJvcGVybHkgdGVzdGVkIGZvciBhZ2VzOiBiYWNrIHRvIG91ciBkaXNjdXNzaW9uIGFi
b3V0IEFUK1ZUUyB3aXRoIHF1b3RlcywgSSBoYXZlIGRpc2NvdmVyZWQgdGhhdDwvZGl2PjxkaXY+
aXQgd2FzIHdpdGggcXVvdGVzIGluIG9mb25vIGF0bW9kZW0gYXQgdGhlIGJlZ2lubmluZywgbW9z
dCBsaWtlbHkgZm9yIHRoZSBUQzY1aSwgYW5kIHRoZW4gcmVtb3ZlZCwgYnV0IG5vdCBlbnRpcmVs
eTo8L2Rpdj48ZGl2PnRoZSBzdHJpbmcgYWxsb2NhdGlvbiBpbiBhdG1vZGVtL3ZvaWNlY2FsbC5j
IHN0aWxsIHRha2VzIGludG8gYWNjb3VudCB0aGUgcm9vbSBmb3IgdGhlIHF1b3RlcyBpbiB0aGUg
Y29kZTo8L2Rpdj48ZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5idWYgPSBnX3RyeV9uZXcoY2hhciwgbGVuICogOSArIDMpOzxicj48L2Rpdj48L2Rpdj48ZGl2
PnRoZSA5IGluIHRoaXMgY29tbWFuZCBpcyB0aGUgbGVuZ3RoIG9mICZxdW90OytWVFM9XCZxdW90
O25cJnF1b3Q7OyZxdW90Oy48L2Rpdj48ZGl2PihidXQgdGhlIGNvbW1hbmQgYWJvdmUgaXQgaGFz
IGJlZW4gdXBkYXRlZCEpPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Nb3N0IEdlbWFsdG8gbW9k
ZW1zIGhhdmUgYSBzZXJpYWwgcG9ydCwgdGhhdCBjYW4gYmUgdXNlZCBpbiBjb21wbGVtZW50IG9y
IGluc3RlYWQgb2YgVVNCIHBvcnRzLCBhbmQ8YnI+PC9kaXY+PGRpdj5pbiBteSBjb2RlIEkgaGF2
ZSBtZXJnZWQgVkVORE9SX0NJTlRFUklPTiBhbmQgVkVORE9SX0dFTUFMVE8uPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5UaGUgcGx1Z2luIGlzIHRoZSBmaW5hbCBwYXJ0IEkgYW0gZ29pbmcgdG8g
cHVzaC4gVGhlcmUgYXJlIHF1aXRlIGEgZmV3IHRvcGljcyB0byBkaXNjdXNzIGJlZm9yZSBJIGNh
biBkbyBpdC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkluIHRoZSBtZWFud2hpbGUsIHdpbGwg
eW91IHRha2UgdGhpcyBjaGFuZ2UgKGFuZCByZWxhdGVkIG9uZXMpPzwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+V2l0aCB0aGlzIGNoYW5nZSwgVkVORE9SX0NJTlRFUklPTiB3b3JrcyBhcyBiZWZv
cmUgZm9yIG5vdywgYnV0IHRoZSBpbnRlcm5hbCBwcmVmaXhlcyBuZWVkIHVwZGF0ZS48L2Rpdj48
ZGl2PsKgPGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQs
MjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5SZWdhcmRzLDxicj4KLURlbmlzPGJyPjwvYmxvY2txdW90
ZT48ZGl2PsKgPC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============6049303085182137623==--

