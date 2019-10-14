Content-Type: multipart/mixed; boundary="===============3657645057650299675=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: Telit HE910-d failed to activate context
Date: Mon, 14 Oct 2019 15:54:51 +0100
Message-ID: <CABPh3UP3sg2hjB5YhQrcKpYONfUW4UeBGxuO=AeorTFgtdTPPw@mail.gmail.com>
In-Reply-To: <CABPh3UN-0x33u-gPWCLjO6=VFAYLMb1CsrTtCF7-GF8Cag1uuA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3657645057650299675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some more information
if i use the monitor-ofono script

./monitor-ofono
{NetworkRegistration} [/telit_0] Status =3D registered
{NetworkRegistration} [/telit_0] LocationAreaCode =3D 32500
{NetworkRegistration} [/telit_0] CellId =3D 47192005
{NetworkRegistration} [/telit_0] Technology =3D umts
{NetworkRegistration} [/telit_0] Status =3D searching
{NetworkRegistration} [/telit_0] Status =3D registered
{NetworkRegistration} [/telit_0] LocationAreaCode =3D 32500
{NetworkRegistration} [/telit_0] CellId =3D 47192005
{NetworkRegistration} [/telit_0] Technology =3D umts
{NetworkRegistration} [/telit_0] Strength =3D 0
{NetworkRegistration} [/telit_0] Name =3D 3
{NetworkRegistration} [/telit_0] MobileCountryCode =3D 272
{NetworkRegistration} [/telit_0] MobileNetworkCode =3D 02
{ConnectionManager} [/telit_0] Attached =3D True
{ConnectionManager} [/telit_0] Bearer =3D hsdpa
{NetworkRegistration} [/telit_0] Strength =3D 40
{MessageManager} [/telit_0] ServiceCenterAddress =3D +353868002000
{ConnectionContext} [/telit_0/context1] Settings =3D { Interface =3D ppp0,
Method =3D static, Address =3D 100.93.113.108, Netmask =3D 255.255.255.255,
DomainNameServers =3D 83.136.46.138 62.40.32.33 }
{ConnectionContext} [/telit_0/context1] Active =3D True
{NetworkRegistration} [/telit_0] Strength =3D 60
{NetworkRegistration} [/telit_0] CellId =3D 47212292
{ConnectionManager} [/telit_0] Bearer =3D lte
{NetworkRegistration} [/telit_0] LocationAreaCode =3D 101
{NetworkRegistration} [/telit_0] CellId =3D 45402
{NetworkRegistration} [/telit_0] Technology =3D gsm
{ConnectionManager} [/telit_0] Bearer =3D edge
{NetworkRegistration} [/telit_0] LocationAreaCode =3D 32500
{NetworkRegistration} [/telit_0] CellId =3D 47192005
{NetworkRegistration} [/telit_0] Technology =3D umts
{ConnectionManager} [/telit_0] Bearer =3D hsdpa
{NetworkRegistration} [/telit_0] Strength =3D 40
{NetworkRegistration} [/telit_0] Strength =3D 60
{NetworkRegistration} [/telit_0] Strength =3D 40


after the activate context call this line is printed

{ConnectionContext} [/telit_0/context1] Settings =3D { Interface =3D ppp0,
Method =3D static, Address =3D 100.93.113.108, Netmask =3D 255.255.255.255,
DomainNameServers =3D 83.136.46.138 62.40.32.33 }

But the ppp0 interface is not correctly configured
ppp0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc
pfifo_fast state UNKNOWN qlen 500
    link/[65534]
    inet6 fe80::55b:a2f6:60d5:9196/64 scope link
       valid_lft forever preferred_lft forever




On Mon, 14 Oct 2019 at 15:33, nick83ola <nick83ola@gmail.com> wrote:
>
> Hello
> I'm working with a telit HE910-D with the latest ofono 1.30 and latest co=
nnman
>
> I do the following:
>
> systemctl start ofono
> root(a)bumblebee-21c24c:~# cd /usr/lib/ofono/test/
> root(a)bumblebee-21c24c:/usr/lib/ofono/test# ./list-modems
> [ /telit_0 ]
>     Online =3D 0
>     Powered =3D 0
>     Lockdown =3D 0
>     Emergency =3D 0
>     SystemPath =3D
> /sys/devices/soc0/soc/30800000.aips-bus/30b30000.usb/ci_hdrc.1/usb2/2-1/2=
-1.1
>     Interfaces =3D
>     Features =3D
>     Type =3D hardware
>
> root(a)bumblebee-21c24c:/usr/lib/ofono/test# ./enable-modem
> Connecting modem /telit_0...
> root(a)bumblebee-21c24c:/usr/lib/ofono/test# ./list-modems
> [ /telit_0 ]
>     Online =3D 1
>     Powered =3D 1
>     Lockdown =3D 0
>     Emergency =3D 0
>     Manufacturer =3D Telit
>     Model =3D HE910-D
>     Revision =3D 12.00.024
>     Serial =3D 351579052975024
>     SystemPath =3D
> /sys/devices/soc0/soc/30800000.aips-bus/30b30000.usb/ci_hdrc.1/usb2/2-1/2=
-1.1
>     Interfaces =3D org.ofono.SmartMessaging org.ofono.PushNotification
> org.ofono.MessageManager org.ofono.Phonebook
> org.ofono.NetworkRegistration org.ofono.ConnectionManager
> org.ofono.AllowedAccessPoints org.ofono.SimManager
>     Features =3D sms net gprs sim
>     Type =3D hardware
>     [ org.ofono.SmartMessaging ]
>     [ org.ofono.PushNotification ]
>     [ org.ofono.MessageManager ]
>         ServiceCenterAddress =3D +353868002000
>         UseDeliveryReports =3D 0
>         Bearer =3D cs-preferred
>         Alphabet =3D default
>     [ org.ofono.Phonebook ]
>     [ org.ofono.NetworkRegistration ]
>         Status =3D registered
>         Mode =3D auto
>         LocationAreaCode =3D 32500
>         CellId =3D 47189919
>         Technology =3D umts
>         MobileCountryCode =3D 272
>         MobileNetworkCode =3D 02
>         Name =3D 3
>         Strength =3D 40
>     [ org.ofono.ConnectionManager ]
>         Attached =3D 1
>         Bearer =3D hsdpa
>         RoamingAllowed =3D 0
>         Powered =3D 1
>         Suspended =3D 0
>     [ org.ofono.AllowedAccessPoints ]
>     [ org.ofono.SimManager ]
>         Present =3D 1
>         CardIdentifier =3D 8935302173240104694
>         SubscriberIdentity =3D 272023119202599
>         FixedDialing =3D 0
>         BarredDialing =3D 0
>         MobileCountryCode =3D 272
>         MobileNetworkCode =3D 02
>         SubscriberNumbers =3D +353864633764
>         LockedPins =3D
>         PinRequired =3D none
>         Retries =3D [pin =3D 3] [pin2 =3D 3] [puk =3D 10] [puk2 =3D 10]
>         CardSlotCount =3D 1
>         ActiveCardSlot =3D 1
>
> root(a)bumblebee-21c24c:/usr/lib/ofono/test# ./list-contexts
> [ /telit_0 ]
>     [ /telit_0/context1 ]
>         Name =3D Internet
>         Active =3D 0
>         Type =3D internet
>         Protocol =3D ip
>         AccessPointName =3D
>         Username =3D
>         Password =3D
>         AuthenticationMethod =3D chap
>         Settings =3D { }
>         IPv6.Settings =3D { }
>
> root(a)bumblebee-21c24c:/usr/lib/ofono/test# ./remove-contexts
> Removed: [ /telit_0/context1 ]
> root(a)bumblebee-21c24c:/usr/lib/ofono/test# ./create-internet-context
> Created new context /telit_0/context1
> root(a)bumblebee-21c24c:/usr/lib/ofono/test# ./online-modem
> Setting modem /telit_0 online...
> root(a)bumblebee-21c24c:/usr/lib/ofono/test# ./activate-context
> root(a)bumblebee-21c24c:/usr/lib/ofono/test# ./list-modems
> [ /telit_0 ]
>     Online =3D 1
>     Powered =3D 1
>     Lockdown =3D 0
>     Emergency =3D 0
>     Manufacturer =3D Telit
>     Model =3D HE910-D
>     Revision =3D 12.00.024
>     Serial =3D 351579052975024
>     SystemPath =3D
> /sys/devices/soc0/soc/30800000.aips-bus/30b30000.usb/ci_hdrc.1/usb2/2-1/2=
-1.1
>     Interfaces =3D org.ofono.SmartMessaging org.ofono.PushNotification
> org.ofono.MessageManager org.ofono.Phonebook
> org.ofono.NetworkRegistration org.ofono.ConnectionManager
> org.ofono.AllowedAccessPoints org.ofono.SimManager
>     Features =3D sms net gprs sim
>     Type =3D hardware
>     [ org.ofono.SmartMessaging ]
>     [ org.ofono.PushNotification ]
>     [ org.ofono.MessageManager ]
>         ServiceCenterAddress =3D +353868002000
>         UseDeliveryReports =3D 0
>         Bearer =3D cs-preferred
>         Alphabet =3D default
>     [ org.ofono.Phonebook ]
>     [ org.ofono.NetworkRegistration ]
>         Status =3D registered
>         Mode =3D auto
>         LocationAreaCode =3D 32500
>         CellId =3D 47192005
>         Technology =3D umts
>         MobileCountryCode =3D 272
>         MobileNetworkCode =3D 02
>         Name =3D 3
>         Strength =3D 40
>     [ org.ofono.ConnectionManager ]
>         Attached =3D 1
>         Bearer =3D hsdpa
>         RoamingAllowed =3D 0
>         Powered =3D 1
>         Suspended =3D 0
>     [ org.ofono.AllowedAccessPoints ]
>     [ org.ofono.SimManager ]
>         Present =3D 1
>         CardIdentifier =3D 8935302173240104694
>         SubscriberIdentity =3D 272023119202599
>         FixedDialing =3D 0
>         BarredDialing =3D 0
>         MobileCountryCode =3D 272
>         MobileNetworkCode =3D 02
>         SubscriberNumbers =3D +353864633764
>         LockedPins =3D
>         PinRequired =3D none
>         Retries =3D [pin =3D 3] [pin2 =3D 3] [puk =3D 10] [puk2 =3D 10]
>         CardSlotCount =3D 1
>         ActiveCardSlot =3D 1
>
>
> root(a)bumblebee-21c24c:/usr/lib/ofono/test# ip a
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen =
1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host
>        valid_lft forever preferred_lft forever
> 2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
> DOWN qlen 1000
>     link/ether 00:01:c0:21:c2:4c brd ff:ff:ff:ff:ff:ff
> 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qle=
n 1000
>     link/ether 00:01:c0:21:c2:53 brd ff:ff:ff:ff:ff:ff
>     inet 10.32.234.43/24 brd 10.32.234.255 scope global dynamic eth1
>        valid_lft 6899sec preferred_lft 6899sec
>     inet6 fe80::201:c0ff:fe21:c253/64 scope link
>        valid_lft forever preferred_lft forever
> 4: sit0(a)NONE: <NOARP> mtu 1480 qdisc noop state DOWN qlen 1000
>     link/sit 0.0.0.0 brd 0.0.0.0
> 5: ppp0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc
> pfifo_fast state UNKNOWN qlen 500
>     link/[65534]
>     inet6 fe80::cfa:2a85:a32a:9967/64 scope link
>        valid_lft forever preferred_lft forever
>
>
> The problem is that the ppp0 interface doesn't get an ip while on te
> log I can clearly see it
>
> Oct 16 14:24:46 bumblebee-21c24c ofonod[551]: ofonod[551]: PPP:
> ../../../../../../workspace/sources/ofono/gatchat/gatppp.c:ppp_enter_phas=
e()
> 4
> Oct 16 14:24:46 bumblebee-21c24c ofonod[551]: ofonod[551]:
> ../../../../../../workspace/sources/ofono/drivers/atmodem/gprs-context.c:=
ppp_connect()
> Oct 16 14:24:46 bumblebee-21c24c ofonod[551]: ofonod[551]: IP: 100.88.174=
.61
> Oct 16 14:24:46 bumblebee-21c24c ofonod[551]: ofonod[551]: DNS:
> 83.136.46.138, 62.40.32.33
> Oct 16 14:24:46 bumblebee-21c24c ofonod[551]: ofonod[551]:
> ../../../../../../workspace/sources/ofono/src/gprs.c:pri_activate_callbac=
k()
> 0x2201620
> Oct 16 14:24:46 bumblebee-21c24c ofonod[551]: ofonod[551]:
> ../../../../../../workspace/sources/ofono/plugins/udevng.c:add_serial_dev=
ice()
> Device is missing required OFONO_DRIVER property
> Oct 16 14:24:47 bumblebee-21c24c ofonod[551]: ofonod[551]:
> ../../../../../../workspace/sources/ofono/plugins/udevng.c:check_modem_li=
st()
> Oct 16 14:24:50 bumblebee-21c24c ofonod[551]: ofonod[551]:
> ../../../../../../workspace/sources/ofono/src/modem.c:get_modem_property()
> modem 0x76c5f530 property SystemPath
>
> Can you help me to debug this?
>
> Thanks
> Nicola Lunghi
--===============3657645057650299675==--

