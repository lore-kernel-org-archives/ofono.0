Content-Type: multipart/mixed; boundary="===============3105169752972055566=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: Roaming SIM card does not get APN and internet connection
Date: Mon, 05 Jul 2021 15:20:11 +0200
Message-ID: <cde4dc4b-cb0e-9d75-a40e-e7052d476f46@kerlink.fr>
In-Reply-To: <20210705131214.2743.10820@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3105169752972055566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 7/5/21 3:12 PM, sebastian.wans(a)physec.de wrote:
> Hi together, =

>
> I have a setup where I want to use a M2M simcard from Telefonica issued i=
n Germany. I have verified with a technician from Telefonica that the MCC/M=
NC's (262 | 03, 07,77) and the APN (iotde.telefonica.com) are correct and h=
ave configured oFono to use those and the network registartion props show t=
hat 262 | 03 seems to be actually used. However, the IMSI shows that the SI=
M card has the MCC and MNC registered for Movistar (Telefonica) Spain (214 =
| 07). =

>
> The problem is that the ConnectionContext does not seem to be able to get=
 or register the correct APN and the device is not able to get connection. =
I have appended some printouts of the different properties.
>
> Does anyone has an idea if I need to configure something additionaly or h=
ow to fix this problem?
>
> HardwarePosition:internal
>    Powered:1
>    Online:1
>    Manufacturer:QUALCOMM INCORPORATED
>    Model:QUECTEL Mobile Broadband Module
>    Revision:EG25GGBR07A07M2G
>   [SimProps]
>       Present:1
>       CardIdentifier:8934076100150326600
>       SubscriberIdentity:214074307601315
>       LockedPins:dbus.Array([], signature=3Ddbus.Signature('s'), variant_=
level=3D1)
>       PinRequired:none
>   [NetworkRegistrationProps]
>       Status:roaming
>       MobileCountryCode:262
>       MobileNetworkCode:03
>       Name:26203
>     Strength:40
>       Technology:lte
>     RSSI:None
>   [ConnectionManagerProperties]
>       Attached:1
>       RoamingAllowed:1
>   [ConnectionContexts]
>     [/quectelqmi_0/context1]
>          Name:Internet
>          Active:0
>          Type:internet
>          Protocol:ip
>          AccessPointName:
>          Username:
>          Password:
>          AuthenticationMethod:chap

Your debug output makes me think you are using a kerlink board. Am I right?

If this is the case, your APN is badly configured. Please send
/etc/network/ofono/provisioning file, I'll have a look. Meanwhile, if
you have modified this file, you can try "/etc/init.d/ofono reset" to be
sure to use the latest version of this file.

> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org


Best Regards,

Christophe Ronco

--===============3105169752972055566==--

