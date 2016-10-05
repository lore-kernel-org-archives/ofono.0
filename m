Content-Type: multipart/mixed; boundary="===============1200558948580408605=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: IPV6 question
Date: Wed, 05 Oct 2016 08:50:48 +0200
Message-ID: <CAH4ZQwtH8U2kftiLgq1DXsvtkQa6sHVDH4vUbooB5itft-_bvg@mail.gmail.com>
In-Reply-To: <57ED3C40.5020705@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1200558948580408605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm still trying to make IPV6 work.
First, I ensured that my modem and network support IPV6 making a successful
IPV6 connection with linux pppd.

Then I set the ofono context protocol to "dual", removed the check on the
protocol in at_gprs_activate_primary(), and set +CGDCONT with "IPV4V6"
which works for my modem.

Result is that the modem successfuly get an IPV6 address because I can
query it from another AT channel, but ofono does not retrieve any IPV6
parameters:

[ /le910na1_0/context1 ]
        Username =3D
        AccessPointName =3D
        Settings =3D {
                    Interface =3D ppp0
                    Method =3D static
                    DomainNameServers =3D 172.22.1.201,  0.0.0.0,
                    Address =3D 172.22.1.101
                    Netmask =3D 255.255.255.255 }
        AuthenticationMethod =3D chap
        Password =3D
        Protocol =3D dual
        Type =3D internet
        Active =3D 1
        IPv6.Settings =3D {
                    Interface =3D ppp0 }
        Name =3D Internet

The consequence is that the ppp0 interface only has an IPV4 address.
I also tried with IPV6 only but same result.
Any hints?

Enrico

--===============1200558948580408605==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SGkgYWxsLDwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2Rl
ZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPjxicj48L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5z
LXNlcmlmIj5JJiMzOTttIHN0aWxsIHRyeWluZyB0byBtYWtlIElQVjYgd29yay48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNl
cmlmIj5GaXJzdCwgSSBlbnN1cmVkIHRoYXQgbXkgbW9kZW0gYW5kIG5ldHdvcmsgc3VwcG9ydCBJ
UFY2IG1ha2luZyBhIHN1Y2Nlc3NmdWwgSVBWNiBjb25uZWN0aW9uIHdpdGggbGludXggcHBwZC48
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFu
YSxzYW5zLXNlcmlmIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9
ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+VGhlbiBJIHNldCB0aGUgb2Zvbm8gY29u
dGV4dCBwcm90b2NvbCB0byAmcXVvdDtkdWFsJnF1b3Q7LCByZW1vdmVkIHRoZSBjaGVjayBvbiB0
aGUgcHJvdG9jb2wgaW4gYXRfZ3Byc19hY3RpdmF0ZV9wcmltYXJ5KCksIGFuZCBzZXQgK0NHRENP
TlQgd2l0aCAmcXVvdDtJUFY0VjYmcXVvdDsgd2hpY2ggd29ya3MgZm9yIG15IG1vZGVtLjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNh
bnMtc2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9u
dC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5SZXN1bHQgaXMgdGhhdCB0aGUgbW9kZW0gc3Vj
Y2Vzc2Z1bHkgZ2V0IGFuIElQVjYgYWRkcmVzcyBiZWNhdXNlIEkgY2FuIHF1ZXJ5IGl0IGZyb20g
YW5vdGhlciBBVCBjaGFubmVsLCBidXQgb2Zvbm8gZG9lcyBub3QgcmV0cmlldmUgYW55IElQVjYg
cGFyYW1ldGVyczo8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1m
YW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVm
YXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+WyAvbGU5MTBuYTFf
MC9jb250ZXh0MSBdPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQt
ZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgVXNlcm5hbWUgPcKgPC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fu
cy1zZXJpZiI+wqAgwqAgwqAgwqAgQWNjZXNzUG9pbnROYW1lID3CoDwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPsKg
IMKgIMKgIMKgIFNldHRpbmdzID0gezwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0
eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIEludGVyZmFjZSA9IHBwcDA8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0
IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBNZXRob2QgPSBzdGF0aWM8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZh
dWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBEb21haW5OYW1lU2VydmVycyA9IDE3Mi4yMi4xLjIwMSwgwqAwLjAu
MC4wLCDCoDwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWls
eTp2ZXJkYW5hLHNhbnMtc2VyaWYiPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEFkZHJl
c3MgPSAxNzIuMjIuMS4xMDE8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0i
Zm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBOZXRtYXNrID0gMjU1LjI1NS4yNTUuMjU1IH08L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9k
ZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj7CoCDCoCDCoCDC
oCBBdXRoZW50aWNhdGlvbk1ldGhvZCA9IGNoYXA8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZh
dWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCBQ
YXNzd29yZCA9wqA8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1m
YW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCBQcm90b2NvbCA9IGR1YWw8L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxz
YW5zLXNlcmlmIj7CoCDCoCDCoCDCoCBUeXBlID0gaW50ZXJuZXQ8L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj7CoCDC
oCDCoCDCoCBBY3RpdmUgPSAxPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9
ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgSVB2Ni5TZXR0aW5n
cyA9IHs8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6
dmVyZGFuYSxzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJbnRlcmZh
Y2UgPSBwcHAwIH08L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1m
YW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCBOYW1lID0gSW50ZXJuZXQ8L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxz
YW5zLXNlcmlmIj7CoDwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250
LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPlRoZSBjb25zZXF1ZW5jZSBpcyB0aGF0IHRoZSBw
cHAwIGludGVyZmFjZSBvbmx5IGhhcyBhbiBJUFY0IGFkZHJlc3MuPC9kaXY+PGRpdiBjbGFzcz0i
Z21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SSBh
bHNvIHRyaWVkIHdpdGggSVBWNiBvbmx5IGJ1dCBzYW1lIHJlc3VsdC48L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5B
bnkgaGludHM/PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxiciBjbGVhcj0iYWxsIj48
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2
IGRpcj0ibHRyIj48ZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi44cHgiPkVucmlj
bzwvc3Bhbj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48
L2Rpdj4K

--===============1200558948580408605==--

