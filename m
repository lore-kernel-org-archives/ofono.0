Content-Type: multipart/mixed; boundary="===============6539398788614903984=="
MIME-Version: 1.0
From: Fabio <fabio.tosetti@gmail.com>
Subject: u-blox modem plugin: missing VoiceCallManager and MessageManager
 interfaces
Date: Fri, 04 Sep 2015 16:06:09 +0000
Message-ID: <CAJvjxsx8NcVpt0bYt2m-=5M0p1irHfLcK6WKLA=hJbRLbruSDQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6539398788614903984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,
I'm using the u-blox driver with a LISA-U200 modem: the modem is correctly
detected, registers to the network, connects to vodafone apn and browse
Internet.
My problem is that the VoiceCallManager and MessageManager interfaces are
not exposed, and I need to send sms and make calls.

$ ./list-modems
[ /ublox_0 ]
    Features =3D net gprs sim
    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.NetworkRegistration org.ofono.ConnectionManager
org.ofono.SimManager
    Online =3D 1
    Model =3D LISA-U200
    Revision =3D 22.40
    Type =3D hardware
    Serial =3D 358901046388192
    Manufacturer =3D u-blox
    [ org.ofono.NetworkRegistration ]
        Status =3D registered
        Strength =3D 20
        Name =3D vodafone IT
        LocationAreaCode =3D 36031
        Mode =3D auto
        MobileCountryCode =3D 222
        Technology =3D hspa
        CellId =3D 10735182
        MobileNetworkCode =3D 10
    [ org.ofono.ConnectionManager ]
        Powered =3D 1
        Attached =3D 1
        Bearer =3D hspa
        Suspended =3D 0
        RoamingAllowed =3D 1
    [ org.ofono.SimManager ]
        Retries =3D [pin2 =3D 3] [puk2 =3D 10] [pin =3D 3] [puk =3D 10]
        MobileCountryCode =3D 222
        FixedDialing =3D 0
        SubscriberNumbers =3D
        PreferredLanguages =3D it en de fr sv
        BarredDialing =3D 0
        CardIdentifier =3D 8939103100003792186
        LockedPins =3D
        MobileNetworkCode =3D 10
        SubscriberIdentity =3D 222107602654388
        Present =3D 1
        PinRequired =3D none

I know that the driver was implemented for a SARA-U270 modem.

Can someone help me?

Thanks in advance,
FabioT

--===============6539398788614903984==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGVsbG8sPGRpdj5JJiMzOTttIHVzaW5nIHRoZSB1LWJsb3ggZHJpdmVy
IHdpdGggYSBMSVNBLVUyMDAgbW9kZW06IHRoZSBtb2RlbSBpcyBjb3JyZWN0bHkgZGV0ZWN0ZWQs
IHJlZ2lzdGVycyB0byB0aGUgbmV0d29yaywgY29ubmVjdHMgdG8gdm9kYWZvbmUgYXBuIGFuZCBi
cm93c2UgSW50ZXJuZXQuPC9kaXY+PGRpdj5NeSBwcm9ibGVtIGlzIHRoYXQgdGhlIFZvaWNlQ2Fs
bE1hbmFnZXIgYW5kIE1lc3NhZ2VNYW5hZ2VyIGludGVyZmFjZXMgYXJlIG5vdCBleHBvc2VkLCBh
bmQgSSBuZWVkIHRvIHNlbmQgc21zIGFuZCBtYWtlIGNhbGxzLjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+JCAuL2xpc3QtbW9kZW1zPC9kaXY+PGRpdj48ZGl2PlsgL3VibG94XzAgXTwvZGl2Pjxk
aXY+wqAgwqAgRmVhdHVyZXMgPSBuZXQgZ3BycyBzaW08L2Rpdj48ZGl2PsKgIMKgIEVtZXJnZW5j
eSA9IDA8L2Rpdj48ZGl2PsKgIMKgIFBvd2VyZWQgPSAxPC9kaXY+PGRpdj7CoCDCoCBMb2NrZG93
biA9IDA8L2Rpdj48ZGl2PsKgIMKgIEludGVyZmFjZXMgPSBvcmcub2Zvbm8uTmV0d29ya1JlZ2lz
dHJhdGlvbiBvcmcub2Zvbm8uQ29ubmVjdGlvbk1hbmFnZXIgb3JnLm9mb25vLlNpbU1hbmFnZXI8
L2Rpdj48ZGl2PsKgIMKgIE9ubGluZSA9IDE8L2Rpdj48ZGl2PsKgIMKgIE1vZGVsID0gTElTQS1V
MjAwPC9kaXY+PGRpdj7CoCDCoCBSZXZpc2lvbiA9IDIyLjQwPC9kaXY+PGRpdj7CoCDCoCBUeXBl
ID0gaGFyZHdhcmU8L2Rpdj48ZGl2PsKgIMKgIFNlcmlhbCA9IDM1ODkwMTA0NjM4ODE5MjwvZGl2
PjxkaXY+wqAgwqAgTWFudWZhY3R1cmVyID0gdS1ibG94PC9kaXY+PGRpdj7CoCDCoCBbIG9yZy5v
Zm9uby5OZXR3b3JrUmVnaXN0cmF0aW9uIF08L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFN0YXR1cyA9
IHJlZ2lzdGVyZWQ8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFN0cmVuZ3RoID0gMjA8L2Rpdj48ZGl2
PsKgIMKgIMKgIMKgIE5hbWUgPSB2b2RhZm9uZSBJVDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgTG9j
YXRpb25BcmVhQ29kZSA9IDM2MDMxPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBNb2RlID0gYXV0bzwv
ZGl2PjxkaXY+wqAgwqAgwqAgwqAgTW9iaWxlQ291bnRyeUNvZGUgPSAyMjI8L2Rpdj48ZGl2PsKg
IMKgIMKgIMKgIFRlY2hub2xvZ3kgPSBoc3BhPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBDZWxsSWQg
PSAxMDczNTE4MjwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgTW9iaWxlTmV0d29ya0NvZGUgPSAxMDwv
ZGl2PjxkaXY+wqAgwqAgWyBvcmcub2Zvbm8uQ29ubmVjdGlvbk1hbmFnZXIgXTwvZGl2PjxkaXY+
wqAgwqAgwqAgwqAgUG93ZXJlZCA9IDE8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIEF0dGFjaGVkID0g
MTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgQmVhcmVyID0gaHNwYTwvZGl2PjxkaXY+wqAgwqAgwqAg
wqAgU3VzcGVuZGVkID0gMDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgUm9hbWluZ0FsbG93ZWQgPSAx
PC9kaXY+PGRpdj7CoCDCoCBbIG9yZy5vZm9uby5TaW1NYW5hZ2VyIF08L2Rpdj48ZGl2PsKgIMKg
IMKgIMKgIFJldHJpZXMgPSBbcGluMiA9IDNdIFtwdWsyID0gMTBdIFtwaW4gPSAzXSBbcHVrID0g
MTBdPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBNb2JpbGVDb3VudHJ5Q29kZSA9IDIyMjwvZGl2Pjxk
aXY+wqAgwqAgwqAgwqAgRml4ZWREaWFsaW5nID0gMDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgU3Vi
c2NyaWJlck51bWJlcnMgPTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgUHJlZmVycmVkTGFuZ3VhZ2Vz
ID0gaXQgZW4gZGUgZnIgc3Y8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIEJhcnJlZERpYWxpbmcgPSAw
PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBDYXJkSWRlbnRpZmllciA9IDg5MzkxMDMxMDAwMDM3OTIx
ODY8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIExvY2tlZFBpbnMgPTwvZGl2PjxkaXY+wqAgwqAgwqAg
wqAgTW9iaWxlTmV0d29ya0NvZGUgPSAxMDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgU3Vic2NyaWJl
cklkZW50aXR5ID0gMjIyMTA3NjAyNjU0Mzg4PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBQcmVzZW50
ID0gMTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgUGluUmVxdWlyZWQgPSBub25lPC9kaXY+PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5JIGtub3cgdGhhdCB0aGUgZHJpdmVyIHdhcyBpbXBsZW1lbnRl
ZCBmb3IgYSBTQVJBLVUyNzAgbW9kZW0uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5DYW4gc29t
ZW9uZSBoZWxwIG1lPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzIGluIGFkdmFuY2Us
PC9kaXY+PGRpdj5GYWJpb1Q8L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj4K

--===============6539398788614903984==--

