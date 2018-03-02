Content-Type: multipart/mixed; boundary="===============6814964015772899124=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono LTE modems and connman services
Date: Fri, 02 Mar 2018 11:15:07 -0600
Message-ID: <cedae6d7-6dcf-5fab-823e-65ffbc8b5ad1@gmail.com>
In-Reply-To: <f258a9ee-dd66-280a-d840-a6b49d7d4a65@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6814964015772899124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/02/2018 09:29 AM, Jonas Bonn wrote:
> On 03/01/2018 05:11 PM, Denis Kenzior wrote:
>> Hi Jonas,
> =

> Hi Denis,
> =

> I've spent most of the day trying to make sense of this.=C2=A0 I'll send =
some =

> new logs when I get a chance but I thought I'd just ask a couple of =

> questions that popped up during the day:
> =

> i)=C2=A0 For LTE, does it really make sense for the Attached property to =
be =

> set before the context is Active?=C2=A0 The two are intricately linked.

So in general the API does not guarantee any particular ordering of =

messages, and the client should be able to handle any message order.  We =

make exceptions to this where a particular order makes implementation =

easy.  For example, ConnectionContext.Settings is signaled prior to =

ConnectionContext.Active.

We set Attached mostly not to confuse ConnMan.  Since ConnMan doesn't =

know about LTE, we tried to preserve the overall behavior.

 From an API consistency perspective & conceptually, I think setting =

Attached before ConnectionContext.Active makes sense.  Having said that, =

if there's consensus from the connman guys that signaling Active then =

Attached for this particular case, we can make the change...

> =

> ii)=C2=A0 For LTE, I'm not sure we should call ofono_gprs_status_notify() =

> when we are registered to the network.=C2=A0 Instead, I suspect we should =

> just wait until cid_activated() gets called.=C2=A0 Is that sufficient?=C2=
=A0 It =

> looks to be, mostly, in my eyes and didn't break terribly when I tried it.

There might be some weirdness in the core around this area actually. =

Looking at src/gprs.c it seems like we expect ofono_gprs_cid_activated =

to be called prior to ofono_gprs_status_notify.  We probably need to =

introduce some checks in ofono_gprs_status_notify in case the call order =

is switched.

When in LTE this status should be largely ignored anyhow.  We can't =

'detach' in case we're roaming, so much of the logic doesn't apply.

> =

> iii)=C2=A0 Looking at src/gprs, couldn't we just set gprs->attached and =

> gprs->driver_attached right away if we are registered on an LTE network. =

>  =C2=A0It seems that conceptually that would be true...???=C2=A0 If we do=
 that, I =

> think we can drop most of the _ATTACHING flags which might make the code =

> easier to understand.

Possibly, though you may be a bit optimistic that any of this can be =

made simpler :)

Right now we always set the _ATTACHING flag inside =

ofono_gprs_cid_activated.  This isn't really correct, we should only do =

so on EUTRAN and if this is the default bearer activation (e.g. we think =

we're not attached yet).  The network can automatically activate =

contexts on 3G or even LTE beyond the initial one.

This logic then proceeds to signal Attached=3DTrue when .read_settings =

returns. There are probably some extra checks we need to put into =

pri_read_settings_callback to make sure we only signal Attached on the =

initial default bearer activation.

> =

> iv)=C2=A0 Even if we do iii), I'm inclined to not set the Attached DBUS =

> property until _cid_activated() returns, and then _after_ context Active =

> instead of before.

The code already tries to do the first part, e.g. querying the default =

bearer settings and then signaling Attached & Active in that order.

> =

> v)=C2=A0 If we detach from the network, do things break conceptually if w=
e =

> set Attached=3Dfalse before setting context Active=3Dfalse?

Again, conceptually I would say Active=3Dfalse then Attached=3Dfalse makes =

the most sense.

> =

> A lot of the above comes from my understanding of what connman is trying =

> to do:=C2=A0 if it sees the state as Attached and has no Active contexts =
then =

> it starts trying to activate the first context.=C2=A0 Ideally, it would n=
ever =

> see an inactive context for LTE, at least not in the Attached state. =

> However, I may be missing something in my understanding of how this is =

> intended to work, so any clarification would be appreciated.

Or it should give up if it sees the InProgress error, but yes it might =

be that re-ordering messages is the right approach.  Daniel, Marcel?

Regards,
-Denis

--===============6814964015772899124==--

