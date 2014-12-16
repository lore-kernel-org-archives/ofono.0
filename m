Content-Type: multipart/mixed; boundary="===============3974472435633628643=="
MIME-Version: 1.0
From: vicamo@gmail.com
Subject: "IPv6.Settings" in interface "org.ofono.ConnectionContext" is not a
 valid name
Date: Tue, 16 Dec 2014 11:57:36 +0800
Message-ID: <CAJ-KqdzPe=-phOwH4Eh52jWRWmT-CLrL5OV9RTF_N3nFt8nAQw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3974472435633628643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I happen to find a strange property "IPv6.Settings" in ConnectionContext.
According to DBus specification [1], dbus member names can only be
consisted of character set "[A-Z][a-z][0-9]_" and may not begin with a
digit. Any plan to get rid of it? Or is a patch to this welcomed? It will
certainly break compatibility to existing programs.

[1]:
http://dbus.freedesktop.org/doc/dbus-specification.html#message-protocol-na=
mes

Regards,
Vicamo

--===============3974472435633628643==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+SGkgYWxsLDxicj48YnI+PC9kaXY+SSBoYXBw
ZW4gdG8gZmluZCBhIHN0cmFuZ2UgcHJvcGVydHkgJnF1b3Q7SVB2Ni5TZXR0aW5ncyZxdW90OyBp
biBDb25uZWN0aW9uQ29udGV4dC4gQWNjb3JkaW5nIHRvIERCdXMgc3BlY2lmaWNhdGlvbiBbMV0s
IGRidXMgbWVtYmVyIG5hbWVzIGNhbiBvbmx5IGJlIGNvbnNpc3RlZCBvZiBjaGFyYWN0ZXIgc2V0
ICZxdW90O1tBLVpdW2Etel1bMC05XV8mcXVvdDsgYW5kIG1heSBub3QgYmVnaW4gd2l0aCBhCiAg
ICAgICAgICAgICAgICBkaWdpdC4gQW55IHBsYW4gdG8gZ2V0IHJpZCBvZiBpdD8gT3IgaXMgYSBw
YXRjaCB0byB0aGlzIHdlbGNvbWVkPyBJdCB3aWxsIGNlcnRhaW5seSBicmVhayBjb21wYXRpYmls
aXR5IHRvIGV4aXN0aW5nIHByb2dyYW1zLjxicj48YnI+WzFdOiA8YSBocmVmPSJodHRwOi8vZGJ1
cy5mcmVlZGVza3RvcC5vcmcvZG9jL2RidXMtc3BlY2lmaWNhdGlvbi5odG1sI21lc3NhZ2UtcHJv
dG9jb2wtbmFtZXMiPmh0dHA6Ly9kYnVzLmZyZWVkZXNrdG9wLm9yZy9kb2MvZGJ1cy1zcGVjaWZp
Y2F0aW9uLmh0bWwjbWVzc2FnZS1wcm90b2NvbC1uYW1lczwvYT48YnI+PGJyPjwvZGl2PlJlZ2Fy
ZHMsPGJyPjwvZGl2PlZpY2Ftbzxicj48L2Rpdj4K

--===============3974472435633628643==--

