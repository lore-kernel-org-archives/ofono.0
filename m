Content-Type: multipart/mixed; boundary="===============5130532816081530152=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/4] gatchat: Emit notification when command is sent to
 modem.
Date: Tue, 04 May 2010 11:07:48 +0200
Message-ID: <1272964068.22838.226.camel@localhost.localdomain>
In-Reply-To: <i2ofb249edb1005031122hdc31004fo4a6b7738bbb1e2c8@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5130532816081530152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> >> So I'm fine with the implementation but the name needs work.  Can we u=
se
> >> g_at_chat_send_with_submit_notify? Or maybe g_at_chat_send_full, simil=
ar to
> >> how GLib does it.
> >>
> >> Perhaps enabling submit_notification for a given command after it has =
been
> >> submitted with g_at_chat_send?
> >>
> >> e.g. g_at_chat_set_submit_notify(GAtChat *chat, guint command,
> >> GAtSubmitNotifyFunc sent, gpointer user_data, GDestroyNotify notify);
> >
> > I am not a huge fan of the _full() stuff, but it is actually pretty nice
> > for the cases where 99% of users don't care. And this seems to be one of
> > them. The send_with_submit_notify() is way too long.
> >
> > Maybe g_at_chat_send_and_notify() is an acceptable simple version for
> > this or just g_at_chat_submit() and g_at_chat_send() to keep these
> > versions apart.
> =

> Here's a patch to add a g_at_chat_set_submit_notify function that
> modifies an already submitted command.  Removing the destroy callback
> from g_at_chat_send would require changing all the many uses of it.

the conclusion was to have g_at_chat_send_full with submit and destroy
notifier. And g_at_chat_send without the destroy notifier.

Yes, we might have to touch a lot of code, but that is fine. That is one
of the reasons why GAtChat is not a separate (yet).

Regards

Marcel



--===============5130532816081530152==--

