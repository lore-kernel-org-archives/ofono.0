Content-Type: multipart/mixed; boundary="===============4194565445010119146=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Wed, 05 Aug 2009 14:35:59 -0500
Message-ID: <200908051436.00016.denkenz@gmail.com>
In-Reply-To: <fb249edb0908051218l3315aa74v4aaf82ee372bdb3b@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4194565445010119146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > For setting mailbox numbers, a working EF-MBDN is required since the on=
ly
> > alternative would be to store them on the filesystem.
>
> mw_set_indicator does the right thing, I missed this fact.  But when a
> mailbox number is set or received from network all clients get a
> PropertyChanged and the new number can be retrieved from the interface
> but only when the store succeeded, previously it would be available
> regardless of MBDN on the card and the writing to card was secondary.
> The number is kind of important if you want to hear the messages.

So you're right that even if we get an enhanced voice mail notification mes=
sage =

the Mailbox number won't be signaled unless we have the SIM provisioned wit=
h =

EF-MBI & EF-MBDN.

The problem is, if we don't have the SIM files available, then the next tim=
e =

oFono is restarted this information is lost anyway until the next MWI =

notification arrives.  So you're back to not being able to dial the mailbox.

This is also an issue with the indications themselves.  If we don't have EF-
MWIS provisioned, the information is lost when oFono is restarted.  So we'r=
e =

now inconsistent between MBDN/MWIS, so maybe we shouldn't update them eithe=
r =

in this case.

One solution is to always store this info on the filesystem and backup to S=
IM.

The other solution is to preserve current behavior, but to also expose the =

enhanced notifications in a separate interface (as discussed previously) an=
d =

include any Mailbox numbers there.

Thoughts?

Regards,
-Denis

--===============4194565445010119146==--

