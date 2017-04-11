Content-Type: multipart/mixed; boundary="===============7650042509599704733=="
MIME-Version: 1.0
From: Rohit Agrawal <agrawal.rohit1@gmail.com>
Subject: Re: How to test ofono for MediaTek Modem and Qualcomm Modem
Date: Tue, 11 Apr 2017 22:41:53 +0530
Message-ID: <CAOLU1cTd4Mj=E0n4svet=HgyFV_MA7AjUzeRRoCCU2uHgeD2QA@mail.gmail.com>
In-Reply-To: <CACM4vuA-Zb9ph-20wQVKCvuc63FGdkHvtbXh0inGTmu0LhHZaA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7650042509599704733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

Isn't the master branch at
https://git.kernel.org/pub/scm/network/ofono/ofono.git/ supposed to support
Android RILD based modems ? My understanding says even MediaTek modems
should be covered under this. The code at location
https://github.com/rilmodem/ofono is based on ofono version 1.12 while the
latest ofono code version is 1.19. I don't want to work on multiple
versions of ofono. Could you elaborate on why such a difference ? Not sure
what special support is present at location
https://github.com/rilmodem/ofono which is not present on master branch of
ofono (Official). It would be great if you could put some light onto this.

-Rohit

On Mon, Apr 10, 2017 at 3:27 PM, Alfonso Sanchez-Beato <
alfonso.sanchez-beato@canonical.com> wrote:

> Hi Rohit,
>
> On Fri, Apr 7, 2017 at 10:16 PM, Rohit Agrawal <agrawal.rohit1@gmail.co=
m>
> wrote:
>
>> Hi Folks,
>>
>> I am new to ofono. Can you please list down the steps to test ofono on
>> MediaTek and Qualcomm Modem.
>> I have got MediaTek and Qualcomm boards with me. What are the necessary
>> arrangements I need to do in order
>> to test ofono on these boards. MediaTek board comes with vendor-ril.so
>> and as per ofono documentation it talks to RILD
>> over unix socket interface.  How exactly the flow happens. Can any one
>> explain to me ?
>>
>
> For RIL-based mediatek modems, I recommend you take a look at our ofono
> branch:
>
> https://github.com/rilmodem/ofono
>
> There are two plugins you can try:
>
> https://github.com/rilmodem/ofono/blob/master/plugins/mtk.c
> https://github.com/rilmodem/ofono/blob/master/plugins/mtk2.c
>
>
>>
>> How about Qualcomm modem ? Ofono talks through qmi, is this through
>> qmi_wwan driver ? If yes so can someone
>> please throw the light on the flow for Qualcomm modem too ?
>>
>> -Best Regards,
>> Rohit Agrawal
>>
>
> Br,
> Alfonso
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>
>

--===============7650042509599704733==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkhpIEFsZm9uc28sPGJyPjxicj48L2Rpdj5Jc24mIzM5
O3QgdGhlIG1hc3RlciBicmFuY2ggYXQgPGEgaHJlZj0iaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL25ldHdvcmsvb2Zvbm8vb2Zvbm8uZ2l0LyI+aHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL25ldHdvcmsvb2Zvbm8vb2Zvbm8uZ2l0LzwvYT4gc3VwcG9zZWQgdG8gc3VwcG9ydCBB
bmRyb2lkIFJJTEQgYmFzZWQgbW9kZW1zID8gTXkgdW5kZXJzdGFuZGluZyBzYXlzIGV2ZW4gTWVk
aWFUZWsgbW9kZW1zIHNob3VsZCBiZSBjb3ZlcmVkIHVuZGVyIHRoaXMuIFRoZSBjb2RlIGF0IGxv
Y2F0aW9uIDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9yaWxtb2RlbS9vZm9ubyIgdGFyZ2V0
PSJfYmxhbmsiPmh0dHBzOi8vZ2l0aHViLmNvbS9yaWxtb2RlbS88d2JyPm9mb25vPC9hPiBpcyBi
YXNlZCBvbiBvZm9ubyB2ZXJzaW9uIDEuMTIgd2hpbGUgdGhlIGxhdGVzdCBvZm9ubyBjb2RlIHZl
cnNpb24gaXMgMS4xOS4gSSBkb24mIzM5O3Qgd2FudCB0byB3b3JrIG9uIG11bHRpcGxlIHZlcnNp
b25zIG9mIG9mb25vLiBDb3VsZCB5b3UgZWxhYm9yYXRlIG9uIHdoeSBzdWNoIGEgZGlmZmVyZW5j
ZSA/IE5vdCBzdXJlIHdoYXQgc3BlY2lhbCBzdXBwb3J0IGlzIHByZXNlbnQgYXQgbG9jYXRpb248
YnI+PGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL3JpbG1vZGVtL29mb25vIiB0YXJnZXQ9Il9i
bGFuayI+aHR0cHM6Ly9naXRodWIuY29tL3JpbG1vZGVtLzx3YnI+b2Zvbm88L2E+IHdoaWNoIGlz
IG5vdCBwcmVzZW50IG9uIG1hc3RlciBicmFuY2ggb2Ygb2Zvbm8gKE9mZmljaWFsKS4gSXQgd291
bGQgYmUgZ3JlYXQgaWYgeW91IGNvdWxkIHB1dCBzb21lIGxpZ2h0IG9udG8gdGhpcy48YnI+PGJy
PjwvZGl2Pi1Sb2hpdDxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBNb24sIEFwciAxMCwgMjAxNyBhdCAzOjI3IFBNLCBBbGZv
bnNvIFNhbmNoZXotQmVhdG8gPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86YWxm
b25zby5zYW5jaGV6LWJlYXRvQGNhbm9uaWNhbC5jb20iIHRhcmdldD0iX2JsYW5rIj5hbGZvbnNv
LnNhbmNoZXotYmVhdG9AY2Fub25pY2FsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+
SGkgUm9oaXQsPGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0iZ21h
aWxfcXVvdGUiPjxzcGFuIGNsYXNzPSIiPk9uIEZyaSwgQXByIDcsIDIwMTcgYXQgMTA6MTYgUE0s
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
aXY+PGJyPjwvZGl2Pjwvc3Bhbj48ZGl2PkZvciBSSUwtYmFzZWQgbWVkaWF0ZWsgbW9kZW1zLCBJ
IHJlY29tbWVuZCB5b3UgdGFrZSBhIGxvb2sgYXQgb3VyIG9mb25vIGJyYW5jaDo8L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PjxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9yaWxtb2RlbS9vZm9u
byIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2l0aHViLmNvbS9yaWxtb2RlbS88d2JyPm9mb25v
PC9hPjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZXJlIGFyZSB0d28gcGx1Z2lucyB5
b3UgY2FuIHRyeTo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxhIGhyZWY9Imh0dHBzOi8vZ2l0
aHViLmNvbS9yaWxtb2RlbS9vZm9uby9ibG9iL21hc3Rlci9wbHVnaW5zL210ay5jIiB0YXJnZXQ9
Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL3JpbG1vZGVtLzx3YnI+b2Zvbm8vYmxvYi9tYXN0
ZXIvcGx1Z2lucy9tdGsuPHdicj5jPC9hPjxicj48L2Rpdj48ZGl2PjxhIGhyZWY9Imh0dHBzOi8v
Z2l0aHViLmNvbS9yaWxtb2RlbS9vZm9uby9ibG9iL21hc3Rlci9wbHVnaW5zL210azIuYyIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2l0aHViLmNvbS9yaWxtb2RlbS88d2JyPm9mb25vL2Jsb2Iv
bWFzdGVyL3BsdWdpbnMvPHdicj5tdGsyLmM8L2E+PGJyPjwvZGl2PjxzcGFuIGNsYXNzPSIiPjxk
aXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7
cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj48YnI+PC9kaXY+PGRpdj5Ib3cg
YWJvdXQgUXVhbGNvbW0gbW9kZW0gPyBPZm9ubyB0YWxrcyB0aHJvdWdoIHFtaSwgaXMgdGhpcyB0
aHJvdWdoIHFtaV93d2FuIGRyaXZlciA/IElmIHllcyBzbyBjYW4gc29tZW9uZSA8YnI+PC9kaXY+
PGRpdj5wbGVhc2UgdGhyb3cgdGhlIGxpZ2h0IG9uIHRoZSBmbG93IGZvciBRdWFsY29tbSBtb2Rl
bSB0b28gPzxicj48YnI+PC9kaXY+PGRpdj4tQmVzdCBSZWdhcmRzLDxicj48L2Rpdj48ZGl2PlJv
aGl0IEFncmF3YWw8YnI+PC9kaXY+PC9kaXY+CjwvYmxvY2txdW90ZT48L3NwYW4+PC9kaXY+PGJy
PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj5Cciw8L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9leHRyYSI+QWxmb25zbzwvZGl2PjwvZGl2Pgo8YnI+X19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fPHdicj5fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8
YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8
YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiBy
ZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy88
d2JyPm1haWxtYW4vbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8YnI+PC9ibG9ja3F1b3RlPjwvZGl2
Pjxicj48L2Rpdj4K

--===============7650042509599704733==--

