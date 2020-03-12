Content-Type: multipart/mixed; boundary="===============8564203876475593314=="
MIME-Version: 1.0
From: Tarmo Kuuse <tarmo.kuuse@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Thu, 12 Mar 2020 21:17:52 +0200
Message-ID: <4ae9db94-dd37-b629-c474-2a67b72d4277@gmail.com>
In-Reply-To: <4f4cb0f7-03e9-47c5-3663-6a984909aac6@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8564203876475593314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cristophe,

On 12.03.20 17:51, Christophe Ronco wrote:
>>>> In my case automatic provisioning always fails:
>>>> - the database has multiple entries for basically every
>>>> operator/country
>>>
>>> mbpi is just not a very good database.=C2=A0 It provides lots of
>>> duplicates and doesn't distinguish by spn last I checked.=C2=A0 Ubuntu
>>> Touch folks used the android apndb and others used custom ones.=C2=A0 As
>>> far as I'm aware, ofono + mbpi was never used in production.=C2=A0 If I=
'm
>>> wrong, I'd love to hear about it.
>>>
>>> I have discouraged the use of mbpi for these reasons.=C2=A0 Not stopping
>>> you from using it, just pointing out what has been done historically.
>>
>> As I understand it, ofono is designed to automatically pick the
>> correct service provider parameters (primarily APN) for the installed
>> SIM - unlike a simple solution like pppd. When arriving to the
>> connman/ofono community I found it very difficult getting my widget
>> online when ofono refuses to use the ready-to-use mbpi database and
>> authoritative response is "mbpi is bad, don't used it".
>>
>> I don't see how am I going to solve this. The end user cannot
>> configure the device (there's no user interaction whatsoever). I could
>> not find the mythical Android database at the time (I do now - it's at
>> https://android.googlesource.com/device/sample/+/master/etc/apns-full-co=
nf.xml).
>> It contains many duplicates, because the virtual MNO-s share MCC and
>> MNC-s with the physical ones. That's how the mobile networks are built
>> in the real world. So I was very confused about how to proceed.
>>
>> Sure, after much, much frustration I arrived to the workaround of
>> manually provisioning APNs (which I stole from mbpi!) for each factory
>> installed SIM through Christophe Ronco's file-provision plugin. This
>> plugin is a life-saver, but it certainly falls short of automatic
>> provisioning. That's the same level of sophistication as pppd. And as
>> extra punishment I have to write a network supervisor which orders
>> connman to actually use the service of a new SIM whenever it is
>> replaced - even if it's from the same MNO. But that's a different rant
>> altogether.
> =

> Thanks! Happy to see this is used outside my company.

It's very useful. Either I've misunderstood something, or it's the only =

usable method for manually provisioning SIMs in ofono.

> I assume we are in the same case, once our device is on field, there is
> no end user to configure anything. So we need automatic choices or in
> factory provisioning.
> =

> In my case, I wouldn't want multiple contexts to be created from mbpi
> database. If I could choose today, I would totally remove mbpi database
> from our product. Some of our clients have a private APN and I am always
> afraid that they can connect with a public APN instead of using the
> specific, secure, with QoS network they have negotiated with their
> network operator.
> =

> I know it's a pain to configure APN (and it's a lot worth for support
> team than for me) but saying "we will magically select an APN, don't
> bother with that" seems dangerous to me.

I agree, it's dangerous to automatically provision stuff in GSM networks.

However, if my options include:

a) support case for almost every customer in another country who needs =

to insert any unseen-by-me, commodity SIM (so I could ask them which SIM =

they inserted, determine the APN, update provisioning file; very =

politely ask customer to take the gadget to office, open waterproof =

enclosure, connect Ethernet; push the updated provisioning file, verify =

dialup; finally ask customer to close enclosure and take it to site).

b) support case only for customers with SIMs that require non-standard =

provisioning, private APNs and other corner cases.

... option b) would win. I _was_ the support team, among other things. =

Option a) was the only option for a few years because I used pppd for =

dialup. I had hoped to fix it with ofono and mbpi.

There are partial workarounds. Unrestricted roaming in EU means we could =

ship gadgets with our own SIMs instead of badgering customers. Apart =

from that it was often a struggle and a waste of time getting commodity =

SIMs in other countries to connect.

I guess the user should eventually be able to set the APN on their own, =

e.g. via Bluetooth. This takes non-trivial effort, though.

> About your problem with ConnMan and first connection with a new SIM, I
> have a patch in ConnMan to handle that (and roaming SIM cards also if I
> remember well). We can discuss that outside the list if it can help.

Thank you for the kind offer. I would otherwise accept it, but I've left =

the job. As a stopgap measure I had a script which poked ConnMan and =

ofono via dbus until they accepted a new SIM and connected.

--
Kind regards,
Tarmo
--===============8564203876475593314==--

