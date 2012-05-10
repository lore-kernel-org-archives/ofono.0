Content-Type: multipart/mixed; boundary="===============3470133528167726009=="
MIME-Version: 1.0
From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: ofono-tests internet context: DNS works,
 ping wget and ssh do not (Connection Refused)
Date: Thu, 10 May 2012 14:50:31 -0700
Message-ID: <4FAC3827.4000802@linux.intel.com>
In-Reply-To: <4FAC2B51.3080109@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3470133528167726009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 05/10/2012 01:55 PM, Darren Hart wrote:
> =

> =

> On 05/10/2012 12:00 PM, Denis Kenzior wrote:
>> Hi Darren,
>>
>>>>> However, ping, wget, and ssh all fail. ping just sits there, wget and=
 ssh both
>>>>> fail with Connection Refused.
>>>>>
>>>>> Is there something obvious/common I might be running into?
>>>>>
>>>>> I'm using ofono 1.5. The steps I took for context follow:
>>>>>
>>>>> # ./enable-modem
>>>>> Connecting modem /mbm_0...
>>>>>
>>>>> # ./online-modem
>>>>> Setting modem /mbm_0 online...
>>>>>
>>>>> # ./activate-context
>>>>>
>>>>
>>>> These steps are fine, is your context pre-configured already?  What do=
es
>>>> the output of list-contexts look like?
>>>
>>> How can I tell? Is there some permanent state that gets recorded after
>>> I've run through the above once?
>>>
>>> After a reboot, I see the following:
>>>
>>> $ ./list-contexts
>>> [ /mbm_0 ]
>>>
>>
>> This means there are no contexts.  For MBM they show up after you run
>> online-modem.
>>
>> Assuming a brand new, virgin device, oFono runs context provisioning
>> using mobile-broadband-provider-info.  If you are lucky, the context
>> will be configured automagically and the list-contexts output will look
>> something like this:
>>
>> denkenz(a)localhost ~/ofono-master $ test/list-contexts
>> [ /mbm_0 ]
>>     [ /mbm_0/context1 ]
>>         Username =3D
>>         Protocol =3D ip
>>         Name =3D Internet
>>         Settings =3D { }
>>         IPv6.Settings =3D { }
>>         Active =3D 0
>>         AccessPointName =3D wap.cingular
>>         Password =3D
>>         Type =3D internet
> =

> =

> In my case, AccessPointName is empty.
> =

>>
>> The settings are then persisted in /var/lib/ofono/<your sim card's imsi>
> =

> # cat /var/lib/ofono/310410469131422/gprs
> =

> [Settings]
> Powered=3Dtrue
> RoamingAllowed=3Dfalse
> =

> [context1]
> Name=3DInternet
> AccessPointName=3D
> Username=3D
> Password=3D
> Type=3Dinternet
> Protocol=3Dip
> =

> =

>>
>> If provisioning fails, oFono creates a default, empty context.  It can
>> be recognized by an empty APN.  In theory activating an empty APN should
>> fail.
>>
>> You then need to use create-internet-context to set the settings
>> manually.  For AT&T the WAP-only APN is wap.cingular, and the data APN
>> is isp.cingular I believe.
>>
> =

> =

> OK:
> =

> # ./create-internet-context isp.cingular
> Found context /mbm_1/context1
> Setting APN to isp.cingular
> =

> root(a)fri2:/usr/lib/ofono/test# cat /var/lib/ofono/310410469131422/gprs
> =

> [Settings]
> Powered=3Dtrue
> RoamingAllowed=3Dfalse
> =

> [context1]
> Name=3DInternet
> AccessPointName=3Disp.cingular
> Username=3D
> Password=3D
> Type=3Dinternet
> Protocol=3Dip
> =


Per some random set of instructions I found on the intertubes:

http://www.unlockit.co.nz/unlockit/?p=3D587

I've updated the context:


AccessPointName=3Dwap.cingular
Username=3DWAP(a)CINGULARGPRS.COM
Password=3DCINGULAR1

I still get an IP address via DHCP and name resolution is working, but
my ping,wget,ssh tests fail.

A colleague allowed me to bottow his AT&T phone. I used this SIM card
and he had the same APN and Username entered in the phone (assuming same
password, wasn't visible and he didn't want me to change it just in case
:-). His phone reported an "EDGE" connection and successfully, albeit
SLOWLY, displayed web pages.

So this suggests to me that the SIM can do IP and not just WAP. However,
it says EDGE (2G?), does ofono support EDGE? I am I off in the weeds now?

-- =

Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel

--===============3470133528167726009==--

