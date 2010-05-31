Content-Type: multipart/mixed; boundary="===============1407204264358453338=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: E63 as generic At Modem?
Date: Mon, 31 May 2010 16:02:25 +0300
Message-ID: <AANLkTil3WFmjih1wB_Oqbfl-8v1Ndw2LX6xaFCB8U3ap@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1407204264358453338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello All,

I am running the latest ofono in my ubuntu 9.10, under virtual box.

I have connected my E63 through USB and I can see that the isimodem up and
working.
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------

root(a)arun-laptop:/home/arun/ofono_repository/ofono/test# ./list-modems
[ /isimodem0 ]
    Powered =3D 1
    Interfaces =3D org.ofono.RadioSettings org.ofono.SupplementaryServices
org.ofono.NetworkRegistration org.ofono.Phonebook org.ofono.SmsManager
org.ofono.SimManager org.ofono.VoiceCallManager
    Model =3D Nokia E63
    Manufacturer =3D Nokia
    Serial =3D 356836020xxxxxx
    Revision =3D V ICPR71_08w44.1
30-10-08
RM-437
(c) Nokia
    [ org.ofono.RadioSettings ]
        TechnologyPreference =3D any
    [ org.ofono.SupplementaryServices ]
        State =3D idle
    [ org.ofono.NetworkRegistration ]
        Status =3D unknown
        Operators =3D
        Mode =3D auto
        Name =3D
    [ org.ofono.Phonebook ]
    [ org.ofono.SmsManager ]
        ServiceCenterAddress =3D +358405202000
    [ org.ofono.SimManager ]
        SubscriberNumbers =3D
        CardIdentifier =3D 89358010802064xxxxx
        LockedPins =3D
        PinRequired =3D none
        SubscriberIdentity =3D 2449154705xxxxx
        Present =3D 1
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 119 118 999 110 08 000 911 112
        MultipartyCalls =3D
        Calls =3D
---------------------------------------------------------------------------=
---------------------------------------------------------------

I tried to use E63 as a generic modem by adding the following to the
modem.conf
---------------------------------------------------------------------------=
------------------------------------------------------------
# Sample for using generic driver
[generic]
Driver=3Datgen
Device=3D/dev/ttyACM1
Baud=3D460800

This was done based on the wvdialconf output:
---------------------------------------------------------------------------=
-------------------------------------------------------------
 wvdialconf create
Editing `create'.

Scanning your serial ports for a modem.

ttyS0<*1>: ATQ0 V1 E1 -- failed with 2400 baud, next try: 9600 baud
ttyS0<*1>: ATQ0 V1 E1 -- failed with 9600 baud, next try: 115200 baud
ttyS0<*1>: ATQ0 V1 E1 -- and failed too at 115200, giving up.
Modem Port Scan<*1>: S1   S2   S3   ACM0
WvModem<*1>: Cannot get information for serial port.
ttyACM1<*1>: ATQ0 V1 E1 -- OK
ttyACM1<*1>: ATQ0 V1 E1 Z -- OK
ttyACM1<*1>: ATQ0 V1 E1 S0=3D0 -- OK
ttyACM1<*1>: ATQ0 V1 E1 S0=3D0 &C1 -- OK
ttyACM1<*1>: ATQ0 V1 E1 S0=3D0 &C1 &D2 -- OK
ttyACM1<*1>: ATQ0 V1 E1 S0=3D0 &C1 &D2 +FCLASS=3D0 -- OK
ttyACM1<*1>: Modem Identifier: ATI -- Nokia
ttyACM1<*1>: Speed 4800: AT -- OK
ttyACM1<*1>: Speed 9600: AT -- OK
ttyACM1<*1>: Speed 19200: AT -- OK
ttyACM1<*1>: Speed 38400: AT -- OK
ttyACM1<*1>: Speed 57600: AT -- OK
ttyACM1<*1>: Speed 115200: AT -- OK
ttyACM1<*1>: Speed 230400: AT -- OK
ttyACM1<*1>: Speed 460800: AT -- OK
ttyACM1<*1>: Max speed is 460800; that should be safe.
ttyACM1<*1>: ATQ0 V1 E1 S0=3D0 &C1 &D2 +FCLASS=3D0 -- OK

Found an USB modem on /dev/ttyACM1.
create<Warn>: Can't open 'create' for reading: No such file or directory
create<Warn>: ...starting with blank configuration.
Modem configuration written to create.
ttyACM1<Info>: Speed 460800; init "ATQ0 V1 E1 S0=3D0 &C1 &D2 +FCLASS=3D0"

---------------------------------------------------------------------------=
--------------------------------------------------------------
---------------------------------------------------------------------------=
----------------------------------------------------------------
and i can see that ofono has detected it properly.
---------------------------------------------------------------------------=
------------------------
[ /generic ]
    Interfaces =3D org.ofono.SimManager
    Powered =3D 1
    [ org.ofono.SimManager ]
        Present =3D 0
---------------------------------------------------------------------------=
------------------------



But i do not see any interfaces other than SimManager. I wanted to try using
E63 as a generic at modem and make calls. Could any one help me in
identifying what is going wrong
here and why the generic modem is not identifying other interfaces?

Also am i right in expecting this from E63? Can i use it as generic AT
modem?

Thanks in advance

Regards
Arun

--===============1407204264358453338==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGVsbG8gQWxsLDxicj48YnI+SSBhbSBydW5uaW5nIHRoZSBsYXRlc3Qgb2Zvbm8gaW4gbXkgdWJ1
bnR1IDkuMTAsIHVuZGVyIHZpcnR1YWwgYm94Ljxicj48YnI+SSBoYXZlIGNvbm5lY3RlZCBteSBF
NjMgdGhyb3VnaCBVU0IgYW5kIEkgY2FuIHNlZSB0aGF0IHRoZSBpc2ltb2RlbSB1cCBhbmQgd29y
a2luZy48YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxi
cj4KPGJyPnJvb3RAYXJ1bi1sYXB0b3A6L2hvbWUvYXJ1bi9vZm9ub19yZXBvc2l0b3J5L29mb25v
L3Rlc3QjIC4vbGlzdC1tb2RlbXMgPGJyPlsgL2lzaW1vZGVtMCBdPGJyPqCgoCBQb3dlcmVkID0g
MTxicj6goKAgSW50ZXJmYWNlcyA9IG9yZy5vZm9uby5SYWRpb1NldHRpbmdzIG9yZy5vZm9uby5T
dXBwbGVtZW50YXJ5U2VydmljZXMgb3JnLm9mb25vLk5ldHdvcmtSZWdpc3RyYXRpb24gb3JnLm9m
b25vLlBob25lYm9vayBvcmcub2Zvbm8uU21zTWFuYWdlciBvcmcub2Zvbm8uU2ltTWFuYWdlciBv
cmcub2Zvbm8uVm9pY2VDYWxsTWFuYWdlciA8YnI+CqCgoCBNb2RlbCA9IE5va2lhIEU2Mzxicj6g
oKAgTWFudWZhY3R1cmVyID0gTm9raWE8YnI+oKCgIFNlcmlhbCA9IDM1NjgzNjAyMHh4eHh4eDxi
cj6goKAgUmV2aXNpb24gPSBWIElDUFI3MV8wOHc0NC4xPGJyPjMwLTEwLTA4PGJyPlJNLTQzNzxi
cj4oYykgTm9raWE8YnI+oKCgIFsgb3JnLm9mb25vLlJhZGlvU2V0dGluZ3MgXTxicj6goKCgoKCg
IFRlY2hub2xvZ3lQcmVmZXJlbmNlID0gYW55PGJyPgqgoKAgWyBvcmcub2Zvbm8uU3VwcGxlbWVu
dGFyeVNlcnZpY2VzIF08YnI+oKCgoKCgoCBTdGF0ZSA9IGlkbGU8YnI+oKCgIFsgb3JnLm9mb25v
Lk5ldHdvcmtSZWdpc3RyYXRpb24gXTxicj6goKCgoKCgIFN0YXR1cyA9IHVua25vd248YnI+oKCg
oKCgoCBPcGVyYXRvcnMgPSA8YnI+oKCgoKCgoCBNb2RlID0gYXV0bzxicj6goKCgoKCgIE5hbWUg
PSA8YnI+oKCgIFsgb3JnLm9mb25vLlBob25lYm9vayBdPGJyPgqgoKAgWyBvcmcub2Zvbm8uU21z
TWFuYWdlciBdPGJyPqCgoKCgoKAgU2VydmljZUNlbnRlckFkZHJlc3MgPSArMzU4NDA1MjAyMDAw
PGJyPqCgoCBbIG9yZy5vZm9uby5TaW1NYW5hZ2VyIF08YnI+oKCgoKCgoCBTdWJzY3JpYmVyTnVt
YmVycyA9IDxicj6goKCgoKCgIENhcmRJZGVudGlmaWVyID0gODkzNTgwMTA4MDIwNjR4eHh4eDxi
cj6goKCgoKCgIExvY2tlZFBpbnMgPSA8YnI+oKCgoKCgoCBQaW5SZXF1aXJlZCA9IG5vbmU8YnI+
CqCgoKCgoKAgU3Vic2NyaWJlcklkZW50aXR5ID0gMjQ0OTE1NDcwNXh4eHh4PGJyPqCgoKCgoKAg
UHJlc2VudCA9IDE8YnI+oKCgIFsgb3JnLm9mb25vLlZvaWNlQ2FsbE1hbmFnZXIgXTxicj6goKCg
oKCgIEVtZXJnZW5jeU51bWJlcnMgPSAxMTkgMTE4IDk5OSAxMTAgMDggMDAwIDkxMSAxMTIgPGJy
PqCgoKCgoKAgTXVsdGlwYXJ0eUNhbGxzID0gPGJyPqCgoKCgoKAgQ2FsbHMgPSA8YnI+Ci0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLTxicj48YnI+SSB0cmllZCB0byB1c2UgRTYzIGFzIGEgZ2VuZXJp
YyBtb2RlbSBieSBhZGRpbmcgdGhlIGZvbGxvd2luZyB0byB0aGUgbW9kZW0uY29uZjxicj4KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tPGJyPiMgU2FtcGxlIGZvciB1c2luZyBnZW5lcmljIGRyaXZlcjxi
cj5bZ2VuZXJpY108YnI+RHJpdmVyPWF0Z2VuPGJyPkRldmljZT0vZGV2L3R0eUFDTTE8YnI+CkJh
dWQ9NDYwODAwPGJyPjxicj5UaGlzIHdhcyBkb25lIGJhc2VkIG9uIHRoZSB3dmRpYWxjb25mIG91
dHB1dDo8YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj6gd3ZkaWFsY29uZiBjcmVhdGU8YnI+
CkVkaXRpbmcgYGNyZWF0ZSYjMzk7Ljxicj48YnI+U2Nhbm5pbmcgeW91ciBzZXJpYWwgcG9ydHMg
Zm9yIGEgbW9kZW0uPGJyPjxicj50dHlTMCZsdDsqMSZndDs6IEFUUTAgVjEgRTEgLS0gZmFpbGVk
IHdpdGggMjQwMCBiYXVkLCBuZXh0IHRyeTogOTYwMCBiYXVkPGJyPnR0eVMwJmx0OyoxJmd0Ozog
QVRRMCBWMSBFMSAtLSBmYWlsZWQgd2l0aCA5NjAwIGJhdWQsIG5leHQgdHJ5OiAxMTUyMDAgYmF1
ZDxicj4KdHR5UzAmbHQ7KjEmZ3Q7OiBBVFEwIFYxIEUxIC0tIGFuZCBmYWlsZWQgdG9vIGF0IDEx
NTIwMCwgZ2l2aW5nIHVwLjxicj5Nb2RlbSBQb3J0IFNjYW4mbHQ7KjEmZ3Q7OiBTMaCgIFMyoKAg
UzOgoCBBQ00wIDxicj5Xdk1vZGVtJmx0OyoxJmd0OzogQ2Fubm90IGdldCBpbmZvcm1hdGlvbiBm
b3Igc2VyaWFsIHBvcnQuPGJyPnR0eUFDTTEmbHQ7KjEmZ3Q7OiBBVFEwIFYxIEUxIC0tIE9LPGJy
Pgp0dHlBQ00xJmx0OyoxJmd0OzogQVRRMCBWMSBFMSBaIC0tIE9LPGJyPnR0eUFDTTEmbHQ7KjEm
Z3Q7OiBBVFEwIFYxIEUxIFMwPTAgLS0gT0s8YnI+dHR5QUNNMSZsdDsqMSZndDs6IEFUUTAgVjEg
RTEgUzA9MCAmYW1wO0MxIC0tIE9LPGJyPnR0eUFDTTEmbHQ7KjEmZ3Q7OiBBVFEwIFYxIEUxIFMw
PTAgJmFtcDtDMSAmYW1wO0QyIC0tIE9LPGJyPnR0eUFDTTEmbHQ7KjEmZ3Q7OiBBVFEwIFYxIEUx
IFMwPTAgJmFtcDtDMSAmYW1wO0QyICtGQ0xBU1M9MCAtLSBPSzxicj4KdHR5QUNNMSZsdDsqMSZn
dDs6IE1vZGVtIElkZW50aWZpZXI6IEFUSSAtLSBOb2tpYTxicj50dHlBQ00xJmx0OyoxJmd0Ozog
U3BlZWQgNDgwMDogQVQgLS0gT0s8YnI+dHR5QUNNMSZsdDsqMSZndDs6IFNwZWVkIDk2MDA6IEFU
IC0tIE9LPGJyPnR0eUFDTTEmbHQ7KjEmZ3Q7OiBTcGVlZCAxOTIwMDogQVQgLS0gT0s8YnI+dHR5
QUNNMSZsdDsqMSZndDs6IFNwZWVkIDM4NDAwOiBBVCAtLSBPSzxicj4KdHR5QUNNMSZsdDsqMSZn
dDs6IFNwZWVkIDU3NjAwOiBBVCAtLSBPSzxicj50dHlBQ00xJmx0OyoxJmd0OzogU3BlZWQgMTE1
MjAwOiBBVCAtLSBPSzxicj50dHlBQ00xJmx0OyoxJmd0OzogU3BlZWQgMjMwNDAwOiBBVCAtLSBP
Szxicj50dHlBQ00xJmx0OyoxJmd0OzogU3BlZWQgNDYwODAwOiBBVCAtLSBPSzxicj50dHlBQ00x
Jmx0OyoxJmd0OzogTWF4IHNwZWVkIGlzIDQ2MDgwMDsgdGhhdCBzaG91bGQgYmUgc2FmZS48YnI+
CnR0eUFDTTEmbHQ7KjEmZ3Q7OiBBVFEwIFYxIEUxIFMwPTAgJmFtcDtDMSAmYW1wO0QyICtGQ0xB
U1M9MCAtLSBPSzxicj48YnI+Rm91bmQgYW4gVVNCIG1vZGVtIG9uIC9kZXYvdHR5QUNNMS48YnI+
Y3JlYXRlJmx0O1dhcm4mZ3Q7OiBDYW4mIzM5O3Qgb3BlbiAmIzM5O2NyZWF0ZSYjMzk7IGZvciBy
ZWFkaW5nOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5PGJyPmNyZWF0ZSZsdDtXYXJuJmd0Ozog
Li4uc3RhcnRpbmcgd2l0aCBibGFuayBjb25maWd1cmF0aW9uLjxicj4KTW9kZW0gY29uZmlndXJh
dGlvbiB3cml0dGVuIHRvIGNyZWF0ZS48YnI+dHR5QUNNMSZsdDtJbmZvJmd0OzogU3BlZWQgNDYw
ODAwOyBpbml0ICZxdW90O0FUUTAgVjEgRTEgUzA9MCAmYW1wO0MxICZhbXA7RDIgK0ZDTEFTUz0w
JnF1b3Q7PGJyPjxicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLTxicj5hbmQgaSBjYW4gc2VlIHRoYXQgb2Zvbm8gaGFzIGRldGVjdGVkIGl0IHBy
b3Blcmx5Ljxicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+
ClsgL2dlbmVyaWMgXTxicj6goKAgSW50ZXJmYWNlcyA9IG9yZy5vZm9uby5TaW1NYW5hZ2VyIDxi
cj6goKAgUG93ZXJlZCA9IDE8YnI+oKCgIFsgb3JnLm9mb25vLlNpbU1hbmFnZXIgXTxicj6goKCg
oKCgIFByZXNlbnQgPSAwPGJyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLTxicj4KPGJyPjxicj48YnI+QnV0IGkgZG8gbm90IHNlZSBhbnkgaW50ZXJmYWNlcyBvdGhl
ciB0aGFuIFNpbU1hbmFnZXIuIEkgd2FudGVkIHRvIHRyeSB1c2luZyBFNjMgYXMgYSBnZW5lcmlj
IGF0IG1vZGVtIGFuZCBtYWtlIGNhbGxzLiBDb3VsZCBhbnkgb25lIGhlbHAgbWUgaW4gaWRlbnRp
Znlpbmcgd2hhdCBpcyBnb2luZyB3cm9uZzxicj5oZXJlIGFuZCB3aHkgdGhlIGdlbmVyaWMgbW9k
ZW0gaXMgbm90IGlkZW50aWZ5aW5nIG90aGVyIGludGVyZmFjZXM/PGJyPgo8YnI+QWxzbyBhbSBp
IHJpZ2h0IGluIGV4cGVjdGluZyB0aGlzIGZyb20gRTYzPyBDYW4gaSB1c2UgaXQgYXMgZ2VuZXJp
YyBBVCBtb2RlbT88YnI+PGJyPlRoYW5rcyBpbiBhZHZhbmNlPGJyPjxicj5SZWdhcmRzPGJyPkFy
dW48YnI+PGJyPgo=

--===============1407204264358453338==--

