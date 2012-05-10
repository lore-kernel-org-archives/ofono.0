Content-Type: multipart/mixed; boundary="===============2069362755861051583=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono-tests internet context: DNS works,
 ping wget and ssh do not (Connection Refused)
Date: Thu, 10 May 2012 14:00:45 -0500
Message-ID: <4FAC105D.6080706@gmail.com>
In-Reply-To: <4FAC0666.2050906@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2069362755861051583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Darren,

>>> However, ping, wget, and ssh all fail. ping just sits there, wget and s=
sh both
>>> fail with Connection Refused.
>>>
>>> Is there something obvious/common I might be running into?
>>>
>>> I'm using ofono 1.5. The steps I took for context follow:
>>>
>>> # ./enable-modem
>>> Connecting modem /mbm_0...
>>>
>>> # ./online-modem
>>> Setting modem /mbm_0 online...
>>>
>>> # ./activate-context
>>>
>>
>> These steps are fine, is your context pre-configured already?  What does
>> the output of list-contexts look like?
> =

> How can I tell? Is there some permanent state that gets recorded after
> I've run through the above once?
> =

> After a reboot, I see the following:
> =

> $ ./list-contexts
> [ /mbm_0 ]
> =


This means there are no contexts.  For MBM they show up after you run
online-modem.

Assuming a brand new, virgin device, oFono runs context provisioning
using mobile-broadband-provider-info.  If you are lucky, the context
will be configured automagically and the list-contexts output will look
something like this:

denkenz(a)localhost ~/ofono-master $ test/list-contexts
[ /mbm_0 ]
    [ /mbm_0/context1 ]
        Username =3D
        Protocol =3D ip
        Name =3D Internet
        Settings =3D { }
        IPv6.Settings =3D { }
        Active =3D 0
        AccessPointName =3D wap.cingular
        Password =3D
        Type =3D internet

The settings are then persisted in /var/lib/ofono/<your sim card's imsi>

If provisioning fails, oFono creates a default, empty context.  It can
be recognized by an empty APN.  In theory activating an empty APN should
fail.

You then need to use create-internet-context to set the settings
manually.  For AT&T the WAP-only APN is wap.cingular, and the data APN
is isp.cingular I believe.

> =

> =

>>
>>> # ./create-internet-context
>>> Found context /mbm_0/context1
>>>
>>
>> Generally you do this _before_ activate_context and you give parameters
>> for the context settings.  e.g. create-internet-context
>> "apn.operator.com" "username" "password"
> =

> OK. I'm new to setting up 3G connectivity. I'm using a prepaid AT&T go
> phone sim card. I have successfully sent and received SMS messages from
> the device without having to setup any kind of pin or other
> authentication credentials. Are these credentials always required - even
> with SIM cards? If so, how do I go about discovering what they would be?
> =


The SIM PIN credentials are separate from GPRS context credentials.
Essentially the SIM PIN locks the SIM card, so the modem cannot read
what is on it until the PIN is entered.  Once the access to the SIM card
is allowed, we can 'dial up' to the network.  Think of the APN details
as old style dial-up modem credentials.  E.g. APN is the phone number,
and the username and password are self-explanatory.

> If I'm understanding this correctly, there exists one context for the
> mbm_0 modem after I ran create-internet-context, and it is no longer
> necessary to run create-internet-context again (assuming it was created
> correctly).
> =


Correct, oFono persists the information in /var/lib/ofono.  You only
need to run create-internet-context if your settings are wrong.

>>
>>> # ifconfig usb0
>>> usb0      Link encap:Ethernet  HWaddr 02:80:37:EC:02:00
>>>           inet addr:10.25.40.80  Bcast:10.25.40.95  Mask:255.255.255.224
>>>           inet6 addr: fe80::80:37ff:feec:200/64 Scope:Link
>>>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>>           RX packets:6 errors:0 dropped:0 overruns:0 frame:0
>>>           TX packets:41 errors:0 dropped:0 overruns:0 carrier:0
>>>           collisions:0 txqueuelen:1000
>>>           RX bytes:846 (846.0 B)  TX bytes:28270 (27.6 KiB)
>>
>> That looks good.
> =

> To test the connman interaction, I disabled connman and setup an entry
> in /etc/network/interfaces:
> =

> iface usb0 inet dhcp
> =

> I then ran "ifup usb0". I got an IP address the route and resolv.conf
> were updated automatically. This time there was no inet6 addr. ping,
> wget, and ssh are still behaving the same though.
> =

> ...
> =


This all sounds correct.  Btw, you can also use
test/process-context-settings to do the above.  It should even do the
DHCP / static assignment correctly.

>>> # ./list-modems =

>>> [ /mbm_0 ]
>>>     Features =3D gprs net cbs ussd gps sms stk rat sim =

>>>     Emergency =3D 0
>>>     Powered =3D 1
>>>     Lockdown =3D 0
>>>     Interfaces =3D org.ofono.ConnectionManager org.ofono.NetworkRegistr=
ation org.ofono.CellBroadcast org.ofono.SupplementaryServices org.ofono.Loc=
ationReporting org.ofono.SmartMessaging org.ofono.PushNotification org.ofon=
o.MessageManager org.ofono.SimToolkit org.ofono.RadioSettings org.ofono.Sim=
Manager =

>>>     Online =3D 1
>>>     Model =3D F5521gw
>>>     Revision =3D R2A07(R2A07)
>>>     Type =3D hardware
>>>     Serial =3D 356215040140315
>>>     Manufacturer =3D Ericsson
>>>     [ org.ofono.ConnectionManager ]
>>>         Powered =3D 1
>>>         Attached =3D 1
>>>         Bearer =3D none
>>>         Suspended =3D 0
>>>         RoamingAllowed =3D 0
>>>     [ org.ofono.NetworkRegistration ]
>>>         Status =3D registered
>>>         Strength =3D 80
>>>         Name =3D AT&T
>>>         LocationAreaCode =3D 33998
>>>         Mode =3D auto-only
>>>         MobileCountryCode =3D 310
>>>         Technology =3D hspa
>>>         CellId =3D 13805302
>>>         MobileNetworkCode =3D 410
>>
>> I see you're on AT&T.  What APN are you using, the WAP-only APN or
>> something that allows actual internet connections?
> =

> This makes it clear to me that I have some research to do. I don't know
> what those terms mean, and certainly don't know which APN I am using (or
> should be using). I haven't specified one intentionally. Any tips on how
> I can determine this?
> =


If you are using an AT&T GoPhone SIM then likely you're limited to
WAP-only network, not a real internet connection.  The easy way to tell
is to run

test/create-internet-context "isp.cingular"

And then try to activate the context.

>>
>>>     [ org.ofono.CellBroadcast ]
>>>         Topics =3D =

>>>         Powered =3D 1
>>>     [ org.ofono.SupplementaryServices ]
>>>         State =3D idle
>>>     [ org.ofono.LocationReporting ]
>>>         Type =3D nmea
>>>         Enabled =3D 0
>>>     [ org.ofono.SmartMessaging ]
>>>     [ org.ofono.PushNotification ]
>>>     [ org.ofono.MessageManager ]
>>>         Alphabet =3D default
>>>         UseDeliveryReports =3D 0
>>>         Bearer =3D cs-preferred
>>>         ServiceCenterAddress =3D +13123149810
>>>     [ org.ofono.SimToolkit ]
>>>         IdleModeIcon =3D =

>>>         MainMenuTitle =3D =

>>>         MainMenu =3D =

>>>         MainMenuIcon =3D =

>>>     [ org.ofono.RadioSettings ]
>>>         TechnologyPreference =3D any
>>>     [ org.ofono.SimManager ]
>>>         Retries =3D [pin2 =3D 3] [puk2 =3D 10] [pin =3D 3] [puk =3D 10] =

>>>         MobileCountryCode =3D 310
>>>         FixedDialing =3D 0
>>>         SubscriberNumbers =3D =

>>>         PreferredLanguages =3D en =

>>>         BarredDialing =3D 0
>>>         CardIdentifier =3D 89014104254691314226
>>>         LockedPins =3D =

>>>         MobileNetworkCode =3D 410
>>>         SubscriberIdentity =3D 310410469131422
>>>         Present =3D 1
>>>         PinRequired =3D none
>>>
>>
>> This looks sane?
> =

> Does the '?' imply that there is something clearly wrong with this listin=
g?
> =


Nah, it all looks good.

Regards,
-Denis

--===============2069362755861051583==--

