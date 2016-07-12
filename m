Content-Type: multipart/mixed; boundary="===============5515563314600306572=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: Re: designated way for modems disappearing from bus during +CFUN=1
Date: Tue, 12 Jul 2016 15:02:17 +0200
Message-ID: <e713d9b4-3597-ff8b-56e9-f265ed9db3e5@endocode.com>
In-Reply-To: <20160711173751.GD5250@nataraja>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5515563314600306572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 07/11/2016 07:37 PM, Harald Welte wrote:
> Dear all,
> =

> I've been struggling for quite some time to find out what is the
> designated way in ofono to deal with modems that actually perform a
> cold/warm reset (and hence USB device stack reset) when you send them an
> AT+CFUN=3D1 message.
> =

> Examples for this are e.g. the Sierra Wireless SL808x series of modems,
> where this behavior is documented and expected.  But I'm sure there are
> others, at least I recall having seen this several times in the past.
> =

> It is somewhat logical, as a +CFUN+1 is supposed to reset _all_ of the
> status in the modem, not just the protocol stack. So the fact that most
> modems don't disappear from the bus afterwards actually means that they
> are cheating.
> =

> The actual behavior of ofono with such a modem is:
> =

> * modem first appears as a /wavecom_X device
> * if you issue enable_modem via dbus, the modem goes thrugh CFUN=3D1
> * the modem disappears from USB, ofono destroys its structures
> * the client program (e.g. the one from tests/) simply hangs and fails
>   at timeout
> * the modem re-enumerates on the bus and ofono creates a new /wavecom_Y
>   device, where Y !=3D the X before the modem restart.
> =

> So for an application it is not possible to continue to talk to one
> modem via dbus accross modem resets.
> =

> Not issuing a +CFUN=3D1 is also not really an option, as then you loose
> the ability to completely disable the modem.  +CFUN=3D4 can be used to
> force an IMSI detach and disable it from the network point of view, but
> the modem is still talking to the SIM card and will not re-read SIM
> card state if brought back online from +CFUN=3D4.
> =

Hmm, this is interesting. As you have noticed, oFono sends a +CFUN=3D4 when
calling enable_modem. The +CFUN=3D1 is set when calling online_modem.

Does the modem even get online? Considering the fact that it triggers
the reset which triggers a disconnection event which should trigger a
modem struct destruction + recreation. Or you can configure whether AT+CFUN=
=3D1
will do a warm or cold reset?

> I'm sure this issue has been seen before, and somebody must have a
> solution for it - or at least some ideas on how to solve this in a ofono
> driver plugin.  I'm willing to spend some time on it, but my
> experience/exposure to the code base is limited.
> =


(I am assuming udevng plugin is used)

The path/name is set by ofono_modem_create. The function is called with a
NULL name from udevng plugin [1] which makes it use the "/name_number"
scheme [2]. This number is the next_modem_id variable which only goes
up.

I see 2 possible ways of changing this scenario:
- Track modem-struct-to-id mappings and release mapping once modem struct
  dissapears. So that on next creation it will re-use the same id.
- Pass down a name from udevng.c.

This might not be the ideal way to do things though. Maybe Denis has
better ideas about this.

[1] http://git.kernel.org/cgit/network/ofono/ofono.git/tree/plugins/udevng.=
c#n1298
[2] http://git.kernel.org/cgit/network/ofono/ofono.git/tree/src/modem.c#n18=
60


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

--===============5515563314600306572==--

