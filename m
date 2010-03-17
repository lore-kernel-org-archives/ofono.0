Content-Type: multipart/mixed; boundary="===============7572018117286766078=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 06/11] Add notify at command callback
Date: Wed, 17 Mar 2010 12:23:28 -0600
Message-ID: <201003171323.28549.denkenz@gmail.com>
In-Reply-To: <1268836241-4834-6-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7572018117286766078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> ---
>  gatchat/gatserver.c |   38 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 38 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
> index bbaef52..6e3347c 100644
> --- a/gatchat/gatserver.c
> +++ b/gatchat/gatserver.c
> @@ -227,10 +227,48 @@ static gboolean is_extended_character(const char c)
>  	}
>  }
> =

>  static GAtServerResult at_command_notify(GAtServer *server, char *comman=
d,
>  						char *prefix)
>  {
>  	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
> +	struct at_command *node;
> +
> +	node =3D g_hash_table_lookup(server->command_list, prefix);
> +	if (node && node->notify) {
> +		GAtServerRequestType type;
> +		GAtResult result;
> +
> +		type =3D get_command_type(command, prefix);
> +		if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_ERROR)
> +			return res;
> +
> +		result.lines =3D g_slist_prepend(NULL, command);
> +		result.final_or_pdu =3D 0;
> +
> +		res =3D node->notify(type, &result, node->user_data);
> +	}

Are you freeing the slist anywhere?  In general you might want to run valgr=
ind =

before submitting patches just to make sure there are no visible leaks.

Regards,
-Denis

--===============7572018117286766078==--

