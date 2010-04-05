Content-Type: multipart/mixed; boundary="===============0972847007194889746=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH 2/2] Added SQLite history plugin
Date: Sun, 04 Apr 2010 19:54:12 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9C138D0D0@orsmsx508.amr.corp.intel.com>
In-Reply-To: <4BB909D7.9020403@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0972847007194889746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> +    tmpparams =3D g_strdup_printf("\"%s\",%d,\"%s\",\"%s\",\"%s\",",
> +                    ofono_modem_get_path(context->modem),
> +                    msg_id, from, text, buf);
> +
> +    strftime(buf, 127, "\"%Y-%m-%dT%H:%M:%S%z\"", remote);
> +    buf[127] =3D '\0';
> +    params =3D g_strconcat(tmpparams, buf, NULL);
> +
> +    query =3D g_strdup_printf(INSERT_IN_MSGS, params);
[Snip]
> +    tmpparams =3D g_strdup_printf("\"%s\",%d,\"%s\",\"%s\",\"%s\",%d,",
> +                    ofono_modem_get_path(context->modem),
> +                    msg_id, to, text, buf,
> +                    OFONO_HISTORY_SMS_STATUS_PENDING);
> +
> +    currtime =3D time(NULL);
> +    strftime(buf, 127, "\"%Y-%m-%dT%H:%M:%S%z\"", localtime(&currtime));
> +    buf[127] =3D '\0';
> +    params =3D g_strconcat(tmpparams, buf, NULL);
> +
> +    query =3D g_strdup_printf(INSERT_OUT_MSGS, params);

The message handling in this patch seems to be vulnerable to SQL injection =
attacks. See http://en.wikipedia.org/wiki/SQL_injection

Cheers,
Waldo

--===============0972847007194889746==--

