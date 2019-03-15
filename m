Content-Type: multipart/mixed; boundary="===============0991018092270030406=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/1] ublox: create only 1 gprs context
Date: Fri, 15 Mar 2019 11:28:35 -0500
Message-ID: <e3343eef-12ff-4f9f-10dd-5ec0a3392e21@gmail.com>
In-Reply-To: <d391b873-ef59-c91f-369f-ed3b4b395789@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0991018092270030406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>> =C2=A0From what I recall, ublox does claim to support multiple PDP conte=
xts =

>> active at the same time.=C2=A0 However, I don't know how this works in =

>> practice as you need a unique network interface for each one.=C2=A0 As i=
t =

>> stands today, given the udevng detection logic, this plugin is wrong.
> =

> Right, so the way this works is that the modem looks like either a =

> "bridge" or a "router".=C2=A0 If configured as a "bridge", the outbound =

> packet's source address is used to determine which context to use; if =

> configured as a "router", the outbound packet's destination _network_ is =

> used to determine which context to use and a default route is set via =

> the _first activated context_ for packets that don't match the network =

> of any active context.=C2=A0 That's a mouthful...!!!

Ugh.  Both of these are really not ideal.  I'd really rather have the =

host manage all these details than having the modem do it.  Oh well.

I take it that in bridged mode we should be setting multiple IP =

addresses to the network interface?

> =

> The short of it is that this probably works in practice.
> =


That depends.  I suspect that it might not 'just work' for certain =

classes of applications running on the host / application processor side.

> Is it ok for the connection manager interface to see multiple active =

> contexts with the same Interface and the IP settings set to method =

> "dhcp".=C2=A0 Will it run a DHCP client on each interface or is it expect=
ed =

> to be smart enough to recognize the common interface???=C2=A0 What would =
the =

> point be since the only thing that differs the contexts is the APN and =

> the connection manager shouldn't care about that particular detail...??? =

>  =C2=A0This all applies to "router" mode only, really.

uBlox is just being too smart here.  The whole bridged vs router stuff =

was never intended by 27.007.  They made this all up themselves. =

Neither oFono nor ConnMan were designed to handle such a setup.

The main issue will be for contexts used for MMS / OMA DM.  My memory =

from the Meego / Tizen days is fuzzy, but from what I recall we designed =

oFono with the assumption that we will always get an IP address and a =

separate interface for the MMS context.

There's also the proxy.  MMS contexts frequently have a proxy associated =

with them.  Again, we assumed that if a proxy is set, then it is also in =

a form of an IP address.  The proxy is then added as a route on the =

interface by oFono (see pri_setproxy for details).  And in practical =

terms there is no domain name resolution for these contexts.  Everything =

just goes to the proxy.

This was how e.g. mmsd was designed to work.  See =

https://git.kernel.org/pub/scm/network/ofono/mmsd.git.  That project has =

not been touched in some time though, but there are others that act very =

similar.

> =

> In "bridge" mode, the above is probably moot since each context would =

> announce different IP settings and the connection manager would be =

> expected to apply those settings to the common interface.=C2=A0 No idea i=
f =

> this works in practice.

Right.  Do note that oFono is responsible for setting the IP on the =

interface.  So in bridged mode, this would need to be fixed.  Also, I =

don't know whether connman supports multi-IP interfaces in the first place.

Another issue is that ConnMan ignores all contexts that are not of type =

Internet.  So for example, nobody (or at least neither oFono, nor =

ConnMan) would set the domain name servers for MMS contexts.

> =

> Do you know how these multiple, active contexts are used in practice? In =

> particular with regard to ofono?
> =


They are used, yes.  MMS, OMA DM/device provisioning, etc.

>>
>>>
>>> If I were to follow the model of other plugins, the below patch would
>>> seem appropriate...
>>>
>>> A bit of insight here would be appreciated.
>>
>> There are drivers for USB based modems that do this properly.=C2=A0 See =

>> xmm7xxx for example.=C2=A0 Multiple PDP context support was added to tha=
t =

>> recently.
>>
>> Modems that used multiplexing had support for multiple PDP contexts =

>> for quite some time.=C2=A0 E.g. plugins/ifx, etc.
>>
>> Anyway, patch looks fine to me.=C2=A0 Let me know if you want me to appl=
y =

>> it or you want to take a stab at fixing the detection logic.
> =

>  From this, it sounds like the multiple gprs-context atoms are probably =

> correct.=C2=A0 I'll take a look at the xmm7xxx driver and see how it hand=
les =

> things.
> =


So this is still debatable :)

Regards,
-Denis

--===============0991018092270030406==--

