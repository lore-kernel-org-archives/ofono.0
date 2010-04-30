Content-Type: multipart/mixed; boundary="===============0985110935630043850=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/4] gatchat: Emit notification when command is sent to
 modem.
Date: Fri, 30 Apr 2010 07:48:03 +0200
Message-ID: <1272606483.22838.180.camel@localhost.localdomain>
In-Reply-To: <201004292200.27678.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0985110935630043850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > +/*!
> > + * Same as g_at_chat_send but with an ability to return a notification=
 the
> > + * moment the command finally leaves the queue and is submitted to low=
er
> > + * layer.
> > + *
> > + * This is useful for cases where the modem's response time needs to be
> > + * measured, assuming that the lower layers processing time is shorter
> > + * than the minimum accuracy needed.
> > + */
> > +guint g_at_chat_send_with_callback(GAtChat *chat, const char *cmd,
> > +					const char **valid_resp,
> > +					GAtSubmitNotifyFunc sent,
> > +					GAtResultFunc func,
> > +					gpointer user_data,
> > +					GDestroyNotify notify);
> > +
> =

> So I'm fine with the implementation but the name needs work.  Can we use =

> g_at_chat_send_with_submit_notify? Or maybe g_at_chat_send_full, similar =
to =

> how GLib does it.
> =

> Perhaps enabling submit_notification for a given command after it has bee=
n =

> submitted with g_at_chat_send?
> =

> e.g. g_at_chat_set_submit_notify(GAtChat *chat, guint command, =

> GAtSubmitNotifyFunc sent, gpointer user_data, GDestroyNotify notify);

I am not a huge fan of the _full() stuff, but it is actually pretty nice
for the cases where 99% of users don't care. And this seems to be one of
them. The send_with_submit_notify() is way too long.

Maybe g_at_chat_send_and_notify() is an acceptable simple version for
this or just g_at_chat_submit() and g_at_chat_send() to keep these
versions apart.

Regards

Marcel



--===============0985110935630043850==--

