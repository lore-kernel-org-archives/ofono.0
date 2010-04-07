Content-Type: multipart/mixed; boundary="===============6026234874720458253=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 13:05:34 -0500
Message-ID: <201004071305.35438.denkenz@gmail.com>
In-Reply-To: <u2j359c5481004071054i4881423al8f6d0aa70adf9403@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6026234874720458253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

> On Wed, Apr 7, 2010 at 7:01 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> [...]
> =

> >> Database connection is handled by sqlite3_* API in a transparent manner
> >> so you could have different open connections at the same time without
> >> any problem, each SQL statement is transactional so the DB is every ti=
me
> >> consistent, but if you prefer I can rethink of it (maybe a DB for every
> >> modem could be a possibility but this would overload the plugin because
> >> we have to open and close the DB in every callback given that we have =
to
> >> filter the files access by modem).
> >
> > My concern here was that multiple open connections to the same database
> > might require locking or other overhead that could be avoided with a
> > single shared connection.  It might be there is no overhead and your
> > original approach is fine.
> =

> What's about a dbfile for each modem? we'll have one connection per
> database, and may avoid the "modem" column on all the tables, saving
> storage space.

This is possible, or you can do 1 db for each IMSI.  Do note that some driv=
ers =

do not have IMSIs (e.g. making calls via HFP driver).  So it is up to the =

implementation to decide whether to log those calls or not.

> =

> [...]
> =

> > We're working on improving the SMS capabilities, and might eventually
> > expose the message id.  However, the message id really has no meaning, =
so
> > this is not something we really want to expose.  I'd like to keep it
> > private between the history plugin and the core.  Are you sure you real=
ly
> > require it to be exposed, or can you do without it?
> =

> We prefer to have the id to easily sync with the history plugin, as
> said in previous mail, if you prefer to not expose the id on
> IncomingMessage, we may emit an HistoryIncomingMessage signal with the
> id.

Your plugin is free to do anything it wants.  The real question is whether =
you =

truly need this id or you can simply update the application state based on =
the =

IncomingMessage signal only.

Regards,
-Denis

--===============6026234874720458253==--

