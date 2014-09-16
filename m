Content-Type: multipart/mixed; boundary="===============7174929890613088394=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: Telit driver implementation
Date: Tue, 16 Sep 2014 11:36:05 +0200
Message-ID: <CAH4ZQwudt7S0twGZRyMXOOZhoPcNJSjUmLo-wmniY9DrDgL4KQ@mail.gmail.com>
In-Reply-To: <541801BA.2080503@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7174929890613088394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanx for the quick answer,
what I don't really understand is the difference between drivers and
plugins in ofono.
Let's take an example: I need radio-settings interface to get and set the
technology preference. This interface is not implemented in atmodem driver.
Is it better to extend atmodem driver or to create a new driver? If I can
do it in plugin it would be fine, but how?
Plus I will need to extend the dbus interfaces to have some more method.
Looking at the dbus code I see that it calls the driver implementations, so
I think I have to either extend the atmodem driver or to create a new one.
Am I missing someting?

Thank you.


Enrico


2014-09-16 11:24 GMT+02:00 Jonas Bonn <jonas@southpole.se>:

>  On 09/16/14 11:16, Enrico Sau wrote:
>
>  Dear all,
> I need to use ofono on a Telit module (UE910). I tried to use he910 plugin
> and atmodem driver and it seems to recognize the modem but, some of the
> interfaces does not work and I also need some more commands than the one
> exported by atmodem.
> This request is to ask what should I do? I'm currently starting to develop
> a new driver (telitmodem) with the interfaces I need.
> Is my behavior correct?
>
>
> Since the UE910 is a member of the xE910 family and extremely similar to
> the HE910 in functionality, it would be better to try to extend the he910
> driver to handle this device.
>
> If you could provide a description of your problem and requirements, then
> it might be easier to give you guidance:
>
> i) what interfaces do not work?
> ii) what commands do you require that are not exported?
>
> The more info you can provide, the better.
>
> /Jonas
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>
>

--===============7174929890613088394==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+VGhhbnggZm9yIHRoZSBxdWljayBhbnN3ZXIsPC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fu
cy1zZXJpZiI+d2hhdCBJIGRvbiYjMzk7dCByZWFsbHkgdW5kZXJzdGFuZCBpcyB0aGUgZGlmZmVy
ZW5jZSBiZXR3ZWVuIGRyaXZlcnMgYW5kIHBsdWdpbnMgaW4gb2Zvbm8uPC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+
TGV0JiMzOTtzIHRha2UgYW4gZXhhbXBsZTogSSBuZWVkIHJhZGlvLXNldHRpbmdzIGludGVyZmFj
ZSB0byBnZXQgYW5kIHNldCB0aGUgdGVjaG5vbG9neSBwcmVmZXJlbmNlLiBUaGlzIGludGVyZmFj
ZSBpcyBub3QgaW1wbGVtZW50ZWQgaW4gYXRtb2RlbSBkcml2ZXIuPC9kaXY+PGRpdiBjbGFzcz0i
Z21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SXMg
aXQgYmV0dGVyIHRvIGV4dGVuZCBhdG1vZGVtIGRyaXZlciBvciB0byBjcmVhdGUgYSBuZXcgZHJp
dmVyPyBJZiBJIGNhbiBkbyBpdCBpbiBwbHVnaW4gaXQgd291bGQgYmUgZmluZSwgYnV0IGhvdz88
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFu
YSxzYW5zLXNlcmlmIj5QbHVzIEkgd2lsbCBuZWVkIHRvIGV4dGVuZCB0aGUgZGJ1cyBpbnRlcmZh
Y2VzIHRvIGhhdmUgc29tZSBtb3JlIG1ldGhvZC4gTG9va2luZyBhdCB0aGUgZGJ1cyBjb2RlIEkg
c2VlIHRoYXQgaXQgY2FsbHMgdGhlIGRyaXZlciBpbXBsZW1lbnRhdGlvbnMsIHNvIEkgdGhpbmsg
SSBoYXZlIHRvIGVpdGhlciBleHRlbmQgdGhlIGF0bW9kZW0gZHJpdmVyIG9yIHRvIGNyZWF0ZSBh
IG5ldyBvbmUuPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+QW0gSSBtaXNzaW5nIHNvbWV0aW5nPzwvZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2Vy
aWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1p
bHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5UaGFuayB5b3UuPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZXh0cmEiPjxiciBjbGVhcj0iYWxsIj48ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+RW5yaWNvPC9k
aXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+Cjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAx
NC0wOS0xNiAxMToyNCBHTVQrMDI6MDAgSm9uYXMgQm9ubiA8c3BhbiBkaXI9Imx0ciI+Jmx0Ozxh
IGhyZWY9Im1haWx0bzpqb25hc0Bzb3V0aHBvbGUuc2UiIHRhcmdldD0iX2JsYW5rIj5qb25hc0Bz
b3V0aHBvbGUuc2U8L2E+Jmd0Ozwvc3Bhbj46PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPgogIAogICAgCiAgCiAgPGRpdiB0ZXh0PSIjMDAwMDAwIiBiZ2Nv
bG9yPSIjRkZGRkZGIj48c3Bhbj4KICAgIDxkaXY+T24gMDkvMTYvMTQgMTE6MTYsIEVucmljbyBT
YXUgd3JvdGU6PGJyPgogICAgPC9kaXY+CiAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAg
ICAgPGRpdiBkaXI9Imx0ciI+CiAgICAgICAgPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFu
YSxzYW5zLXNlcmlmIj5EZWFyIGFsbCw8L2Rpdj4KICAgICAgICA8ZGl2IHN0eWxlPSJmb250LWZh
bWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPkkgbmVlZCB0byB1c2Ugb2Zvbm8gb24KICAgICAgICAg
IGEgVGVsaXQgbW9kdWxlIChVRTkxMCkuIEkgdHJpZWQgdG8gdXNlIGhlOTEwIHBsdWdpbiBhbmQK
ICAgICAgICAgIGF0bW9kZW0gZHJpdmVyIGFuZCBpdCBzZWVtcyB0byByZWNvZ25pemUgdGhlIG1v
ZGVtIGJ1dCwgc29tZQogICAgICAgICAgb2YgdGhlIGludGVyZmFjZXMgZG9lcyBub3Qgd29yayBh
bmQgSSBhbHNvIG5lZWQgc29tZSBtb3JlCiAgICAgICAgICBjb21tYW5kcyB0aGFuIHRoZSBvbmUg
ZXhwb3J0ZWQgYnkgYXRtb2RlbS48L2Rpdj4KICAgICAgICA8ZGl2IHN0eWxlPSJmb250LWZhbWls
eTp2ZXJkYW5hLHNhbnMtc2VyaWYiPlRoaXMgcmVxdWVzdCBpcyB0byBhc2sKICAgICAgICAgIHdo
YXQgc2hvdWxkIEkgZG8/IEkmIzM5O20gY3VycmVudGx5IHN0YXJ0aW5nIHRvIGRldmVsb3AgYSBu
ZXcKICAgICAgICAgIGRyaXZlciAodGVsaXRtb2RlbSkgd2l0aCB0aGUgaW50ZXJmYWNlcyBJIG5l
ZWQuPC9kaXY+CiAgICAgICAgPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNl
cmlmIj5JcyBteSBiZWhhdmlvciBjb3JyZWN0PzwvZGl2PgogICAgICA8L2Rpdj4KICAgIDwvYmxv
Y2txdW90ZT4KICAgIDxicj48L3NwYW4+CiAgICBTaW5jZSB0aGUgVUU5MTAgaXMgYSBtZW1iZXIg
b2YgdGhlIHhFOTEwIGZhbWlseSBhbmQgZXh0cmVtZWx5CiAgICBzaW1pbGFyIHRvIHRoZSBIRTkx
MCBpbiBmdW5jdGlvbmFsaXR5LCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gdHJ5IHRvCiAgICBleHRl
bmQgdGhlIGhlOTEwIGRyaXZlciB0byBoYW5kbGUgdGhpcyBkZXZpY2UuPGJyPgogICAgPGJyPgog
ICAgSWYgeW91IGNvdWxkIHByb3ZpZGUgYSBkZXNjcmlwdGlvbiBvZiB5b3VyIHByb2JsZW0gYW5k
IHJlcXVpcmVtZW50cywKICAgIHRoZW4gaXQgbWlnaHQgYmUgZWFzaWVyIHRvIGdpdmUgeW91IGd1
aWRhbmNlOjxicj4KICAgIDxicj4KICAgIGkpIHdoYXQgaW50ZXJmYWNlcyBkbyBub3Qgd29yaz88
YnI+CiAgICBpaSkgd2hhdCBjb21tYW5kcyBkbyB5b3UgcmVxdWlyZSB0aGF0IGFyZSBub3QgZXhw
b3J0ZWQ/PGJyPgogICAgPGJyPgogICAgVGhlIG1vcmUgaW5mbyB5b3UgY2FuIHByb3ZpZGUsIHRo
ZSBiZXR0ZXIuPHNwYW4+PGZvbnQgY29sb3I9IiM4ODg4ODgiPjxicj4KICAgIDxicj4KICAgIC9K
b25hczxicj4KICA8L2ZvbnQ+PC9zcGFuPjwvZGl2PgoKPGJyPl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+Cjxh
IGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9u
by5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFp
bG1hbi9saXN0aW5mby9vZm9ubzwvYT48YnI+Cjxicj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwv
ZGl2PjwvZGl2Pgo=

--===============7174929890613088394==--

