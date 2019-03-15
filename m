Content-Type: multipart/mixed; boundary="===============6595876921891787051=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [RFC PATCH 1/1] ublox: create only 1 gprs context
Date: Fri, 15 Mar 2019 08:42:23 +0100
Message-ID: <d391b873-ef59-c91f-369f-ed3b4b395789@norrbonn.se>
In-Reply-To: <1883c433-e0e2-6086-e396-583bcc438f26@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6595876921891787051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 15/03/2019 02:27, Denis Kenzior wrote:
> Hi Jonas,
> =

> On 03/14/2019 05:37 PM, Jonas Bonn wrote:
>> ---
>>
> =

> Funny, I was looking at this code today and thought it was wrong.=C2=A0 W=
as =

> going to point this out to you, but you beat me to it ;)
> =

>> Here's something that I'm having trouble understanding.=C2=A0 The ublox
>> plugin creates 8 gprs_context atoms.=C2=A0 As far as I can tell, this me=
ans
>> that ofono will allow it to activate 8 contexts simultaneously... right?
>>
> =

> Correct.=C2=A0 Each context driver added to gprs allows a concurrent cont=
ext =

> to be activated.=C2=A0 E.g. if you have 2 drivers, you can activate 2 =

> contexts simultaneously.=C2=A0 Obviously you need a high speed / ppp =

> interface for each active context.
> =

>> Why is the ublox plugin the only one that does this?=C2=A0 Do other mode=
ms
>> not support multiple active contexts?=C2=A0 Or is this plugin wrong?
> =

>  From what I recall, ublox does claim to support multiple PDP contexts =

> active at the same time.=C2=A0 However, I don't know how this works in =

> practice as you need a unique network interface for each one.=C2=A0 As it =

> stands today, given the udevng detection logic, this plugin is wrong.

Right, so the way this works is that the modem looks like either a =

"bridge" or a "router".  If configured as a "bridge", the outbound =

packet's source address is used to determine which context to use; if =

configured as a "router", the outbound packet's destination _network_ is =

used to determine which context to use and a default route is set via =

the _first activated context_ for packets that don't match the network =

of any active context.  That's a mouthful...!!!

The short of it is that this probably works in practice.

Is it ok for the connection manager interface to see multiple active =

contexts with the same Interface and the IP settings set to method =

"dhcp".  Will it run a DHCP client on each interface or is it expected =

to be smart enough to recognize the common interface???  What would the =

point be since the only thing that differs the contexts is the APN and =

the connection manager shouldn't care about that particular detail...??? =

  This all applies to "router" mode only, really.

In "bridge" mode, the above is probably moot since each context would =

announce different IP settings and the connection manager would be =

expected to apply those settings to the common interface.  No idea if =

this works in practice.

Do you know how these multiple, active contexts are used in practice? =

In particular with regard to ofono?

> =

>>
>> If I were to follow the model of other plugins, the below patch would
>> seem appropriate...
>>
>> A bit of insight here would be appreciated.
> =

> There are drivers for USB based modems that do this properly.=C2=A0 See =

> xmm7xxx for example.=C2=A0 Multiple PDP context support was added to that =

> recently.
> =

> Modems that used multiplexing had support for multiple PDP contexts for =

> quite some time.=C2=A0 E.g. plugins/ifx, etc.
> =

> Anyway, patch looks fine to me.=C2=A0 Let me know if you want me to apply=
 it =

> or you want to take a stab at fixing the detection logic.

 From this, it sounds like the multiple gprs-context atoms are probably =

correct.  I'll take a look at the xmm7xxx driver and see how it handles =

things.

Thanks,
Jonas

--===============6595876921891787051==--

