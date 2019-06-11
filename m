Content-Type: multipart/mixed; boundary="===============8894580405765628712=="
MIME-Version: 1.0
From: swathika kesavan <swathikakesavan@gmail.com>
Subject: Query related to calling via ofono api's
Date: Tue, 11 Jun 2019 13:17:53 +0530
Message-ID: <CAB7taOueBPF2L+r1SV4k+rv7EMq65Wp8Fqa=3uHtEV6raLNiwQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8894580405765628712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Team,
I have got few clarification related to ofono and connection manager.
We are using connection manager to bring the cellular interface up and its
successful.
We have got some application to make calls (which uses dbus ofono api's
like Dial).
When the cellular is under enabled state(connmanctl enable cellular) then
upon running ofono in debug mode ,I could see those ATD (dial commands)
been received by ofono and calling is successful.

But we are facing some issues,when I disable the cellular option in
connection manager using (connmanctl disable cellular).I couldn't see any
AT commands been received by ofono used for calling(via dbus)
*Note: *
Upon disabling ,instead of pushing the module to airplane mode (default
behavior),we have modified it in such a way they are not pushed to airplane
mode(instead we tried by disabling gprs alone(AT+CGATT=3D0)).
Here are my queries,
If Ofono is independent application ,which means disabling cellular in
connection manager shouldn't affect the call related api's which is been
used in my third application correct?
else ofono is dependent application on connman?
Kindly help me ,am stuck at the above case.

--===============8894580405765628712==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBUZWFtLDwvZGl2PjxkaXY+SSBoYXZlIGdvdCBmZXcgY2xh
cmlmaWNhdGlvbiByZWxhdGVkIHRvIG9mb25vIGFuZCBjb25uZWN0aW9uIG1hbmFnZXIuPC9kaXY+
PGRpdj5XZSBhcmUgdXNpbmcgY29ubmVjdGlvbiBtYW5hZ2VyIHRvIGJyaW5nIHRoZSBjZWxsdWxh
ciBpbnRlcmZhY2UgdXAgYW5kIGl0cyBzdWNjZXNzZnVsLjwvZGl2PjxkaXY+V2UgaGF2ZSBnb3Qg
c29tZSBhcHBsaWNhdGlvbiB0byBtYWtlIGNhbGxzICh3aGljaCB1c2VzIGRidXMgb2Zvbm8gYXBp
JiMzOTtzIGxpa2UgRGlhbCkuPC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luLWxlZnQ6NDBweCI+V2hl
biB0aGUgY2VsbHVsYXIgaXMgdW5kZXIgZW5hYmxlZCBzdGF0ZShjb25ubWFuY3RsIGVuYWJsZSBj
ZWxsdWxhcikgdGhlbiB1cG9uIHJ1bm5pbmcgb2Zvbm8gaW4gZGVidWcgbW9kZSAsSSBjb3VsZCBz
ZWUgdGhvc2UgQVREIChkaWFsIGNvbW1hbmRzKSBiZWVuIHJlY2VpdmVkIGJ5IG9mb25vIGFuZCBj
YWxsaW5nIGlzIHN1Y2Nlc3NmdWwuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXYgc3R5bGU9
Im1hcmdpbi1sZWZ0OjQwcHgiPkJ1dCB3ZSBhcmUgZmFjaW5nIHNvbWUgaXNzdWVzLHdoZW4gSSBk
aXNhYmxlIHRoZSBjZWxsdWxhciBvcHRpb24gaW4gY29ubmVjdGlvbiBtYW5hZ2VyIHVzaW5nIChj
b25ubWFuY3RsIGRpc2FibGUgY2VsbHVsYXIpLkkgY291bGRuJiMzOTt0IHNlZSBhbnkgQVQgY29t
bWFuZHMgYmVlbiByZWNlaXZlZCBieSBvZm9ubyB1c2VkIGZvciBjYWxsaW5nKHZpYSBkYnVzKTwv
ZGl2PjxkaXYgc3R5bGU9Im1hcmdpbi1sZWZ0OjQwcHgiPjxpPjxiPk5vdGU6IDwvYj48L2k+PGJy
PlVwb24gZGlzYWJsaW5nICxpbnN0ZWFkIG9mIHB1c2hpbmcgdGhlIG1vZHVsZSB0bwogYWlycGxh
bmUgbW9kZSAoZGVmYXVsdCBiZWhhdmlvciksd2UgaGF2ZSBtb2RpZmllZCBpdCBpbiBzdWNoIGEg
d2F5IHRoZXkKIGFyZSBub3QgcHVzaGVkIHRvIGFpcnBsYW5lIG1vZGUoaW5zdGVhZCB3ZSB0cmll
ZCBieSBkaXNhYmxpbmcgZ3BycyAKYWxvbmUoQVQrQ0dBVFQ9MCkpLjwvZGl2PjxkaXY+SGVyZSBh
cmUgbXkgcXVlcmllcyw8L2Rpdj48ZGl2PklmIE9mb25vIGlzIGluZGVwZW5kZW50IGFwcGxpY2F0
aW9uICx3aGljaCBtZWFucyBkaXNhYmxpbmcgY2VsbHVsYXIgaW4gY29ubmVjdGlvbiBtYW5hZ2Vy
IHNob3VsZG4mIzM5O3QgYWZmZWN0IHRoZSBjYWxsIHJlbGF0ZWQgYXBpJiMzOTtzIHdoaWNoIGlz
IGJlZW4gdXNlZCBpbiBteSB0aGlyZCBhcHBsaWNhdGlvbiBjb3JyZWN0PzwvZGl2PjxkaXY+ZWxz
ZSBvZm9ubyBpcyBkZXBlbmRlbnQgYXBwbGljYXRpb24gb24gY29ubm1hbj8gPGJyPjwvZGl2Pjxk
aXY+S2luZGx5IGhlbHAgbWUgLGFtIHN0dWNrIGF0IHRoZSBhYm92ZSBjYXNlLjxicj48L2Rpdj48
YnI+PGRpdj48YnI+PC9kaXY+PC9kaXY+Cg==

--===============8894580405765628712==--

