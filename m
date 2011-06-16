Content-Type: multipart/mixed; boundary="===============3550998126119535827=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: Re: PDP Context Activation
Date: Thu, 16 Jun 2011 09:57:07 +0530
Message-ID: <BANLkTinOCnVHnu_483nZXrkQoJgZENPYOw@mail.gmail.com>
In-Reply-To: <4DF72B70.1020201@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3550998126119535827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I set access point name and tried. Same result.

Here i am providing more info about this issue

Ofono logs at http://pastebin.com/xFrEjRYA

*# list of contexts*

~/Downloads/ofono-0.40/test$ ./list-contexts
[ /ste0 ]
    [ /ste0/context6 ]
        Username =3D
        Protocol =3D ip
        Name =3D Internet
        Settings =3D { }
        Active =3D 0
        AccessPointName =3D Testing
        Password =3D
        Type =3D internet

~/Downloads/ofono-0.40/test$ ./activate-context
Error activating /ste0/context6: org.ofono.Error.Failed: Operation failed


Thanks

Yuvaraj R



On Tue, Jun 14, 2011 at 3:05 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Yuvaraj,
>
> > Control @ ste_gprs_activate_primary
> >  Command is AT+CGDCONT=3D1,"IP",""
> > Control @ ste_cgdcont_cb
> > Control 1 @ ste_cgdcont_cb
> > ofonod[8803]: src/gprs.c:pri_activate_callback() 0xa02f868 (null)
> > ofonod[8803]: src/gprs.c:pri_activate_callback() Activating context
> > failed with error: Unknown error type
>
> You might try provisioning the context first since you're trying to
> activate an empty APN.
>
> See doc/connman-api.txt for more details.
>
> Regards,
> -Denis
>

--===============3550998126119535827==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj5JIHNldCBhY2Nlc3MgcG9pbnQgbmFtZSBhbmQgdHJpZWQuIFNhbWUgcmVzdWx0
Ljxicj48YnI+SGVyZSBpIGFtIHByb3ZpZGluZyBtb3JlIGluZm8gYWJvdXQgdGhpcyBpc3N1ZTxi
cj48YnI+T2Zvbm8gbG9ncyBhdCA8YSBocmVmPSJodHRwOi8vcGFzdGViaW4uY29tL3hGckVqUllB
Ij5odHRwOi8vcGFzdGViaW4uY29tL3hGckVqUllBPC9hPjxicj48YnI+PGI+IyBsaXN0IG9mIGNv
bnRleHRzPC9iPjxicj4KPGJyPn4vRG93bmxvYWRzL29mb25vLTAuNDAvdGVzdCQgLi9saXN0LWNv
bnRleHRzIDxicj5bIC9zdGUwIF08YnI+oKCgIFsgL3N0ZTAvY29udGV4dDYgXTxicj6goKCgoKCg
IFVzZXJuYW1lID0gPGJyPqCgoKCgoKAgUHJvdG9jb2wgPSBpcDxicj6goKCgoKCgIE5hbWUgPSBJ
bnRlcm5ldDxicj6goKCgoKCgIFNldHRpbmdzID0geyB9PGJyPqCgoKCgoKAgQWN0aXZlID0gMDxi
cj6goKCgoKCgIEFjY2Vzc1BvaW50TmFtZSA9IFRlc3Rpbmc8YnI+CqCgoKCgoKAgUGFzc3dvcmQg
PSA8YnI+oKCgoKCgoCBUeXBlID0gaW50ZXJuZXQ8YnI+PGJyPn4vRG93bmxvYWRzL29mb25vLTAu
NDAvdGVzdCQgLi9hY3RpdmF0ZS1jb250ZXh0IDxicj5FcnJvciBhY3RpdmF0aW5nIC9zdGUwL2Nv
bnRleHQ2OiBvcmcub2Zvbm8uRXJyb3IuRmFpbGVkOiBPcGVyYXRpb24gZmFpbGVkPGJyPjxicj48
YnI+VGhhbmtzPGJyPjxicj5ZdXZhcmFqIFI8YnI+PGJyPgo8YnI+PGJyPjxkaXYgY2xhc3M9Imdt
YWlsX3F1b3RlIj5PbiBUdWUsIEp1biAxNCwgMjAxMSBhdCAzOjA1IFBNLCBEZW5pcyBLZW56aW9y
IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5k
ZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVy
LWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+
CkhpIFl1dmFyYWosPGJyPgo8ZGl2IGNsYXNzPSJpbSI+PGJyPgomZ3Q7IENvbnRyb2wgQCBzdGVf
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
cj4KPC9mb250PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+Cg==

--===============3550998126119535827==--

