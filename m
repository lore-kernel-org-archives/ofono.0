Content-Type: multipart/mixed; boundary="===============6817302739231242546=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] netreg: Add CPHS CSP implementation
Date: Thu, 03 Feb 2011 15:06:08 -0600
Message-ID: <4D4B18C0.9000809@gmail.com>
In-Reply-To: <1296739688-26585-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6817302739231242546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> @@ -838,6 +860,9 @@ static DBusMessage *network_register(DBusConnection *=
conn,
>  =

>  	netreg->driver->register_auto(netreg, register_callback, netreg);
>  =

> +	if (netreg->mode =3D=3D NETWORK_REGISTRATION_MODE_AUTO_ONLY)
> +		return NULL;
> +

So we might just return access_denied here as well.

>  	set_registration_mode(netreg, NETWORK_REGISTRATION_MODE_AUTO);
>  =

>  	return NULL;

<snip>

> @@ -1769,7 +1835,7 @@ static void netreg_load_settings(struct ofono_netre=
g *netreg)
>  	mode =3D g_key_file_get_integer(netreg->settings, SETTINGS_GROUP,
>  					"Mode", NULL);
>  =

> -	if (mode >=3D 0 && mode <=3D 1)
> +	if (mode !=3D NETWORK_REGISTRATION_MODE_AUTO_ONLY)
>  		netreg->mode =3D mode;
>  =


This check is unnecessary, you already loaded the settings before you
managed to load the sim file.  You're also removing a sanity check for
no real reason.

This brings up another point, since the CPHS CSP file is actually
user-writeable (for some unknown reason) the user can remove the SIM,
put it in another phone and modify the forced-auto settings.  If you
store the forced-auto mode in the settings file, then there's no way to
ever go back to non-forced auto, even though he should be able to.

I suggest that when forced-auto is detected, that we only write
NETWORK_REGISTRATION_MODE_AUTO to the settings store.

Regards,
-Denis

--===============6817302739231242546==--

