Content-Type: multipart/mixed; boundary="===============1361143784823941123=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v4 09/10] hfp_ag: Add media transport support
Date: Fri, 06 Apr 2012 12:38:02 -0500
Message-ID: <4F7F29FA.5060106@gmail.com>
In-Reply-To: <1333718232-8447-10-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1361143784823941123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

> @@ -82,6 +93,12 @@ static DBusMessage *hfp_ag_agent_new_connection(DBusCo=
nnection *conn,
>  		return __ofono_error_failed(msg);
>  =

>  	ofono_emulator_register(em, fd);
> +	audio =3D bluetooth_set_audio_management(em, path, features);
> +
> +	io =3D g_io_channel_unix_new(fd);
> +	g_io_add_watch_full(io, G_PRIORITY_HIGH,
> +				G_IO_HUP | G_IO_ERR | G_IO_NVAL, client_event,
> +				audio, NULL);

It might be better to register to atom removal rather than an IO watch.

>  =

>  	return dbus_message_new_method_return(msg);
>  }

Regards,
-Denis

--===============1361143784823941123==--

