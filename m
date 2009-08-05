Content-Type: multipart/mixed; boundary="===============5744780403948115250=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] atmodem: add serial line debugging to gatchat
Date: Wed, 05 Aug 2009 17:09:12 -0500
Message-ID: <200908051709.12869.denkenz@gmail.com>
In-Reply-To: <20090805173313.450a0e20@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5744780403948115250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andres,

>  drivers/atmodem/atmodem.c |   13 ++++++++++++-
>  gatchat/gatchat.c         |   33 ++++++++++++++++++++++++++++++---
>  gatchat/gatchat.h         |    7 +++++--
>  include/log.h             |    5 +++++
>  src/log.c                 |   39 +++++++++++++++++++++++++++++++++------
>  src/main.c                |    1 +
>  6 files changed, 86 insertions(+), 12 deletions(-)

Send two separate patches, one for gatchat related functionality.  One for =
the =

ofono integration.

> +static void g_at_chat_debug_log(GAtChat *chat, gboolean is_read,
> +		char *str, gsize len)

I suggest you use const char *str here

> +{
> +	char type =3D is_read ? '<' : '>';
> +	char *tmp;
> +
> +	if (!chat->debugf || !len)
> +		return;
> +
> +	if (len > 1024) {
> +		/* let's keep it to a reasonable length.. */
> +		chat->debugf("%c (ignoring string of length %d)\n", type, len);

27.007 specifies a max command result length of 2048, Section 5.1:
"the total number of characters, including line terminators, in the =

information text shall not exceed 2048 characters."

> +		return;
> +	}
> +
> +	str[len] =3D '\0';	/* XXX: is it safe to overwrite this byte? */

Probably not

> +	tmp =3D g_strescape(str, "\"");
> +	chat->debugf("%c %s\n", type, tmp);
> +	g_free(tmp);
> +}
> +
> -GAtChat *g_at_chat_new(GIOChannel *channel, int flags)
> +GAtChat *g_at_chat_new(GIOChannel *channel, int flags, GAtDebugFunc

Lets make the debug function settable / gettable.  I.e. something like:

g_at_chat_set_debug_info(GAtChat *chat, GAtDebugFunc *debugf, void *debugda=
ta)
g_at_chat_get_debug_func(GAtChat *chat)
g_at_chat_get_debug_data(GAtChat *chat)

>  GAtChat *g_at_chat_ref(GAtChat *chat)
> diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
> index 969f6f4..4353e08 100644
> --- a/gatchat/gatchat.h
> +++ b/gatchat/gatchat.h
> @@ -36,6 +36,8 @@ typedef void (*GAtResultFunc)(gboolean success, GAtResu=
lt
> *result, gpointer user_data);
>  typedef void (*GAtNotifyFunc)(GAtResult *result, gpointer user_data);
>  typedef void (*GAtDisconnectFunc)(gpointer user_data);
> +typedef void (*GAtDebugFunc)(const char *format, ...)
> +		__attribute__((format(printf, 1, 2)));
>

make the signature a simple void (*foo)(const char *str, void *data);

Regards,
-Denis

--===============5744780403948115250==--

