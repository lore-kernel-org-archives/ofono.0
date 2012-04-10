Content-Type: multipart/mixed; boundary="===============6588052929297702286=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] SpeedUp: enable online/offline
Date: Tue, 10 Apr 2012 02:40:12 -0500
Message-ID: <4F83E3DC.30203@gmail.com>
In-Reply-To: <1334052671-6638-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6588052929297702286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> @@ -232,12 +236,122 @@ static int speedup_disable(struct ofono_modem *mod=
em)
>  	g_at_chat_cancel_all(data->aux);
>  	g_at_chat_unregister_all(data->aux);
>  =

> +	/* Cleanup potential online enable polling */
> +	if (data->online_poll_source > 0) {
> +		g_source_remove(data->online_poll_source);
> +		data->online_poll_source =3D 0;
> +
> +		g_free(data->online_cbd);
> +		data->online_cbd =3D NULL;
> +	}
> +

This looks fine, but it is actually in the wrong place.  The core
doesn't allow concurrent online and disable operations.  This really
belongs in speedup_remove so that you take care of the case where the
modem is physically yanked out.

Regards,
-Denis

--===============6588052929297702286==--

