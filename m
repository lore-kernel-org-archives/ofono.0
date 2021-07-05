Content-Type: multipart/mixed; boundary="===============7820871519715713424=="
MIME-Version: 1.0
From: sebastian.wans@physec.de
Subject: Roaming SIM card does not get APN and internet connection
Date: Mon, 05 Jul 2021 13:12:14 +0000
Message-ID: <20210705131214.2743.10820@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7820871519715713424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi together, =


I have a setup where I want to use a M2M simcard from Telefonica issued in =
Germany. I have verified with a technician from Telefonica that the MCC/MNC=
's (262 | 03, 07,77) and the APN (iotde.telefonica.com) are correct and hav=
e configured oFono to use those and the network registartion props show tha=
t 262 | 03 seems to be actually used. However, the IMSI shows that the SIM =
card has the MCC and MNC registered for Movistar (Telefonica) Spain (214 | =
07). =


The problem is that the ConnectionContext does not seem to be able to get o=
r register the correct APN and the device is not able to get connection. I =
have appended some printouts of the different properties.

Does anyone has an idea if I need to configure something additionaly or how=
 to fix this problem?

HardwarePosition:internal
   Powered:1
   Online:1
   Manufacturer:QUALCOMM INCORPORATED
   Model:QUECTEL Mobile Broadband Module
   Revision:EG25GGBR07A07M2G
  [SimProps]
      Present:1
      CardIdentifier:8934076100150326600
      SubscriberIdentity:214074307601315
      LockedPins:dbus.Array([], signature=3Ddbus.Signature('s'), variant_le=
vel=3D1)
      PinRequired:none
  [NetworkRegistrationProps]
      Status:roaming
      MobileCountryCode:262
      MobileNetworkCode:03
      Name:26203
    Strength:40
      Technology:lte
    RSSI:None
  [ConnectionManagerProperties]
      Attached:1
      RoamingAllowed:1
  [ConnectionContexts]
    [/quectelqmi_0/context1]
         Name:Internet
         Active:0
         Type:internet
         Protocol:ip
         AccessPointName:
         Username:
         Password:
         AuthenticationMethod:chap
--===============7820871519715713424==--

