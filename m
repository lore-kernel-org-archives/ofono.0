Content-Type: multipart/mixed; boundary="===============8573840559115572980=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Add support for text mode SMS sending
Date: Tue, 24 Aug 2010 12:45:27 +0200
Message-ID: <1282646727.6841.18.camel@localhost.localdomain>
In-Reply-To: <1282645879-25437-1-git-send-email-yong.su@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8573840559115572980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yong,
 =

> +/*
> + * Send AT command with length.
> + * Such as SMS text mode which contains 0x00 or 0x0A, 0x0D
> + */
> +guint g_at_chat_send_with_len(GAtChat *chat, const char *cmd, int cmdlen,
> +		const char **prefix_list, GAtResultFunc func,
> +		gpointer user_data, GDestroyNotify notify);
> +

so in theory we could handle 0x0a and 0x0d automatically as long as they
are included in "". I don't see a huge problem with that.

What is the 0x00 character used for in an SMS text mode AT command.
Maybe I am missing something obvious, but this needs a bit more details.
Right now I am not liking this split with _with_len() at all.

Regards

Marcel



--===============8573840559115572980==--

