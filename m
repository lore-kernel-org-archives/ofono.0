Content-Type: multipart/mixed; boundary="===============7141303142061290283=="
MIME-Version: 1.0
From: Rajashekharaiah, Kiran KumarX <kiran.kumarx.rajashekharaiah@intel.com>
Subject: RE: Using ofono for location service
Date: Thu, 12 Mar 2015 06:25:12 +0000
Message-ID: <50BCD3CCE3CFC54ABCADC6EDD7405570C5551A@BGSMSX104.gar.corp.intel.com>
In-Reply-To: <54F9E7BE.4080409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7141303142061290283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Also when I tried running "test-gnss" for testing AGPS, I get the =

> following error(with ofonod daemon running in background):
>
> *NameError: name 'gnss' is not defined*
>

Yes, sounds like no modems with the
org.ofono.AssistedSatelliteNavigation interface were found.

> **
>
> Does this mean AGPS is not enabled? If so how can I enable it?
>
> **

>> Have you powered up your telit HE 910 via enable-modem?

Kiran: I executed in the following order and ppp is up, but still I get the=
 error: *NameError: name 'gnss' is not defined*.
ofonod -> enable-modem -> activate-context  =


When I run list-modem I get the following output, which does not list  "org=
.ofono.AssistedSatelliteNavigation":

[ /he910_0 ]
    Features =3D sms net gprs ussd gps sim =

    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.SmartMessaging org.ofono.PushNotification org.=
ofono.MessageManager org.ofono.Phonebook org.ofono.NetworkRegistration org.=
ofono.ConnectionManager org.ofono.CallMeter org.ofono.SupplementaryServices=
 org.ofono.VoiceCallManager org.ofono.CallBarring org.ofono.CallSettings or=
g.ofono.CallForwarding org.ofono.MessageWaiting org.ofono.LocationReporting=
 org.ofono.SimManager =

    Online =3D 1
    Model =3D HE910
    Revision =3D 12.00.004
    Type =3D hardware
    Serial =3D 357164040824024
    Manufacturer =3D Telit
    [ org.ofono.SmartMessaging ]
    [ org.ofono.PushNotification ]
    [ org.ofono.MessageManager ]
        Alphabet =3D default
        UseDeliveryReports =3D 0
        Bearer =3D cs-preferred
        ServiceCenterAddress =3D +919845087001
    [ org.ofono.Phonebook ]
    [ org.ofono.NetworkRegistration ]
        Status =3D registered
        Strength =3D 80
        Name =3D airtel
        LocationAreaCode =3D 34181
        Mode =3D auto
        MobileCountryCode =3D 404
        Technology =3D umts
        CellId =3D 27398329
        MobileNetworkCode =3D 45
    [ org.ofono.ConnectionManager ]
        Powered =3D 1
        Attached =3D 1
        Bearer =3D hsdpa
        Suspended =3D 0
        RoamingAllowed =3D 0
    [ org.ofono.CallMeter ]
        Currency =3D =

        CallMeter =3D 0
        AccumulatedCallMeter =3D 0
        PricePerUnit =3D 0.0
        AccumulatedCallMeterMaximum =3D 0
    [ org.ofono.SupplementaryServices ]
        State =3D idle
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 08 000 999 110 112 911 118 119 =

    [ org.ofono.CallBarring ]
        VoiceOutgoing =3D disabled
        VoiceIncoming =3D disabled
    [ org.ofono.CallSettings ]
        HideCallerId =3D default
        CallingLinePresentation =3D enabled
        VoiceCallWaiting =3D enabled
        CalledLinePresentation =3D disabled
        ConnectedLineRestriction =3D disabled
        ConnectedLinePresentation =3D disabled
        CallingLineRestriction =3D permanent
        CallingNamePresentation =3D unknown
    [ org.ofono.CallForwarding ]
        ForwardingFlagOnSim =3D 0
        VoiceNoReplyTimeout =3D 20
        VoiceNotReachable =3D =

        VoiceBusy =3D =

        VoiceNoReply =3D =

        VoiceUnconditional =3D =

    [ org.ofono.MessageWaiting ]
        VoicemailMessageCount =3D 0
        VoicemailMailboxNumber =3D =

        VoicemailWaiting =3D 0
    [ org.ofono.LocationReporting ]
        Type =3D nmea
        Enabled =3D 0
    [ org.ofono.SimManager ]
        Retries =3D [pin2 =3D 3] [puk2 =3D 10] [pin =3D 3] [puk =3D 10] =

        MobileCountryCode =3D 404
        FixedDialing =3D 0
        SubscriberNumbers =3D =

        BarredDialing =3D 0
        CardIdentifier =3D 89914500050200371777
        LockedPins =3D =

        MobileNetworkCode =3D 45
        SubscriberIdentity =3D 404450520037177
        Present =3D 1
        PinRequired =3D none

Regards,
Kiran

--===============7141303142061290283==--

