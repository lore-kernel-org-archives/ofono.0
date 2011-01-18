Content-Type: multipart/mixed; boundary="===============2012990478652580163=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/5] atmodem: sim-auth atom driver.
Date: Tue, 18 Jan 2011 13:30:28 -0600
Message-ID: <4D35EA54.9030902@gmail.com>
In-Reply-To: <1295285934-9306-5-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2012990478652580163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> +static void at_discover_apps_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	GAtResultIter iter;
> +	ofono_sim_list_apps_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +	GSList *list =3D NULL, *i;
> +	struct ofono_sim_app_record *buffer;
> +	int j, n;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok) {
> +		cb(&error, NULL, 0, cbd->data);
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, "+CUAD:")) {
> +		const guint8 *obj_str;
> +		gint len;
> +
> +		if (!g_at_result_iter_next_hexstring(&iter, &obj_str, &len))
> +			goto error;
> +
> +		i =3D sim_parse_app_template_entries(obj_str, len);
> +		if (i =3D=3D NULL)
> +			goto error;
> +
> +		list =3D g_slist_concat(i, list);
> +	}
> +

Since we potentially multiple results, what do you think of using an
approach similar to how phonebook works.  E.g. a simple:

typedef void (*ofono_sim_auth_cb_t)(const struct ofono_error *error,
                                        void *data);

and ofono_sim_auth_app_record(struct ofono_sim_auth *sa, unsigned char
*record, int len);

This would work nicely even for drivers using CRSM I think...

> +	n =3D g_slist_length(list);
> +	buffer =3D g_new(struct ofono_sim_app_record, n);
> +
> +	for (i =3D list, j =3D n - 1; i !=3D NULL; i =3D i->next, i--)
> +		memcpy(&buffer[j], i->data, sizeof(*buffer));
> +
> +	cb(&error, buffer, n, cbd->data);
> +
> +	g_free(buffer);
> +	goto done;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
> +
> +done:
> +	while (list) {
> +		i =3D list;
> +		list =3D list->next;
> +
> +		g_free(((struct ofono_sim_app_record *) i->data)->label);
> +		g_free(i->data);
> +		g_slist_free_1(i);
> +	}
> +}

Regards,
-Denis

--===============2012990478652580163==--

