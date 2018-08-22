Content-Type: multipart/mixed; boundary="===============4358607131660847674=="
MIME-Version: 1.0
From: Ilya Bizyaev <bizyaev@zoho.com>
Subject: Ofono and Intel Clovertrail+
Date: Wed, 22 Aug 2018 23:54:16 +0300
Message-ID: <165636a9e99.1080f78118117.5400090142518811727@zoho.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4358607131660847674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone, I am currently working on a Halium port to an Intel Clovert=
rail+ phone, ASUS ZenFone 5 (A501CG). At the moment most vital device funct=
ions are supported, but it lacks the ability to make calls and send SMS. I =
have made some attempts to enable these features with Ofono but ran into is=
sues. The device uses the XMM6360 modem and Intrinsyc Rapid-RIL M6.59, so I=
 attempted to start the Ofono daemon like this: # OFONO_RIL_DEVICE=3Dril OF=
ONO_RIL_TRACE=3D1 ofonod -d -n But it failed to detect the SIM card with va=
rious errors like E_RADIO_NOT_AVAILABLE: Ofono log: https://paste.kde.org/p=
jpiczknh RIL log: https://paste.kde.org/pmt7drhforo8 There is almost no pub=
licly available information on the subject, so I would like to ask your opi=
nion about my project, especially from the perspective of Ofono. Do you thi=
nk it is possible to make this modem work with Ofono? Are there any tricky =
details or quirks I should know about? Any experience you can share is high=
ly valuable to me. Best regards, Ilya Bizyaev.

--===============4358607131660847674==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMDEgVHJhbnNpdGlvbmFs
Ly9FTiI+PGh0bWw+PGhlYWQ+PG1ldGEgY29udGVudD0idGV4dC9odG1sO2NoYXJzZXQ9VVRGLTgi
IGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSI+PC9oZWFkPjxib2R5ID48ZGl2IHN0eWxlPSdmb250
LXNpemU6MTBwdDtmb250LWZhbWlseTpWZXJkYW5hLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlm
O2NvbG9yOiMwMDAwMDsnPjxkaXY+SGVsbG8gZXZlcnlvbmUsPGJyPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+SSBhbSBjdXJyZW50bHkgd29ya2luZyBvbiBhIDxhIGhyZWY9Imh0dHBzOi8vaGFs
aXVtLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPkhhbGl1bTwvYT4gcG9ydCB0byBhbiBJbnRlbCBDbG92
ZXJ0cmFpbCsgcGhvbmUsIEFTVVMgWmVuRm9uZSA1IChBNTAxQ0cpLiBBdCB0aGUgbW9tZW50IG1v
c3Qgdml0YWwgZGV2aWNlIGZ1bmN0aW9ucyBhcmUgc3VwcG9ydGVkLCBidXQgaXQgbGFja3MgdGhl
IGFiaWxpdHkgdG8gbWFrZSBjYWxscyBhbmQgc2VuZCBTTVMuIEkgaGF2ZSBtYWRlIHNvbWUgYXR0
ZW1wdHMgdG8gZW5hYmxlIHRoZXNlIGZlYXR1cmVzIHdpdGggT2Zvbm8gYnV0IHJhbiBpbnRvIGlz
c3Vlcy48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgZGV2aWNlIHVzZXMgdGhlIFhN
TTYzNjAgbW9kZW0gYW5kIEludHJpbnN5YyBSYXBpZC1SSUwgTTYuNTksIHNvIEkgYXR0ZW1wdGVk
IHRvIHN0YXJ0IHRoZSBPZm9ubyBkYWVtb24gbGlrZSB0aGlzOjxicj48L2Rpdj48ZGl2PjxzcGFu
IGNsYXNzPSJmb250IiBzdHlsZT0iZm9udC1mYW1pbHk6ICZxdW90O2NvdXJpZXIgbmV3JnF1b3Q7
LCBjb3VyaWVyLCBtb25vc3BhY2UsIHNhbnMtc2VyaWY7Ij4jIE9GT05PX1JJTF9ERVZJQ0U9cmls
IE9GT05PX1JJTF9UUkFDRT0xIG9mb25vZCAtZCAtbjwvc3Bhbj48YnI+PC9kaXY+PGRpdj48c3Bh
biBjbGFzcz0iZm9udCIgc3R5bGU9ImZvbnQtZmFtaWx5OiB2ZXJkYW5hLCBzYW5zLXNlcmlmOyI+
QnV0IGl0IGZhaWxlZCB0byBkZXRlY3QgdGhlIFNJTSBjYXJkIHdpdGggdmFyaW91cyBlcnJvcnMg
bGlrZSBFX1JBRElPX05PVF9BVkFJTEFCTEU6PC9zcGFuPjxicj48L2Rpdj48ZGl2Pk9mb25vIGxv
ZzogPGEgaHJlZj0iaHR0cHM6Ly9wYXN0ZS5rZGUub3JnL3BqcGljemtuaCIgdGFyZ2V0PSJfYmxh
bmsiPmh0dHBzOi8vcGFzdGUua2RlLm9yZy9wanBpY3prbmg8L2E+PGJyPjwvZGl2PjxkaXY+UklM
IGxvZzogPGEgaHJlZj0iaHR0cHM6Ly9wYXN0ZS5rZGUub3JnL3BtdDdkcmhvOCIgdGFyZ2V0PSJf
YmxhbmsiPmh0dHBzOi8vcGFzdGUua2RlLm9yZy9wbXQ3ZHJoZm9ybzg8L2E+PGJyPjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+VGhlcmUgaXMgYWxtb3N0IG5vIHB1YmxpY2x5IGF2YWlsYWJsZSBp
bmZvcm1hdGlvbiBvbiB0aGUgc3ViamVjdCwgc28gSSAKd291bGQgbGlrZSB0byBhc2sgeW91ciBv
cGluaW9uIGFib3V0IG15IHByb2plY3QsIGVzcGVjaWFsbHkgZnJvbSB0aGUgCnBlcnNwZWN0aXZl
IG9mIE9mb25vLiBEbyB5b3UgdGhpbmsgaXQgaXMgcG9zc2libGUgdG8gbWFrZSB0aGlzIG1vZGVt
IAp3b3JrIHdpdGggT2Zvbm8/IEFyZSB0aGVyZSBhbnkgdHJpY2t5IGRldGFpbHMgb3IgcXVpcmtz
IEkgc2hvdWxkIGtub3cgCmFib3V0PyBBbnkgZXhwZXJpZW5jZSB5b3UgY2FuIHNoYXJlIGlzIGhp
Z2hseSB2YWx1YWJsZSB0byBtZS48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IHJl
Z2FyZHMsPGJyPjwvZGl2PjxkaXY+SWx5YSBCaXp5YWV2Ljxicj48L2Rpdj48L2Rpdj48YnI+PC9i
b2R5PjwvaHRtbD4=
--===============4358607131660847674==--

