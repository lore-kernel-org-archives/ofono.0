Content-Type: multipart/mixed; boundary="===============4995371593741708478=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: Re: Ublox Toby Modem
Date: Wed, 20 Apr 2016 16:18:06 +0200
Message-ID: <57178F9E.6080604@endocode.com>
In-Reply-To: <57178E0F.7000904@gmx.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4995371593741708478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 04/20/2016 04:11 PM, Yorn wrote:
> + adding ofono mailinglist as it may be of interest
> =

Thanks.

> Point is, that I am trying to run the u-blox on ofono+connman and had/hav=
e some questions regarding the setup.
> I compiled the git version of the ofono for a freescale vf610 board with =
an onboard ublox usb adapter and got quite far.
> =

> A manual setup on pppd+peer+provider+chat script gave me a clean internet=
 connection.
> =

> Now I want to integrate that with ofono/connman. I got ofono finding the =
module, advertise it as a cellular technology to connman, but no service is=
 showing up.
> =

> I will go on setting up the umts high throughput profile.
> =

> So the rest of the story can be found below!
> =

> @Dragos:
> without any changes, I got
> lsusb:
> 1546:1146 U-Blox AG (which is high performance?)
>
Good. Now we're on stable grounds :).
 =

> online modem runs without any complains, but without any changes
> root(a)colibri-vf:~/test# ./online-modem
> Setting modem /ublox_0 online...
> =

Can you check the output of list-contexts now? You should see one active.
And if that is so, you should also see a connman cellular service present.

> =

> BR - Yorn (J=C3=B6rn)
> =

> =

> Am 20.04.2016 um 15:16 schrieb Dragos Tatulea:
>> Hi J=C3=B6rn,
>>
>> Can we take this discussion to the connman/ofono ml? Other people
>> might find this useful.
>>
>> On 04/20/2016 03:01 PM, J=C3=B6rn wrote:
>>> Hi Dragos,
>>>
>>> I got python to work for the test scripts, this is what it gave [1]. I =
believe I am just a minute away ..
>>>
>> Good.
>>
>>> I got the connection up and running on a manual (old fassioned) way wit=
h pppd, chat and provider script. However I am not an expert on ofono/connm=
an yet (but trying hard ...).
>>>
>>> I firstly wanted to use 2g/3g with high performance mode (as I saw your=
 effort has been put on this point, right?). I am rather not sure, how to c=
onfigure that without having a connman service.
>> The AT Commands Examples [1] documents that (USB configuration section).
>> You should change the mode manually. A successful set will yield the
>> following ids from lsusb:
>>
>> 1546:1140 U-Blox AG
>>
>>
>>> BR - J=C3=B6rn
>>>
>>> [1]
>>> root(a)colibri-vf:~/test# ./activate-context
>>> Error activating /ublox_0/context1: org.ofono.Error.NotAttached: GPRS i=
s not attached
>>> root(a)colibri-vf:~/test# ./list-contexts
>>> [ /ublox_0 ]
>>>      [ /ublox_0/context1 ]
>>>          Username =3D
>>>          AuthenticationMethod =3D chap
>>>          Protocol =3D ip
>>>          Name =3D Internet
>>>          Settings =3D { }
>>>          IPv6.Settings =3D { }
>>>          Active =3D 0
>>>          AccessPointName =3D
>>>          Password =3D
>>>          Type =3D internet
>>>
>>> root(a)colibri-vf:~/test# ./list-modems
>>> [ /ublox_0 ]
>>>      Features =3D net gprs sim
>>>      Emergency =3D 0
>>>      Powered =3D 1
>>>      Lockdown =3D 0
>>>      Interfaces =3D org.ofono.NetworkRegistration org.ofono.ConnectionM=
anager org.ofono.SimManager
>>>      Online =3D 1
>>>      Model =3D TOBY-L210
>>>      Revision =3D 09.71
>>>      Type =3D hardware
>>>      Serial =3D 352255060097262
>>>      Manufacturer =3D u-blox
>>>      [ org.ofono.NetworkRegistration ]
>>>          Status =3D roaming
>>>          Strength =3D 60
>>>          Name =3D Tele2 M2M (E-Plus)
>>>          LocationAreaCode =3D 0
>>>          Mode =3D auto
>>>          MobileCountryCode =3D 262
>>>          Technology =3D hspa
>>>          CellId =3D 16
>>>          MobileNetworkCode =3D 03
>>>      [ org.ofono.ConnectionManager ]
>>>          Powered =3D 1
>>>          Attached =3D 0
>>>          Bearer =3D none
>>>          RoamingAllowed =3D 0
>>>      [ org.ofono.SimManager ]
>>>          ServiceProviderName =3D Tele2 M2M
>>>          Retries =3D [pin2 =3D 3] [puk2 =3D 10] [pin =3D 3] [puk =3D 10]
>>>          MobileCountryCode =3D 240
>>>          FixedDialing =3D 0
>>>          SubscriberNumbers =3D
>>>          PreferredLanguages =3D en
>>>          BarredDialing =3D 0
>>>          CardIdentifier =3D 89462046051001005763
>>>          LockedPins =3D
>>>          MobileNetworkCode =3D 07
>>>          SubscriberIdentity =3D 240075810199181
>>>          Present =3D 1
>>>          PinRequired =3D none
>>>
>>>

Thanks
-- =

Dragos Tatulea
Software Developer @ Endocode AG
dragos(a)endocode.com

Endocode AG, Br=C3=BCckenstra=C3=9Fe 5A, 10179 Berlin
+49 30 1206 4472 | info(a)endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Thomas Fricke, Sebastian Sucker
Aufsichtsratsvorsitzende: Alexandra Boehm

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B

--===============4995371593741708478==--

