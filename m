Content-Type: multipart/mixed; boundary="===============3649039509802836656=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Thu, 12 Mar 2020 15:06:24 -0500
Message-ID: <16075134-e441-32ca-8beb-d825028925ee@gmail.com>
In-Reply-To: <50960623-ace4-5fac-c30c-7c004b12eb8f@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3649039509802836656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tarmo,

>> Once a proper database is used, this mostly goes away as an issue.=C2=A0=
 We =

>> did add the SPN field to MBPI schema in the olden days.=C2=A0 The proble=
m =

>> is that nobody actually updated the MBPI database to take advantage of =

>> this.

Hmm, maybe my memory is faulty (it has been ~9 years now), but I do not =

see anything in the mbpi DTD file for the SPN.  The oFono change was =

done in 2011 in ef37b3fe4244d823a5dde1a311c0d466ad2e7172.  And we did =

have someone working on extending mbpi, but it seems SPN changes never =

made it.  I no longer recall what happened, exactly.

> =

> So if the SPN for every duplicate in mbpi was populated, ofono would =

> start provisioning them? That's useful information. Where could one find =

> the details of this schema documented?

It is much more likely to, yes.  The number of duplicates goes down =

tremendously, particularly if the db is reasonably up to date.  There =

may be a few extra bits we can also differentiate on as well, and extend =

the provisioning API for these.

See above about the schema.  Maybe someone wants to pick up this work =

again...

> =

>>> Sure, after much, much frustration I arrived to the workaround of =

>>> manually provisioning APNs (which I stole from mbpi!) for each =

>>> factory installed SIM through Christophe Ronco's file-provision =

>>> plugin. This plugin is a life-saver, but it certainly falls short of =

>>> automatic provisioning. That's the same level of sophistication as =

>>> pppd. And as extra punishment I have to write a network supervisor =

>>> which orders connman to actually use the service of a new SIM =

>>> whenever it is replaced - even if it's from the same MNO. But that's =

>>> a different rant altogether.
>>>
>>> So, for perspective - saying "mbpi is just not a very good database" =

>>> helps me none at all when I need to get my widget to go online :) =

>>> Please handle the duplication, as this is how the mobile networks are =

>>> built.
>>>
>>
>> I can take a patch that enables duplicates as a config / environmental =

>> setting.=C2=A0 As long as the default is the old behavior.=C2=A0 But as =
I =

>> mentioned previously, ConnMan / oFono were not designed to work this =

>> way, and so far nobody has been willing to do the work in both =

>> projects to change that.
> =

> I emphasize.
> =

> Stepping back, I suspect the task of maintaining a clean, accurate =

> provisioning database of every SIM in the world is rather challenging. =

> Perhaps more challenging, than re-designing ofono :)

Quite possible.  But I would still question whether trying APNs at =

semi-random is a good strategy.

> =

> I could pick up a few commodity SIMs from my country, determine the SPN =

> and contribute updates somewhere. Heh, I don't even know which MVNOs =

> here are dead and which are operational.

Exactly.  In the Meego days Nokia had their own APN database.  And it =

was considered crown jewels / company secret ;)  Understandable, =

considering how much work probably went into keeping it up to date.

Regards,
-Denis
--===============3649039509802836656==--

