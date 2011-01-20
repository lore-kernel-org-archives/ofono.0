Content-Type: multipart/mixed; boundary="===============2173500069976453531=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 4/4] atmodem: sim-auth atom driver.
Date: Thu, 20 Jan 2011 18:21:42 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802DA0746@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1295424478-12049-6-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2173500069976453531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej,

ofono-bounces(a)ofono.org wrote:
> +static void at_discover_apps_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data) +{
> +	struct cb_data *cbd =3D user_data;
> +	GAtResultIter iter;
> +	ofono_sim_list_apps_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +	const unsigned char *dataobj;
> +	gint linelen;
> +	unsigned char *buffer;
> +	int len;
> +
> +	decode_at_error(&error, g_at_result_final_response(result)); +
> +	if (!ok) {
> +		cb(&error, NULL, 0, cbd->data);
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	len =3D 0;
> +	while (g_at_result_iter_next(&iter, "+CUAD:")) {
> +		if (!g_at_result_iter_next_hexstring(&iter,
> NULL, &linelen))
> +			goto error;
> +
> +		len +=3D linelen;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	buffer =3D g_malloc(len);
> +	len =3D 0;
> +	while (g_at_result_iter_next(&iter, "+CUAD:")) {
> +		g_at_result_iter_next_hexstring(&iter,
> &dataobj, &linelen);
> +		memcpy(buffer + len, dataobj, linelen);
> +		len +=3D linelen;
> +	}

missing check for buffer memory allocation failure =


> +
> +static int at_sim_auth_probe(struct ofono_sim_auth *sa,
> unsigned int vendor,
> +				void *data)
> +{
> +	GAtChat *chat =3D data;
> +	struct sim_auth_data *sad;
> +
> +	sad =3D g_new0(struct sim_auth_data, 1);
> +	sad->chat =3D g_at_chat_clone(chat);
> +	sad->vendor =3D vendor;

missing check for "sad" memory allocation failure =


Regards,
Jeevaka

--===============2173500069976453531==--

