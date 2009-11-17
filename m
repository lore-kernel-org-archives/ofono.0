Content-Type: multipart/mixed; boundary="===============4177714174951644035=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Patch on unsupported AT command
Date: Tue, 17 Nov 2009 11:56:15 -0600
Message-ID: <200911171156.15968.denkenz@gmail.com>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001B4C01793@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4177714174951644035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> Thanks for the comments. I have split the patch to two separate ones.
>

Two problems:

>+void g_at_chat_add_terminator(GAtChat *chat, const char *terminator,
>+					int len, gboolean success)
>+{
>+	struct terminator_info *ti =3D g_new0(struct terminator_info, 1);
>+	ti->terminator =3D terminator;
>+	ti->len =3D len;
>+	ti->success =3D success;
>+	chat->terminator_table =3D g_slist_prepend(chat->terminator_table, ti);
>+}

You're not strdup'ing the terminator string here.  For safety reasons I =

suggest this be done.

>+	g_at_chat_add_terminator(chat, "+EXT ERROR:", 11, FALSE);
>+	g_at_chat_add_terminator(chat, "+CME ERROR:", 11, FALSE);
>+	g_at_chat_add_terminator(chat, "+CMS ERROR:", 11, FALSE);
>+	g_at_chat_add_terminator(chat, "NO ANSWER", -1, FALSE);
>+	g_at_chat_add_terminator(chat, "CONNECT", -1, TRUE);
>+	g_at_chat_add_terminator(chat, "NO CARRIER", -1, FALSE);
>+	g_at_chat_add_terminator(chat, "BUSY", -1, FALSE);
>+	g_at_chat_add_terminator(chat, "NO DIALTONE", -1, FALSE);
>+	g_at_chat_add_terminator(chat, "ERROR", -1, FALSE);
>+	g_at_chat_add_terminator(chat, "OK", -1, TRUE);

I really don't like this.  Lets keep the non-standard terminators in a =

separate list.  I don't want the vast majority of the drivers incurring the =

cost of multiple g_new/g_frees.

Regards,
-Denis

--===============4177714174951644035==--

