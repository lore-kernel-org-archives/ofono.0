Content-Type: multipart/mixed; boundary="===============1058761699874807035=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: Ofono and PPP
Date: Fri, 18 Jun 2010 15:37:07 +0300
Message-ID: <AANLkTinmsDix_J1MviE68tcDJGfyBX-NOmmeoq1nDnd5@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1058761699874807035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

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

I am running a Ubuntu 9.10, running as guest in virtual box, latest connmand
and ofono sources compiled. ofono is compiled without isimodem support.

Thanks in advance for any help

Regards
Arun

--===============1058761699874807035==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgYWxsLDxicj48YnI+SSBoYXZlIG1hbmFnZWQgdG8gcHV0IHRvZ2V0aGVyIG9mb25vIGFuZCBj
b25uIG1hbiBmb3IgYW4gYXQgbW9kZW0gaW50ZXJmYWNlLiA8YnI+PGJyPlRoZSBhdG1vZGVtIGlz
IHdvcmtpbmcgYW5kIGhlcmUgaXMgdGhlIGRldGFpbCBvZiBhIHBkcCBjb250ZXh0IGkgY3JlYXRl
ZC48YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS08YnI+ClsgL2dlbmVyaWMgXTxicj6goKAgWyAvZ2VuZXJpYy9wcmltYXJ5
Y29udGV4dDEgXTxicj6goKCgoKCgIFVzZXJuYW1lID0gPGJyPqCgoKCgoKAgTmFtZSA9IEludGVy
bmV0IGFjY2Vzczxicj6goKCgoKCgIFNldHRpbmdzID0geyBJbnRlcmZhY2U9cHBwMCBOZXRtYXNr
PTI1NS4yNTUuMjU1LjI1NSBNZXRob2Q9c3RhdGljIERvbWFpbk5hbWVTZXJ2ZXJzPTE5Mi44OS4x
MjMuMjMxLDE5Mi44OS4xMjMuMjMwLCBBZGRyZXNzPTEwOS4yNDAuMTkzLjE2OSB9PGJyPgqgoKCg
oKCgIEFjdGl2ZSA9IDE8YnI+oKCgoKCgoCBBY2Nlc3NQb2ludE5hbWUgPSBpbnRlcm5ldDxicj6g
oKCgoKCgIFBhc3N3b3JkID0gPGJyPqCgoKCgoKAgVHlwZSA9IGludGVybmV0PGJyPi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PGJyPgo8YnI+dGhlIGlmY29uZmlnOjxicj48YnI+cHBwMKCgoKCgIExpbmsgZW5jYXA6VU5TUEVD
oCBIV2FkZHIgMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDAtMDCg
IDxicj6goKCgoKCgoKAgVVAgUE9JTlRPUE9JTlQgUlVOTklORyBOT0FSUCBNVUxUSUNBU1SgIE1U
VToxNTAwoCBNZXRyaWM6MTxicj6goKCgoKCgoKAgUlggcGFja2V0czowIGVycm9yczowIGRyb3Bw
ZWQ6MCBvdmVycnVuczowIGZyYW1lOjA8YnI+CqCgoKCgoKCgoCBUWCBwYWNrZXRzOjMyIGVycm9y
czowIGRyb3BwZWQ6MCBvdmVycnVuczowIGNhcnJpZXI6MDxicj6goKCgoKCgoKAgY29sbGlzaW9u
czowIHR4cXVldWVsZW46NTAwIDxicj6goKCgoKCgoKAgUlggYnl0ZXM6MCAoMC4wIEIpoCBUWCBi
eXRlczoxMDk0NCAoMTAuOSBLQik8YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4KPGJyPlRoZSBpZmNvbmZpZyBk
b2VzbiYjMzk7dCBzZWVtIHRvIGhhdmUgYWxsIHRoZSByZXF1aXJlZCBpbmZvcm1hdGlvbiBmcm9t
IHRoZSBwcHAgbGluayBjcmVhdGVkLiB3aHkgdGhpcyBpcyBzbz8gSXMgdGhlcmUgYSB3YXkgdG8g
cHV0IHRoZXNlIGluIHN5bmM/PGJyPjxicj5JIGhhdmUgbWFuYWdlZCB0byBwdXQgdG9nZXRoZXIg
Y29ubWFuIGFuZCBvZm9uby4gVGhlIGNvbm1hbiBpcyB3b3JraW5nIHBlcmZlY3RseSBmb3IgRXRo
ZXJuZXQuIGFuZCBpcyBhbHNvIGdldHRpbmcgdGhlIGRldGFpbHMgb2YgdGhlIGNvbnRleHQgaSBj
cmVhdGVkLjxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS08YnI+ClsgL3Byb2ZpbGUvZGVmYXVsdC9jZWxsdWxhcl8yNDQ5MTU0NzA1NTgwMTRfcHJpbWFy
eWNvbnRleHQxIF08YnI+oKCgIEF1dG9Db25uZWN0ID0gZmFsc2U8YnI+oKCgIE5hbWUgPSBGSSBT
T05FUkE8YnI+oKCgIE5hbWVzZXJ2ZXJzID0gWyBdPGJyPqCgoCBNQ0MgPSAyNDQ8YnI+oKCgIFBy
b3h5ID0geyB9PGJyPqCgoCBGYXZvcml0ZSA9IGZhbHNlPGJyPqCgoCBEb21haW5zLkNvbmZpZ3Vy
YXRpb24gPSBbIF08YnI+CqCgoCBJUHY0LkNvbmZpZ3VyYXRpb24gPSB7IH08YnI+oKCgIFN0YXRl
ID0gaWRsZTxicj6goKAgSVB2NCA9IHsgfTxicj6goKAgTmFtZXNlcnZlcnMuQ29uZmlndXJhdGlv
biA9IFsgXTxicj6goKAgTW9kZSA9IGdwcnM8YnI+oKCgIERvbWFpbnMgPSBbIF08YnI+oKCgIEV0
aGVybmV0ID0geyB9PGJyPqCgoCBSb2FtaW5nID0gMDxicj6goKAgTU5DID0gOTE8YnI+oKCgIFR5
cGUgPSBjZWxsdWxhcjxicj4KoKCgIEltbXV0YWJsZSA9IGZhbHNlPGJyPqCgoCBTZXR1cFJlcXVp
cmVkID0gdHJ1ZTxicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj4KaWYgdGhlIHBwcDAgaW50ZXJmYWNlIG5vdCBwcm92aWRlZCB3aXRoIGFuIGlw
YWRkcmVzcz8gSSBzZWUgbm8gaXAgYWRkcmVzcyBmcm9tIHN5c3RlbSB0b29scyB0b28uIHdoYXQg
aXMgbWlzc2luZyBoZXJlIGZyb20gb2Zvbm8vc3lzdGVtIGNvbmZpZ3VyYXRpb24/IDxicj5JIGFt
IHJ1bm5pbmcgYSBVYnVudHUgOS4xMCwgcnVubmluZyBhcyBndWVzdCBpbiB2aXJ0dWFsIGJveCwg
bGF0ZXN0IGNvbm5tYW5kIGFuZCBvZm9ubyBzb3VyY2VzIGNvbXBpbGVkLiBvZm9ubyBpcyBjb21w
aWxlZCB3aXRob3V0IGlzaW1vZGVtIHN1cHBvcnQuPGJyPgo8YnI+VGhhbmtzIGluIGFkdmFuY2Ug
Zm9yIGFueSBoZWxwPGJyPjxicj5SZWdhcmRzPGJyPkFydW48YnI+PGJyPjxicj4K

--===============1058761699874807035==--

