Content-Type: multipart/mixed; boundary="===============1108787232292224543=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Tue, 12 Jan 2016 12:04:36 +0200
Message-ID: <CADnUhn2aWyjRZ_A_XpuW96JfK4cZa71o+MEvkA1=X7znrzMYyQ@mail.gmail.com>
In-Reply-To: <CADnUhn0-4OM6PFyxPMBLxSpsVbq+gbBDJr=qYsV4MHyJfc58qQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1108787232292224543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In fact it seems that no ofonod is needed to get old Huawei 3131 up and
running. Connman just notices it as wired service after plugging in.

-Matti

2016-01-12 11:40 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:

> I tried without option drivers. Ofono logs looked very similar to those of
> the old Huawei 3131. Main exception was that old uses interface eth1 and
> new wwan0. The main difference, however,  is that there is no traffic with
> the new modem.
>
> Modem management commands do not work if option driver is not loaded (for
> example online-modem). On the other hand this seems the case with the old
> modem, too. Connmanctl services command lists old modem as Wired service
> and new is not listed at all if these option drivers are not present.
>
> -Matti
>
> 2016-01-12 10:47 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:
>
>>
>> 2016-01-12 10:38 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:
>>
>>> Note that driver listed is not kernel drive, like with new 3131 but most
>>> likely ofono driver - at least it is not listed with lsmod.
>>
>>
>>
>> Now I was not careful enough. Modem was created exactly as before -
>> check_usb_device() reported kernel module and create_modem() reported
>> huawei.
>>
>
>

--===============1108787232292224543==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5JbiBmYWN0IGl0IHNlZW1zIHRoYXQgbm8gb2Zvbm9kIGlzIG5l
ZWRlZCB0byBnZXQgb2xkIEh1YXdlaSAzMTMxIHVwIGFuZCBydW5uaW5nLiBDb25ubWFuIGp1c3Qg
bm90aWNlcyBpdCBhcyB3aXJlZCBzZXJ2aWNlIGFmdGVyIHBsdWdnaW5nIGluLiA8YnI+PGJyPjwv
ZGl2Pi1NYXR0aTxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj4yMDE2LTAxLTEyIDExOjQwIEdNVCswMjowMCBtYXR0aSBrYWFzaW5l
biA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzptYXR0aS5rYWFzaW5lbkBnbWFp
bC5jb20iIHRhcmdldD0iX2JsYW5rIj5tYXR0aS5rYWFzaW5lbkBnbWFpbC5jb208L2E+Jmd0Ozwv
c3Bhbj46PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
IDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxk
aXYgZGlyPSJsdHIiPjxkaXY+PGRpdj5JIHRyaWVkIHdpdGhvdXQgb3B0aW9uIGRyaXZlcnMuIE9m
b25vIGxvZ3MgbG9va2VkIHZlcnkgc2ltaWxhciB0byB0aG9zZSBvZiB0aGUgb2xkIEh1YXdlaSAz
MTMxLiBNYWluIGV4Y2VwdGlvbiB3YXMgdGhhdCBvbGQgdXNlcyBpbnRlcmZhY2UgZXRoMSBhbmQg
bmV3IHd3YW4wLiBUaGUgbWFpbiBkaWZmZXJlbmNlLCBob3dldmVyLMKgIGlzIHRoYXQgdGhlcmUg
aXMgbm8gdHJhZmZpYyB3aXRoIHRoZSBuZXcgbW9kZW0uIDxicj48YnI+PC9kaXY+TW9kZW0gbWFu
YWdlbWVudCBjb21tYW5kcyBkbyBub3Qgd29yayBpZiBvcHRpb24gZHJpdmVyIGlzIG5vdCBsb2Fk
ZWQgKGZvciBleGFtcGxlIG9ubGluZS1tb2RlbSkuIE9uIHRoZSBvdGhlciBoYW5kIHRoaXMgc2Vl
bXMgdGhlIGNhc2Ugd2l0aCB0aGUgb2xkIG1vZGVtLCB0b28uIENvbm5tYW5jdGwgc2VydmljZXMg
Y29tbWFuZCBsaXN0cyBvbGQgbW9kZW0gYXMgV2lyZWQgc2VydmljZSBhbmQgbmV3IGlzIG5vdCBs
aXN0ZWQgYXQgYWxsIGlmIHRoZXNlIG9wdGlvbiBkcml2ZXJzIGFyZSBub3QgcHJlc2VudC48c3Bh
biBjbGFzcz0iSE9FblpiIj48Zm9udCBjb2xvcj0iIzg4ODg4OCI+PGJyPjxicj48L2ZvbnQ+PC9z
cGFuPjwvZGl2PjxzcGFuIGNsYXNzPSJIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij4tTWF0
dGk8YnI+PC9mb250Pjwvc3Bhbj48L2Rpdj48ZGl2IGNsYXNzPSJIT0VuWmIiPjxkaXYgY2xhc3M9
Img1Ij48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3Rl
Ij4yMDE2LTAxLTEyIDEwOjQ3IEdNVCswMjowMCBtYXR0aSBrYWFzaW5lbiA8c3BhbiBkaXI9Imx0
ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzptYXR0aS5rYWFzaW5lbkBnbWFpbC5jb20iIHRhcmdldD0i
X2JsYW5rIj5tYXR0aS5rYWFzaW5lbkBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj46PGJyPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxz
cGFuPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUi
PjIwMTYtMDEtMTIgMTA6MzggR01UKzAyOjAwIG1hdHRpIGthYXNpbmVuIDxzcGFuIGRpcj0ibHRy
Ij4mbHQ7PGEgaHJlZj0ibWFpbHRvOm1hdHRpLmthYXNpbmVuQGdtYWlsLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPm1hdHRpLmthYXNpbmVuQGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjo8YnI+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+Tm90ZSB0aGF0IGRyaXZlciBs
aXN0ZWQgaXMgbm90IGtlcm5lbCBkcml2ZSwgbGlrZSB3aXRoIG5ldyAzMTMxIGJ1dCBtb3N0IGxp
a2VseSBvZm9ubyBkcml2ZXIgLSBhdCBsZWFzdCBpdCBpcyBub3QgbGlzdGVkIHdpdGggbHNtb2Qu
IDwvYmxvY2txdW90ZT48L2Rpdj48YnI+PGJyPjwvZGl2Pjwvc3Bhbj48ZGl2IGNsYXNzPSJnbWFp
bF9leHRyYSI+Tm93IEkgd2FzIG5vdCBjYXJlZnVsIGVub3VnaC4gTW9kZW0gd2FzIGNyZWF0ZWQg
ZXhhY3RseSBhcyBiZWZvcmUgLSBjaGVja191c2JfZGV2aWNlKCkgcmVwb3J0ZWQga2VybmVsIG1v
ZHVsZSBhbmQgY3JlYXRlX21vZGVtKCkgcmVwb3J0ZWQgaHVhd2VpLjxicj48L2Rpdj48L2Rpdj4K
PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4KPC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwv
ZGl2Pjxicj48L2Rpdj4K

--===============1108787232292224543==--

