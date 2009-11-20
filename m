Content-Type: multipart/mixed; boundary="===============8591874367636194225=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Patch on unsupported AT command
Date: Fri, 20 Nov 2009 14:30:43 +0100
Message-ID: <1258723843.25879.5.camel@localhost.localdomain>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001B4CCBAAB@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8591874367636194225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> >> >+	g_at_chat_add_terminator(chat, "+EXT ERROR:", 11, FALSE);
> >> >+	g_at_chat_add_terminator(chat, "+CME ERROR:", 11, FALSE);
> >> >+	g_at_chat_add_terminator(chat, "+CMS ERROR:", 11, FALSE);
> >> >+	g_at_chat_add_terminator(chat, "NO ANSWER", -1, FALSE);
> >> >+	g_at_chat_add_terminator(chat, "CONNECT", -1, TRUE);
> >> >+	g_at_chat_add_terminator(chat, "NO CARRIER", -1, FALSE);
> >> >+	g_at_chat_add_terminator(chat, "BUSY", -1, FALSE);
> >> >+	g_at_chat_add_terminator(chat, "NO DIALTONE", -1, FALSE);
> >> >+	g_at_chat_add_terminator(chat, "ERROR", -1, FALSE);
> >> >+	g_at_chat_add_terminator(chat, "OK", -1, TRUE);
> >>
> >> I really don't like this.  Lets keep the non-standard terminators in a
> >> separate list.  I don't want the vast majority of the drivers incurrin=
g the
> >> cost of multiple g_new/g_frees.
> >
> >I have to agree on this. We should keep the penalty for well behaving
> >cards as small as possible.
> =

> Thank you for the comments. Modified patches are attached!

please do casts with a space between. Like (char *) terminator etc. Also
why do you bother with making it const. Just leave that out. Since you
do actually copy the string anyway.

Regards

Marcel



--===============8591874367636194225==--

