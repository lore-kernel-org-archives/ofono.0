Content-Type: multipart/mixed; boundary="===============4513358932094224215=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unreliable next_msg_id (was Re: [PATCH 2/2] Added SQLite history
 plugin)
Date: Thu, 15 Apr 2010 17:24:49 -0500
Message-ID: <201004151724.49943.denkenz@gmail.com>
In-Reply-To: <x2j359c5481004151457u9ab1f05cn81d7c598803ab415@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4513358932094224215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

> > The proper fix is to generate a SHA1 or MD5 hash over the contents, loc=
al
> > reception/send time, remote reception / send time, destination /
> > originator of the message.
> =

> Dario suggested that to me too, the only problem I see is that an hash
> signature does not provide ">" operator that may help in some sync
> scenarios, but this may be fixed in several ways (for example using an
> additional autoincrement serial column that may expose to applications
> an unique, ordered and reliable id without exposing the ofono internal
> one).

I suggest using a sync timestamp or some other way to accomplish this.

> =

> Will check if all history callbacks lets us rehash the messages properly.
> =

> A shot in the dark: what's about delegating the id generation to the
> history plugin (if present and capable)?
> That should fix the above problems, avoid hash generation and provide
> a possible base to reuse the id while resubmitting failed/pending
> messages providing the right id to ofono, avoiding the introduction of
> race conditions or complex implementations.

oFono will keep pending messages around across reboots, that is an enhancem=
ent =

we're already working on.  Resubmitting of failed messages should result in=
 a =

new ID anyway.

And I honestly don't think N implementations of hashing SMS messages in eac=
h =

history plugin is a good idea.  Let oFono do it so we get it right for =

everyone.

> >> Finally, we'd like to use some "panic" function in ofono, that should
> >> power down all modems and warn clients when critical conditions
> >> happen.
> >>
> >> Is that possible?
> >
> > Send HUP to the daemon?  Or do you want oFono to keep running?
> =

> I mean the best way to shutdown modems and ofono inside the code (in
> the history for example if an sql statement fails, or if it cannot
> save id to the permanent storage, big dbus troubles or other similiar
> cases).

Yikes.  The answer is "Please don't even think about it" :)

Regards,
-Denis

--===============4513358932094224215==--

