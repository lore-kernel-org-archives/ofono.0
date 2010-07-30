Content-Type: multipart/mixed; boundary="===============7332496322934683709=="
MIME-Version: 1.0
From: s s <sk53901@gmail.com>
Subject: USSD support in ofono-0.25
Date: Fri, 30 Jul 2010 11:53:26 +0530
Message-ID: <AANLkTimW8X91gm4DCw1sZXu306zd4QbHho=ku=DKv3on@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7332496322934683709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Is USSD support is available and functional in ofono latest version?


I found the support in SupplementaryServices interface and I am able to read
the properties from this interface, but I am getting error when try to call
"Initiate" method,
from the definition of "Initiate" method in ussd.c found that out arguments
are "sv". below is the test code.

gchar *str=3DNULL;
GValue val=3D{0,};
g_value_init(&val,G_TYPE_STRING);
dbus_g_proxy_call (proxy,
"Initiate",&error,G_TYPE_STRING,"*#43#",G_TYPE_INVALID,G_TYPE_STRING,&str,G=
_TYPE_VALUE,&val,
G_TYPE_INVALID);

if above code is executed  , the error is
" GLib-GObject-WARNING **: gvalue.c:185: cannot initialize GValue with type
`GValueArray_gchararray+GHashTable_gchararray+GValue__', the value has
already been initialized as `gchararray'

Couldn't convert argument, expected "GValue" "


and in generate_cw_ss_query_reply callback , message signature is "(sa{sv})"
so tried with

GArray *list;
GHashTable *OUT_arg0=3DNULL;
dbus_g_proxy_call (proxy,
"Initiate",&error,G_TYPE_STRING,"*#43#",G_TYPE_INVALID,
                                dbus_g_type_get_struct ("GValueArray",
G_TYPE_STRING,
                                dbus_g_type_get_map ("GHashTable",
G_TYPE_STRING, G_TYPE_VALUE),G_TYPE_INVALID),
                                &OUT_arg0, G_TYPE_INVALID);

but it is returning error " Expected D-BUS struct, got type code 's'"

can any body please tell me the correct return types.

in both cases ofono is getting response from phonesim.

and no proper documentation is available for USSD support .


can anybody please help?

thanks
sk.

--===============7332496322934683709==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SXMgVVNTRCBzdXBwb3J0IGlzIGF2YWlsYWJsZSBhbmQgZnVuY3Rpb25hbCBpbiBvZm9ubyBsYXRl
c3QgdmVyc2lvbj88YnI+PGJyPjxicj5JIGZvdW5kIHRoZSBzdXBwb3J0IGluIFN1cHBsZW1lbnRh
cnlTZXJ2aWNlcyBpbnRlcmZhY2UgYW5kIEkgYW0gYWJsZSB0byByZWFkIHRoZSBwcm9wZXJ0aWVz
IGZyb20gdGhpcyBpbnRlcmZhY2UsIGJ1dCBJIGFtIGdldHRpbmcgZXJyb3Igd2hlbiB0cnkgdG8g
Y2FsbCAmcXVvdDtJbml0aWF0ZSZxdW90OyBtZXRob2QsPGJyPgpmcm9tIHRoZSBkZWZpbml0aW9u
IG9mICZxdW90O0luaXRpYXRlJnF1b3Q7IG1ldGhvZCBpbiB1c3NkLmMgZm91bmQgdGhhdCBvdXQg
YXJndW1lbnRzIGFyZSAmcXVvdDtzdiZxdW90Oy4gYmVsb3cgaXMgdGhlIHRlc3QgY29kZS48YnI+
PGJyPmdjaGFyICpzdHI9TlVMTDs8YnI+R1ZhbHVlIHZhbD17MCx9Ozxicj5nX3ZhbHVlX2luaXQo
JmFtcDt2YWwsR19UWVBFX1NUUklORyk7PGJyPmRidXNfZ19wcm94eV9jYWxsIChwcm94eSwgJnF1
b3Q7SW5pdGlhdGUmcXVvdDssJmFtcDtlcnJvcixHX1RZUEVfU1RSSU5HLCZxdW90OyojNDMjJnF1
b3Q7LEdfVFlQRV9JTlZBTElELEdfVFlQRV9TVFJJTkcsJmFtcDtzdHIsR19UWVBFX1ZBTFVFLCZh
bXA7dmFsLCBHX1RZUEVfSU5WQUxJRCk7PGJyPgo8YnI+aWYgYWJvdmUgY29kZSBpcyBleGVjdXRl
ZKAgLCB0aGUgZXJyb3IgaXMgPGJyPiZxdW90OyBHTGliLUdPYmplY3QtV0FSTklORyAqKjogZ3Zh
bHVlLmM6MTg1OiBjYW5ub3QgaW5pdGlhbGl6ZSBHVmFsdWUgd2l0aCB0eXBlIGBHVmFsdWVBcnJh
eV9nY2hhcmFycmF5K0dIYXNoVGFibGVfZ2NoYXJhcnJheStHVmFsdWVfXyYjMzk7LCB0aGUgdmFs
dWUgaGFzIGFscmVhZHkgYmVlbiBpbml0aWFsaXplZCBhcyBgZ2NoYXJhcnJheSYjMzk7PGJyPgo8
YnI+Q291bGRuJiMzOTt0IGNvbnZlcnQgYXJndW1lbnQsIGV4cGVjdGVkICZxdW90O0dWYWx1ZSZx
dW90OyAmcXVvdDs8YnI+PGJyPjxicj5hbmQgaW4gZ2VuZXJhdGVfY3dfc3NfcXVlcnlfcmVwbHkg
Y2FsbGJhY2sgLCBtZXNzYWdlIHNpZ25hdHVyZSBpcyAmcXVvdDsoc2F7c3Z9KSZxdW90Ozxicj5z
byB0cmllZCB3aXRoIDxicj48YnI+R0FycmF5ICpsaXN0Ozxicj5HSGFzaFRhYmxlICpPVVRfYXJn
MD1OVUxMOzxicj4KZGJ1c19nX3Byb3h5X2NhbGwgKHByb3h5LCAmcXVvdDtJbml0aWF0ZSZxdW90
OywmYW1wO2Vycm9yLEdfVFlQRV9TVFJJTkcsJnF1b3Q7KiM0MyMmcXVvdDssR19UWVBFX0lOVkFM
SUQsPGJyPqCgoCCgoKAgoKAgoCCgIKAgoCCgIKAgoCCgIKAgoKAgZGJ1c19nX3R5cGVfZ2V0X3N0
cnVjdCAoJnF1b3Q7R1ZhbHVlQXJyYXkmcXVvdDssIEdfVFlQRV9TVFJJTkcsPGJyPqCgoCCgoKAg
oKCgIKCgoCCgoKAgoKCgoKCgoKCgoKAgZGJ1c19nX3R5cGVfZ2V0X21hcCAoJnF1b3Q7R0hhc2hU
YWJsZSZxdW90OywgR19UWVBFX1NUUklORywgR19UWVBFX1ZBTFVFKSxHX1RZUEVfSU5WQUxJRCks
PGJyPgqgoKAgoKCgIKCgoCCgoKAgoKCgIKCgoKCgoKCgoKCgICZhbXA7T1VUX2FyZzAsIEdfVFlQ
RV9JTlZBTElEKTs8YnI+PGJyPmJ1dCBpdCBpcyByZXR1cm5pbmcgZXJyb3IgJnF1b3Q7IEV4cGVj
dGVkIEQtQlVTIHN0cnVjdCwgZ290IHR5cGUgY29kZSAmIzM5O3MmIzM5OyZxdW90OyA8YnI+PGJy
PmNhbiBhbnkgYm9keSBwbGVhc2UgdGVsbCBtZSB0aGUgY29ycmVjdCByZXR1cm4gdHlwZXMuPGJy
Pgo8YnI+aW4gYm90aCBjYXNlcyBvZm9ubyBpcyBnZXR0aW5nIHJlc3BvbnNlIGZyb20gcGhvbmVz
aW0uPGJyPjxicj5hbmQgbm8gcHJvcGVyIGRvY3VtZW50YXRpb24gaXMgYXZhaWxhYmxlIGZvciBV
U1NEIHN1cHBvcnQgLjxicj48YnI+PGJyPmNhbiBhbnlib2R5IHBsZWFzZSBoZWxwPzxicj48YnI+
dGhhbmtzIDxicj5zay48YnI+PGJyPjxicj48YnI+PGJyPjxicj4K

--===============7332496322934683709==--

