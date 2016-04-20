Content-Type: multipart/mixed; boundary="===============7401372854016322866=="
MIME-Version: 1.0
From: Yorn <yorn@gmx.net>
Subject: Re: Ublox Toby Modem
Date: Wed, 20 Apr 2016 16:11:27 +0200
Message-ID: <57178E0F.7000904@gmx.net>
In-Reply-To: <57178134.7070200@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7401372854016322866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

+ adding ofono mailinglist as it may be of interest

Point is, that I am trying to run the u-blox on ofono+connman and =

had/have some questions regarding the setup.
I compiled the git version of the ofono for a freescale vf610 board with =

an onboard ublox usb adapter and got quite far.

A manual setup on pppd+peer+provider+chat script gave me a clean =

internet connection.

Now I want to integrate that with ofono/connman. I got ofono finding the =

module, advertise it as a cellular technology to connman, but no service =

is showing up.

I will go on setting up the umts high throughput profile.

So the rest of the story can be found below!

@Dragos:
without any changes, I got
lsusb:
1546:1146 U-Blox AG (which is high performance?)

online modem runs without any complains, but without any changes
root(a)colibri-vf:~/test# ./online-modem
Setting modem /ublox_0 online...


BR - Yorn (J=C3=B6rn)


Am 20.04.2016 um 15:16 schrieb Dragos Tatulea:
> Hi J=C3=B6rn,
>
> Can we take this discussion to the connman/ofono ml? Other people
> might find this useful.
>
> On 04/20/2016 03:01 PM, J=C3=B6rn wrote:
>> Hi Dragos,
>>
>> I got python to work for the test scripts, this is what it gave [1]. I b=
elieve I am just a minute away ..
>>
> Good.
>
>> I got the connection up and running on a manual (old fassioned) way with=
 pppd, chat and provider script. However I am not an expert on ofono/connma=
n yet (but trying hard ...).
>>
>> I firstly wanted to use 2g/3g with high performance mode (as I saw your =
effort has been put on this point, right?). I am rather not sure, how to co=
nfigure that without having a connman service.
> The AT Commands Examples [1] documents that (USB configuration section).
> You should change the mode manually. A successful set will yield the
> following ids from lsusb:
>
> 1546:1140 U-Blox AG
>
>
>> BR - J=C3=B6rn
>>
>> [1]
>> root(a)colibri-vf:~/test# ./activate-context
>> Error activating /ublox_0/context1: org.ofono.Error.NotAttached: GPRS is=
 not attached
>> root(a)colibri-vf:~/test# ./list-contexts
>> [ /ublox_0 ]
>>      [ /ublox_0/context1 ]
>>          Username =3D
>>          AuthenticationMethod =3D chap
>>          Protocol =3D ip
>>          Name =3D Internet
>>          Settings =3D { }
>>          IPv6.Settings =3D { }
>>          Active =3D 0
>>          AccessPointName =3D
>>          Password =3D
>>          Type =3D internet
>>
>> root(a)colibri-vf:~/test# ./list-modems
>> [ /ublox_0 ]
>>      Features =3D net gprs sim
>>      Emergency =3D 0
>>      Powered =3D 1
>>      Lockdown =3D 0
>>      Interfaces =3D org.ofono.NetworkRegistration org.ofono.ConnectionMa=
nager org.ofono.SimManager
>>      Online =3D 1
>>      Model =3D TOBY-L210
>>      Revision =3D 09.71
>>      Type =3D hardware
>>      Serial =3D 352255060097262
>>      Manufacturer =3D u-blox
>>      [ org.ofono.NetworkRegistration ]
>>          Status =3D roaming
>>          Strength =3D 60
>>          Name =3D Tele2 M2M (E-Plus)
>>          LocationAreaCode =3D 0
>>          Mode =3D auto
>>          MobileCountryCode =3D 262
>>          Technology =3D hspa
>>          CellId =3D 16
>>          MobileNetworkCode =3D 03
>>      [ org.ofono.ConnectionManager ]
>>          Powered =3D 1
>>          Attached =3D 0
>>          Bearer =3D none
>>          RoamingAllowed =3D 0
>>      [ org.ofono.SimManager ]
>>          ServiceProviderName =3D Tele2 M2M
>>          Retries =3D [pin2 =3D 3] [puk2 =3D 10] [pin =3D 3] [puk =3D 10]
>>          MobileCountryCode =3D 240
>>          FixedDialing =3D 0
>>          SubscriberNumbers =3D
>>          PreferredLanguages =3D en
>>          BarredDialing =3D 0
>>          CardIdentifier =3D 89462046051001005763
>>          LockedPins =3D
>>          MobileNetworkCode =3D 07
>>          SubscriberIdentity =3D 240075810199181
>>          Present =3D 1
>>          PinRequired =3D none
>>
>>
> Hmm, not sure what the roaming state is. But it looks like it's not yet
> ready to attach the gprs context (Attached is not yet 1).
>
> Can you try running online-modem script? Maybe it will work.
>
>>
>> Am 20.04.2016 um 12:59 schrieb Dragos Tatulea:
>>> Hi J=C3=B6rn,
>>>
>>> On 04/20/2016 12:02 PM, J=C3=B6rn wrote:
>>>> Hi Dragos,
>>>>
>>>> thanks for your quick reply!
>>>>
>>>> What I did is the following:
>>>>
>>>> connmanctl> enable cellular
>>>> Error cellular: Already enabled  <- due to the second time
>>>> cconnmanctl> technologies
>>>> /net/connman/technology/cellular
>>>>     Name =3D Cellular
>>>>     Type =3D cellular
>>>>     Powered =3D True
>>>>     Connected =3D False
>>>>     Tethering =3D False
>>>> /net/connman/technology/ethernet
>>>>     Name =3D Wired
>>>>     Type =3D ethernet
>>>>     Powered =3D True
>>>>     Connected =3D True
>>>>     Tethering =3D False
>>>> connmanctl> services
>>>> *AO Wired                ethernet_00142d4ac28f_cable
>>>>
>>>> Is there something else to activate?
>>>>
>>>> I am actually trying to transfer the python test scripts to my embedde=
d system, but there is no python3 available on open embedded, and so I do n=
ot have dbus access from there :(.
>>>>
>>> The python scripts are really useful. Especially to investigate the sta=
te
>>> of oFono. See list-modems and list-contexts.
>>>
>>>> I am not sure, what a context is...
>>>>
>>> A context is oFono's concept of a "connection to internet" :). For 2/3G=
 there
>>> are 3 states to enable the internet connection:
>>> * enable the modem (done by connman in your case)
>>> * register to the network (might be done by connman, list-modems will
>>>     help you debug that)
>>> * activate context (sometimes done by connman, list-contexts will
>>> tell you the state of the context)
>>>
>>>   =

>>>> BR - J=C3=B6rn
>>>>
>>>>
>>>> Am 20.04.2016 um 11:20 schrieb Dragos Tatulea:
>>>>> Hi J=C3=B6rn,
>>>>>
>>>>> On 04/20/2016 09:44 AM, J=C3=B6rn wrote:
>>>>>> Hi Dragos
>>>>>>
>>>>>> I saw, you wrote some code for the toby ublox modem on ofono.
>>>>>> I am actually setting up an embedded system using that modem and got=
 some issues with the latest ofono git and connman.
>>>>>>
>>>>>> The ofono deamon seem to recognize the modem and connman shows the c=
ellular technologie but there is no service shown on connman.
>>>>>>
>>>>> Are you using LTE or 2/3G? If 2/3G, did you activate the context? Con=
nman
>>>>> will create a service for every activated context.
>>>>>    =

>>> So, are you using LTE or 2/3G? And also, which version of Toby are you
>>> using and in which mode (high throughput, fairly compatible or backward
>>> compatible). We used only high throughput mode so far.
>>>
>>> Thanks
> Once again, let's move the discussion to the mailing list please.
>
> [1] - https://www.u-blox.com/sites/default/files/AT-CommandsExamples_AppN=
ote_(UBX-13001820).pdf
>
> Thanks


--===============7401372854016322866==--

