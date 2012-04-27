Content-Type: multipart/mixed; boundary="===============0966506323381406485=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv1 4/5] service: Sort conversation list by message date
Date: Fri, 27 Apr 2012 14:23:25 +0200
Message-ID: <1335529405.16897.467.camel@aeonflux>
In-Reply-To: <1335344513-2347-5-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0966506323381406485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

>  src/service.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> =

> diff --git a/src/service.c b/src/service.c
> index 2787c3a..1bd4671 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -719,6 +719,31 @@ static gboolean get_conversation_get_args(DBusMessag=
e *dbus_msg,
>  	return TRUE;
>  }
> =

> +static gint fill_conversation_sort(gconstpointer a, gconstpointer b)
> +{
> +	const struct mms_message *msg1 =3D a;
> +	const struct mms_message *msg2 =3D b;
> +	time_t date1, date2;
> +
> +	if (msg1->type =3D=3D MMS_MESSAGE_TYPE_SEND_REQ)
> +		date1 =3D msg1->sr.date;
> +	else
> +		date1 =3D msg1->rc.date;
> +
> +	if (msg2->type =3D=3D MMS_MESSAGE_TYPE_SEND_REQ)
> +		date2 =3D msg2->sr.date;
> +	else
> +		date2 =3D msg2->rc.date;
> +
> +	if (date1 > date2)
> +		return 1;
> +
> +	if (date1 < date2)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static gboolean is_recipient(const char *recipients, const char *number)
>  {
>  	const char *rec, *num;
> @@ -784,6 +809,8 @@ static GList *fill_conversation(const struct mms_serv=
ice *service,
>  			conversation =3D g_list_prepend(conversation, value);
>  	}
> =

> +	conversation =3D g_list_sort(conversation, fill_conversation_sort);
> +

is it really more efficient to prepend and then later sort the list? Can
we just not insert items sorted to begin with?

Regards

Marcel



--===============0966506323381406485==--

