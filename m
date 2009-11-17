Content-Type: multipart/mixed; boundary="===============6824379850650949857=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Patch on unsupported AT command
Date: Tue, 17 Nov 2009 21:35:34 +0100
Message-ID: <1258490134.2003.34.camel@violet>
In-Reply-To: <200911171156.15968.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6824379850650949857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >+	g_at_chat_add_terminator(chat, "+EXT ERROR:", 11, FALSE);
> >+	g_at_chat_add_terminator(chat, "+CME ERROR:", 11, FALSE);
> >+	g_at_chat_add_terminator(chat, "+CMS ERROR:", 11, FALSE);
> >+	g_at_chat_add_terminator(chat, "NO ANSWER", -1, FALSE);
> >+	g_at_chat_add_terminator(chat, "CONNECT", -1, TRUE);
> >+	g_at_chat_add_terminator(chat, "NO CARRIER", -1, FALSE);
> >+	g_at_chat_add_terminator(chat, "BUSY", -1, FALSE);
> >+	g_at_chat_add_terminator(chat, "NO DIALTONE", -1, FALSE);
> >+	g_at_chat_add_terminator(chat, "ERROR", -1, FALSE);
> >+	g_at_chat_add_terminator(chat, "OK", -1, TRUE);
> =

> I really don't like this.  Lets keep the non-standard terminators in a =

> separate list.  I don't want the vast majority of the drivers incurring t=
he =

> cost of multiple g_new/g_frees.

I have to agree on this. We should keep the penalty for well behaving
cards as small as possible.

Regards

Marcel



--===============6824379850650949857==--

