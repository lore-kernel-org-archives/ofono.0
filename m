Content-Type: multipart/mixed; boundary="===============6654248518044330822=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Re: How to test ofono for MediaTek Modem and Qualcomm Modem
Date: Mon, 10 Apr 2017 11:57:00 +0200
Message-ID: <CACM4vuA-Zb9ph-20wQVKCvuc63FGdkHvtbXh0inGTmu0LhHZaA@mail.gmail.com>
In-Reply-To: <CAOLU1cRL7pYDMbi-QOFM4D3_Lw-SV8Z75uYR2jgfBc7vEYPy1g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6654248518044330822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rohit,

On Fri, Apr 7, 2017 at 10:16 PM, Rohit Agrawal <agrawal.rohit1@gmail.com>
wrote:

> Hi Folks,
>
> I am new to ofono. Can you please list down the steps to test ofono on
> MediaTek and Qualcomm Modem.
> I have got MediaTek and Qualcomm boards with me. What are the necessary
> arrangements I need to do in order
> to test ofono on these boards. MediaTek board comes with vendor-ril.so and
> as per ofono documentation it talks to RILD
> over unix socket interface.  How exactly the flow happens. Can any one
> explain to me ?
>

For RIL-based mediatek modems, I recommend you take a look at our ofono
branch:

https://github.com/rilmodem/ofono

There are two plugins you can try:

https://github.com/rilmodem/ofono/blob/master/plugins/mtk.c
https://github.com/rilmodem/ofono/blob/master/plugins/mtk2.c


>
> How about Qualcomm modem ? Ofono talks through qmi, is this through
> qmi_wwan driver ? If yes so can someone
> please throw the light on the flow for Qualcomm modem too ?
>
> -Best Regards,
> Rohit Agrawal
>

Br,
Alfonso

--===============6654248518044330822==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgUm9oaXQsPGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+
PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIEZyaSwgQXByIDcsIDIwMTcgYXQgMTA6MTYgUE0s
IFJvaGl0IEFncmF3YWwgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86YWdyYXdh
bC5yb2hpdDFAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+YWdyYXdhbC5yb2hpdDFAZ21haWwu
Y29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj48
ZGl2PjxkaXY+PGRpdj48ZGl2PkhpIEZvbGtzLDxicj48YnI+PC9kaXY+SSBhbSBuZXcgdG8gb2Zv
bm8uIENhbiB5b3UgcGxlYXNlIGxpc3QgZG93biB0aGUgc3RlcHMgdG8gdGVzdCBvZm9ubyBvbiBN
ZWRpYVRlayBhbmQgUXVhbGNvbW0gTW9kZW0uPGJyPjwvZGl2PkkgaGF2ZSBnb3QgTWVkaWFUZWsg
YW5kIFF1YWxjb21tIGJvYXJkcyB3aXRoIG1lLiBXaGF0IGFyZSB0aGUgbmVjZXNzYXJ5IGFycmFu
Z2VtZW50cyBJIG5lZWQgdG8gZG8gaW4gb3JkZXI8YnI+PC9kaXY+dG8gdGVzdCBvZm9ubyBvbiB0
aGVzZSBib2FyZHMuIE1lZGlhVGVrIGJvYXJkIGNvbWVzIHdpdGggdmVuZG9yLXJpbC5zbyBhbmQg
YXMgcGVyIG9mb25vIGRvY3VtZW50YXRpb24gaXQgdGFsa3MgdG8gUklMRDxicj48L2Rpdj5vdmVy
IHVuaXggc29ja2V0IGludGVyZmFjZS7CoCBIb3cgZXhhY3RseSB0aGUgZmxvdyBoYXBwZW5zLiBD
YW4gYW55IG9uZSBleHBsYWluIHRvIG1lID88YnI+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxk
aXY+PGJyPjwvZGl2PjxkaXY+Rm9yIFJJTC1iYXNlZCBtZWRpYXRlayBtb2RlbXMsIEkgcmVjb21t
ZW5kIHlvdSB0YWtlIGEgbG9vayBhdCBvdXIgb2Zvbm8gYnJhbmNoOjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+PGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL3JpbG1vZGVtL29mb25vIj5odHRw
czovL2dpdGh1Yi5jb20vcmlsbW9kZW0vb2Zvbm88L2E+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+VGhlcmUgYXJlIHR3byBwbHVnaW5zIHlvdSBjYW4gdHJ5OjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+PGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL3JpbG1vZGVtL29mb25vL2Jsb2Iv
bWFzdGVyL3BsdWdpbnMvbXRrLmMiPmh0dHBzOi8vZ2l0aHViLmNvbS9yaWxtb2RlbS9vZm9uby9i
bG9iL21hc3Rlci9wbHVnaW5zL210ay5jPC9hPjxicj48L2Rpdj48ZGl2PjxhIGhyZWY9Imh0dHBz
Oi8vZ2l0aHViLmNvbS9yaWxtb2RlbS9vZm9uby9ibG9iL21hc3Rlci9wbHVnaW5zL210azIuYyI+
aHR0cHM6Ly9naXRodWIuY29tL3JpbG1vZGVtL29mb25vL2Jsb2IvbWFzdGVyL3BsdWdpbnMvbXRr
Mi5jPC9hPjxicj48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xp
ZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXY+
PGJyPjwvZGl2PjxkaXY+SG93IGFib3V0IFF1YWxjb21tIG1vZGVtID8gT2Zvbm8gdGFsa3MgdGhy
b3VnaCBxbWksIGlzIHRoaXMgdGhyb3VnaCBxbWlfd3dhbiBkcml2ZXIgPyBJZiB5ZXMgc28gY2Fu
IHNvbWVvbmUgPGJyPjwvZGl2PjxkaXY+cGxlYXNlIHRocm93IHRoZSBsaWdodCBvbiB0aGUgZmxv
dyBmb3IgUXVhbGNvbW0gbW9kZW0gdG9vID88YnI+PGJyPjwvZGl2PjxkaXY+LUJlc3QgUmVnYXJk
cyw8YnI+PC9kaXY+PGRpdj5Sb2hpdCBBZ3Jhd2FsPGJyPjwvZGl2PjwvZGl2Pgo8L2Jsb2NrcXVv
dGU+PC9kaXY+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj5Cciw8L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9leHRyYSI+QWxmb25zbzwvZGl2PjwvZGl2Pgo=

--===============6654248518044330822==--

