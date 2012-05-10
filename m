Content-Type: multipart/mixed; boundary="===============8312496121336534919=="
MIME-Version: 1.0
From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: ofono-tests internet context: DNS works,
 ping wget and ssh do not (Connection Refused)
Date: Thu, 10 May 2012 11:18:14 -0700
Message-ID: <4FAC0666.2050906@linux.intel.com>
In-Reply-To: <4FABDFCE.6050402@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8312496121336534919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 05/10/2012 08:33 AM, Denis Kenzior wrote:
> Hi Darren,
> =

> On 05/09/2012 05:46 PM, Darren Hart wrote:
>> I have successfully used ofono-tests to  enable,online,activate,and
>> create-internet-context. I have an IP address and added the opendns serv=
ers. DNS
>> appears to be working and the route looks sane-ish.
>>
> =

> Please keep in mind that oFono is only signaling settings to an external
> component (e.g. a connection manager like ConnMan).  So route
> assignment, DNS entry assignment, etc are not done by oFono.  oFono only
> brings up the interface and assigns the local IPv4 address.

I should have clarified this a bit. I'm putting together a Board Support
Package (BSP) for the Yocto Project. This involves a kernel config,
sometimes some kernel patches, and listing a set of packages to be
installed.

I have ofono ofono-tests connman and connman-tests. I tried the
connman-gnome UI, but the 3G modem doesn't appear in the UI. I tried the
connman-tests tools which does list the modem in services, but the
connect command times out. I then tried the ofono-tests scripts as
described below. The system obtained the IP address after the
create-internet-context command. As far as I know, connman was not
involved (the 3g connection didn't appear in the connman-gnome UI
afterward).

> =

>> However, ping, wget, and ssh all fail. ping just sits there, wget and ss=
h both
>> fail with Connection Refused.
>>
>> Is there something obvious/common I might be running into?
>>
>> I'm using ofono 1.5. The steps I took for context follow:
>>
>> # ./enable-modem
>> Connecting modem /mbm_0...
>>
>> # ./online-modem
>> Setting modem /mbm_0 online...
>>
>> # ./activate-context
>>
> =

> These steps are fine, is your context pre-configured already?  What does
> the output of list-contexts look like?

How can I tell? Is there some permanent state that gets recorded after
I've run through the above once?

After a reboot, I see the following:

$ ./list-contexts
[ /mbm_0 ]



> =

>> # ./create-internet-context
>> Found context /mbm_0/context1
>>
> =

> Generally you do this _before_ activate_context and you give parameters
> for the context settings.  e.g. create-internet-context
> "apn.operator.com" "username" "password"

OK. I'm new to setting up 3G connectivity. I'm using a prepaid AT&T go
phone sim card. I have successfully sent and received SMS messages from
the device without having to setup any kind of pin or other
authentication credentials. Are these credentials always required - even
with SIM cards? If so, how do I go about discovering what they would be?

If I'm understanding this correctly, there exists one context for the
mbm_0 modem after I ran create-internet-context, and it is no longer
necessary to run create-internet-context again (assuming it was created
correctly).

> =

>> # ifconfig usb0
>> usb0      Link encap:Ethernet  HWaddr 02:80:37:EC:02:00
>>           inet addr:10.25.40.80  Bcast:10.25.40.95  Mask:255.255.255.224
>>           inet6 addr: fe80::80:37ff:feec:200/64 Scope:Link
>>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>           RX packets:6 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:41 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:1000
>>           RX bytes:846 (846.0 B)  TX bytes:28270 (27.6 KiB)
> =

> That looks good.

To test the connman interaction, I disabled connman and setup an entry
in /etc/network/interfaces:

iface usb0 inet dhcp

I then ran "ifup usb0". I got an IP address the route and resolv.conf
were updated automatically. This time there was no inet6 addr. ping,
wget, and ssh are still behaving the same though.

...

>> # ./list-modems =

>> [ /mbm_0 ]
>>     Features =3D gprs net cbs ussd gps sms stk rat sim =

>>     Emergency =3D 0
>>     Powered =3D 1
>>     Lockdown =3D 0
>>     Interfaces =3D org.ofono.ConnectionManager org.ofono.NetworkRegistra=
tion org.ofono.CellBroadcast org.ofono.SupplementaryServices org.ofono.Loca=
tionReporting org.ofono.SmartMessaging org.ofono.PushNotification org.ofono=
.MessageManager org.ofono.SimToolkit org.ofono.RadioSettings org.ofono.SimM=
anager =

>>     Online =3D 1
>>     Model =3D F5521gw
>>     Revision =3D R2A07(R2A07)
>>     Type =3D hardware
>>     Serial =3D 356215040140315
>>     Manufacturer =3D Ericsson
>>     [ org.ofono.ConnectionManager ]
>>         Powered =3D 1
>>         Attached =3D 1
>>         Bearer =3D none
>>         Suspended =3D 0
>>         RoamingAllowed =3D 0
>>     [ org.ofono.NetworkRegistration ]
>>         Status =3D registered
>>         Strength =3D 80
>>         Name =3D AT&T
>>         LocationAreaCode =3D 33998
>>         Mode =3D auto-only
>>         MobileCountryCode =3D 310
>>         Technology =3D hspa
>>         CellId =3D 13805302
>>         MobileNetworkCode =3D 410
> =

> I see you're on AT&T.  What APN are you using, the WAP-only APN or
> something that allows actual internet connections?

This makes it clear to me that I have some research to do. I don't know
what those terms mean, and certainly don't know which APN I am using (or
should be using). I haven't specified one intentionally. Any tips on how
I can determine this?

> =

>>     [ org.ofono.CellBroadcast ]
>>         Topics =3D =

>>         Powered =3D 1
>>     [ org.ofono.SupplementaryServices ]
>>         State =3D idle
>>     [ org.ofono.LocationReporting ]
>>         Type =3D nmea
>>         Enabled =3D 0
>>     [ org.ofono.SmartMessaging ]
>>     [ org.ofono.PushNotification ]
>>     [ org.ofono.MessageManager ]
>>         Alphabet =3D default
>>         UseDeliveryReports =3D 0
>>         Bearer =3D cs-preferred
>>         ServiceCenterAddress =3D +13123149810
>>     [ org.ofono.SimToolkit ]
>>         IdleModeIcon =3D =

>>         MainMenuTitle =3D =

>>         MainMenu =3D =

>>         MainMenuIcon =3D =

>>     [ org.ofono.RadioSettings ]
>>         TechnologyPreference =3D any
>>     [ org.ofono.SimManager ]
>>         Retries =3D [pin2 =3D 3] [puk2 =3D 10] [pin =3D 3] [puk =3D 10] =

>>         MobileCountryCode =3D 310
>>         FixedDialing =3D 0
>>         SubscriberNumbers =3D =

>>         PreferredLanguages =3D en =

>>         BarredDialing =3D 0
>>         CardIdentifier =3D 89014104254691314226
>>         LockedPins =3D =

>>         MobileNetworkCode =3D 410
>>         SubscriberIdentity =3D 310410469131422
>>         Present =3D 1
>>         PinRequired =3D none
>>
> =

> This looks sane?

Does the '?' imply that there is something clearly wrong with this listing?

Thanks,

-- =

Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel

--===============8312496121336534919==--

