Content-Type: multipart/mixed; boundary="===============0743354504510190936=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jer=C3=B4nimo?= Lopes <lopesjeronimo@gmail.com>
Subject: Re: Can't reconnect a Huawei E3131 modem
Date: Thu, 17 Jul 2014 09:55:47 -0300
Message-ID: <CAM5ihG88Qte8oc1JNTa2ci-uBT-Sc5jF9A_mqMTTFK8+qrdhcQ@mail.gmail.com>
In-Reply-To: <8A0F2701-665E-4853-831D-80E4C477C5FB@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0743354504510190936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric, tanks for your answer.

2014-07-12 8:28 GMT-03:00 CedrIc Jehasse <cedric.jehasse@gmail.com>:

> Hi,
>
> On 11 Jul 2014, at 19:32, Jer=C3=B4nimo Lopes <lopesjeronimo@gmail.com>=
 wrote:
>
> Hi,
>
> I'm trying to use ofono and a Huawei E3131 modem.
>
> First off all, I need to change AT+CGDATA=3D"PPP",%u to ATD*99***%u# to m=
ake
> it work. But that's ok.
>
> The problem, is if disconnect, and try to connect again, it doesn't work.
>
>
> I=E2=80=99ve seen the same behaviour with an Huawei E303.
> The problem with the E303 is oFono sends AT&C0 to the modem to avoid DCD
> drops after the disconnect, but the modem drops it anyway. This causes a
> tty hangup, and oFono can=E2=80=99t send commands to the modem port anymo=
re.
>
> The E3131 could have the same bug=E2=80=A6
>
> regards,
> Cedric
> =E2=80=8B
>

Yes, I just got a E303 and it has the same problem.

Is there any workaround for this? At least here in Brazil, this models,
E3131 and E303 are really common.
=E2=80=8B

> =E2=80=8B
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>
>

--===============0743354504510190936==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OmNvdXJpZXIgbmV3LG1vbm9zcGFjZSI+SGkgQ2VkcmljLCB0YW5rcyBmb3IgeW91ciBhbnN3
ZXIuPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+MjAxNC0wNy0xMiA4OjI4IEdNVC0wMzowMCBDZWRySWMgSmVoYXNzZSA8c3BhbiBkaXI9
Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpjZWRyaWMuamVoYXNzZUBnbWFpbC5jb20iIHRhcmdl
dD0iX2JsYW5rIj5jZWRyaWMuamVoYXNzZUBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj46PGJyPgo8
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IHN0eWxlPSJ3
b3JkLXdyYXA6YnJlYWstd29yZCI+SGksPGRpdiBjbGFzcz0iIj48ZGl2Pjxicj48ZGl2PjxkaXY+
T24gMTEgSnVsIDIwMTQsIGF0IDE5OjMyLCBKZXLDtG5pbW8gTG9wZXMgJmx0OzxhIGhyZWY9Im1h
aWx0bzpsb3Blc2plcm9uaW1vQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmxvcGVzamVyb25p
bW9AZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PC9kaXY+Cjxicj48YmxvY2txdW90ZSB0eXBlPSJj
aXRlIj48ZGl2IGRpcj0ibHRyIj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTomIzM5O2NvdXJpZXIg
bmV3JiMzOTssbW9ub3NwYWNlIj5IaSw8L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTomIzM5
O2NvdXJpZXIgbmV3JiMzOTssbW9ub3NwYWNlIj48YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1m
YW1pbHk6JiMzOTtjb3VyaWVyIG5ldyYjMzk7LG1vbm9zcGFjZSI+CgpJJiMzOTttIHRyeWluZyB0
byB1c2Ugb2Zvbm8gYW5kIGEgSHVhd2VpIEUzMTMxIG1vZGVtLjwvZGl2PjxkaXYgc3R5bGU9ImZv
bnQtZmFtaWx5OiYjMzk7Y291cmllciBuZXcmIzM5Oyxtb25vc3BhY2UiPjxicj5GaXJzdCBvZmYg
YWxsLCBJIG5lZWQgdG8gY2hhbmdlwqBBVCtDR0RBVEE9JnF1b3Q7UFBQJnF1b3Q7LCV1IHRvwqBB
VEQqOTkqKioldSMgdG8gbWFrZSBpdCB3b3JrLiBCdXQgdGhhdCYjMzk7cyBvay48L2Rpdj4KCjxk
aXYgc3R5bGU9ImZvbnQtZmFtaWx5OiYjMzk7Y291cmllciBuZXcmIzM5Oyxtb25vc3BhY2UiPjxi
cj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTomIzM5O2NvdXJpZXIgbmV3JiMzOTssbW9u
b3NwYWNlIj5UaGUgcHJvYmxlbSwgaXMgaWYgZGlzY29ubmVjdCwgYW5kIHRyeSB0byBjb25uZWN0
IGFnYWluLCBpdCBkb2VzbiYjMzk7dCB3b3JrLsKgPC9kaXY+CjxkaXYgc3R5bGU9ImZvbnQtZmFt
aWx5OiYjMzk7Y291cmllciBuZXcmIzM5Oyxtb25vc3BhY2UiPjxicj48L2Rpdj48L2Rpdj48L2Js
b2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2PjwvZGl2PjxkaXY+SeKAmXZlIHNlZW4gdGhlIHNhbWUg
YmVoYXZpb3VyIHdpdGggYW4gSHVhd2VpIEUzMDMuwqA8L2Rpdj48ZGl2PlRoZSBwcm9ibGVtIHdp
dGggdGhlIEUzMDMgaXMgb0Zvbm8gc2VuZHMgQVQmYW1wO0MwIHRvIHRoZSBtb2RlbSB0byBhdm9p
ZCBEQ0QgZHJvcHMgYWZ0ZXIgdGhlIGRpc2Nvbm5lY3QsIGJ1dCB0aGUgbW9kZW0gZHJvcHMgaXQg
YW55d2F5LiBUaGlzIGNhdXNlcyBhIHR0eSBoYW5ndXAsIGFuZCBvRm9ubyBjYW7igJl0IHNlbmQg
Y29tbWFuZHMgdG8gdGhlIG1vZGVtIHBvcnQgYW55bW9yZS48L2Rpdj4KPGRpdj48YnI+PC9kaXY+
PGRpdj5UaGUgRTMxMzEgY291bGQgaGF2ZSB0aGUgc2FtZSBidWfigKY8L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PnJlZ2FyZHMsPC9kaXY+PGRpdj5DZWRyaWM8L2Rpdj48L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6JiMzOTtjb3VyaWVyIG5ldyYjMzk7
LG1vbm9zcGFjZTtkaXNwbGF5OmlubGluZSI+4oCLPC9kaXY+PC9ibG9ja3F1b3RlPgo8ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6JiMzOTtjb3VyaWVyIG5ldyYj
Mzk7LG1vbm9zcGFjZSI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxl
PSJmb250LWZhbWlseTomIzM5O2NvdXJpZXIgbmV3JiMzOTssbW9ub3NwYWNlIj5ZZXMsIEkganVz
dCBnb3QgYSBFMzAzIGFuZCBpdCBoYXMgdGhlIHNhbWUgcHJvYmxlbS7CoDwvZGl2Pgo8ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6JiMzOTtjb3VyaWVyIG5ldyYj
Mzk7LG1vbm9zcGFjZSI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxl
PSJmb250LWZhbWlseTomIzM5O2NvdXJpZXIgbmV3JiMzOTssbW9ub3NwYWNlIj5JcyB0aGVyZSBh
bnkgd29ya2Fyb3VuZCBmb3IgdGhpcz8gQXQgbGVhc3QgaGVyZSBpbiBCcmF6aWwsIHRoaXMgbW9k
ZWxzLCBFMzEzMSBhbmQgRTMwMyBhcmUgcmVhbGx5IGNvbW1vbi7CoDwvZGl2Pgo8ZGl2IGNsYXNz
PSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6JiMzOTtjb3VyaWVyIG5ldyYjMzk7
LG1vbm9zcGFjZSI+4oCLPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OiYj
Mzk7Y291cmllciBuZXcmIzM5Oyxtb25vc3BhY2U7ZGlzcGxheTppbmxpbmUiPgrigIs8L2Rpdj48
YnI+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+Cm9m
b25vIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+b2Zv
bm9Ab2Zvbm8ub3JnPC9hPjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFp
bG1hbi9saXN0aW5mby9vZm9ubyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMub2Zvbm8u
b3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8YnI+PC9ibG9ja3F1b3RlPjwvZGl2
Pjxicj48L2Rpdj48L2Rpdj4K

--===============0743354504510190936==--

