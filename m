Content-Type: multipart/mixed; boundary="===============2399676491298555982=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Re: How to test ofono for MediaTek Modem and Qualcomm Modem
Date: Wed, 12 Apr 2017 09:01:31 +0200
Message-ID: <CACM4vuC=t4WhdrGcY0_D6N7fk=i4-eP_iTHniPnd1UvBRRUSAw@mail.gmail.com>
In-Reply-To: <CAOLU1cTd4Mj=E0n4svet=HgyFV_MA7AjUzeRRoCCU2uHgeD2QA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2399676491298555982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 7:11 PM, Rohit Agrawal <agrawal.rohit1@gmail.com>
wrote:

> Hi Alfonso,
>
> Isn't the master branch at https://git.kernel.org/pub/
> scm/network/ofono/ofono.git/ supposed to support Android RILD based
> modems ? My understanding says even MediaTek modems should be covered und=
er
> this. The code at location https://github.com/rilmodem/ofono is based on
> ofono version 1.12 while the latest ofono code version is 1.19.
>

No, it is based on 1.17.


> I don't want to work on multiple versions of ofono. Could you elaborate on
> why such a difference ? Not sure what special support is present at locat=
ion
> https://github.com/rilmodem/ofono which is not present on master branch
> of ofono (Official). It would be great if you could put some light onto
> this.
>

As Denis said, RIL support in oFono upstream has been tested only for Intel
modems. There was a big refactoring when the RIL code was incorporated
upstream, and our branch has not been rebased yet. You can either use our
branch or try to take MTK parts to upstream. It would be some work, but
should not be that hard.


>
>
> -Rohit
>
> On Mon, Apr 10, 2017 at 3:27 PM, Alfonso Sanchez-Beato <
> alfonso.sanchez-beato(a)canonical.com> wrote:
>
>> Hi Rohit,
>>
>> On Fri, Apr 7, 2017 at 10:16 PM, Rohit Agrawal <agrawal.rohit1@gmail.c=
om>
>> wrote:
>>
>>> Hi Folks,
>>>
>>> I am new to ofono. Can you please list down the steps to test ofono on
>>> MediaTek and Qualcomm Modem.
>>> I have got MediaTek and Qualcomm boards with me. What are the necessary
>>> arrangements I need to do in order
>>> to test ofono on these boards. MediaTek board comes with vendor-ril.so
>>> and as per ofono documentation it talks to RILD
>>> over unix socket interface.  How exactly the flow happens. Can any one
>>> explain to me ?
>>>
>>
>> For RIL-based mediatek modems, I recommend you take a look at our ofono
>> branch:
>>
>> https://github.com/rilmodem/ofono
>>
>> There are two plugins you can try:
>>
>> https://github.com/rilmodem/ofono/blob/master/plugins/mtk.c
>> https://github.com/rilmodem/ofono/blob/master/plugins/mtk2.c
>>
>>
>>>
>>> How about Qualcomm modem ? Ofono talks through qmi, is this through
>>> qmi_wwan driver ? If yes so can someone
>>> please throw the light on the flow for Qualcomm modem too ?
>>>
>>> -Best Regards,
>>> Rohit Agrawal
>>>
>>
>> Br,
>> Alfonso
>>
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
>>
>>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>
>

--===============2399676491298555982==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIFR1ZSwgQXByIDExLCAyMDE3IGF0IDc6MTEgUE0sIFJvaGl0IEFn
cmF3YWwgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86YWdyYXdhbC5yb2hpdDFA
Z21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+YWdyYXdhbC5yb2hpdDFAZ21haWwuY29tPC9hPiZn
dDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxl
ZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2PjxkaXY+SGkgQWxmb25zbyw8YnI+PGJyPjwvZGl2
PklzbiYjMzk7dCB0aGUgbWFzdGVyIGJyYW5jaCBhdCA8YSBocmVmPSJodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbmV0d29yay9vZm9uby9vZm9uby5naXQvIiB0YXJnZXQ9Il9ibGFuayI+
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvPHdicj5zY20vbmV0d29yay9vZm9uby9vZm9uby5n
aXQvPC9hPiBzdXBwb3NlZCB0byBzdXBwb3J0IEFuZHJvaWQgUklMRCBiYXNlZCBtb2RlbXMgPyBN
eSB1bmRlcnN0YW5kaW5nIHNheXMgZXZlbiBNZWRpYVRlayBtb2RlbXMgc2hvdWxkIGJlIGNvdmVy
ZWQgdW5kZXIgdGhpcy4gVGhlIGNvZGUgYXQgbG9jYXRpb24gPGEgaHJlZj0iaHR0cHM6Ly9naXRo
dWIuY29tL3JpbG1vZGVtL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29t
L3JpbG1vZGVtL29mPHdicj5vbm88L2E+IGlzIGJhc2VkIG9uIG9mb25vIHZlcnNpb24gMS4xMiB3
aGlsZSB0aGUgbGF0ZXN0IG9mb25vIGNvZGUgdmVyc2lvbiBpcyAxLjE5LjwvZGl2PjwvZGl2Pjwv
YmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pk5vLCBpdCBpcyBiYXNlZCBvbiAxLjE3Ljwv
ZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2PkkgZG9uJiMzOTt0IHdhbnQgdG8gd29yayBvbiBtdWx0
aXBsZSB2ZXJzaW9ucyBvZiBvZm9uby4gQ291bGQgeW91IGVsYWJvcmF0ZSBvbiB3aHkgc3VjaCBh
IGRpZmZlcmVuY2UgPyBOb3Qgc3VyZSB3aGF0IHNwZWNpYWwgc3VwcG9ydCBpcyBwcmVzZW50IGF0
IGxvY2F0aW9uPGJyPjxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9yaWxtb2RlbS9vZm9ubyIg
dGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2l0aHViLmNvbS9yaWxtb2RlbS9vZjx3YnI+b25vPC9h
PiB3aGljaCBpcyBub3QgcHJlc2VudCBvbiBtYXN0ZXIgYnJhbmNoIG9mIG9mb25vIChPZmZpY2lh
bCkuIEl0IHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBjb3VsZCBwdXQgc29tZSBsaWdodCBvbnRvIHRo
aXMuPC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+QXMgRGVuaXMg
c2FpZCwgUklMIHN1cHBvcnQgaW4gb0Zvbm8gdXBzdHJlYW0gaGFzIGJlZW4gdGVzdGVkIG9ubHkg
Zm9yIEludGVsIG1vZGVtcy4gVGhlcmUgd2FzIGEgYmlnIHJlZmFjdG9yaW5nIHdoZW4gdGhlIFJJ
TCBjb2RlIHdhcyBpbmNvcnBvcmF0ZWQgdXBzdHJlYW0sIGFuZCBvdXIgYnJhbmNoIGhhcyBub3Qg
YmVlbiByZWJhc2VkIHlldC4gWW91IGNhbiBlaXRoZXIgdXNlIG91ciBicmFuY2ggb3IgdHJ5IHRv
IHRha2UgTVRLIHBhcnRzIHRvIHVwc3RyZWFtLiBJdCB3b3VsZCBiZSBzb21lIHdvcmssIGJ1dCBz
aG91bGQgbm90IGJlIHRoYXQgaGFyZC48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj48c3BhbiBj
bGFzcz0iSE9FblpiIj48Zm9udCBjb2xvcj0iIzg4ODg4OCI+PGJyPjxicj48L2ZvbnQ+PC9zcGFu
PjwvZGl2PjxzcGFuIGNsYXNzPSJIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij4tUm9oaXQ8
YnI+PC9mb250Pjwvc3Bhbj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2PjxkaXYgY2xhc3M9Img1Ij5PbiBNb24sIEFwciAxMCwg
MjAxNyBhdCAzOjI3IFBNLCBBbGZvbnNvIFNhbmNoZXotQmVhdG8gPHNwYW4gZGlyPSJsdHIiPiZs
dDs8YSBocmVmPSJtYWlsdG86YWxmb25zby5zYW5jaGV6LWJlYXRvQGNhbm9uaWNhbC5jb20iIHRh
cmdldD0iX2JsYW5rIj5hbGZvbnNvLnNhbmNoZXotYmVhdG9APHdicj5jYW5vbmljYWwuY29tPC9h
PiZndDs8L3NwYW4+IHdyb3RlOjxicj48L2Rpdj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBz
b2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2PjxkaXYgY2xhc3M9Img1Ij48ZGl2IGRpcj0ibHRy
Ij5IaSBSb2hpdCw8YnI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PHNwYW4+T24gRnJpLCBBcHIgNywgMjAxNyBhdCAxMDoxNiBQTSwgUm9oaXQg
QWdyYXdhbCA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzphZ3Jhd2FsLnJvaGl0
MUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5hZ3Jhd2FsLnJvaGl0MUBnbWFpbC5jb208L2E+
Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIw
NCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2PjxkaXY+PGRp
dj48ZGl2PjxkaXY+SGkgRm9sa3MsPGJyPjxicj48L2Rpdj5JIGFtIG5ldyB0byBvZm9uby4gQ2Fu
IHlvdSBwbGVhc2UgbGlzdCBkb3duIHRoZSBzdGVwcyB0byB0ZXN0IG9mb25vIG9uIE1lZGlhVGVr
IGFuZCBRdWFsY29tbSBNb2RlbS48YnI+PC9kaXY+SSBoYXZlIGdvdCBNZWRpYVRlayBhbmQgUXVh
bGNvbW0gYm9hcmRzIHdpdGggbWUuIFdoYXQgYXJlIHRoZSBuZWNlc3NhcnkgYXJyYW5nZW1lbnRz
IEkgbmVlZCB0byBkbyBpbiBvcmRlcjxicj48L2Rpdj50byB0ZXN0IG9mb25vIG9uIHRoZXNlIGJv
YXJkcy4gTWVkaWFUZWsgYm9hcmQgY29tZXMgd2l0aCB2ZW5kb3ItcmlsLnNvIGFuZCBhcyBwZXIg
b2Zvbm8gZG9jdW1lbnRhdGlvbiBpdCB0YWxrcyB0byBSSUxEPGJyPjwvZGl2Pm92ZXIgdW5peCBz
b2NrZXQgaW50ZXJmYWNlLsKgIEhvdyBleGFjdGx5IHRoZSBmbG93IGhhcHBlbnMuIENhbiBhbnkg
b25lIGV4cGxhaW4gdG8gbWUgPzxicj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+
PC9kaXY+PC9zcGFuPjxkaXY+Rm9yIFJJTC1iYXNlZCBtZWRpYXRlayBtb2RlbXMsIEkgcmVjb21t
ZW5kIHlvdSB0YWtlIGEgbG9vayBhdCBvdXIgb2Zvbm8gYnJhbmNoOjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+PGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL3JpbG1vZGVtL29mb25vIiB0YXJn
ZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL3JpbG1vZGVtL29mPHdicj5vbm88L2E+PGJy
PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhlcmUgYXJlIHR3byBwbHVnaW5zIHlvdSBjYW4g
dHJ5OjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29t
L3JpbG1vZGVtL29mb25vL2Jsb2IvbWFzdGVyL3BsdWdpbnMvbXRrLmMiIHRhcmdldD0iX2JsYW5r
Ij5odHRwczovL2dpdGh1Yi5jb20vcmlsbW9kZW0vb2Y8d2JyPm9uby9ibG9iL21hc3Rlci9wbHVn
aW5zL210ay5jPC9hPjxicj48L2Rpdj48ZGl2PjxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9y
aWxtb2RlbS9vZm9uby9ibG9iL21hc3Rlci9wbHVnaW5zL210azIuYyIgdGFyZ2V0PSJfYmxhbmsi
Pmh0dHBzOi8vZ2l0aHViLmNvbS9yaWxtb2RlbS9vZjx3YnI+b25vL2Jsb2IvbWFzdGVyL3BsdWdp
bnMvbXRrMi5jPC9hPjxicj48L2Rpdj48c3Bhbj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1s
ZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGly
PSJsdHIiPjxkaXY+PGJyPjwvZGl2PjxkaXY+SG93IGFib3V0IFF1YWxjb21tIG1vZGVtID8gT2Zv
bm8gdGFsa3MgdGhyb3VnaCBxbWksIGlzIHRoaXMgdGhyb3VnaCBxbWlfd3dhbiBkcml2ZXIgPyBJ
ZiB5ZXMgc28gY2FuIHNvbWVvbmUgPGJyPjwvZGl2PjxkaXY+cGxlYXNlIHRocm93IHRoZSBsaWdo
dCBvbiB0aGUgZmxvdyBmb3IgUXVhbGNvbW0gbW9kZW0gdG9vID88YnI+PGJyPjwvZGl2PjxkaXY+
LUJlc3QgUmVnYXJkcyw8YnI+PC9kaXY+PGRpdj5Sb2hpdCBBZ3Jhd2FsPGJyPjwvZGl2PjwvZGl2
Pgo8L2Jsb2NrcXVvdGU+PC9zcGFuPjwvZGl2Pjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9l
eHRyYSI+QnIsPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPkFsZm9uc288L2Rpdj48L2Rp
dj4KPGJyPjwvZGl2PjwvZGl2PjxzcGFuIGNsYXNzPSIiPl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXzx3YnI+X19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxicj4K
PGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9m
b25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4v
bGlzdGluZm8vb2Zvbm8iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8v
bGlzdHMub2Zvbm8ub3JnL21haWxtYTx3YnI+bi9saXN0aW5mby9vZm9ubzwvYT48YnI+Cjxicj48
L3NwYW4+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4KPGJyPl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXzx3YnI+X19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlz
dDxicj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9h
Pjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9v
Zm9ubyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy5vZm9u
by5vcmcvPHdicj5tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPGJyPjwvYmxvY2txdW90
ZT48L2Rpdj48YnI+PC9kaXY+PC9kaXY+Cg==

--===============2399676491298555982==--

