Content-Type: multipart/mixed; boundary="===============6158187979970136774=="
MIME-Version: 1.0
From: Alexandre Da Costa <alexandre.dacosta1@gmail.com>
Subject: HFP support
Date: Thu, 21 Apr 2016 08:54:56 +0200
Message-ID: <CAFN7RgDrDCtvRfuBSNWvwfPaSuT9tzH8rukz_i4gqjH2gsBNMw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6158187979970136774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I've been using bluez, ofono and pulseaudio for bluetooth audio tests for a
few months. While everything worked fine with bluez 4, I've the need to
include BLE tests which require bluez 5.

This leads to quite some changes regarding HSP and HFP. My main requirement
is to test a bluetooth headset. Using pulseaudio with its native HSP
support I can have audio both ways from and to my headset. As I would like
to include the telephony features, I'm trying to move to ofono and HFP.

I've not found the current status of ofono and its HFP support. What use
cases are currently supported (audio gateway and/or headset) ? I tried to
configure pulseaudio to use ofono as HFP agent but I keep receiving the
following message when switch from A2DH to HFP : "Refused to switch profile
to headset_head_unit: Not connected"

Is there any limitation or am I missing something ?

Thanks

--===============6158187979970136774==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkhpIGFsbCw8YnI+PGJyPjwvZGl2PkkmIzM5O3ZlIGJl
ZW4gdXNpbmcgYmx1ZXosIDxzcGFuIGNsYXNzPSIiPm9mb25vPC9zcGFuPgogYW5kIHB1bHNlYXVk
aW8gZm9yIGJsdWV0b290aCBhdWRpbyB0ZXN0cyBmb3IgYSBmZXcgbW9udGhzLiBXaGlsZSAKZXZl
cnl0aGluZyB3b3JrZWQgZmluZSB3aXRoIGJsdWV6IDQsIEkmIzM5O3ZlIHRoZSBuZWVkIHRvIGlu
Y2x1ZGUgQkxFIHRlc3RzIAp3aGljaCByZXF1aXJlIGJsdWV6IDUuPGJyPjxicj48L2Rpdj48ZGl2
PlRoaXMgbGVhZHMgdG8gcXVpdGUgc29tZSAKY2hhbmdlcyByZWdhcmRpbmcgSFNQIGFuZCBIRlAu
IE15IG1haW4gcmVxdWlyZW1lbnQgaXMgdG8gdGVzdCBhIApibHVldG9vdGggaGVhZHNldC4gVXNp
bmcgcHVsc2VhdWRpbyB3aXRoIGl0cyBuYXRpdmUgSFNQIHN1cHBvcnQgSSBjYW4gCmhhdmUgYXVk
aW8gYm90aCB3YXlzIGZyb20gYW5kIHRvIG15IGhlYWRzZXQuIEFzIEkgd291bGQgbGlrZSB0byBp
bmNsdWRlIAp0aGUgdGVsZXBob255IGZlYXR1cmVzLCBJJiMzOTttIHRyeWluZyB0byBtb3ZlIHRv
IDxzcGFuIGNsYXNzPSIiPm9mb25vPC9zcGFuPiBhbmQgSEZQLjxicj48YnI+PC9kaXY+PGRpdj5J
JiMzOTt2ZSBub3QgZm91bmQgdGhlIGN1cnJlbnQgc3RhdHVzIG9mIDxzcGFuIGNsYXNzPSIiPm9m
b25vPC9zcGFuPgogYW5kIGl0cyBIRlAgc3VwcG9ydC4gV2hhdCB1c2UgY2FzZXMgYXJlIGN1cnJl
bnRseSBzdXBwb3J0ZWQgKGF1ZGlvIApnYXRld2F5IGFuZC9vciBoZWFkc2V0KSA/IEkgdHJpZWQg
dG8gY29uZmlndXJlIHB1bHNlYXVkaW8gdG8gdXNlIDxzcGFuIGNsYXNzPSIiPm9mb25vPC9zcGFu
PgogYXMgSEZQIGFnZW50IGJ1dCBJIGtlZXAgcmVjZWl2aW5nIHRoZSBmb2xsb3dpbmcgbWVzc2Fn
ZSB3aGVuIHN3aXRjaCAKZnJvbSBBMkRIIHRvIEhGUCA6ICZxdW90O1JlZnVzZWQgdG8gc3dpdGNo
IHByb2ZpbGUgdG8gaGVhZHNldF9oZWFkX3VuaXQ6IE5vdCAKY29ubmVjdGVkJnF1b3Q7PGJyPjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXMgdGhlcmUgYW55IGxpbWl0YXRpb24gb3IgYW0gSSBt
aXNzaW5nIHNvbWV0aGluZyA/PGJyPjxicj48L2Rpdj5UaGFua3M8L2Rpdj4K

--===============6158187979970136774==--

