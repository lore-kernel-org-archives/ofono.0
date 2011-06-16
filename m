Content-Type: multipart/mixed; boundary="===============5265015031057895093=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: Re: PDP Context Activation
Date: Thu, 16 Jun 2011 10:29:01 +0530
Message-ID: <BANLkTin=Zm0DZci4y9FJt1rNtdZ2Fk2Cow@mail.gmail.com>
In-Reply-To: <BANLkTinOCnVHnu_483nZXrkQoJgZENPYOw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5265015031057895093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

Sorry , I am trying with invalid APN

Thanks

Yuvaraj R

On Thu, Jun 16, 2011 at 9:57 AM, Yuvaraj Ragupathi
<yuvaraj.addu@gmail.com>wrote:

> Hi,
>
> I set access point name and tried. Same result.
>
> Here i am providing more info about this issue
>
> Ofono logs at http://pastebin.com/xFrEjRYA
>
> *# list of contexts*
>
> ~/Downloads/ofono-0.40/test$ ./list-contexts
> [ /ste0 ]
>     [ /ste0/context6 ]
>         Username =3D
>         Protocol =3D ip
>         Name =3D Internet
>         Settings =3D { }
>         Active =3D 0
>         AccessPointName =3D Testing
>         Password =3D
>         Type =3D internet
>
> ~/Downloads/ofono-0.40/test$ ./activate-context
> Error activating /ste0/context6: org.ofono.Error.Failed: Operation failed
>
>
> Thanks
>
> Yuvaraj R
>
>
>
>
> On Tue, Jun 14, 2011 at 3:05 PM, Denis Kenzior <denkenz@gmail.com> wrot=
e:
>
>> Hi Yuvaraj,
>>
>> > Control @ ste_gprs_activate_primary
>> >  Command is AT+CGDCONT=3D1,"IP",""
>> > Control @ ste_cgdcont_cb
>> > Control 1 @ ste_cgdcont_cb
>> > ofonod[8803]: src/gprs.c:pri_activate_callback() 0xa02f868 (null)
>> > ofonod[8803]: src/gprs.c:pri_activate_callback() Activating context
>> > failed with error: Unknown error type
>>
>> You might try provisioning the context first since you're trying to
>> activate an empty APN.
>>
>> See doc/connman-api.txt for more details.
>>
>> Regards,
>> -Denis
>>
>
>

--===============5265015031057895093==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGk8YnI+PGJyPlNvcnJ5ICwgSSBhbSB0cnlpbmcgd2l0aCBpbnZhbGlkIEFQTjxicj48YnI+VGhh
bmtzPGJyPjxicj5ZdXZhcmFqIFI8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBU
aHUsIEp1biAxNiwgMjAxMSBhdCA5OjU3IEFNLCBZdXZhcmFqIFJhZ3VwYXRoaSA8c3BhbiBkaXI9
Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzp5dXZhcmFqLmFkZHVAZ21haWwuY29tIj55dXZhcmFq
LmFkZHVAZ21haWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVy
LWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+
SGksPGJyPjxicj5JIHNldCBhY2Nlc3MgcG9pbnQgbmFtZSBhbmQgdHJpZWQuIFNhbWUgcmVzdWx0
Ljxicj48YnI+SGVyZSBpIGFtIHByb3ZpZGluZyBtb3JlIGluZm8gYWJvdXQgdGhpcyBpc3N1ZTxi
cj4KPGJyPk9mb25vIGxvZ3MgYXQgPGEgaHJlZj0iaHR0cDovL3Bhc3RlYmluLmNvbS94RnJFalJZ
QSIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9wYXN0ZWJpbi5jb20veEZyRWpSWUE8L2E+PGJyPjxi
cj48Yj4jIGxpc3Qgb2YgY29udGV4dHM8L2I+PGJyPgo8YnI+fi9Eb3dubG9hZHMvb2Zvbm8tMC40
MC90ZXN0JCAuL2xpc3QtY29udGV4dHMgPGJyPlsgL3N0ZTAgXTxicj6goKAgWyAvc3RlMC9jb250
ZXh0NiBdPGJyPqCgoKCgoKAgVXNlcm5hbWUgPSA8YnI+oKCgoKCgoCBQcm90b2NvbCA9IGlwPGJy
PqCgoKCgoKAgTmFtZSA9IEludGVybmV0PGJyPqCgoKCgoKAgU2V0dGluZ3MgPSB7IH08YnI+oKCg
oKCgoCBBY3RpdmUgPSAwPGJyPqCgoKCgoKAgQWNjZXNzUG9pbnROYW1lID0gVGVzdGluZzxicj4K
CqCgoKCgoKAgUGFzc3dvcmQgPSA8YnI+oKCgoKCgoCBUeXBlID0gaW50ZXJuZXQ8YnI+PGJyPn4v
RG93bmxvYWRzL29mb25vLTAuNDAvdGVzdCQgLi9hY3RpdmF0ZS1jb250ZXh0IDxicj5FcnJvciBh
Y3RpdmF0aW5nIC9zdGUwL2NvbnRleHQ2OiBvcmcub2Zvbm8uRXJyb3IuRmFpbGVkOiBPcGVyYXRp
b24gZmFpbGVkPGJyPjxicj48YnI+VGhhbmtzPGJyPjxicj5ZdXZhcmFqIFI8ZGl2PjxkaXY+Cjwv
ZGl2PjxkaXYgY2xhc3M9Img1Ij48YnI+PGJyPgo8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1
b3RlIj5PbiBUdWUsIEp1biAxNCwgMjAxMSBhdCAzOjA1IFBNLCBEZW5pcyBLZW56aW9yIDxzcGFu
IGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIiB0YXJnZXQ9
Il9ibGFuayI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44
ZXg7IGJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxl
ZnQ6IDFleDsiPgoKSGkgWXV2YXJhaiw8YnI+CjxkaXY+PGJyPgomZ3Q7IENvbnRyb2wgQCBzdGVf
Z3Byc19hY3RpdmF0ZV9wcmltYXJ5PGJyPgomZ3Q7IKBDb21tYW5kIGlzIEFUK0NHRENPTlQ9MSwm
cXVvdDtJUCZxdW90OywmcXVvdDsmcXVvdDs8YnI+CiZndDsgQ29udHJvbCBAIHN0ZV9jZ2Rjb250
X2NiPGJyPgomZ3Q7IENvbnRyb2wgMSBAIHN0ZV9jZ2Rjb250X2NiPGJyPgomZ3Q7IG9mb25vZFs4
ODAzXTogc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSAweGEwMmY4NjggKG51bGwp
PGJyPgomZ3Q7IG9mb25vZFs4ODAzXTogc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVfY2FsbGJhY2so
KSBBY3RpdmF0aW5nIGNvbnRleHQ8YnI+CiZndDsgZmFpbGVkIHdpdGggZXJyb3I6IFVua25vd24g
ZXJyb3IgdHlwZTxicj4KPGJyPgo8L2Rpdj5Zb3UgbWlnaHQgdHJ5IHByb3Zpc2lvbmluZyB0aGUg
Y29udGV4dCBmaXJzdCBzaW5jZSB5b3UmIzM5O3JlIHRyeWluZyB0bzxicj4KYWN0aXZhdGUgYW4g
ZW1wdHkgQVBOLjxicj4KPGJyPgpTZWUgZG9jL2Nvbm5tYW4tYXBpLnR4dCBmb3IgbW9yZSBkZXRh
aWxzLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KPGZvbnQgY29sb3I9IiM4ODg4ODgiPi1EZW5pczxi
cj4KPC9mb250PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+CjwvZGl2PjwvZGl2PjwvYmxvY2txdW90
ZT48L2Rpdj48YnI+Cg==

--===============5265015031057895093==--

