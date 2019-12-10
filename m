Content-Type: multipart/mixed; boundary="===============3362987119824147211=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: automatically retrieve the apn for a network
Date: Tue, 10 Dec 2019 15:59:45 +0100
Message-ID: <CAKSBH7EX-S0tj1UYauLnPK__pvNUoktsRUCBdXDBcvfSznZwqw@mail.gmail.com>
In-Reply-To: <CABPh3UOpewhbDuU3W6FoKiETJ7HJ24e_=mi9an-cTNCYShPSMw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3362987119824147211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicola,

On Tue, Dec 10, 2019 at 2:33 PM nick83ola <nick83ola@gmail.com> wrote:
>
> Hi,
> I'm a newbie of ofono and I'm having some issue connecting with connman/o=
fono.
>
> There's a way to retrieve the apn for a specific network and automaticall=
y create a context?
> I tried to use the mbpi plugins but a lot of network have duplicates in t=
he apn list.
>
> There's also a property in modem properties
>   [ org.ofono.AllowedAccessPoints ]
>
> but is empty
>
> what's the smart way to retrieve the APN for a given network programmatic=
ly?

I am afraid there isn't.
And this because there are several APNs for each network, for
segmenting the customers or the traffic, and there are private APNs,
MVNOs APNs...

>
> Thanks
> Nicola Lunghi
>
>
> /list-modems
> [ /telit_0 ]
>     Online =3D 1
>     Powered =3D 1
>     Lockdown =3D 0
>     Emergency =3D 0
>     Manufacturer =3D Telit
>     Model =3D HE910-D
>     Revision =3D 12.00.024
>     Serial =3D 351579054636509
>     SystemPath =3D /sys/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.1/1-=
2.1.3
>     Interfaces =3D org.ofono.SmartMessaging org.ofono.PushNotification or=
g.ofono.MessageManager org.ofono.Phonebook org.ofono.NetworkRegistration or=
g.ofono.ConnectionManager org.ofono.AllowedAccessPoints org.ofono.SimManager
>     Features =3D sms net gprs sim
>     Type =3D hardware
>     [ org.ofono.SmartMessaging ]
>     [ org.ofono.PushNotification ]
>     [ org.ofono.MessageManager ]
>         ServiceCenterAddress =3D +353857000000
>         UseDeliveryReports =3D 0
>         Bearer =3D cs-preferred
>         Alphabet =3D default
>     [ org.ofono.Phonebook ]
>     [ org.ofono.NetworkRegistration ]
>         Status =3D denied
>         Mode =3D auto
>         Name =3D
>     [ org.ofono.ConnectionManager ]
>         Attached =3D 0
>         Bearer =3D hsdpa
>         RoamingAllowed =3D 0
>         Powered =3D 1
>     [ org.ofono.AllowedAccessPoints ]
>     [ org.ofono.SimManager ]
>         Present =3D 1
>         CardIdentifier =3D 8935303052299844310
>         SubscriberIdentity =3D 272032040423839
>         ServiceProviderName =3D eir
>         FixedDialing =3D 0
>         BarredDialing =3D 0
>         MobileCountryCode =3D 272
>         MobileNetworkCode =3D 03
>         SubscriberNumbers =3D +353858016215
>         LockedPins =3D
>         ServiceNumbers =3D [Call Wait Off] =3D '#43#' [Call Wait On] =3D =
'*43#' [Voice Mail 171] =3D '171' [Last Call Info] =3D '*#101#' [Nat Direct=
 Enq] =3D '11811' [Int Direct Enq] =3D '11818' [Customer Care] =3D '1921' [=
Int Cust Care] =3D '+35317011450' [Int Voice Mail] =3D '+353855'
>         PinRequired =3D none
>         Retries =3D [pin =3D 3] [pin2 =3D 3] [puk =3D 10] [puk2 =3D 10]
>         CardSlotCount =3D 1
>         ActiveCardSlot =3D 1
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org

BR,
Giacinto
--===============3362987119824147211==--

