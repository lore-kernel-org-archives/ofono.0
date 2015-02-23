Content-Type: multipart/mixed; boundary="===============4011139141094157676=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] Add ResetProperties method to ConnectionContext
 interface
Date: Mon, 23 Feb 2015 09:47:40 -0600
Message-ID: <54EB4B9C.3060505@gmail.com>
In-Reply-To: <CAAVgdeFqOXKC+8=ce-g6Yg4gE+TuxhAOLkxxFqnfzPt6nV5bgA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4011139141094157676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

 >> Why don't you just remove the settings file and restart oFono?
> oFono handles many other services so restarting would have undesirable ef=
fects.
> For a moment clients would think there is no telephony at all: no SIM,
> no cellular signal strength, no voice/emergency calls, no SIM ATK etc.
>

Which is probably OK given that you're resetting cellular settings. =

Unless you expect the user to know / have control over very fine-grained =

details.

>>> Deactivation of the context is obviously mandatory. The reasoning for p=
lacing
>>> this into ofono is handling client requests consistently and avoiding r=
ace
>>> conditions. Using this approach ofono does not re-activate the context,=
 that's
>>> done by ConnMan or whatever connection manger the system uses.
>>>
>> I'm not so sure that this is a good idea.  A 'live' reset of the
>> settings just seems wrong to me.  Why would you ever want to do that
>> anyway?  If something is working, why bother resetting the settings?
> Generally speaking I agree with the point of view. The main point was
> not the 'live' part, but to allow running provisioning again, e.g. if
> user has set wrong ones.

Then this has to be done with Powered =3D False as a prerequisite.  And =

you need some way to tell ConnMan what is happening and why.  Since =

someone still has to go in and activate the new contexts afterwards.

> FYI a MMS context may be active using a correct APN but messages don't
> flow due to a wrong proxy. In such a case context remains active for
> some time.

I don't get it, if the proxy is wrong, it must have been provisioned =

that way.  How is re-provisioning going to help?  Either way, it sounds =

like you want the UI to reset a particular context's settings, not =

everything.

>
>> oFono supports arbitrary number of contexts, so your UI can always add
>> more.  So if you need to re-provision, let your UI handle this.  The UI
>> should be capable of reading the provisioning database anyway in order
>> to handle duplicates, etc.
> When ofono already implements the initial provisioning logic it is not
> tempting to duplicate it but instead trigger it again.

Not tempting, no.  Provisioning is there to handle simple cases.  E.g. =

user receives new device, turns it on and gets connected.  If you want =

the user to mess with the settings, or if your database might contain =

ambiguous information, then you need to write a proper UI.  One that can =

read the provisioning database as well and present choices to the user.

> (A more suitable name for the new method could be  "ProvisiongContext"
> or similar.)
> If reverting provisioned settings is done by creating a new empty
> context, one would still want to run ofono provisioning for that
> (ofono restart not an option).

The problem is there's really no mapping between what the provisioning =

database returns and what the settings are right now.  You can sort of =

kludge around by comparing the context type, but you might be =

over-writing the wrong context.

The better way is to wipe all existing settings and re-populate.  But =

that would require quite a bit of ContextRemoved, ContextAdded signals =

to keep the clients consistent.

Might be easier to just re-boot the gprs atom.

Regards,
-Denis

--===============4011139141094157676==--

