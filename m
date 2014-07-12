Content-Type: multipart/mixed; boundary="===============8135932635010357883=="
MIME-Version: 1.0
From: CedrIc Jehasse <cedric.jehasse@gmail.com>
Subject: Re: Can't reconnect a Huawei E3131 modem
Date: Sat, 12 Jul 2014 13:28:54 +0200
Message-ID: <8A0F2701-665E-4853-831D-80E4C477C5FB@gmail.com>
In-Reply-To: <CAM5ihG-ZCkAaTC2jjxh-JG7hQyFb1y2v3oAyreV3AqeNEVe0_A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8135932635010357883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 11 Jul 2014, at 19:32, Jer=C3=B4nimo Lopes <lopesjeronimo@gmail.com> w=
rote:

> Hi,
> =

> I'm trying to use ofono and a Huawei E3131 modem.
> =

> First off all, I need to change AT+CGDATA=3D"PPP",%u to ATD*99***%u# to m=
ake it work. But that's ok.
> =

> The problem, is if disconnect, and try to connect again, it doesn't work. =

> =


I=E2=80=99ve seen the same behaviour with an Huawei E303. =

The problem with the E303 is oFono sends AT&C0 to the modem to avoid DCD dr=
ops after the disconnect, but the modem drops it anyway. This causes a tty =
hangup, and oFono can=E2=80=99t send commands to the modem port anymore.

The E3131 could have the same bug=E2=80=A6

regards,
Cedric

--===============8135932635010357883==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWwgY2hhcnNldD13aW5kb3dzLTEyNTIiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFw
OiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IC13ZWJraXQtbGluZS1icmVh
azogYWZ0ZXItd2hpdGUtc3BhY2U7Ij5IaSw8ZGl2Pjxicj48ZGl2PjxkaXY+T24gMTEgSnVsIDIw
MTQsIGF0IDE5OjMyLCBKZXL0bmltbyBMb3BlcyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmxvcGVzamVy
b25pbW9AZ21haWwuY29tIj5sb3Blc2plcm9uaW1vQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjwv
ZGl2PjxiciBjbGFzcz0iQXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSI+PGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSI+PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9
ImZvbnQtZmFtaWx5Oidjb3VyaWVyIG5ldycsbW9ub3NwYWNlIj5IaSw8L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6J2NvdXJpZXIgbmV3Jyxtb25vc3Bh
Y2UiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1p
bHk6J2NvdXJpZXIgbmV3Jyxtb25vc3BhY2UiPgpJJ20gdHJ5aW5nIHRvIHVzZSBvZm9ubyBhbmQg
YSBIdWF3ZWkgRTMxMzEgbW9kZW0uPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5
bGU9ImZvbnQtZmFtaWx5Oidjb3VyaWVyIG5ldycsbW9ub3NwYWNlIj48YnI+Rmlyc3Qgb2ZmIGFs
bCwgSSBuZWVkIHRvIGNoYW5nZSZuYnNwO0FUK0NHREFUQT0iUFBQIiwldSB0byZuYnNwO0FURCo5
OSoqKiV1IyB0byBtYWtlIGl0IHdvcmsuIEJ1dCB0aGF0J3Mgb2suPC9kaXY+CjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTonY291cmllciBuZXcnLG1vbm9zcGFj
ZSI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWls
eTonY291cmllciBuZXcnLG1vbm9zcGFjZSI+VGhlIHByb2JsZW0sIGlzIGlmIGRpc2Nvbm5lY3Qs
IGFuZCB0cnkgdG8gY29ubmVjdCBhZ2FpbiwgaXQgZG9lc24ndCB3b3JrLiZuYnNwOzwvZGl2Pgo8
ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6J2NvdXJpZXIgbmV3
Jyxtb25vc3BhY2UiPjxicj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2
PjxkaXY+SZJ2ZSBzZWVuIHRoZSBzYW1lIGJlaGF2aW91ciB3aXRoIGFuIEh1YXdlaSBFMzAzLiZu
YnNwOzwvZGl2PjxkaXY+VGhlIHByb2JsZW0gd2l0aCB0aGUgRTMwMyBpcyBvRm9ubyBzZW5kcyBB
VCZhbXA7QzAgdG8gdGhlIG1vZGVtIHRvIGF2b2lkIERDRCBkcm9wcyBhZnRlciB0aGUgZGlzY29u
bmVjdCwgYnV0IHRoZSBtb2RlbSBkcm9wcyBpdCBhbnl3YXkuIFRoaXMgY2F1c2VzIGEgdHR5IGhh
bmd1cCwgYW5kIG9Gb25vIGNhbpJ0IHNlbmQgY29tbWFuZHMgdG8gdGhlIG1vZGVtIHBvcnQgYW55
bW9yZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBFMzEzMSBjb3VsZCBoYXZlIHRoZSBz
YW1lIGJ1Z4U8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnJlZ2FyZHMsPC9kaXY+PGRpdj5DZWRy
aWM8L2Rpdj48L2JvZHk+PC9odG1sPg==
--===============8135932635010357883==--

