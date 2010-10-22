Content-Type: multipart/mixed; boundary="===============5064001581400522057=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 1/4] radio settings: allow for more than one property
Date: Fri, 22 Oct 2010 16:21:51 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7D0933E3@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <4CC19652.1060208@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5064001581400522057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > Thanks. Still, I'd vote for a common checkpatch script in =

> the oFono tree. ;)
> >
> =

> Are you volunteering to maintain such a beast and make sure =

> it is up to
> date with the kernel upstream version?

Only if I get to decide on the coding style. Otherwise, I'm proposing you g=
uys should do it. Anyway, this is just a friendly suggestion in with the o =
sav e everyone's time.

> Yes, so let me give you a case where your approach breaks:
> =

> Set the RAT property, then run two GetProperties at the same =

> time.  You
> end up querying FastDormancy twice.

No you won't, because the second GetProperties query will be terminated rig=
ht off the bat with ofono busy error. Again, see here:

> > static DBusMessage *radio_get_properties(DBusConnection =

> *conn, DBusMessage *msg,
> >                                         void *data)
> > {
> >         struct ofono_radio_settings *rs =3D data;
> > =

> >         if (rs->pending)
> >                 return __ofono_error_busy(msg);
> > =

> >         return radio_get_properties_reply(msg, rs);
> > }
> > =

> > A busy error is returned if a previous query is in progress.

Only one API call can be active at one time.

> So let me try to make it pretty clear.  I maintain all of the =

> core and I
> review just about every single patch.  For me code readability and
> consistency of implementation is very important.  This is =

> also the case
> for anyone new starting with the codebase.  If I allow every =

> atom to do
> things just a little bit differently for the sake of saving =

> 20 lines of
> code or because the original author likes his approach =

> better, I will go
> crazy and the code will become unmaintainable.

Understandable. Makes it difficult to improve on design patterns that have =
already been replicated, though.

> I'd like to keep my sanity for a while longer ;)  So please =

> modify your
> patch to follow the oFono conventions.

Sure. My personal cost optimization function tells me that at this point it=
's faster to rewrite than to argue further.

Br,

	MikaL

--===============5064001581400522057==--

