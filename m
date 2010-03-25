Content-Type: multipart/mixed; boundary="===============8765134793727994343=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] Refactor the command parsing framework
Date: Thu, 25 Mar 2010 12:24:30 -0500
Message-ID: <201003251224.31500.denkenz@gmail.com>
In-Reply-To: <1269524901-1745-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8765134793727994343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> ---
>  gatchat/gatserver.c |  182
>  +++++++++++++++++++++++++++++++++++--------------- gatchat/gatserver.h |=
  =

>   7 ++-
>  2 files changed, 133 insertions(+), 56 deletions(-)
> =

> -	at_command_notify(server, buf, prefix, type);
> +	notify =3D at_node_new(server, buf, prefix, type);
> +	if (!notify)
> +		goto error;
> =

>  	/* Also consume the terminating null */
> -	return i + 1;
> +	server->read_pos +=3D i + 1;
> +	server->notify_source =3D g_idle_add_full(G_PRIORITY_DEFAULT,
> +						at_command_notify,
> +						notify, g_free);
> +
> +	return;
> +
> +error:
> +	g_free(notify);
> +
> +	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
>  }

Err, OK stop right there.  This is really way too complicated.  How about w=
e =

simply set a flag before calling at_command_notify.  If after executing it =

send_final or send_ext_final response has been sent, then we continue =

processing, otherwise we restart when send_ext_final or send_final will be =

called again.  You really don't need to touch this function at all.

> +typedef void (*GAtServerNotifyCallback)(gpointer user_data);
> +

Get rid of this, not necessary.

>  typedef void (*GAtServerNotifyFunc)(GAtServerRequestType type,
> -					GAtResult *result, gpointer user_data);
> +					GAtResult *result,
> +					gpointer user_data,
> +					GAtServerNotifyCallback cb,
> +					gpointer cb_data);
> =


Keep the NotifyFunc the way it is, your changes are really not required.

Regards,
-Denis

--===============8765134793727994343==--

