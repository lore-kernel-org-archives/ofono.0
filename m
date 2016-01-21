Content-Type: multipart/mixed; boundary="===============1203529432576788859=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Thu, 21 Jan 2016 10:05:09 +0200
Message-ID: <CADnUhn1Ts0rWpLknGnibnzt7iWU4B0e1pgHesVZ==yrLUSNZ1Q@mail.gmail.com>
In-Reply-To: <CADnUhn0dGRuwjF59+SWHbW-zm5ttb+7BZp7jNWrgC+4GfOE1Qg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1203529432576788859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B8rn,
2016-01-20 19:20 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:

> I don't think so. It all looks OK to me.  It's just the AT^DHCP?
>> response which is a bit unexpected.  IIUC, the modem LEDs indicate a
>> connection?  What about "AT^NDISDUP?" ?
>>
> Initial LED led operation was "blinking green". It changed to "slow
> blinking blue"  after online-modem command. There was no change after
> activate-context (that produced "AT^NDISUP..."). I did not try manual
> "AT^NDISDUP?" command, though. I'll try it tomorrow.
>
  "AT^NDISDUP?" after connect-modem and activate-context returns pure OK

>
>> Did you try a DHCP client?  Maybe this firmware doesn't implement the
>> AT^DHCP command but has a DHCP server?
>>
> I did not try. I'll try it tomorrow.
>
Executing ifconfig wwan0 up;dhclient wwan0 can't get lease from wwan0
interface.

-Matti

--===============1203529432576788859==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPkhpIEJqw7hybiw8YnI+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDE2
LTAxLTIwIDE5OjIwIEdNVCswMjowMCBtYXR0aSBrYWFzaW5lbiA8c3BhbiBkaXI9Imx0ciI+Jmx0
OzxhIGhyZWY9Im1haWx0bzptYXR0aS5rYWFzaW5lbkBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5tYXR0aS5rYWFzaW5lbkBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj46PGJyPjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48c3Bh
biBjbGFzcz0iIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7
cGFkZGluZy1sZWZ0OjFleCI+SSBkb24mIzM5O3QgdGhpbmsgc28uIEl0IGFsbCBsb29rcyBPSyB0
byBtZS7CoCBJdCYjMzk7cyBqdXN0IHRoZSBBVF5ESENQPzxicj4KcmVzcG9uc2Ugd2hpY2ggaXMg
YSBiaXQgdW5leHBlY3RlZC7CoCBJSVVDLCB0aGUgbW9kZW0gTEVEcyBpbmRpY2F0ZSBhPGJyPgpj
b25uZWN0aW9uP8KgIFdoYXQgYWJvdXQgJnF1b3Q7QVReTkRJU0RVUD8mcXVvdDsgPzxicj48L2Js
b2NrcXVvdGU+PC9zcGFuPjxkaXY+SW5pdGlhbCBMRUQgbGVkIG9wZXJhdGlvbiB3YXMgJnF1b3Q7
YmxpbmtpbmcgZ3JlZW4mcXVvdDsuIEl0IGNoYW5nZWQgdG8gJnF1b3Q7c2xvdyBibGlua2luZyBi
bHVlJnF1b3Q7wqAgYWZ0ZXIgb25saW5lLW1vZGVtIGNvbW1hbmQuIFRoZXJlIHdhcyBubyBjaGFu
Z2UgYWZ0ZXIgYWN0aXZhdGUtY29udGV4dCAodGhhdCBwcm9kdWNlZCAmcXVvdDtBVF5ORElTVVAu
Li4mcXVvdDspLiBJIGRpZCBub3QgdHJ5IG1hbnVhbCAmcXVvdDtBVF5ORElTRFVQPyZxdW90OyBj
b21tYW5kLCB0aG91Z2guIEkmIzM5O2xsIHRyeSBpdCB0b21vcnJvdy4gPC9kaXY+PC9ibG9ja3F1
b3RlPjxkaXY+wqA8c3BhbiBjbGFzcz0iIj4gJnF1b3Q7QVReTkRJU0RVUD8mcXVvdDsgYWZ0ZXIg
Y29ubmVjdC1tb2RlbSBhbmQgYWN0aXZhdGUtY29udGV4dCByZXR1cm5zIHB1cmUgT0s8YnI+PC9z
cGFuPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtw
YWRkaW5nLWxlZnQ6MWV4Ij48c3BhbiBjbGFzcz0iIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNv
bGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KRGlkIHlvdSB0cnkg
YSBESENQIGNsaWVudD/CoCBNYXliZSB0aGlzIGZpcm13YXJlIGRvZXNuJiMzOTt0IGltcGxlbWVu
dCB0aGU8YnI+CkFUXkRIQ1AgY29tbWFuZCBidXQgaGFzIGEgREhDUCBzZXJ2ZXI/PGJyPjwvYmxv
Y2txdW90ZT48L3NwYW4+PGRpdj5JIGRpZCBub3QgdHJ5LiBJJiMzOTtsbCB0cnkgaXQgdG9tb3Jy
b3cuIDxicj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj5FeGVjdXRpbmcgaWZjb25maWcgd3dhbjAg
dXA7ZGhjbGllbnQgd3dhbjAgY2FuJiMzOTt0IGdldCBsZWFzZSBmcm9tIHd3YW4wIGludGVyZmFj
ZS48YnI+PGJyPjwvZGl2PjxkaXY+LU1hdHRpPGJyPjwvZGl2PjwvZGl2Pjxicj48YnI+PC9kaXY+
PC9kaXY+Cg==

--===============1203529432576788859==--

