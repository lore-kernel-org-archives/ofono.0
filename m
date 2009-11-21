Content-Type: multipart/mixed; boundary="===============5062707053189881297=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Patch on unsupported AT command
Date: Sat, 21 Nov 2009 11:41:33 +0100
Message-ID: <1258800093.25879.37.camel@localhost.localdomain>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001B4CCBB20@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5062707053189881297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> >> >> >+	g_at_chat_add_terminator(chat, "+EXT ERROR:", 11, FALSE);
> >> >> >+	g_at_chat_add_terminator(chat, "+CME ERROR:", 11, FALSE);
> >> >> >+	g_at_chat_add_terminator(chat, "+CMS ERROR:", 11, FALSE);
> >> >> >+	g_at_chat_add_terminator(chat, "NO ANSWER", -1, FALSE);
> >> >> >+	g_at_chat_add_terminator(chat, "CONNECT", -1, TRUE);
> >> >> >+	g_at_chat_add_terminator(chat, "NO CARRIER", -1, FALSE);
> >> >> >+	g_at_chat_add_terminator(chat, "BUSY", -1, FALSE);
> >> >> >+	g_at_chat_add_terminator(chat, "NO DIALTONE", -1, FALSE);
> >> >> >+	g_at_chat_add_terminator(chat, "ERROR", -1, FALSE);
> >> >> >+	g_at_chat_add_terminator(chat, "OK", -1, TRUE);
> >> >>
> >> >> I really don't like this.  Lets keep the non-standard terminators i=
n a
> >> >> separate list.  I don't want the vast majority of the drivers incur=
ring the
> >> >> cost of multiple g_new/g_frees.
> >> >
> >> >I have to agree on this. We should keep the penalty for well behaving
> >> >cards as small as possible.
> >>
> >> Thank you for the comments. Modified patches are attached!
> >
> >please do casts with a space between. Like (char *) terminator etc. Also
> >why do you bother with making it const. Just leave that out. Since you
> >do actually copy the string anyway.
> =

> Fixed!

I don't like this casting at all actually. Please just store the
terminator as char and not const char. That is internal code anyway and
you do allocate it. So no need to mark it as read-only. Also please use
g_strdup since you are using g_free to free it.

+static gboolean meet_terminator(GAtChat *chat,
+                               struct terminator_info *info, char *line)

About this function name, I don't really like it since it confuses the
hell out of me what it is meant do be doing. I do get what you are
trying to do here, but I would just name it check_terminator and then
leave the g_at_chat_finish_command() call in the original code.

Regards

Marcel



--===============5062707053189881297==--

