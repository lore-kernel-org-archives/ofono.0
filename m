Content-Type: multipart/mixed; boundary="===============3163212830261656489=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: Re: PDP Context Activation
Date: Tue, 21 Jun 2011 17:03:58 +0530
Message-ID: <BANLkTimnhp+VWdf+UfakX+yVosbUkh2Udw@mail.gmail.com>
In-Reply-To: <BANLkTin=Zm0DZci4y9FJt1rNtdZ2Fk2Cow@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3163212830261656489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI,

Even i tried with proper APN. Still i am facing same issue. I am testing on
my host.
#../list-contexts

[ /ste0 ]
    [ /ste0/context8 ]
        Username =3D
        Protocol =3D ip
        Name =3D Internet
        Settings =3D { }
        Active =3D 0
        AccessPointName =3D xx.yy.INTERNET
        Password =3D
        Type =3D internet


 #./activate-context
Error activating /ste0/context8: org.ofono.Error.Failed: Operation failed

Thanks

Yuvaraj R

On Thu, Jun 16, 2011 at 10:29 AM, Yuvaraj Ragupathi
<yuvaraj.addu@gmail.com>wrote:

> Hi
>
> Sorry , I am trying with invalid APN
>
> Thanks
>
> Yuvaraj R
>
>
> On Thu, Jun 16, 2011 at 9:57 AM, Yuvaraj Ragupathi <yuvaraj.addu@gmail.=
com
> > wrote:
>
>> Hi,
>>
>> I set access point name and tried. Same result.
>>
>> Here i am providing more info about this issue
>>
>> Ofono logs at http://pastebin.com/xFrEjRYA
>>
>> *# list of contexts*
>>
>> ~/Downloads/ofono-0.40/test$ ./list-contexts
>> [ /ste0 ]
>>     [ /ste0/context6 ]
>>         Username =3D
>>         Protocol =3D ip
>>         Name =3D Internet
>>         Settings =3D { }
>>         Active =3D 0
>>         AccessPointName =3D Testing
>>         Password =3D
>>         Type =3D internet
>>
>> ~/Downloads/ofono-0.40/test$ ./activate-context
>> Error activating /ste0/context6: org.ofono.Error.Failed: Operation failed
>>
>>
>> Thanks
>>
>> Yuvaraj R
>>
>>
>>
>>
>> On Tue, Jun 14, 2011 at 3:05 PM, Denis Kenzior <denkenz@gmail.com> wro=
te:
>>
>>> Hi Yuvaraj,
>>>
>>> > Control @ ste_gprs_activate_primary
>>> >  Command is AT+CGDCONT=3D1,"IP",""
>>> > Control @ ste_cgdcont_cb
>>> > Control 1 @ ste_cgdcont_cb
>>> > ofonod[8803]: src/gprs.c:pri_activate_callback() 0xa02f868 (null)
>>> > ofonod[8803]: src/gprs.c:pri_activate_callback() Activating context
>>> > failed with error: Unknown error type
>>>
>>> You might try provisioning the context first since you're trying to
>>> activate an empty APN.
>>>
>>> See doc/connman-api.txt for more details.
>>>
>>> Regards,
>>> -Denis
>>>
>>
>>
>

--===============3163212830261656489==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SEksPGJyPjxicj5FdmVuIGkgdHJpZWQgd2l0aCBwcm9wZXIgQVBOLiBTdGlsbCBpIGFtIGZhY2lu
ZyBzYW1lIGlzc3VlLiBJIGFtIHRlc3Rpbmcgb24gbXkgaG9zdC48YnI+Iy4uL2xpc3QtY29udGV4
dHM8YnI+PGJyPlsgL3N0ZTAgXTxicj6goKAgWyAvc3RlMC9jb250ZXh0OCBdPGJyPqCgoKCgoKAg
VXNlcm5hbWUgPSA8YnI+oKCgoKCgoCBQcm90b2NvbCA9IGlwPGJyPqCgoKCgoKAgTmFtZSA9IElu
dGVybmV0PGJyPgqgoKCgoKCgIFNldHRpbmdzID0geyB9PGJyPqCgoKCgoKAgQWN0aXZlID0gMDxi
cj6goKCgoKCgIEFjY2Vzc1BvaW50TmFtZSA9IHh4Lnl5LklOVEVSTkVUPGJyPqCgoKCgoKAgUGFz
c3dvcmQgPSA8YnI+oKCgoKCgoCBUeXBlID0gaW50ZXJuZXQ8YnI+PGJyPjxicj6gIy4vYWN0aXZh
dGUtY29udGV4dCA8YnI+RXJyb3IgYWN0aXZhdGluZyAvc3RlMC9jb250ZXh0ODogb3JnLm9mb25v
LkVycm9yLkZhaWxlZDogT3BlcmF0aW9uIGZhaWxlZDxicj4KPGJyPlRoYW5rczxicj48YnI+WXV2
YXJhaiBSPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVGh1LCBKdW4gMTYsIDIw
MTEgYXQgMTA6MjkgQU0sIFl1dmFyYWogUmFndXBhdGhpIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEg
aHJlZj0ibWFpbHRvOnl1dmFyYWouYWRkdUBnbWFpbC5jb20iPnl1dmFyYWouYWRkdUBnbWFpbC5j
b208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IGJvcmRlci1sZWZ0OiAxcHggc29s
aWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxlZnQ6IDFleDsiPgpIaTxicj48YnI+U29y
cnkgLCBJIGFtIHRyeWluZyB3aXRoIGludmFsaWQgQVBOPGJyPjxicj5UaGFua3M8YnI+PGJyPll1
dmFyYWogUjxkaXY+PGRpdj48L2Rpdj48ZGl2IGNsYXNzPSJoNSI+PGJyPjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+T24gVGh1LCBKdW4gMTYsIDIwMTEgYXQgOTo1NyBBTSwgWXV2YXJhaiBS
YWd1cGF0aGkgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86eXV2YXJhai5hZGR1
QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnl1dmFyYWouYWRkdUBnbWFpbC5jb208L2E+Jmd0
Ozwvc3Bhbj4gd3JvdGU6PGJyPgoKPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2Io
MjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+SGksPGJyPjxicj5JIHNldCBhY2Nl
c3MgcG9pbnQgbmFtZSBhbmQgdHJpZWQuIFNhbWUgcmVzdWx0Ljxicj48YnI+SGVyZSBpIGFtIHBy
b3ZpZGluZyBtb3JlIGluZm8gYWJvdXQgdGhpcyBpc3N1ZTxicj4KCjxicj5PZm9ubyBsb2dzIGF0
IDxhIGhyZWY9Imh0dHA6Ly9wYXN0ZWJpbi5jb20veEZyRWpSWUEiIHRhcmdldD0iX2JsYW5rIj5o
dHRwOi8vcGFzdGViaW4uY29tL3hGckVqUllBPC9hPjxicj48YnI+PGI+IyBsaXN0IG9mIGNvbnRl
eHRzPC9iPjxicj4KPGJyPn4vRG93bmxvYWRzL29mb25vLTAuNDAvdGVzdCQgLi9saXN0LWNvbnRl
eHRzIDxicj5bIC9zdGUwIF08YnI+oKCgIFsgL3N0ZTAvY29udGV4dDYgXTxicj6goKCgoKCgIFVz
ZXJuYW1lID0gPGJyPqCgoKCgoKAgUHJvdG9jb2wgPSBpcDxicj6goKCgoKCgIE5hbWUgPSBJbnRl
cm5ldDxicj6goKCgoKCgIFNldHRpbmdzID0geyB9PGJyPqCgoKCgoKAgQWN0aXZlID0gMDxicj6g
oKCgoKCgIEFjY2Vzc1BvaW50TmFtZSA9IFRlc3Rpbmc8YnI+CgoKoKCgoKCgoCBQYXNzd29yZCA9
IDxicj6goKCgoKCgIFR5cGUgPSBpbnRlcm5ldDxicj48YnI+fi9Eb3dubG9hZHMvb2Zvbm8tMC40
MC90ZXN0JCAuL2FjdGl2YXRlLWNvbnRleHQgPGJyPkVycm9yIGFjdGl2YXRpbmcgL3N0ZTAvY29u
dGV4dDY6IG9yZy5vZm9uby5FcnJvci5GYWlsZWQ6IE9wZXJhdGlvbiBmYWlsZWQ8YnI+PGJyPjxi
cj5UaGFua3M8YnI+PGJyPll1dmFyYWogUjxkaXY+PGRpdj4KCjwvZGl2PjxkaXY+PGJyPjxicj4K
PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVHVlLCBKdW4gMTQsIDIwMTEgYXQg
MzowNSBQTSwgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0
bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29tPC9h
PiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIHJn
YigyMDQsIDIwNCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KCgpIaSBZdXZhcmFqLDxicj4K
PGRpdj48YnI+CiZndDsgQ29udHJvbCBAIHN0ZV9ncHJzX2FjdGl2YXRlX3ByaW1hcnk8YnI+CiZn
dDsgoENvbW1hbmQgaXMgQVQrQ0dEQ09OVD0xLCZxdW90O0lQJnF1b3Q7LCZxdW90OyZxdW90Ozxi
cj4KJmd0OyBDb250cm9sIEAgc3RlX2NnZGNvbnRfY2I8YnI+CiZndDsgQ29udHJvbCAxIEAgc3Rl
X2NnZGNvbnRfY2I8YnI+CiZndDsgb2Zvbm9kWzg4MDNdOiBzcmMvZ3Bycy5jOnByaV9hY3RpdmF0
ZV9jYWxsYmFjaygpIDB4YTAyZjg2OCAobnVsbCk8YnI+CiZndDsgb2Zvbm9kWzg4MDNdOiBzcmMv
Z3Bycy5jOnByaV9hY3RpdmF0ZV9jYWxsYmFjaygpIEFjdGl2YXRpbmcgY29udGV4dDxicj4KJmd0
OyBmYWlsZWQgd2l0aCBlcnJvcjogVW5rbm93biBlcnJvciB0eXBlPGJyPgo8YnI+CjwvZGl2Pllv
dSBtaWdodCB0cnkgcHJvdmlzaW9uaW5nIHRoZSBjb250ZXh0IGZpcnN0IHNpbmNlIHlvdSYjMzk7
cmUgdHJ5aW5nIHRvPGJyPgphY3RpdmF0ZSBhbiBlbXB0eSBBUE4uPGJyPgo8YnI+ClNlZSBkb2Mv
Y29ubm1hbi1hcGkudHh0IGZvciBtb3JlIGRldGFpbHMuPGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgo8
Zm9udCBjb2xvcj0iIzg4ODg4OCI+LURlbmlzPGJyPgo8L2ZvbnQ+PC9ibG9ja3F1b3RlPjwvZGl2
Pjxicj4KPC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4KPC9kaXY+PC9kaXY+PC9i
bG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============3163212830261656489==--

