Content-Type: multipart/mixed; boundary="===============0392492195003053162=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Wed, 04 Mar 2020 12:49:41 -0600
Message-ID: <a39210bd-2edb-21dc-7f21-b81a60649745@gmail.com>
In-Reply-To: <CABPh3UOAp1A37VAjrVYyuSb4fx9A=aONmHOyZRzQvFhwsVvc9A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0392492195003053162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> In my case automatic provisioning always fails:
> - the database has multiple entries for basically every operator/country

mbpi is just not a very good database.  It provides lots of duplicates =

and doesn't distinguish by spn last I checked.  Ubuntu Touch folks used =

the android apndb and others used custom ones.  As far as I'm aware, =

ofono + mbpi was never used in production.  If I'm wrong, I'd love to =

hear about it.

I have discouraged the use of mbpi for these reasons.  Not stopping you =

from using it, just pointing out what has been done historically.

> - also Ofono doesn;t expose a Dbus API to query the database

There was never a reason to...

> - so the current plugin is useless: it always provision the wrong settings

Pretty much, yes.

> =

> If I want to do it externally I have to reimplement the whole "quering =

> thedatabase logic", delete
> all the automatic provisioned profile and setup custom ones.

The null profile created when automatic provisioning fails is by design. =

  It serves as a hint to ConnMan & settings service that manual =

provisioning is required.  So the current behavior is how oFono + =

ConnMan were designed to interoperate.  You can certainly try and change =

the design, I'm just pointing out that this might not be the path of =

least resistance.

> What is the more "elegant" solution in your opinion?

Not sure, ideally there should be a way to avoid something like this. =

Also some providers allow a context to be activated, but no traffic can =

pass, so this might not be a foolproof solution anyway.

> mmm Those are details that are exposed in every connection manager that =

> I know of... see Android network settings for example
> (maybe there's a reason??)

That is something you can take up with ConnMan guys.

Regards,
-Denis
--===============0392492195003053162==--

