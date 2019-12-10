Content-Type: multipart/mixed; boundary="===============8074720491454706357=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: automatically retrieve the apn for a network
Date: Tue, 10 Dec 2019 18:35:37 +0000
Message-ID: <CABPh3UOH_3wctPiEOjQjZNYh46oXKNkwr3rz+U9vZdVSbcQwUQ@mail.gmail.com>
In-Reply-To: <CAKSBH7EX-S0tj1UYauLnPK__pvNUoktsRUCBdXDBcvfSznZwqw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8074720491454706357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

thanks for your email.
Is not possible either to get it from the SIM card itself?
I was reading this

https://stackoverflow.com/questions/9896079/is-apn-login-information-stored=
-on-sim-cards#answer-32880199

and also what about the org.ofono.AllowedAccessPoints property?

if I call the test command list-allowed-access-pints connman is trying to
get those from the sim I think

ofonod[30132]: Aux: > AT+CRSM=3D192,28503\r
ofonod[30132]: Aux: < \r\n
ofonod[30132]: Aux: < +CRSM:
144,0,621B8202412183026F57A5038001718A01058B036F0607800200648800\r\n\r\nOK\=
r\n
ofonod[30132]: Aux: > AT+CRSM=3D176,28503,0,0,100\r
ofonod[30132]: Aux: < \r\n
ofonod[30132]: Aux: < +CRSM:
144,0,00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n

Cheers
Nicola Lunghi




On Tue, 10 Dec 2019@14:59, Giacinto Cifelli <gciofono@gmail.com> wrote:

> Hi Nicola,
>
> On Tue, Dec 10, 2019 at 2:33 PM nick83ola <nick83ola@gmail.com> wrote:
> >
> > Hi,
> > I'm a newbie of ofono and I'm having some issue connecting with
> connman/ofono.
> >
> > There's a way to retrieve the apn for a specific network and
> automatically create a context?
> > I tried to use the mbpi plugins but a lot of network have duplicates in
> the apn list.
> >
> > There's also a property in modem properties
> >   [ org.ofono.AllowedAccessPoints ]
> >
> > but is empty
> >
> > what's the smart way to retrieve the APN for a given network
> programmaticly?
>
> I am afraid there isn't.
> And this because there are several APNs for each network, for
> segmenting the customers or the traffic, and there are private APNs,
> MVNOs APNs...
>
> >
> > Thanks
> > Nicola Lunghi
> >
> >
> > /list-modems
> > [ /telit_0 ]
> >     Online =3D 1
> >     Powered =3D 1
> >     Lockdown =3D 0
> >     Emergency =3D 0
> >     Manufacturer =3D Telit
> >     Model =3D HE910-D
> >     Revision =3D 12.00.024
> >     Serial =3D 351579054636509
> >     SystemPath =3D
> /sys/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.1/1-2.1.3
> >     Interfaces =3D org.ofono.SmartMessaging org.ofono.PushNotification
> org.ofono.MessageManager org.ofono.Phonebook org.ofono.NetworkRegistration
> org.ofono.ConnectionManager org.ofono.AllowedAccessPoints
> org.ofono.SimManager
> >     Features =3D sms net gprs sim
> >     Type =3D hardware
> >     [ org.ofono.SmartMessaging ]
> >     [ org.ofono.PushNotification ]
> >     [ org.ofono.MessageManager ]
> >         ServiceCenterAddress =3D +353857000000
> >         UseDeliveryReports =3D 0
> >         Bearer =3D cs-preferred
> >         Alphabet =3D default
> >     [ org.ofono.Phonebook ]
> >     [ org.ofono.NetworkRegistration ]
> >         Status =3D denied
> >         Mode =3D auto
> >         Name =3D
> >     [ org.ofono.ConnectionManager ]
> >         Attached =3D 0
> >         Bearer =3D hsdpa
> >         RoamingAllowed =3D 0
> >         Powered =3D 1
> >     [ org.ofono.AllowedAccessPoints ]
> >     [ org.ofono.SimManager ]
> >         Present =3D 1
> >         CardIdentifier =3D 8935303052299844310
> >         SubscriberIdentity =3D 272032040423839
> >         ServiceProviderName =3D eir
> >         FixedDialing =3D 0
> >         BarredDialing =3D 0
> >         MobileCountryCode =3D 272
> >         MobileNetworkCode =3D 03
> >         SubscriberNumbers =3D +353858016215
> >         LockedPins =3D
> >         ServiceNumbers =3D [Call Wait Off] =3D '#43#' [Call Wait On] =
=3D
> '*43#' [Voice Mail 171] =3D '171' [Last Call Info] =3D '*#101#' [Nat Dire=
ct
> Enq] =3D '11811' [Int Direct Enq] =3D '11818' [Customer Care] =3D '1921' =
[Int
> Cust Care] =3D '+35317011450' [Int Voice Mail] =3D '+353855'
> >         PinRequired =3D none
> >         Retries =3D [pin =3D 3] [pin2 =3D 3] [puk =3D 10] [puk2 =3D 10]
> >         CardSlotCount =3D 1
> >         ActiveCardSlot =3D 1
> > _______________________________________________
> > ofono mailing list -- ofono(a)ofono.org
> > To unsubscribe send an email to ofono-leave(a)ofono.org
>
> BR,
> Giacinto
>

--===============8074720491454706357==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBHaWFjaW50byw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PnRoYW5rcyBmb3IgeW91ciBlbWFpbC48L2Rpdj48ZGl2PklzIG5vdCBwb3NzaWJsZSBlaXRoZXIg
dG8gZ2V0IGl0IGZyb20gdGhlIFNJTSBjYXJkIGl0c2VsZj88L2Rpdj48ZGl2Pkkgd2FzIHJlYWRp
bmcgdGhpcyA8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YSBocmVmPSJodHRwczovL3N0
YWNrb3ZlcmZsb3cuY29tL3F1ZXN0aW9ucy85ODk2MDc5L2lzLWFwbi1sb2dpbi1pbmZvcm1hdGlv
bi1zdG9yZWQtb24tc2ltLWNhcmRzI2Fuc3dlci0zMjg4MDE5OSIgdGFyZ2V0PSJfYmxhbmsiPmh0
dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vcXVlc3Rpb25zLzk4OTYwNzkvaXMtYXBuLWxvZ2luLWlu
Zm9ybWF0aW9uLXN0b3JlZC1vbi1zaW0tY2FyZHMjYW5zd2VyLTMyODgwMTk5PC9hPjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+YW5kIGFsc28gd2hhdCBhYm91dCB0aGUgb3JnLm9mb25vLkFsbG93
ZWRBY2Nlc3NQb2ludHMgcHJvcGVydHk/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5pZiBJIGNh
bGwgdGhlIHRlc3QgY29tbWFuZCBsaXN0LWFsbG93ZWQtYWNjZXNzLXBpbnRzIGNvbm5tYW4gaXMg
dHJ5aW5nIHRvIGdldCB0aG9zZSBmcm9tIHRoZSBzaW0gSSB0aGluazxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pm9mb25vZFszMDEzMl06IEF1eDogJmd0OyBBVCtDUlNNPTE5MiwyODUwM1xy
PGJyPm9mb25vZFszMDEzMl06IEF1eDogJmx0OyBcclxuPGJyPm9mb25vZFszMDEzMl06IEF1eDog
Jmx0OyArQ1JTTTogMTQ0LDAsNjIxQjgyMDI0MTIxODMwMjZGNTdBNTAzODAwMTcxOEEwMTA1OEIw
MzZGMDYwNzgwMDIwMDY0ODgwMFxyXG5cclxuT0tcclxuPGJyPm9mb25vZFszMDEzMl06IEF1eDog
Jmd0OyBBVCtDUlNNPTE3NiwyODUwMywwLDAsMTAwXHI8YnI+b2Zvbm9kWzMwMTMyXTogQXV4OiAm
bHQ7IFxyXG48YnI+b2Zvbm9kWzMwMTMyXTogQXV4OiAmbHQ7ICtDUlNNOiAxNDQsMCwwMEZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRlxyXG5cclxuT0tcclxuPGJyPjxicj48L2Rpdj48ZGl2PkNo
ZWVyczwvZGl2PjxkaXY+Tmljb2xhIEx1bmdoaTxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFR1ZSwg
MTAgRGVjIDIwMTkgYXQgMTQ6NTksIEdpYWNpbnRvIENpZmVsbGkgJmx0OzxhIGhyZWY9Im1haWx0
bzpnY2lvZm9ub0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5nY2lvZm9ub0BnbWFpbC5jb208
L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkhpIE5pY29sYSw8YnI+Cjxicj4KT24gVHVl
LCBEZWMgMTAsIDIwMTkgYXQgMjozMyBQTSBuaWNrODNvbGEgJmx0OzxhIGhyZWY9Im1haWx0bzpu
aWNrODNvbGFAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bmljazgzb2xhQGdtYWlsLmNvbTwv
YT4mZ3Q7IHdyb3RlOjxicj4KJmd0Ozxicj4KJmd0OyBIaSw8YnI+CiZndDsgSSYjMzk7bSBhIG5l
d2JpZSBvZiBvZm9ubyBhbmQgSSYjMzk7bSBoYXZpbmcgc29tZSBpc3N1ZSBjb25uZWN0aW5nIHdp
dGggY29ubm1hbi9vZm9uby48YnI+CiZndDs8YnI+CiZndDsgVGhlcmUmIzM5O3MgYSB3YXkgdG8g
cmV0cmlldmUgdGhlIGFwbiBmb3IgYSBzcGVjaWZpYyBuZXR3b3JrIGFuZCBhdXRvbWF0aWNhbGx5
IGNyZWF0ZSBhIGNvbnRleHQ/PGJyPgomZ3Q7IEkgdHJpZWQgdG8gdXNlIHRoZSBtYnBpIHBsdWdp
bnMgYnV0IGEgbG90IG9mIG5ldHdvcmsgaGF2ZSBkdXBsaWNhdGVzIGluIHRoZSBhcG4gbGlzdC48
YnI+CiZndDs8YnI+CiZndDsgVGhlcmUmIzM5O3MgYWxzbyBhIHByb3BlcnR5IGluIG1vZGVtIHBy
b3BlcnRpZXM8YnI+CiZndDvCoCDCoFsgb3JnLm9mb25vLkFsbG93ZWRBY2Nlc3NQb2ludHMgXTxi
cj4KJmd0Ozxicj4KJmd0OyBidXQgaXMgZW1wdHk8YnI+CiZndDs8YnI+CiZndDsgd2hhdCYjMzk7
cyB0aGUgc21hcnQgd2F5IHRvIHJldHJpZXZlIHRoZSBBUE4gZm9yIGEgZ2l2ZW4gbmV0d29yayBw
cm9ncmFtbWF0aWNseT88YnI+Cjxicj4KSSBhbSBhZnJhaWQgdGhlcmUgaXNuJiMzOTt0Ljxicj4K
QW5kIHRoaXMgYmVjYXVzZSB0aGVyZSBhcmUgc2V2ZXJhbCBBUE5zIGZvciBlYWNoIG5ldHdvcmss
IGZvcjxicj4Kc2VnbWVudGluZyB0aGUgY3VzdG9tZXJzIG9yIHRoZSB0cmFmZmljLCBhbmQgdGhl
cmUgYXJlIHByaXZhdGUgQVBOcyw8YnI+Ck1WTk9zIEFQTnMuLi48YnI+Cjxicj4KJmd0Ozxicj4K
Jmd0OyBUaGFua3M8YnI+CiZndDsgTmljb2xhIEx1bmdoaTxicj4KJmd0Ozxicj4KJmd0Ozxicj4K
Jmd0OyAvbGlzdC1tb2RlbXM8YnI+CiZndDsgWyAvdGVsaXRfMCBdPGJyPgomZ3Q7wqAgwqAgwqBP
bmxpbmUgPSAxPGJyPgomZ3Q7wqAgwqAgwqBQb3dlcmVkID0gMTxicj4KJmd0O8KgIMKgIMKgTG9j
a2Rvd24gPSAwPGJyPgomZ3Q7wqAgwqAgwqBFbWVyZ2VuY3kgPSAwPGJyPgomZ3Q7wqAgwqAgwqBN
YW51ZmFjdHVyZXIgPSBUZWxpdDxicj4KJmd0O8KgIMKgIMKgTW9kZWwgPSBIRTkxMC1EPGJyPgom
Z3Q7wqAgwqAgwqBSZXZpc2lvbiA9IDEyLjAwLjAyNDxicj4KJmd0O8KgIMKgIMKgU2VyaWFsID0g
MzUxNTc5MDU0NjM2NTA5PGJyPgomZ3Q7wqAgwqAgwqBTeXN0ZW1QYXRoID0gL3N5cy9kZXZpY2Vz
L3BjaTAwMDA6MDAvMDAwMDowMDoxNC4wL3VzYjEvMS0yLzEtMi4xLzEtMi4xLjM8YnI+CiZndDvC
oCDCoCDCoEludGVyZmFjZXMgPSBvcmcub2Zvbm8uU21hcnRNZXNzYWdpbmcgb3JnLm9mb25vLlB1
c2hOb3RpZmljYXRpb24gb3JnLm9mb25vLk1lc3NhZ2VNYW5hZ2VyIG9yZy5vZm9uby5QaG9uZWJv
b2sgb3JnLm9mb25vLk5ldHdvcmtSZWdpc3RyYXRpb24gb3JnLm9mb25vLkNvbm5lY3Rpb25NYW5h
Z2VyIG9yZy5vZm9uby5BbGxvd2VkQWNjZXNzUG9pbnRzIG9yZy5vZm9uby5TaW1NYW5hZ2VyPGJy
PgomZ3Q7wqAgwqAgwqBGZWF0dXJlcyA9IHNtcyBuZXQgZ3BycyBzaW08YnI+CiZndDvCoCDCoCDC
oFR5cGUgPSBoYXJkd2FyZTxicj4KJmd0O8KgIMKgIMKgWyBvcmcub2Zvbm8uU21hcnRNZXNzYWdp
bmcgXTxicj4KJmd0O8KgIMKgIMKgWyBvcmcub2Zvbm8uUHVzaE5vdGlmaWNhdGlvbiBdPGJyPgom
Z3Q7wqAgwqAgwqBbIG9yZy5vZm9uby5NZXNzYWdlTWFuYWdlciBdPGJyPgomZ3Q7wqAgwqAgwqAg
wqAgwqBTZXJ2aWNlQ2VudGVyQWRkcmVzcyA9ICszNTM4NTcwMDAwMDA8YnI+CiZndDvCoCDCoCDC
oCDCoCDCoFVzZURlbGl2ZXJ5UmVwb3J0cyA9IDA8YnI+CiZndDvCoCDCoCDCoCDCoCDCoEJlYXJl
ciA9IGNzLXByZWZlcnJlZDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgQWxwaGFiZXQgPSBkZWZhdWx0
PGJyPgomZ3Q7wqAgwqAgwqBbIG9yZy5vZm9uby5QaG9uZWJvb2sgXTxicj4KJmd0O8KgIMKgIMKg
WyBvcmcub2Zvbm8uTmV0d29ya1JlZ2lzdHJhdGlvbiBdPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqBT
dGF0dXMgPSBkZW5pZWQ8YnI+CiZndDvCoCDCoCDCoCDCoCDCoE1vZGUgPSBhdXRvPGJyPgomZ3Q7
wqAgwqAgwqAgwqAgwqBOYW1lID08YnI+CiZndDvCoCDCoCDCoFsgb3JnLm9mb25vLkNvbm5lY3Rp
b25NYW5hZ2VyIF08YnI+CiZndDvCoCDCoCDCoCDCoCDCoEF0dGFjaGVkID0gMDxicj4KJmd0O8Kg
IMKgIMKgIMKgIMKgQmVhcmVyID0gaHNkcGE8YnI+CiZndDvCoCDCoCDCoCDCoCDCoFJvYW1pbmdB
bGxvd2VkID0gMDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgUG93ZXJlZCA9IDE8YnI+CiZndDvCoCDC
oCDCoFsgb3JnLm9mb25vLkFsbG93ZWRBY2Nlc3NQb2ludHMgXTxicj4KJmd0O8KgIMKgIMKgWyBv
cmcub2Zvbm8uU2ltTWFuYWdlciBdPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqBQcmVzZW50ID0gMTxi
cj4KJmd0O8KgIMKgIMKgIMKgIMKgQ2FyZElkZW50aWZpZXIgPSA4OTM1MzAzMDUyMjk5ODQ0MzEw
PGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqBTdWJzY3JpYmVySWRlbnRpdHkgPSAyNzIwMzIwNDA0MjM4
Mzk8YnI+CiZndDvCoCDCoCDCoCDCoCDCoFNlcnZpY2VQcm92aWRlck5hbWUgPSBlaXI8YnI+CiZn
dDvCoCDCoCDCoCDCoCDCoEZpeGVkRGlhbGluZyA9IDA8YnI+CiZndDvCoCDCoCDCoCDCoCDCoEJh
cnJlZERpYWxpbmcgPSAwPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqBNb2JpbGVDb3VudHJ5Q29kZSA9
IDI3Mjxicj4KJmd0O8KgIMKgIMKgIMKgIMKgTW9iaWxlTmV0d29ya0NvZGUgPSAwMzxicj4KJmd0
O8KgIMKgIMKgIMKgIMKgU3Vic2NyaWJlck51bWJlcnMgPSArMzUzODU4MDE2MjE1PGJyPgomZ3Q7
wqAgwqAgwqAgwqAgwqBMb2NrZWRQaW5zID08YnI+CiZndDvCoCDCoCDCoCDCoCDCoFNlcnZpY2VO
dW1iZXJzID0gW0NhbGwgV2FpdCBPZmZdID0gJiMzOTsjNDMjJiMzOTsgW0NhbGwgV2FpdCBPbl0g
PSAmIzM5Oyo0MyMmIzM5OyBbVm9pY2UgTWFpbCAxNzFdID0gJiMzOTsxNzEmIzM5OyBbTGFzdCBD
YWxsIEluZm9dID0gJiMzOTsqIzEwMSMmIzM5OyBbTmF0IERpcmVjdCBFbnFdID0gJiMzOTsxMTgx
MSYjMzk7IFtJbnQgRGlyZWN0IEVucV0gPSAmIzM5OzExODE4JiMzOTsgW0N1c3RvbWVyIENhcmVd
ID0gJiMzOTsxOTIxJiMzOTsgW0ludCBDdXN0IENhcmVdID0gJiMzOTsrMzUzMTcwMTE0NTAmIzM5
OyBbSW50IFZvaWNlIE1haWxdID0gJiMzOTsrMzUzODU1JiMzOTs8YnI+CiZndDvCoCDCoCDCoCDC
oCDCoFBpblJlcXVpcmVkID0gbm9uZTxicj4KJmd0O8KgIMKgIMKgIMKgIMKgUmV0cmllcyA9IFtw
aW4gPSAzXSBbcGluMiA9IDNdIFtwdWsgPSAxMF0gW3B1azIgPSAxMF08YnI+CiZndDvCoCDCoCDC
oCDCoCDCoENhcmRTbG90Q291bnQgPSAxPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqBBY3RpdmVDYXJk
U2xvdCA9IDE8YnI+CiZndDsgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX188YnI+CiZndDsgb2Zvbm8gbWFpbGluZyBsaXN0IC0tIDxhIGhyZWY9Im1haWx0bzpv
Zm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgom
Z3Q7IFRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gPGEgaHJlZj0ibWFpbHRvOm9mb25v
LWxlYXZlQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vLWxlYXZlQG9mb25vLm9yZzwv
YT48YnI+Cjxicj4KQlIsPGJyPgpHaWFjaW50bzxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============8074720491454706357==--

