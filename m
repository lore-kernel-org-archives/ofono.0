Content-Type: multipart/mixed; boundary="===============5436200251657563891=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: automatically retrieve the apn for a network
Date: Tue, 10 Dec 2019 13:33:04 +0000
Message-ID: <CABPh3UOpewhbDuU3W6FoKiETJ7HJ24e_=mi9an-cTNCYShPSMw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5436200251657563891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
I'm a newbie of ofono and I'm having some issue connecting with
connman/ofono.

There's a way to retrieve the apn for a specific network and automatically
create a context?
I tried to use the mbpi plugins but a lot of network have duplicates in the
apn list.

There's also a property in modem properties
  [ org.ofono.AllowedAccessPoints ]

but is empty

what's the smart way to retrieve the APN for a given network programmaticly?

Thanks
Nicola Lunghi


/list-modems
[ /telit_0 ]
    Online =3D 1
    Powered =3D 1
    Lockdown =3D 0
    Emergency =3D 0
    Manufacturer =3D Telit
    Model =3D HE910-D
    Revision =3D 12.00.024
    Serial =3D 351579054636509
    SystemPath =3D /sys/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.1/1-2.=
1.3
    Interfaces =3D org.ofono.SmartMessaging org.ofono.PushNotification
org.ofono.MessageManager org.ofono.Phonebook org.ofono.NetworkRegistration
org.ofono.ConnectionManager org.ofono.AllowedAccessPoints
org.ofono.SimManager
    Features =3D sms net gprs sim
    Type =3D hardware
    [ org.ofono.SmartMessaging ]
    [ org.ofono.PushNotification ]
    [ org.ofono.MessageManager ]
        ServiceCenterAddress =3D +353857000000
        UseDeliveryReports =3D 0
        Bearer =3D cs-preferred
        Alphabet =3D default
    [ org.ofono.Phonebook ]
    [ org.ofono.NetworkRegistration ]
        Status =3D denied
        Mode =3D auto
        Name =3D
    [ org.ofono.ConnectionManager ]
        Attached =3D 0
        Bearer =3D hsdpa
        RoamingAllowed =3D 0
        Powered =3D 1
    [ org.ofono.AllowedAccessPoints ]
    [ org.ofono.SimManager ]
        Present =3D 1
        CardIdentifier =3D 8935303052299844310
        SubscriberIdentity =3D 272032040423839
        ServiceProviderName =3D eir
        FixedDialing =3D 0
        BarredDialing =3D 0
        MobileCountryCode =3D 272
        MobileNetworkCode =3D 03
        SubscriberNumbers =3D +353858016215
        LockedPins =3D
        ServiceNumbers =3D [Call Wait Off] =3D '#43#' [Call Wait On] =3D '*=
43#'
[Voice Mail 171] =3D '171' [Last Call Info] =3D '*#101#' [Nat Direct Enq] =
=3D
'11811' [Int Direct Enq] =3D '11818' [Customer Care] =3D '1921' [Int Cust C=
are]
=3D '+35317011450' [Int Voice Mail] =3D '+353855'
        PinRequired =3D none
        Retries =3D [pin =3D 3] [pin2 =3D 3] [puk =3D 10] [puk2 =3D 10]
        CardSlotCount =3D 1
        ActiveCardSlot =3D 1

--===============5436200251657563891==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSw8L2Rpdj48ZGl2PkkmIzM5O20gYSBuZXdiaWUgb2Ygb2Zv
bm8gYW5kIEkmIzM5O20gaGF2aW5nIHNvbWUgaXNzdWUgY29ubmVjdGluZyB3aXRoIGNvbm5tYW4v
b2Zvbm8uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGVyZSYjMzk7cyBhIHdheSB0byByZXRy
aWV2ZSB0aGUgYXBuIGZvciBhIHNwZWNpZmljIG5ldHdvcmsgYW5kIGF1dG9tYXRpY2FsbHkgY3Jl
YXRlIGEgY29udGV4dD88YnI+PC9kaXY+PGRpdj48L2Rpdj48ZGl2PkkgdHJpZWQgdG8gdXNlIHRo
ZSBtYnBpIHBsdWdpbnMgYnV0IGEgbG90IG9mIG5ldHdvcmsgaGF2ZSBkdXBsaWNhdGVzIGluIHRo
ZSBhcG4gbGlzdC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZXJlJiMzOTtzIGFsc28gYSBw
cm9wZXJ0eSBpbiBtb2RlbSBwcm9wZXJ0aWVzPGJyPjwvZGl2PjxkaXY+IMKgIFsgb3JnLm9mb25v
LkFsbG93ZWRBY2Nlc3NQb2ludHMgXTxicj7CoDwvZGl2PjxkaXY+YnV0IGlzIGVtcHR5PGJyPjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+d2hhdCYjMzk7cyB0aGUgc21hcnQgd2F5IHRvIHJldHJp
ZXZlIHRoZSBBUE4gZm9yIGEgZ2l2ZW4gbmV0d29yayBwcm9ncmFtbWF0aWNseT88L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PlRoYW5rczwvZGl2PjxkaXY+Tmljb2xhIEx1bmdoaTwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+L2xpc3QtbW9kZW1zIDxicj5bIC90ZWxpdF8w
IF08YnI+wqAgwqAgT25saW5lID0gMTxicj7CoCDCoCBQb3dlcmVkID0gMTxicj7CoCDCoCBMb2Nr
ZG93biA9IDA8YnI+wqAgwqAgRW1lcmdlbmN5ID0gMDxicj7CoCDCoCBNYW51ZmFjdHVyZXIgPSBU
ZWxpdDxicj7CoCDCoCBNb2RlbCA9IEhFOTEwLUQ8YnI+wqAgwqAgUmV2aXNpb24gPSAxMi4wMC4w
MjQ8YnI+wqAgwqAgU2VyaWFsID0gMzUxNTc5MDU0NjM2NTA5PGJyPsKgIMKgIFN5c3RlbVBhdGgg
PSAvc3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjE0LjAvdXNiMS8xLTIvMS0yLjEvMS0y
LjEuMzxicj7CoCDCoCBJbnRlcmZhY2VzID0gb3JnLm9mb25vLlNtYXJ0TWVzc2FnaW5nIG9yZy5v
Zm9uby5QdXNoTm90aWZpY2F0aW9uIG9yZy5vZm9uby5NZXNzYWdlTWFuYWdlciBvcmcub2Zvbm8u
UGhvbmVib29rIG9yZy5vZm9uby5OZXR3b3JrUmVnaXN0cmF0aW9uIG9yZy5vZm9uby5Db25uZWN0
aW9uTWFuYWdlciBvcmcub2Zvbm8uQWxsb3dlZEFjY2Vzc1BvaW50cyBvcmcub2Zvbm8uU2ltTWFu
YWdlciA8YnI+wqAgwqAgRmVhdHVyZXMgPSBzbXMgbmV0IGdwcnMgc2ltIDxicj7CoCDCoCBUeXBl
ID0gaGFyZHdhcmU8YnI+wqAgwqAgWyBvcmcub2Zvbm8uU21hcnRNZXNzYWdpbmcgXTxicj7CoCDC
oCBbIG9yZy5vZm9uby5QdXNoTm90aWZpY2F0aW9uIF08YnI+wqAgwqAgWyBvcmcub2Zvbm8uTWVz
c2FnZU1hbmFnZXIgXTxicj7CoCDCoCDCoCDCoCBTZXJ2aWNlQ2VudGVyQWRkcmVzcyA9ICszNTM4
NTcwMDAwMDA8YnI+wqAgwqAgwqAgwqAgVXNlRGVsaXZlcnlSZXBvcnRzID0gMDxicj7CoCDCoCDC
oCDCoCBCZWFyZXIgPSBjcy1wcmVmZXJyZWQ8YnI+wqAgwqAgwqAgwqAgQWxwaGFiZXQgPSBkZWZh
dWx0PGJyPsKgIMKgIFsgb3JnLm9mb25vLlBob25lYm9vayBdPGJyPsKgIMKgIFsgb3JnLm9mb25v
Lk5ldHdvcmtSZWdpc3RyYXRpb24gXTxicj7CoCDCoCDCoCDCoCBTdGF0dXMgPSBkZW5pZWQ8YnI+
wqAgwqAgwqAgwqAgTW9kZSA9IGF1dG88YnI+wqAgwqAgwqAgwqAgTmFtZSA9IDxicj7CoCDCoCBb
IG9yZy5vZm9uby5Db25uZWN0aW9uTWFuYWdlciBdPGJyPsKgIMKgIMKgIMKgIEF0dGFjaGVkID0g
MDxicj7CoCDCoCDCoCDCoCBCZWFyZXIgPSBoc2RwYTxicj7CoCDCoCDCoCDCoCBSb2FtaW5nQWxs
b3dlZCA9IDA8YnI+wqAgwqAgwqAgwqAgUG93ZXJlZCA9IDE8YnI+wqAgwqAgWyBvcmcub2Zvbm8u
QWxsb3dlZEFjY2Vzc1BvaW50cyBdPGJyPsKgIMKgIFsgb3JnLm9mb25vLlNpbU1hbmFnZXIgXTxi
cj7CoCDCoCDCoCDCoCBQcmVzZW50ID0gMTxicj7CoCDCoCDCoCDCoCBDYXJkSWRlbnRpZmllciA9
IDg5MzUzMDMwNTIyOTk4NDQzMTA8YnI+wqAgwqAgwqAgwqAgU3Vic2NyaWJlcklkZW50aXR5ID0g
MjcyMDMyMDQwNDIzODM5PGJyPsKgIMKgIMKgIMKgIFNlcnZpY2VQcm92aWRlck5hbWUgPSBlaXI8
YnI+wqAgwqAgwqAgwqAgRml4ZWREaWFsaW5nID0gMDxicj7CoCDCoCDCoCDCoCBCYXJyZWREaWFs
aW5nID0gMDxicj7CoCDCoCDCoCDCoCBNb2JpbGVDb3VudHJ5Q29kZSA9IDI3Mjxicj7CoCDCoCDC
oCDCoCBNb2JpbGVOZXR3b3JrQ29kZSA9IDAzPGJyPsKgIMKgIMKgIMKgIFN1YnNjcmliZXJOdW1i
ZXJzID0gKzM1Mzg1ODAxNjIxNSA8YnI+wqAgwqAgwqAgwqAgTG9ja2VkUGlucyA9IDxicj7CoCDC
oCDCoCDCoCBTZXJ2aWNlTnVtYmVycyA9IFtDYWxsIFdhaXQgT2ZmXSA9ICYjMzk7IzQzIyYjMzk7
IFtDYWxsIFdhaXQgT25dID0gJiMzOTsqNDMjJiMzOTsgW1ZvaWNlIE1haWwgMTcxXSA9ICYjMzk7
MTcxJiMzOTsgW0xhc3QgQ2FsbCBJbmZvXSA9ICYjMzk7KiMxMDEjJiMzOTsgW05hdCBEaXJlY3Qg
RW5xXSA9ICYjMzk7MTE4MTEmIzM5OyBbSW50IERpcmVjdCBFbnFdID0gJiMzOTsxMTgxOCYjMzk7
IFtDdXN0b21lciBDYXJlXSA9ICYjMzk7MTkyMSYjMzk7IFtJbnQgQ3VzdCBDYXJlXSA9ICYjMzk7
KzM1MzE3MDExNDUwJiMzOTsgW0ludCBWb2ljZSBNYWlsXSA9ICYjMzk7KzM1Mzg1NSYjMzk7IDxi
cj7CoCDCoCDCoCDCoCBQaW5SZXF1aXJlZCA9IG5vbmU8YnI+wqAgwqAgwqAgwqAgUmV0cmllcyA9
IFtwaW4gPSAzXSBbcGluMiA9IDNdIFtwdWsgPSAxMF0gW3B1azIgPSAxMF0gPGJyPsKgIMKgIMKg
IMKgIENhcmRTbG90Q291bnQgPSAxPGJyPsKgIMKgIMKgIMKgIEFjdGl2ZUNhcmRTbG90ID0gMTxi
cj48L2Rpdj48L2Rpdj4K

--===============5436200251657563891==--

