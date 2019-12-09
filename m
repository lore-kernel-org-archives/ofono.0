Content-Type: multipart/mixed; boundary="===============7007182728555158752=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: How accuracy to get 4G LTE RSSI via connman dbus query?
Date: Mon, 09 Dec 2019 17:50:38 +1100
Message-ID: <CAA=hcWRuZf0kk+HOhWL5=hfspp6NgqL8cirvHCrj89Znx3u80w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7007182728555158752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I get 4G LTE RSSI from dbus connman service, I usually got about -61 I
thought it was accurate. But today, we are doing a test to check 4G LTE
RSSI based on different antennas, when connected to a antenna, the RSSI is
about -61, when I did not connect to an antenna, the RSSI =3D -40 but the 4G
LTE connection lost:

kernel: qmi_wwan 1-1:1.3: nonzero urb status received: -71.

Apparently that RSSI =3D -40 was wrong in the situation of without antenna
connection. I tried to build qmicli, but I could not get it running.
googling Internet, people pointed out, it could not be run if the qmi is
running by other services (ofono is running qmi on /dev/cdc-wdm0).

# qmicli --nas-get-signal-strength --device=3D/dev/cdc-wdm0
error: couldn't create client for the 'nas' service: CID allocation failed
in the CTL client: Transaction timed out

Appreciate tips how to get qmicli running.

Thank you.

Kind regards,

- jh

--===============7007182728555158752==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OmdhcmFtb25kLHNlcmlmIj5IaSw8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBz
dHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWYiPkkgZ2V0IDRH
IExURSBSU1NJIGZyb20gZGJ1cyBjb25ubWFuIHNlcnZpY2UsIEkgdXN1YWxseSBnb3QgYWJvdXQg
LTYxIEkgdGhvdWdodCBpdCB3YXMgYWNjdXJhdGUuIEJ1dCB0b2RheSwgd2UgYXJlIGRvaW5nIGEg
dGVzdCB0byBjaGVjayA0RyBMVEUgUlNTSSBiYXNlZCBvbiBkaWZmZXJlbnQgYW50ZW5uYXMsIHdo
ZW4gY29ubmVjdGVkIHRvIGEgYW50ZW5uYSwgdGhlIFJTU0kgaXMgYWJvdXQgLTYxLCB3aGVuIEkg
ZGlkIG5vdCBjb25uZWN0IHRvIGFuIGFudGVubmEsIHRoZSBSU1NJID0gLTQwIGJ1dCB0aGUgNEcg
TFRFIGNvbm5lY3Rpb24gbG9zdDo8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHls
ZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWYiPmtlcm5lbDogcW1p
X3d3YW4gMS0xOjEuMzogbm9uemVybyB1cmIgc3RhdHVzIHJlY2VpdmVkOiAtNzEuIDxicj48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQs
c2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1m
YW1pbHk6Z2FyYW1vbmQsc2VyaWYiPkFwcGFyZW50bHkgdGhhdCBSU1NJID0gLTQwIHdhcyB3cm9u
ZyBpbiB0aGUgc2l0dWF0aW9uIG9mIHdpdGhvdXQgYW50ZW5uYSBjb25uZWN0aW9uLiBJIHRyaWVk
IHRvIGJ1aWxkIHFtaWNsaSwgYnV0IEkgY291bGQgbm90IGdldCBpdCBydW5uaW5nLiBnb29nbGlu
ZyBJbnRlcm5ldCwgcGVvcGxlIHBvaW50ZWQgb3V0LCBpdCBjb3VsZCBub3QgYmUgcnVuIGlmIHRo
ZSBxbWkgaXMgcnVubmluZyBieSBvdGhlciBzZXJ2aWNlcyAob2Zvbm8gaXMgcnVubmluZyBxbWkg
b24gL2Rldi9jZGMtd2RtMCkuIDxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBz
dHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWYiPiMgcW1pY2xp
IC0tbmFzLWdldC1zaWduYWwtc3RyZW5ndGggLS1kZXZpY2U9L2Rldi9jZGMtd2RtMDxicj5lcnJv
cjogY291bGRuJiMzOTt0IGNyZWF0ZSBjbGllbnQgZm9yIHRoZSAmIzM5O25hcyYjMzk7IHNlcnZp
Y2U6IENJRCBhbGxvY2F0aW9uIGZhaWxlZCBpbiB0aGUgQ1RMIGNsaWVudDogVHJhbnNhY3Rpb24g
dGltZWQgb3V0PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OmdhcmFtb25kLHNlcmlmIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU9ImZvbnQtZmFtaWx5OmdhcmFtb25kLHNlcmlmIj5BcHByZWNpYXRlIHRpcHMgaG93IHRv
IGdldCBxbWljbGkgcnVubmluZy48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHls
ZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWYiPlRoYW5rIHlvdS48
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1v
bmQsc2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9u
dC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWYiPktpbmQgcmVnYXJkcyw8L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWYiPjxicj48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQs
c2VyaWYiPi0gamg8YnI+PC9kaXY+PC9kaXY+Cg==

--===============7007182728555158752==--

