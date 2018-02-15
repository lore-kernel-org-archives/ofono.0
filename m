Content-Type: multipart/mixed; boundary="===============6760902013690169835=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: [PATCH] udevng: Add OFONO_PATHNAME property to set modem dbus
 path name
Date: Thu, 15 Feb 2018 09:47:11 +0100
Message-ID: <8a51aff7-b963-0097-befd-4b6d2e6117d8@kerlink.fr>
In-Reply-To: <bc1a28ea-8d0b-6eae-8123-86aaa8873945@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6760902013690169835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pau, hi Denis,


On 02/14/2018 09:31 PM, Denis Kenzior wrote:
> Hi Pau,
>
>> As far as I understand the IMEI is available in =

>> org.ofono.Modem.GetProperties "Serial" property. To be able to access =

>> this information, I need to previously power on the modem =

>> (SetProperty Powered true), otherwise it doesn't show up.
>> Which means that for an ofono user, it is a requirement to power on =

>> the modem and thus use it before being able to identify it.
>
> Correct, but why is this a problem?=C2=A0 Under normal circumstances the =

> modems are auto-powered by connman anyway.=C2=A0 That's the only reason =

> that oFono doesn't do this automagically.
>
>>
>> Simple case: Several modems attached to a PC, in order to find the =

>> one I'm interested in I need to power on all of them and find which =

>> one matches a given IMEI. Really? Do I need this if I know where is =

>> my device always physically attached? Are you going through all your =

>> network interfaces and check against its MAC address to find the one =

>> you are interested in? Or you configure your network manager based on =

>> interface names? Would you enjoy it if your enp0s25 interface was =

>> suddenly named enp1s67? Specially if you have iptables rules, I bet =

>> that's going to be funny.
>>
>> More complex case (my scenario): Again, I repeat: To identify a =

>> modem, as of now, you seem to require to power it on (use it, change =

>> its state) before identifying it. Now think of a system which has a =

>> config file with modems available on the system (with its dbus paths) =

>> and a resources database of modems (and other types of resources) =

>> currently in use. Now imagine several processes reserving any =

>> specific subset of modems with specific capabilities (in parallel) =

>> against the resources database, then using them and among the use =

>> cases they power off and power them on. Even if you have locking =

>> mechanism in the database, it's a nightmare, because again, you must =

>> use a modem before identifying it, meaning you either race condition =

>> with other processes using the modem you are identifying (eg. by =

>> powering it on, or leaving it powered on after identifying it, or =

>> while powering it off after identifying while other process is =

>> starting to use it).
> oFono doesn't expose hardware details, only hardware capabilities.=C2=A0 =
So =

> I understand how this is helpful for your usecase, but I'm not =

> convinced this is relevant for what oFono was designed to do.
>
>>
>> Then the easy way: Each modem is assigned a unique persistent path, =

>> and that's the one always being presented and used. No need to =

>> identify it, I already know which modem is which. If I have several =

>> system setups, I can assign same names in all systems for easy use, =

>> etc. >
>> So the question should be better: Why should it NOT be deterministic?
>>
>
> In general oFono does not use deterministic paths, the Manager APIs =

> should be used to query the list of objects.=C2=A0 In fact the docs even =

> specifically state that the modem object path might have a variable =

> prefix (e.g. a random number) and that variable prefix can change =

> across oFono boots.=C2=A0 This is mainly to encourage UI/client writers t=
o =

> use the APIs properly.
>
> We have used hardcoded paths in one or two cases for synthetic test =

> cases (e.g. stktest) but those are highly special and not user-visible =

> anyhow.
>
>>
>>>
>>> How are you making sure that dbus path is valid? ofono_modem_create =

>>> can fail after all...
>>
>> Yes, it can fail while validating the path (dbus_validate_path) which =

>> is expected if a bad OFONO_PATHMNAME is supplied. If it's fine for =

>> you, I can add an error message there stating that dbus_validate_path =

>> failed and printing the pathname. Agree?
>
> Go ahead and send a V2, I'll let it sit for a week or so to see if =

> anyone else gives any feedback.

I have the same use case on my boards: several modems and I need to know =

where they physically are to be able to power the one I want and to =

physically reset a none working modem (using gpios corresponding to its =

hardware position). So I have a patch in Ofono to do that.
I have added a ModemSyspath property in org.ofono.Modem displaying dbus =

path. The patch is good enough for me but maybe not for upstream. As =

information comes from udevng plugin, this property might be in a =

specific interface added in udevng plugin and not in org.ofono.Modem.

This is just another way to have needed information (without changing =

modem name). I'll send my patch.

Christophe


--===============6760902013690169835==--

