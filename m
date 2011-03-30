Content-Type: multipart/mixed; boundary="===============0550875758305161750=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 4/4] ifxmodem: emergency number list support
Date: Tue, 29 Mar 2011 22:17:45 -0500
Message-ID: <4D92A0D9.2000107@gmail.com>
In-Reply-To: <1301320689-25201-5-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0550875758305161750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 03/28/2011 08:58 AM, Jeevaka Badrappan wrote:
> ---
>  drivers/ifxmodem/voicecall.c |   98 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 98 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
> index 87a48e6..a92ac11 100644
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
> +	GSList *en_list;
>  };
>  =

>  struct release_id_req {
> @@ -786,6 +788,95 @@ static void xcolp_notify(GAtResult *result, gpointer=
 user_data)
>  	ofono_voicecall_notify(vc, call);
>  }
>  =

> +static gint number_compare(gconstpointer a, gconstpointer b)
> +{
> +	const char *s1 =3D a, *s2 =3D b;
> +	return strcmp(s1, s2);
> +}
> +
> +static void xlema_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GAtResultIter iter;
> +	int index, total_cnt;
> +	const char *number;
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
> +	// Skip the category, EN valid with simpresence and mcc fields

Just a nitpick, but can you please use C-style comments ;)

> +
> +	if (!g_slist_find_custom(vd->en_list, number, number_compare))
> +		vd->en_list =3D g_slist_prepend(vd->en_list, g_strdup(number));
> +

Does this duplicate detection belong in the core?  It might be more
efficient to bite the bullet and use something like a GHashtable to
build the final list of ECCs.

> +	if (index !=3D total_cnt)
> +		return;
> +
> +	vd->en_list =3D g_slist_reverse(vd->en_list);
> +
> +	ofono_voicecall_en_list_notify(vc, vd->en_list);
> +
> +	g_slist_foreach(vd->en_list, (GFunc) g_free, NULL);
> +	g_slist_free(vd->en_list);
> +	vd->en_list =3D NULL;
> +}
> +
> +static void xlema_read(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GAtResultIter iter;
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
> +		// Skip the category, EN valid with simpresence and mcc fields

Again about c-style comments

> +		g_at_result_iter_skip_next(&iter);
> +		g_at_result_iter_skip_next(&iter);
> +		g_at_result_iter_skip_next(&iter);
> +
> +		if (!g_slist_find_custom(vd->en_list, number, number_compare))
> +			vd->en_list =3D g_slist_prepend(vd->en_list,
> +							g_strdup(number));
> +	}
> +
> +	vd->en_list =3D g_slist_reverse(vd->en_list);
> +
> +	ofono_voicecall_en_list_notify(vc, vd->en_list);
> +
> +	g_slist_foreach(vd->en_list, (GFunc) g_free, NULL);
> +	g_slist_free(vd->en_list);
> +	vd->en_list =3D NULL;
> +}
> +
>  static void ifx_voicecall_initialized(gboolean ok, GAtResult *result,
>  					gpointer user_data)
>  {
> @@ -803,7 +894,14 @@ static void ifx_voicecall_initialized(gboolean ok, G=
AtResult *result,
>  							FALSE, vc, NULL);
>  	g_at_chat_register(vd->chat, "+XCOLP:", xcolp_notify, FALSE, vc, NULL);
>  =

> +	g_at_chat_register(vd->chat, "+XLEMA:", xlema_notify, FALSE, vc, NULL);

An empty line here please

> +	/* Enable emergency number list notification */
> +	g_at_chat_send(vd->chat, "AT+XLEMA=3D1", none_prefix, NULL, NULL, NULL);
> +
>  	ofono_voicecall_register(vc);
> +
> +	g_at_chat_send(vd->chat, "AT+XLEMA?", xlema_prefix, xlema_read, vc,
> +									NULL);
>  }
>  =

>  static int ifx_voicecall_probe(struct ofono_voicecall *vc, unsigned int =
vendor,

Regards,
-Denis

--===============0550875758305161750==--

