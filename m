Content-Type: multipart/mixed; boundary="===============8305735264746022860=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: Unreliable next_msg_id (was Re: [PATCH 2/2] Added SQLite history
 plugin)
Date: Thu, 15 Apr 2010 23:57:45 +0200
Message-ID: <x2j359c5481004151457u9ab1f05cn81d7c598803ab415@mail.gmail.com>
In-Reply-To: <201004151335.17156.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8305735264746022860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 15, 2010 at 8:35 PM, Denis Kenzior <denkenz@gmail.com> wrote:
[...]
>> During our tests, users reported bad behaivour of the sqlite history
>> plugins and error messages about sqlite constraints violation, after a
>> rude power off of the device (battery drained, forced shutdown with
>> long press power button, and so on).
>
> So the immediate fix is to set & sync the SMS settings whenever the next_=
msg_id
> is updated.

Yes, this for sure will help a lot.

>> That's becouse ofono on the next start reads an "old" next_msg_id from
>> the permanent storage, so when sending/receiving a new message the
>> history plugin fails to insert a new row as one with the same msg_id
>> was already inserted in the prev session.
>>
>> Any suggestion to fix that?
>
> The proper fix is to generate a SHA1 or MD5 hash over the contents, local
> reception/send time, remote reception / send time, destination / originat=
or of
> the message.

Dario suggested that to me too, the only problem I see is that an hash
signature does not provide ">" operator that may help in some sync
scenarios, but this may be fixed in several ways (for example using an
additional autoincrement serial column that may expose to applications
an unique, ordered and reliable id without exposing the ofono internal
one).

Will check if all history callbacks lets us rehash the messages properly.

A shot in the dark: what's about delegating the id generation to the
history plugin (if present and capable)?
That should fix the above problems, avoid hash generation and provide
a possible base to reuse the id while resubmitting failed/pending
messages providing the right id to ofono, avoiding the introduction of
race conditions or complex implementations.

Anyway this is a delicate and upcoming use case, we just created our
git tracking to experiment some solutions, when ready will submit
patches again.

>> Finally, we'd like to use some "panic" function in ofono, that should
>> power down all modems and warn clients when critical conditions
>> happen.
>>
>> Is that possible?
>
> Send HUP to the daemon? =C2=A0Or do you want oFono to keep running?

I mean the best way to shutdown modems and ofono inside the code (in
the history for example if an sql statement fails, or if it cannot
save id to the permanent storage, big dbus troubles or other similiar
cases).
We just discovered our users may become crazy if they lose a single sms/cal=
l :)

Regards

     Niko

--===============8305735264746022860==--

