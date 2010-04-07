Content-Type: multipart/mixed; boundary="===============8540367681087225213=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 19:54:32 +0200
Message-ID: <u2j359c5481004071054i4881423al8f6d0aa70adf9403@mail.gmail.com>
In-Reply-To: <201004071201.38877.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8540367681087225213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 7, 2010 at 7:01 PM, Denis Kenzior <denkenz@gmail.com> wrote:
[...]
>> Database connection is handled by sqlite3_* API in a transparent manner
>> so you could have different open connections at the same time without
>> any problem, each SQL statement is transactional so the DB is every time
>> consistent, but if you prefer I can rethink of it (maybe a DB for every
>> modem could be a possibility but this would overload the plugin because
>> we have to open and close the DB in every callback given that we have to
>> filter the files access by modem).
>
> My concern here was that multiple open connections to the same database m=
ight
> require locking or other overhead that could be avoided with a single sha=
red
> connection. =C2=A0It might be there is no overhead and your original appr=
oach is
> fine.

What's about a dbfile for each modem? we'll have one connection per
database, and may avoid the "modem" column on all the tables, saving
storage space.

[...]

> We're working on improving the SMS capabilities, and might eventually exp=
ose
> the message id. =C2=A0However, the message id really has no meaning, so t=
his is not
> something we really want to expose. =C2=A0I'd like to keep it private bet=
ween the
> history plugin and the core. =C2=A0Are you sure you really require it to =
be
> exposed, or can you do without it?

We prefer to have the id to easily sync with the history plugin, as
said in previous mail, if you prefer to not expose the id on
IncomingMessage, we may emit an HistoryIncomingMessage signal with the
id.

Regards

     Niko

--===============8540367681087225213==--

