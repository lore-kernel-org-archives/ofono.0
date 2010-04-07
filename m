Content-Type: multipart/mixed; boundary="===============5345279481826049232=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 23:26:14 +0200
Message-ID: <o2v359c5481004071426z72c1684j30afe59d218afd64@mail.gmail.com>
In-Reply-To: <201004071433.26967.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5345279481826049232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 7, 2010 at 9:33 PM, Denis Kenzior <denkenz@gmail.com> wrote:
[...]
> I suggest storing this information directly in the history database. =C2=
=A0E.g.
> Read / Unread flag. =C2=A0Ideally the application can access the database
> concurrently to mark the message as Read / Unread. =C2=A0If not, then som=
e sort of
> DBus API will be required.

At first impact we thinked on this solution, but there are two
different use cases, for example from user perspective a message may
be read/unread, and that's an information that has a global sense and
has to stay in the history db (remember my first mail on this topic
when I talked about metadata), but from application perpective a
message may be "processed" or not and IMHO that's an information that
should manage the application itself.

>> When the app start, it simply query the history plugin and start
>> processing only messages where id > lastsavedid.
>
> Why not query the database directly?

Yes, but apps cannot determine the last processed id, I know we may
query the db every time an IncomingMessage arrives and do some magic
(and assumptions, for example that the signal is emitted always after
the message reach the history plugin, or doing periodically a cpu
wasting query).
But thats seems quite weird, so I think finally we'll go providing a
dbus interface to the history plugin with a signal giving the needed
id when a new message arrives.

I understand all that may be out of the ofono scope, but if
ineterested we'll keep you updated on our further development and
provide patches that may be interesting for other users.

Keep up the good work and regards!

     Niko

--===============5345279481826049232==--

