Content-Type: multipart/mixed; boundary="===============7506659197294435442=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: RE: Ofono and PPP
Date: Tue, 22 Jun 2010 17:25:09 +0300
Message-ID: <AANLkTim3fVQ8mY3fMVERuHnCHyB82DkEUW1HbrNc8Me-@mail.gmail.com>
In-Reply-To: <AANLkTinmsDix_J1MviE68tcDJGfyBX-NOmmeoq1nDnd5@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7506659197294435442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Could any one help me in this? Where could be the issue?

I have managed to put together ofono and conn man for an at modem interface.


The atmodem is working and here is the detail of a pdp context i created.
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------
[ /generic ]
    [ /generic/primarycontext1 ]
        Username =3D
        Name =3D Internet access
        Settings =3D { Interface=3Dppp0 Netmask=3D255.255.255.255 Method=3D=
static
DomainNameServers=3D192.89.123.231,192.89.123.230, Address=3D109.240.193.16=
9 }
        Active =3D 1
        AccessPointName =3D internet
        Password =3D
        Type =3D internet
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------

the ifconfig:

ppp0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:32 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:500
          RX bytes:0 (0.0 B)  TX bytes:10944 (10.9 KB)
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------

The ifconfig doesn't seem to have all the required information from the ppp
link created. why this is so? Is there a way to put these in sync?

I have managed to put together conman and ofono. The conman is working
perfectly for Ethernet. and is also getting the details of the context i
created.
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------------------------------------------------
[ /profile/default/cellular_244915470558014_primarycontext1 ]
    AutoConnect =3D false
    Name =3D FI SONERA
    Nameservers =3D [ ]
    MCC =3D 244
    Proxy =3D { }
    Favorite =3D false
    Domains.Configuration =3D [ ]
    IPv4.Configuration =3D { }
    State =3D idle
    IPv4 =3D { }
    Nameservers.Configuration =3D [ ]
    Mode =3D gprs
    Domains =3D [ ]
    Ethernet =3D { }
    Roaming =3D 0
    MNC =3D 91
    Type =3D cellular
    Immutable =3D false
    SetupRequired =3D true
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------------------------------------------------
if the ppp0 interface not provided with an ipaddress? I see no ip address
from system tools too. what is missing here from ofono/system configuration?


I did code modifications to set the ip address received to the interface
ppp0, i can see that the interface shows this ip, but i am unable to use it.


I am running a Ubuntu 9.10, running as guest in virtual box, latest connmand
and ofono sources compiled. ofono is compiled without isimodem support.

Thanks in advance for any help

Regards
Arun

--===============7506659197294435442==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPkhpIGFsbCw8YnI+PGJyPkNvdWxkIGFueSBvbmUgaGVs
cCBtZSBpbiB0aGlzPyBXaGVyZSBjb3VsZCBiZSB0aGUgaXNzdWU/PGJyPjxicj5JIGhhdmUgbWFu
YWdlZCB0byBwdXQgdG9nZXRoZXIgb2Zvbm8gYW5kIGNvbm4gbWFuIGZvciBhbiBhdCBtb2RlbSBp
bnRlcmZhY2UuIDxicj48YnI+VGhlIGF0bW9kZW0gaXMgd29ya2luZyBhbmQgaGVyZSBpcyB0aGUg
ZGV0YWlsIG9mIGEgcGRwIGNvbnRleHQgaSBjcmVhdGVkLjxicj4KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CgpbIC9n
ZW5lcmljIF08YnI+oKCgIFsgL2dlbmVyaWMvcHJpbWFyeWNvbnRleHQxIF08YnI+oKCgoKCgoCBV
c2VybmFtZSA9IDxicj6goKCgoKCgIE5hbWUgPSBJbnRlcm5ldCBhY2Nlc3M8YnI+oKCgoKCgoCBT
ZXR0aW5ncyA9IHsgSW50ZXJmYWNlPXBwcDAgTmV0bWFzaz0yNTUuMjU1LjI1NS4yNTUgTWV0aG9k
PXN0YXRpYyBEb21haW5OYW1lU2VydmVycz0xOTIuODkuMTIzLjIzMSwxOTIuODkuMTIzLjIzMCwg
QWRkcmVzcz0xMDkuMjQwLjE5My4xNjkgfTxicj4KCqCgoKCgoKAgQWN0aXZlID0gMTxicj6goKCg
oKCgIEFjY2Vzc1BvaW50TmFtZSA9IGludGVybmV0PGJyPqCgoKCgoKAgUGFzc3dvcmQgPSA8YnI+
oKCgoKCgoCBUeXBlID0gaW50ZXJuZXQ8YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+Cgo8YnI+dGhlIGlmY29uZmln
Ojxicj48YnI+cHBwMKCgoKCgIExpbmsgZW5jYXA6VU5TUEVDoCBIV2FkZHIgMDAtMDAtMDAtMDAt
MDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDCgIDxicj6goKCgoKCgoKAgVVAgUE9J
TlRPUE9JTlQgUlVOTklORyBOT0FSUCBNVUxUSUNBU1SgIE1UVToxNTAwoCBNZXRyaWM6MTxicj6g
oKCgoKCgoKAgUlggcGFja2V0czowIGVycm9yczowIGRyb3BwZWQ6MCBvdmVycnVuczowIGZyYW1l
OjA8YnI+CgqgoKCgoKCgoKAgVFggcGFja2V0czozMiBlcnJvcnM6MCBkcm9wcGVkOjAgb3ZlcnJ1
bnM6MCBjYXJyaWVyOjA8YnI+oKCgoKCgoKCgIGNvbGxpc2lvbnM6MCB0eHF1ZXVlbGVuOjUwMCA8
YnI+oKCgoKCgoKCgIFJYIGJ5dGVzOjAgKDAuMCBCKaAgVFggYnl0ZXM6MTA5NDQgKDEwLjkgS0Ip
PGJyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS08YnI+Cgo8YnI+VGhlIGlmY29uZmlnIGRvZXNuJiMzOTt0IHNlZW0gdG8g
aGF2ZSBhbGwgdGhlIHJlcXVpcmVkIGluZm9ybWF0aW9uIGZyb20gdGhlIHBwcCBsaW5rIGNyZWF0
ZWQuIHdoeSB0aGlzIGlzIHNvPyBJcyB0aGVyZSBhIHdheSB0byBwdXQgdGhlc2UgaW4gc3luYz88
YnI+PGJyPkkgaGF2ZSBtYW5hZ2VkIHRvIHB1dCB0b2dldGhlciBjb25tYW4gYW5kIG9mb25vLiBU
aGUgY29ubWFuIGlzIHdvcmtpbmcgcGVyZmVjdGx5IGZvciBFdGhlcm5ldC4gYW5kIGlzIGFsc28g
Z2V0dGluZyB0aGUgZGV0YWlscyBvZiB0aGUgY29udGV4dCBpIGNyZWF0ZWQuPGJyPgoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CgpbIC9wcm9maWxl
L2RlZmF1bHQvY2VsbHVsYXJfMjQ0OTE1NDcwNTU4MDE0X3ByaW1hcnljb250ZXh0MSBdPGJyPqCg
oCBBdXRvQ29ubmVjdCA9IGZhbHNlPGJyPqCgoCBOYW1lID0gRkkgU09ORVJBPGJyPqCgoCBOYW1l
c2VydmVycyA9IFsgXTxicj6goKAgTUNDID0gMjQ0PGJyPqCgoCBQcm94eSA9IHsgfTxicj6goKAg
RmF2b3JpdGUgPSBmYWxzZTxicj6goKAgRG9tYWlucy5Db25maWd1cmF0aW9uID0gWyBdPGJyPgoK
oKCgIElQdjQuQ29uZmlndXJhdGlvbiA9IHsgfTxicj6goKAgU3RhdGUgPSBpZGxlPGJyPqCgoCBJ
UHY0ID0geyB9PGJyPqCgoCBOYW1lc2VydmVycy5Db25maWd1cmF0aW9uID0gWyBdPGJyPqCgoCBN
b2RlID0gZ3Byczxicj6goKAgRG9tYWlucyA9IFsgXTxicj6goKAgRXRoZXJuZXQgPSB7IH08YnI+
oKCgIFJvYW1pbmcgPSAwPGJyPqCgoCBNTkMgPSA5MTxicj6goKAgVHlwZSA9IGNlbGx1bGFyPGJy
PgoKoKCgIEltbXV0YWJsZSA9IGZhbHNlPGJyPqCgoCBTZXR1cFJlcXVpcmVkID0gdHJ1ZTxicj4t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4KCmlm
IHRoZSBwcHAwIGludGVyZmFjZSBub3QgcHJvdmlkZWQgd2l0aCBhbiBpcGFkZHJlc3M/IEkgc2Vl
IG5vIGlwIGFkZHJlc3MgZnJvbSBzeXN0ZW0gdG9vbHMgdG9vLiB3aGF0IGlzIG1pc3NpbmcgaGVy
ZSBmcm9tIG9mb25vL3N5c3RlbSBjb25maWd1cmF0aW9uPyA8YnI+PGJyPkkgZGlkIGNvZGUgbW9k
aWZpY2F0aW9ucyB0byBzZXQgdGhlIGlwIGFkZHJlc3MgcmVjZWl2ZWQgdG8gdGhlIGludGVyZmFj
ZSBwcHAwLCBpIGNhbiBzZWUgdGhhdCB0aGUgaW50ZXJmYWNlIHNob3dzIHRoaXMgaXAsIGJ1dCBp
IGFtIHVuYWJsZSB0byB1c2UgaXQuIDxicj4KPGJyPkkgYW0gcnVubmluZyBhIFVidW50dSA5LjEw
LCBydW5uaW5nIGFzIGd1ZXN0IGluIHZpcnR1YWwgYm94LCBsYXRlc3QgY29ubm1hbmQgYW5kIG9m
b25vIHNvdXJjZXMgY29tcGlsZWQuIG9mb25vIGlzIGNvbXBpbGVkIHdpdGhvdXQgaXNpbW9kZW0g
c3VwcG9ydC48YnI+Cjxicj5UaGFua3MgaW4gYWR2YW5jZSBmb3IgYW55IGhlbHA8YnI+PGJyPlJl
Z2FyZHM8YnI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPkFydW48YnI+PGJyPjxicj4KPC9mb250Pjwv
ZGl2Pjxicj4K

--===============7506659197294435442==--

