Content-Type: multipart/mixed; boundary="===============8671813609712444665=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: Re: PDP Context Activation
Date: Mon, 27 Jun 2011 16:46:30 +0530
Message-ID: <BANLkTikW3ior-TXzXAdrnOJf67DXoh2QxA@mail.gmail.com>
In-Reply-To: <BANLkTimnhp+VWdf+UfakX+yVosbUkh2Udw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8671813609712444665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

My APN details are:

$ ./list-contexts
[ /ste0 ]
    [ /ste0/context3 ]
        Username =3D
        Protocol =3D ip
        Name =3D internet
        Settings =3D { }
        Active =3D 0
        AccessPointName =3D TATA.DOCOMO.INTERNET
        Password =3D
        Type =3D internet

$ ./activate-context
Error activating /ste0/context3: org.ofono.Error.Failed: Operation failed

This is happening with st board on Ubuntu


Any updates on this issue?

Thanks

Yuvaraj R

On Tue, Jun 21, 2011 at 5:03 PM, Yuvaraj Ragupathi
<yuvaraj.addu@gmail.com>wrote:

> HI,
>
> Even i tried with proper APN. Still i am facing same issue. I am testing =
on
> my host.
> #../list-contexts
>
> [ /ste0 ]
>     [ /ste0/context8 ]
>
>         Username =3D
>         Protocol =3D ip
>         Name =3D Internet
>         Settings =3D { }
>         Active =3D 0
>         AccessPointName =3D xx.yy.INTERNET
>         Password =3D
>         Type =3D internet
>
>
>  #./activate-context
> Error activating /ste0/context8: org.ofono.Error.Failed: Operation failed
>
> Thanks
>
> Yuvaraj R
>
>
> On Thu, Jun 16, 2011 at 10:29 AM, Yuvaraj Ragupathi <
> yuvaraj.addu(a)gmail.com> wrote:
>
>> Hi
>>
>> Sorry , I am trying with invalid APN
>>
>> Thanks
>>
>> Yuvaraj R
>>
>>
>> On Thu, Jun 16, 2011 at 9:57 AM, Yuvaraj Ragupathi <
>> yuvaraj.addu(a)gmail.com> wrote:
>>
>>> Hi,
>>>
>>> I set access point name and tried. Same result.
>>>
>>> Here i am providing more info about this issue
>>>
>>> Ofono logs at http://pastebin.com/xFrEjRYA
>>>
>>> *# list of contexts*
>>>
>>> ~/Downloads/ofono-0.40/test$ ./list-contexts
>>> [ /ste0 ]
>>>     [ /ste0/context6 ]
>>>         Username =3D
>>>         Protocol =3D ip
>>>         Name =3D Internet
>>>         Settings =3D { }
>>>         Active =3D 0
>>>         AccessPointName =3D Testing
>>>         Password =3D
>>>         Type =3D internet
>>>
>>> ~/Downloads/ofono-0.40/test$ ./activate-context
>>> Error activating /ste0/context6: org.ofono.Error.Failed: Operation fail=
ed
>>>
>>>
>>> Thanks
>>>
>>> Yuvaraj R
>>>
>>>
>>>
>>>
>>> On Tue, Jun 14, 2011 at 3:05 PM, Denis Kenzior <denkenz@gmail.com>wro=
te:
>>>
>>>> Hi Yuvaraj,
>>>>
>>>> > Control @ ste_gprs_activate_primary
>>>> >  Command is AT+CGDCONT=3D1,"IP",""
>>>> > Control @ ste_cgdcont_cb
>>>> > Control 1 @ ste_cgdcont_cb
>>>> > ofonod[8803]: src/gprs.c:pri_activate_callback() 0xa02f868 (null)
>>>> > ofonod[8803]: src/gprs.c:pri_activate_callback() Activating context
>>>> > failed with error: Unknown error type
>>>>
>>>> You might try provisioning the context first since you're trying to
>>>> activate an empty APN.
>>>>
>>>> See doc/connman-api.txt for more details.
>>>>
>>>> Regards,
>>>> -Denis
>>>>
>>>
>>>
>>
>

--===============8671813609712444665==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

TXkgQVBOIGRldGFpbHMgYXJlOjxicj48YnI+JCAuL2xpc3QtY29udGV4dHMgPGJyPlsgL3N0ZTAg
XTxicj6goKAgWyAvc3RlMC9jb250ZXh0MyBdPGJyPqCgoKCgoKAgVXNlcm5hbWUgPSA8YnI+oKCg
oKCgoCBQcm90b2NvbCA9IGlwPGJyPqCgoKCgoKAgTmFtZSA9IGludGVybmV0PGJyPqCgoKCgoKAg
U2V0dGluZ3MgPSB7IH08YnI+oKCgoKCgoCBBY3RpdmUgPSAwPGJyPqCgoKCgoKAgQWNjZXNzUG9p
bnROYW1lID0gVEFUQS5ET0NPTU8uSU5URVJORVQ8YnI+CqCgoKCgoKAgUGFzc3dvcmQgPSA8YnI+
oKCgoKCgoCBUeXBlID0gaW50ZXJuZXQ8YnI+PGJyPiQgLi9hY3RpdmF0ZS1jb250ZXh0IDxicj5F
cnJvciBhY3RpdmF0aW5nIC9zdGUwL2NvbnRleHQzOiBvcmcub2Zvbm8uRXJyb3IuRmFpbGVkOiBP
cGVyYXRpb24gZmFpbGVkPGJyPjxicj5UaGlzIGlzIGhhcHBlbmluZyB3aXRoIHN0IGJvYXJkIG9u
IFVidW50dTxicj48YnI+PGJyPkFueSB1cGRhdGVzIG9uIHRoaXMgaXNzdWU/PGJyPgo8YnI+VGhh
bmtzPGJyPjxicj5ZdXZhcmFqIFI8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBU
dWUsIEp1biAyMSwgMjAxMSBhdCA1OjAzIFBNLCBZdXZhcmFqIFJhZ3VwYXRoaSA8c3BhbiBkaXI9
Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzp5dXZhcmFqLmFkZHVAZ21haWwuY29tIj55dXZhcmFq
LmFkZHVAZ21haWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3JkZXIt
bGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4K
SEksPGJyPjxicj5FdmVuIGkgdHJpZWQgd2l0aCBwcm9wZXIgQVBOLiBTdGlsbCBpIGFtIGZhY2lu
ZyBzYW1lIGlzc3VlLiBJIGFtIHRlc3Rpbmcgb24gbXkgaG9zdC48YnI+Iy4uL2xpc3QtY29udGV4
dHM8YnI+PGJyPlsgL3N0ZTAgXTxicj6goKAgWyAvc3RlMC9jb250ZXh0OCBdPGRpdiBjbGFzcz0i
aW0iPjxicj6goKCgoKCgIFVzZXJuYW1lID0gPGJyPqCgoKCgoKAgUHJvdG9jb2wgPSBpcDxicj4K
oKCgoKCgoCBOYW1lID0gSW50ZXJuZXQ8YnI+CqCgoKCgoKAgU2V0dGluZ3MgPSB7IH08YnI+oKCg
oKCgoCBBY3RpdmUgPSAwPGJyPjwvZGl2PqCgoKCgoKAgQWNjZXNzUG9pbnROYW1lID0geHgueXku
SU5URVJORVQ8YnI+oKCgoKCgoCBQYXNzd29yZCA9IDxicj6goKCgoKCgIFR5cGUgPSBpbnRlcm5l
dDxicj48YnI+PGJyPqAjLi9hY3RpdmF0ZS1jb250ZXh0IDxicj5FcnJvciBhY3RpdmF0aW5nIC9z
dGUwL2NvbnRleHQ4OiBvcmcub2Zvbm8uRXJyb3IuRmFpbGVkOiBPcGVyYXRpb24gZmFpbGVkPGJy
PgoKPGJyPlRoYW5rczxicj48YnI+WXV2YXJhaiBSPGRpdj48ZGl2PjwvZGl2PjxkaXYgY2xhc3M9
Img1Ij48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUaHUsIEp1biAxNiwgMjAx
MSBhdCAxMDoyOSBBTSwgWXV2YXJhaiBSYWd1cGF0aGkgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBo
cmVmPSJtYWlsdG86eXV2YXJhai5hZGR1QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnl1dmFy
YWouYWRkdUBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3Jk
ZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7
Ij4KSGk8YnI+PGJyPlNvcnJ5ICwgSSBhbSB0cnlpbmcgd2l0aCBpbnZhbGlkIEFQTjxicj48YnI+
VGhhbmtzPGJyPjxicj5ZdXZhcmFqIFI8ZGl2PjxkaXY+PC9kaXY+PGRpdj48YnI+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUaHUsIEp1biAxNiwgMjAxMSBhdCA5OjU3IEFNLCBZdXZh
cmFqIFJhZ3VwYXRoaSA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzp5dXZhcmFq
LmFkZHVAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+eXV2YXJhai5hZGR1QGdtYWlsLmNvbTwv
YT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+CgoKPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVyLWxlZnQ6IDFweCBzb2xp
ZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+SGksPGJyPjxicj5JIHNl
dCBhY2Nlc3MgcG9pbnQgbmFtZSBhbmQgdHJpZWQuIFNhbWUgcmVzdWx0Ljxicj48YnI+SGVyZSBp
IGFtIHByb3ZpZGluZyBtb3JlIGluZm8gYWJvdXQgdGhpcyBpc3N1ZTxicj4KCgo8YnI+T2Zvbm8g
bG9ncyBhdCA8YSBocmVmPSJodHRwOi8vcGFzdGViaW4uY29tL3hGckVqUllBIiB0YXJnZXQ9Il9i
bGFuayI+aHR0cDovL3Bhc3RlYmluLmNvbS94RnJFalJZQTwvYT48YnI+PGJyPjxiPiMgbGlzdCBv
ZiBjb250ZXh0czwvYj48YnI+Cjxicj5+L0Rvd25sb2Fkcy9vZm9uby0wLjQwL3Rlc3QkIC4vbGlz
dC1jb250ZXh0cyA8YnI+WyAvc3RlMCBdPGJyPqCgoCBbIC9zdGUwL2NvbnRleHQ2IF08YnI+oKCg
oKCgoCBVc2VybmFtZSA9IDxicj6goKCgoKCgIFByb3RvY29sID0gaXA8YnI+oKCgoKCgoCBOYW1l
ID0gSW50ZXJuZXQ8YnI+oKCgoKCgoCBTZXR0aW5ncyA9IHsgfTxicj6goKCgoKCgIEFjdGl2ZSA9
IDA8YnI+oKCgoKCgoCBBY2Nlc3NQb2ludE5hbWUgPSBUZXN0aW5nPGJyPgoKCgqgoKCgoKCgIFBh
c3N3b3JkID0gPGJyPqCgoKCgoKAgVHlwZSA9IGludGVybmV0PGJyPjxicj5+L0Rvd25sb2Fkcy9v
Zm9uby0wLjQwL3Rlc3QkIC4vYWN0aXZhdGUtY29udGV4dCA8YnI+RXJyb3IgYWN0aXZhdGluZyAv
c3RlMC9jb250ZXh0Njogb3JnLm9mb25vLkVycm9yLkZhaWxlZDogT3BlcmF0aW9uIGZhaWxlZDxi
cj48YnI+PGJyPlRoYW5rczxicj48YnI+WXV2YXJhaiBSPGRpdj48ZGl2PgoKCjwvZGl2PjxkaXY+
PGJyPjxicj4KPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVHVlLCBKdW4gMTQs
IDIwMTEgYXQgMzowNSBQTSwgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhy
ZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21h
aWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDogMXB4
IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KCgoKSGkgWXV2
YXJhaiw8YnI+CjxkaXY+PGJyPgomZ3Q7IENvbnRyb2wgQCBzdGVfZ3Byc19hY3RpdmF0ZV9wcmlt
YXJ5PGJyPgomZ3Q7IKBDb21tYW5kIGlzIEFUK0NHRENPTlQ9MSwmcXVvdDtJUCZxdW90OywmcXVv
dDsmcXVvdDs8YnI+CiZndDsgQ29udHJvbCBAIHN0ZV9jZ2Rjb250X2NiPGJyPgomZ3Q7IENvbnRy
b2wgMSBAIHN0ZV9jZ2Rjb250X2NiPGJyPgomZ3Q7IG9mb25vZFs4ODAzXTogc3JjL2dwcnMuYzpw
cmlfYWN0aXZhdGVfY2FsbGJhY2soKSAweGEwMmY4NjggKG51bGwpPGJyPgomZ3Q7IG9mb25vZFs4
ODAzXTogc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSBBY3RpdmF0aW5nIGNvbnRl
eHQ8YnI+CiZndDsgZmFpbGVkIHdpdGggZXJyb3I6IFVua25vd24gZXJyb3IgdHlwZTxicj4KPGJy
Pgo8L2Rpdj5Zb3UgbWlnaHQgdHJ5IHByb3Zpc2lvbmluZyB0aGUgY29udGV4dCBmaXJzdCBzaW5j
ZSB5b3UmIzM5O3JlIHRyeWluZyB0bzxicj4KYWN0aXZhdGUgYW4gZW1wdHkgQVBOLjxicj4KPGJy
PgpTZWUgZG9jL2Nvbm5tYW4tYXBpLnR4dCBmb3IgbW9yZSBkZXRhaWxzLjxicj4KPGJyPgpSZWdh
cmRzLDxicj4KPGZvbnQgY29sb3I9IiM4ODg4ODgiPi1EZW5pczxicj4KPC9mb250PjwvYmxvY2tx
dW90ZT48L2Rpdj48YnI+CjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+CjwvZGl2
PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+CjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48
L2Rpdj48YnI+Cg==

--===============8671813609712444665==--

