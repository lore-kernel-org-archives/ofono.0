Content-Type: multipart/mixed; boundary="===============0230986053392171941=="
MIME-Version: 1.0
From: Davide Tuccilli <tuccio89@hotmail.com>
Subject: Re: Problem setting up ofono
Date: Tue, 18 Apr 2017 08:22:59 +0000
Message-ID: <VI1PR1001MB0783E352F14C3DFA19836B77C9190@VI1PR1001MB0783.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <b7f6d69a-9f32-0340-ead5-65478821c6cb@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0230986053392171941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thank you for your response. I'm using BlueZ 5.28 and I've ran a test with =
OFONO_AT_DEBUG=3D1 as you suggested. From this test, it would look like the=
 bluetooth communication is working, since I'm getting messages printed out=
 by ofono when I try to call, although I'm not sure how to interpret them. =
I will link full log in case you want to take a look: https://pastebin.com/=
1SQwBDZ5 . I've tried calling 3 times in the latter part of the log.


________________________________
Da: Denis Kenzior <denkenz@gmail.com>
Inviato: gioved=C3=AC 13 aprile 2017 18.53
A: ofono(a)ofono.org; tuccio89(a)hotmail.com
Oggetto: Re: Problem setting up ofono

Hi Davide,

> I've tried running ofonod with the -d flag to get some debug
> information, but I didn't see anything that could help me, since it
> stops printing out anything after the connection succeeds, here's the
> full log: https://pastebin.com/gz2tFK4n

Run ofonod with OFONO_AT_DEBUG=3D1 environment variable set.

e.g.
export OFONO_AT_DEBUG=3D1
ofonod -nd

What version of BlueZ are you using?

Regards,
-Denis

--===============0230986053392171941==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD1pc28tODg1OS0xIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIiBzdHls
ZT0iZGlzcGxheTpub25lOyI+PCEtLSBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30g
LS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBkaXI9Imx0ciI+CjxkaXYgaWQ9ImRpdnRhZ2RlZmF1
bHR3cmFwcGVyIiBzdHlsZT0iZm9udC1zaXplOjEycHQ7Y29sb3I6IzAwMDAwMDtmb250LWZhbWls
eTpDYWxpYnJpLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmOyIgZGlyPSJsdHIiPgo8ZGl2Pgo8
cD5IaSBEZW5pcyw8L3A+ClRoYW5rIHlvdSBmb3IgeW91ciByZXNwb25zZS4gSSdtIHVzaW5nIEJs
dWVaIDUuMjggYW5kIEkndmUgcmFuIGEgdGVzdCB3aXRoIE9GT05PX0FUX0RFQlVHPTEgYXMgeW91
IHN1Z2dlc3RlZC4gRnJvbSB0aGlzIHRlc3QsIGl0IHdvdWxkIGxvb2sgbGlrZSB0aGUgYmx1ZXRv
b3RoIGNvbW11bmljYXRpb24gaXMgd29ya2luZywgc2luY2UgSSdtIGdldHRpbmcgbWVzc2FnZXMg
cHJpbnRlZCBvdXQgYnkgb2Zvbm8gd2hlbiBJIHRyeSB0byBjYWxsLCBhbHRob3VnaAogSSdtIG5v
dCBzdXJlIGhvdyB0byBpbnRlcnByZXQgdGhlbS4gSSB3aWxsIGxpbmsgZnVsbCBsb2cgaW4gY2Fz
ZSB5b3Ugd2FudCB0byB0YWtlIGEgbG9vazoKPGEgaHJlZj0iaHR0cHM6Ly9wYXN0ZWJpbi5jb20v
MVNRd0JEWjUiIGNsYXNzPSJPV0FBdXRvTGluayIgaWQ9IkxQbG5rODIzMTg0IiBwcmV2aWV3cmVt
b3ZlZD0idHJ1ZSI+Cmh0dHBzOi8vcGFzdGViaW4uY29tLzFTUXdCRFo1IDwvYT4uIEkndmUgdHJp
ZWQgY2FsbGluZyAzIHRpbWVzIGluIHRoZSBsYXR0ZXIgcGFydCBvZiB0aGUgbG9nLjwvZGl2Pgo8
YnI+Cjxicj4KPGRpdiBzdHlsZT0iY29sb3I6IHJnYigwLCAwLCAwKTsiPgo8ZGl2Pgo8aHIgdGFi
aW5kZXg9Ii0xIiBzdHlsZT0iZGlzcGxheTppbmxpbmUtYmxvY2s7IHdpZHRoOjk4JSI+CjxkaXYg
aWQ9InhfZGl2UnBseUZ3ZE1zZyIgZGlyPSJsdHIiPjxmb250IHN0eWxlPSJmb250LXNpemU6MTFw
dCIgY29sb3I9IiMwMDAwMDAiIGZhY2U9IkNhbGlicmksIHNhbnMtc2VyaWYiPjxiPkRhOjwvYj4g
RGVuaXMgS2VuemlvciAmbHQ7ZGVua2VuekBnbWFpbC5jb20mZ3Q7PGJyPgo8Yj5JbnZpYXRvOjwv
Yj4gZ2lvdmVk7CAxMyBhcHJpbGUgMjAxNyAxOC41Mzxicj4KPGI+QTo8L2I+IG9mb25vQG9mb25v
Lm9yZzsgdHVjY2lvODlAaG90bWFpbC5jb208YnI+CjxiPk9nZ2V0dG86PC9iPiBSZTogUHJvYmxl
bSBzZXR0aW5nIHVwIG9mb25vPC9mb250Pgo8ZGl2PiZuYnNwOzwvZGl2Pgo8L2Rpdj4KPC9kaXY+
Cjxmb250IHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTBwdDsiPgo8ZGl2IGNsYXNz
PSJQbGFpblRleHQiPkhpIERhdmlkZSw8YnI+Cjxicj4KJmd0OyBJJ3ZlIHRyaWVkIHJ1bm5pbmcg
b2Zvbm9kIHdpdGggdGhlIC1kIGZsYWcgdG8gZ2V0IHNvbWUgZGVidWc8YnI+CiZndDsgaW5mb3Jt
YXRpb24sIGJ1dCBJIGRpZG4ndCBzZWUgYW55dGhpbmcgdGhhdCBjb3VsZCBoZWxwIG1lLCBzaW5j
ZSBpdDxicj4KJmd0OyBzdG9wcyBwcmludGluZyBvdXQgYW55dGhpbmcgYWZ0ZXIgdGhlIGNvbm5l
Y3Rpb24gc3VjY2VlZHMsIGhlcmUncyB0aGU8YnI+CiZndDsgZnVsbCBsb2c6IDxhIGhyZWY9Imh0
dHBzOi8vcGFzdGViaW4uY29tL2d6MnRGSzRuIiBpZD0iTFBsbms5MjkzNDQiIHByZXZpZXdyZW1v
dmVkPSJ0cnVlIj4KaHR0cHM6Ly9wYXN0ZWJpbi5jb20vZ3oydEZLNG48L2E+PGJyPgo8YnI+ClJ1
biBvZm9ub2Qgd2l0aCBPRk9OT19BVF9ERUJVRz0xIGVudmlyb25tZW50IHZhcmlhYmxlIHNldC48
YnI+Cjxicj4KZS5nLjxicj4KZXhwb3J0IE9GT05PX0FUX0RFQlVHPTE8YnI+Cm9mb25vZCAtbmQ8
YnI+Cjxicj4KV2hhdCB2ZXJzaW9uIG9mIEJsdWVaIGFyZSB5b3UgdXNpbmc/PGJyPgo8YnI+ClJl
Z2FyZHMsPGJyPgotRGVuaXM8YnI+CjwvZGl2Pgo8L3NwYW4+PC9mb250PjwvZGl2Pgo8L2Rpdj4K
PC9ib2R5Pgo8L2h0bWw+Cg==

--===============0230986053392171941==--

