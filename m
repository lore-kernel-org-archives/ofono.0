Content-Type: multipart/mixed; boundary="===============9062323659193962499=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ifxmodem: emergency number list support
Date: Mon, 06 Jun 2011 18:04:15 -0500
Message-ID: <4DED5CEF.8020205@gmail.com>
In-Reply-To: <1307547887-30665-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9062323659193962499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 06/08/2011 10:44 AM, Jeevaka Badrappan wrote:
> ---
>  drivers/ifxmodem/voicecall.c |   95 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 95 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
> index 87a48e6..0aa83e4 100644
> --- a/drivers/ifxmodem/voicecall.c
> +++ b/drivers/ifxmodem/voicecall.c
> @@ -42,11 +42,13 @@
>  #include "ifxmodem.h"
>  =

>  static const char *none_prefix[] =3D { NULL };
> +static const char *xlema_prefix[] =3D { "+XLEMA:", NULL };
>  =

>  struct voicecall_data {
>  	GSList *calls;
>  	unsigned int local_release;
>  	GAtChat *chat;
> +	char **en_list;
>  };
>  =

>  struct release_id_req {
> @@ -786,6 +788,93 @@ static void xcolp_notify(GAtResult *result, gpointer=
 user_data)
>  	ofono_voicecall_notify(vc, call);
>  }
>  =

> +static void xlema_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GAtResultIter iter;
> +	int index, total_cnt;
> +	const char *number;
> +	int count =3D (vd->en_list =3D=3D NULL) ? 0 : g_strv_length(vd->en_list=
);
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+XLEMA:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &index))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &total_cnt))
> +		return;
> +
> +	if (!g_at_result_iter_next_string(&iter, &number))
> +		return;
> +
> +	/* Skip the category, valid in simpresent and mcc fields */

What is this comment referring to?

> +
> +	if (vd->en_list =3D=3D NULL)
> +		vd->en_list =3D g_new0(char *, total_cnt + 1);
> +
> +	vd->en_list[count] =3D g_strdup(number);
> +
> +	if (index !=3D total_cnt)
> +		return;
> +
> +	ofono_voicecall_en_list_notify(vc, vd->en_list);
> +
> +	g_strfreev(vd->en_list);
> +	vd->en_list =3D NULL;
> +}
> +
> +static void xlema_read(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GAtResultIter iter;
> +	int num =3D 0;
> +	int index, total_cnt;
> +	const char *number;
> +
> +	if (!ok) {
> +		DBG("Emergency number list read failed");
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, "+XLEMA:"))
> +		num +=3D 1;
> +
> +	vd->en_list =3D g_new0(char *, num + 1);
> +
> +	num =3D 0;
> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, "+XLEMA:")) {
> +		if (!g_at_result_iter_next_number(&iter, &index))
> +			continue;
> +
> +		if (!g_at_result_iter_next_number(&iter, &total_cnt))
> +			continue;
> +
> +		if (!g_at_result_iter_next_string(&iter, &number))
> +			continue;
> +
> +		/* Skip the category, valid in simpresent and mcc fields */
> +		g_at_result_iter_skip_next(&iter);
> +		g_at_result_iter_skip_next(&iter);
> +		g_at_result_iter_skip_next(&iter);

What are you trying to achieve here?  Since you're not checking the
result, it doesn't look like this code serves any purpose.

> +
> +		vd->en_list[num++] =3D g_strdup(number);
> +	}
> +
> +	ofono_voicecall_en_list_notify(vc, vd->en_list);
> +
> +	g_strfreev(vd->en_list);
> +	vd->en_list =3D NULL;
> +}
> +
>  static void ifx_voicecall_initialized(gboolean ok, GAtResult *result,
>  					gpointer user_data)
>  {
> @@ -802,6 +891,10 @@ static void ifx_voicecall_initialized(gboolean ok, G=
AtResult *result,
>  	g_at_chat_register(vd->chat, "+XCALLSTAT:", xcallstat_notify,
>  							FALSE, vc, NULL);
>  	g_at_chat_register(vd->chat, "+XCOLP:", xcolp_notify, FALSE, vc, NULL);
> +	g_at_chat_register(vd->chat, "+XLEMA:", xlema_notify, FALSE, vc, NULL);
> +	/* Enable emergency number list notification */
> +	g_at_chat_send(vd->chat, "AT+XLEMA=3D1", xlema_prefix, xlema_read, vc,
> +									NULL);
>  =

>  	ofono_voicecall_register(vc);
>  }
> @@ -840,6 +933,8 @@ static void ifx_voicecall_remove(struct ofono_voiceca=
ll *vc)
>  	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
>  	g_slist_free(vd->calls);
>  =

> +	g_strfreev(vd->en_list);
> +
>  	ofono_voicecall_set_data(vc, NULL);
>  =

>  	g_at_chat_unref(vd->chat);

Otherwise this looks good to me.

Regards,
-Denis

--===============9062323659193962499==--

