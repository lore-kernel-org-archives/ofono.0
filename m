Content-Type: multipart/mixed; boundary="===============2086929921990965440=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 14:46:47 +0200
Message-ID: <2987728d1cd242b2a0e024b4c321c6ec@chewa.net>
In-Reply-To: <1251892966.1266.74.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2086929921990965440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 02 Sep 2009 05:02:46 -0700, Marcel Holtmann <marcel@holtmann.org>
wrote:
> I mentioned that already. We do wanna store something like Type that
> says internet, mms, wap etc. The only comment here was that for network
> initiated context we have no idea of its intent.

And we do not want to.

>> The attachment to the GPRS network in this proposal is bit vague. To
>> my understanding, to attach the GPRS you need to set "Powered"
>> property on and "RoamingAllowed" on. To detach you need to set the
>> "Powered" property off. Since attaching can take a long time (or
>> fail), does this mean that the attach errors are handled in the
>> "Powered" property setter callback?  Or what happens when (during
>> roaming) the "Powered" is already on and the user puts the
>> "RoamingAllowed" on -- where are the attach errors handled? I kind of
>> think that it might be a better idea to just expose the GPRS
>> registration status and the attach status, and let a higher level
>> component explicitly set the attach/detach with either a readwrite
>> property or Attach() and Detach() methods.
> =

> Powered =3D on and RoamingAllowed =3D yes and Roaming =3D true will lead =
to
> auto-attach.

That's just _idiotic_ from the naming perspective.

A modem can have radio on or off. Whether this is done by completely
powering the modem off, or by going into some kind of flight mode, is
driver-specific. Hence the "powered" name is semantically wrong. When
possible, it's actually best to keep the modem in flight mode, so that e.g.
the SIM is still usable.

The story is basically the same with roaming. Roaming means you are outside
your home network. It does not mean that you want to auto-attach or not.
Some people _never_ want to auto-attach, and some people _always_ want to
auto-attach. In fact, different operators have different requirements with
that regard. Sure, some people want to auto-attach if and only if not
roaming. Given that roaming is not just about GPRS, the name is wrong and
confusing. But more importantly, we need t support turning the radio on
while in the home network yet _not_ attach automatically. This has operator
requirements as well as power saving implications.

> We are not going to expose Attach() or Detach() method.

And we are going to expose it.

> I am still not seeing the point in what suspended will do for us and the
> UI. And that Maemo 5 exposed such a state in the UI is not an argument
> to keep doing it. I asked this before, what are we suppose to be doing
> when we get signaled suspended?

User, as well as intelligent (connectivity-aware) applications, need to
know about this so that they understand why "Internet" is momentarily
broken. It's as simple as that.

Oh we could also use the network device carrier flag, and then use Netlink
(and we probably should do that too), but we all know how horrible Netlink
is from userland.

(...)
> This is for ConnMan or similar to figure out. And we can always count
> via netfilter or some other facility. Counting inside oFono makes no
> sense. However we could send out a statistics signal before taking the
> interface down if it would be really needed. Making it part of the
> properties and having to poll for it is wrong.

This has legal(ish) implications related to charging. Skipping this is not
exactly an option (for a device vendor). I actually agree that this is ugly
in some ways. In theory, I don't really care if Ofono or the over-lying
connection manager takes care of it. *But* we even need to collect
statistics for contexts not handled in Ofono (e.g. Windows PC tethering).
And I doubt that Connman would be able to do that properly.

It's ugly and annoying, but we have to suck it up.

>> As I said, I think that the differences between this proposal and mine
>> are mostly philosophical -- should the context data be stored in Ofono
>> or in the upper layers of the stack? And should Ofono set the policies
>> (for instance the roaming case) or just act as a low-level interface
>> to the GPRS functionality?
> =

> While oFono is sort of low-level, it is not that low-level. If it would
> we could expose the native AT commands. So in summary the PDP context
> are stored persistently in oFono. Like BlueZ remember paired devices.

I fail to see how providing a direct low-level interface would prevent us
from providing _also_ a higher-level interface. The later can handle
provisioning and data persistence.

-- =

R=C3=A9mi Denis-Courmont


--===============2086929921990965440==--

