Content-Type: multipart/mixed; boundary="===============8225046308690286778=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2 v2] hfp_ag_bluez5: register audio card
Date: Mon, 05 Oct 2015 11:45:55 -0500
Message-ID: <5612A943.2000704@gmail.com>
In-Reply-To: <1444044790-17392-2-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8225046308690286778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

<snip>

> @@ -123,14 +168,24 @@ static DBusMessage *profile_new_connection(DBusConn=
ection *conn,
>
>   	ofono_emulator_register(em, fd);
>
> -	fd_dup =3D dup(fd);
> -	io =3D g_io_channel_unix_new(fd_dup);
> +	io =3D g_io_channel_unix_new(fd);

The comment in commit 9332299b indicates that a dup() was needed to =

properly detect HUP events.  Can you double check that this change is =

indeed correct?

>   	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, G_IO_HUP, io_hup_cb,
>   						g_strdup(device), g_free);
>   	g_io_channel_unref(io);
>
> -	g_hash_table_insert(connection_hash, g_strdup(device),
> -						GINT_TO_POINTER(fd_dup));
> +	dev =3D g_new0(struct device_info, 1);
> +	dev->fd =3D fd;
> +
> +	dev->card =3D ofono_handsfree_card_create(0,
> +					OFONO_HANDSFREE_CARD_TYPE_GATEWAY,
> +					NULL, NULL);
> +
> +	ofono_handsfree_card_set_local(dev->card, local);
> +	ofono_handsfree_card_set_remote(dev->card, remote);
> +
> +	g_hash_table_insert(connection_hash, g_strdup(device), dev);
> +
> +	ofono_handsfree_card_register(dev->card);
>

On HFP 1.6 and 1.7, the audio should not be triggered until SLC is =

established.  Whats your plan to ensure that PulseAudio does not start =

using the audio device until then?  FYI, the earlier attempt to add AG =

support had src/emulator.c make the ofono_handsfree_card_register() call =

at the appropriate time.

Regards,
-Denis

--===============8225046308690286778==--

