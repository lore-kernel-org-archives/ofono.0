Content-Type: multipart/mixed; boundary="===============5554872518362643871=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] netreg: Deprecate the deregister method
Date: Thu, 20 Jan 2011 09:57:52 -0600
Message-ID: <4D385B80.2010304@gmail.com>
In-Reply-To: <1295474035-7142-2-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5554872518362643871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> @@ -1795,14 +1768,8 @@ static void netreg_load_settings(struct ofono_netr=
eg *netreg)
>  =

>  	netreg->imsi =3D g_strdup(imsi);
>  =

> -	mode =3D g_key_file_get_integer(netreg->settings, SETTINGS_GROUP,
> -					"Mode", NULL);
> -
> -	if (mode >=3D 0 && mode <=3D 2)
> -		netreg->mode =3D mode;
> -
> -	g_key_file_set_integer(netreg->settings, SETTINGS_GROUP,
> -				"Mode", netreg->mode);
> +	netreg->mode =3D g_key_file_get_integer(netreg->settings, SETTINGS_GROU=
P,
> +						"Mode", NULL);
>  }
>  =


I dropped this chunk and amended your patch to stipulate mode 0 and 1
only.  This was a sanity check that no-one is messing with our settings
file.

>  void ofono_netreg_register(struct ofono_netreg *netreg)

Regards,
-Denis

--===============5554872518362643871==--

