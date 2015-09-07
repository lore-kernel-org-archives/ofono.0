Content-Type: multipart/mixed; boundary="===============5090809932396869531=="
MIME-Version: 1.0
From: Fabio <fabio.tosetti@gmail.com>
Subject: u-blox modem plugin: missing VoiceCallManager and MessageManager
 interfaces
Date: Mon, 07 Sep 2015 07:08:44 +0000
Message-ID: <CAJvjxsyYoj1BR73kYSpUPHXqZits9PF14N=E45smWFekFRab5A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5090809932396869531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,
I'm using the u-blox driver with a LISA-U200 modem: the modem is correctly
detected, registers to the network, connects to vodafone apn and browses
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

--===============5090809932396869531==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMy4ycHg7bGluZS1oZWlnaHQ6
MTkuOHB4Ij5IZWxsbyw8L3NwYW4+PGRpdiBzdHlsZT0iZm9udC1zaXplOjEzLjJweDtsaW5lLWhl
aWdodDoxOS44cHgiPkkmIzM5O20gdXNpbmcgdGhlIHUtYmxveCBkcml2ZXIgd2l0aCBhIExJU0Et
VTIwMCBtb2RlbTogdGhlIG1vZGVtIGlzIGNvcnJlY3RseSBkZXRlY3RlZCwgcmVnaXN0ZXJzIHRv
IHRoZSBuZXR3b3JrLCBjb25uZWN0cyB0byB2b2RhZm9uZSBhcG4gYW5kIGJyb3dzZXMgSW50ZXJu
ZXQuPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjEzLjJweDtsaW5lLWhlaWdodDoxOS44cHgi
Pk15IHByb2JsZW0gaXMgdGhhdCB0aGUgVm9pY2VDYWxsTWFuYWdlciBhbmQgTWVzc2FnZU1hbmFn
ZXIgaW50ZXJmYWNlcyBhcmUgbm90IGV4cG9zZWQsIGFuZCBJIG5lZWQgdG8gc2VuZCBzbXMgYW5k
IG1ha2UgY2FsbHMuPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjEzLjJweDtsaW5lLWhlaWdo
dDoxOS44cHgiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTMuMnB4O2xpbmUtaGVp
Z2h0OjE5LjhweCI+JCAuL2xpc3QtbW9kZW1zPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1zaXplOjEz
LjJweDtsaW5lLWhlaWdodDoxOS44cHgiPjxkaXY+WyAvdWJsb3hfMCBdPC9kaXY+PGRpdj7CoCDC
oCBGZWF0dXJlcyA9IG5ldCBncHJzIHNpbTwvZGl2PjxkaXY+wqAgwqAgRW1lcmdlbmN5ID0gMDwv
ZGl2PjxkaXY+wqAgwqAgUG93ZXJlZCA9IDE8L2Rpdj48ZGl2PsKgIMKgIExvY2tkb3duID0gMDwv
ZGl2PjxkaXY+wqAgwqAgSW50ZXJmYWNlcyA9IG9yZy5vZm9uby5OZXR3b3JrUmVnaXN0cmF0aW9u
IG9yZy5vZm9uby5Db25uZWN0aW9uTWFuYWdlciBvcmcub2Zvbm8uU2ltTWFuYWdlcjwvZGl2Pjxk
aXY+wqAgwqAgT25saW5lID0gMTwvZGl2PjxkaXY+wqAgwqAgTW9kZWwgPSBMSVNBLVUyMDA8L2Rp
dj48ZGl2PsKgIMKgIFJldmlzaW9uID0gMjIuNDA8L2Rpdj48ZGl2PsKgIMKgIFR5cGUgPSBoYXJk
d2FyZTwvZGl2PjxkaXY+wqAgwqAgU2VyaWFsID0gMzU4OTAxMDQ2Mzg4MTkyPC9kaXY+PGRpdj7C
oCDCoCBNYW51ZmFjdHVyZXIgPSB1LWJsb3g8L2Rpdj48ZGl2PsKgIMKgIFsgb3JnLm9mb25vLk5l
dHdvcmtSZWdpc3RyYXRpb24gXTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgU3RhdHVzID0gcmVnaXN0
ZXJlZDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgU3RyZW5ndGggPSAyMDwvZGl2PjxkaXY+wqAgwqAg
wqAgwqAgTmFtZSA9IHZvZGFmb25lIElUPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBMb2NhdGlvbkFy
ZWFDb2RlID0gMzYwMzE8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIE1vZGUgPSBhdXRvPC9kaXY+PGRp
dj7CoCDCoCDCoCDCoCBNb2JpbGVDb3VudHJ5Q29kZSA9IDIyMjwvZGl2PjxkaXY+wqAgwqAgwqAg
wqAgVGVjaG5vbG9neSA9IGhzcGE8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIENlbGxJZCA9IDEwNzM1
MTgyPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBNb2JpbGVOZXR3b3JrQ29kZSA9IDEwPC9kaXY+PGRp
dj7CoCDCoCBbIG9yZy5vZm9uby5Db25uZWN0aW9uTWFuYWdlciBdPC9kaXY+PGRpdj7CoCDCoCDC
oCDCoCBQb3dlcmVkID0gMTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgQXR0YWNoZWQgPSAxPC9kaXY+
PGRpdj7CoCDCoCDCoCDCoCBCZWFyZXIgPSBoc3BhPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBTdXNw
ZW5kZWQgPSAwPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBSb2FtaW5nQWxsb3dlZCA9IDE8L2Rpdj48
ZGl2PsKgIMKgIFsgb3JnLm9mb25vLlNpbU1hbmFnZXIgXTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAg
UmV0cmllcyA9IFtwaW4yID0gM10gW3B1azIgPSAxMF0gW3BpbiA9IDNdIFtwdWsgPSAxMF08L2Rp
dj48ZGl2PsKgIMKgIMKgIMKgIE1vYmlsZUNvdW50cnlDb2RlID0gMjIyPC9kaXY+PGRpdj7CoCDC
oCDCoCDCoCBGaXhlZERpYWxpbmcgPSAwPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBTdWJzY3JpYmVy
TnVtYmVycyA9PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBQcmVmZXJyZWRMYW5ndWFnZXMgPSBpdCBl
biBkZSBmciBzdjwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgQmFycmVkRGlhbGluZyA9IDA8L2Rpdj48
ZGl2PsKgIMKgIMKgIMKgIENhcmRJZGVudGlmaWVyID0gODkzOTEwMzEwMDAwMzc5MjE4NjwvZGl2
PjxkaXY+wqAgwqAgwqAgwqAgTG9ja2VkUGlucyA9PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBNb2Jp
bGVOZXR3b3JrQ29kZSA9IDEwPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBTdWJzY3JpYmVySWRlbnRp
dHkgPSAyMjIxMDc2MDI2NTQzODg8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFByZXNlbnQgPSAxPC9k
aXY+PGRpdj7CoCDCoCDCoCDCoCBQaW5SZXF1aXJlZCA9IG5vbmU8L2Rpdj48L2Rpdj48ZGl2IHN0
eWxlPSJmb250LXNpemU6MTMuMnB4O2xpbmUtaGVpZ2h0OjE5LjhweCI+PGJyPjwvZGl2PjxkaXYg
c3R5bGU9ImZvbnQtc2l6ZToxMy4ycHg7bGluZS1oZWlnaHQ6MTkuOHB4Ij5JIGtub3cgdGhhdCB0
aGUgZHJpdmVyIHdhcyBpbXBsZW1lbnRlZCBmb3IgYSBTQVJBLVUyNzAgbW9kZW0uPC9kaXY+PGRp
diBzdHlsZT0iZm9udC1zaXplOjEzLjJweDtsaW5lLWhlaWdodDoxOS44cHgiPjxicj48L2Rpdj48
ZGl2IHN0eWxlPSJmb250LXNpemU6MTMuMnB4O2xpbmUtaGVpZ2h0OjE5LjhweCI+Q2FuIHNvbWVv
bmUgaGVscCBtZT88L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTMuMnB4O2xpbmUtaGVpZ2h0
OjE5LjhweCI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxMy4ycHg7bGluZS1oZWln
aHQ6MTkuOHB4Ij5UaGFua3MgaW4gYWR2YW5jZSw8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6
MTMuMnB4O2xpbmUtaGVpZ2h0OjE5LjhweCI+RmFiaW9UPC9kaXY+PC9kaXY+Cg==

--===============5090809932396869531==--

