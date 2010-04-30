Content-Type: multipart/mixed; boundary="===============4102658704150994504=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/4] gatchat: Emit notification when command is sent to
 modem.
Date: Fri, 30 Apr 2010 15:41:16 +0200
Message-ID: <1272634876.22838.197.camel@localhost.localdomain>
In-Reply-To: <201004300831.47649.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4102658704150994504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > > > +/*!
> > > > + * Same as g_at_chat_send but with an ability to return a notifica=
tion
> > > > the + * moment the command finally leaves the queue and is submitte=
d to
> > > > lower + * layer.
> > > > + *
> > > > + * This is useful for cases where the modem's response time needs =
to
> > > > be + * measured, assuming that the lower layers processing time is
> > > > shorter + * than the minimum accuracy needed.
> > > > + */
> > > > +guint g_at_chat_send_with_callback(GAtChat *chat, const char *cmd,
> > > > +					const char **valid_resp,
> > > > +					GAtSubmitNotifyFunc sent,
> > > > +					GAtResultFunc func,
> > > > +					gpointer user_data,
> > > > +					GDestroyNotify notify);
> > > > +
> > >
> > > So I'm fine with the implementation but the name needs work.  Can we =
use
> > > g_at_chat_send_with_submit_notify? Or maybe g_at_chat_send_full, simi=
lar
> > > to how GLib does it.
> > >
> > > Perhaps enabling submit_notification for a given command after it has
> > > been submitted with g_at_chat_send?
> > >
> > > e.g. g_at_chat_set_submit_notify(GAtChat *chat, guint command,
> > > GAtSubmitNotifyFunc sent, gpointer user_data, GDestroyNotify notify);
> > =

> > I am not a huge fan of the _full() stuff, but it is actually pretty nice
> > for the cases where 99% of users don't care. And this seems to be one of
> > them. The send_with_submit_notify() is way too long.
> =

> I'm not a fan of _full either, however it is a precedent, so might as wel=
l be =

> a candidate.
> =

> > =

> > Maybe g_at_chat_send_and_notify() is an acceptable simple version for
> > this or just g_at_chat_submit() and g_at_chat_send() to keep these
> > versions apart.
> =

> In my opinion send_and_notify does not convey enough information about wh=
at =

> the function is trying to do.  _submit is even less clear.  API should be=
 very =

> clear on its intent just from the function name without needing to consul=
t =

> documentation.
> =

> Out of all these so far my vote is on send_full just because it is famili=
ar to =

> folks using GLib...  We might have to cut down some of the parameters to =
_send =

> as well (like GDestroyNotify argument) if we introduce send_full.

then lets do send_full() and move the destroy function parameter to the
full version.

Regards

Marcel



--===============4102658704150994504==--

