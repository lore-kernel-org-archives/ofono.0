Content-Type: multipart/mixed; boundary="===============7467137593656420756=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatserver: Don't free twice after user disconnect
Date: Tue, 06 Jul 2010 11:11:57 -0500
Message-ID: <4C3355CD.30600@gmail.com>
In-Reply-To: <1278298752-10232-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7467137593656420756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> @@ -1019,9 +1019,6 @@ static void io_disconnect(gpointer user_data)
>  =

>  	if (server->user_disconnect)
>  		server->user_disconnect(server->user_disconnect_data);
> -
> -	if (server->destroyed)
> -		g_free(server);
>  }
>  =

>  static void server_wakeup_writer(GAtServer *server)

Good catch.  Patch has been applied, thanks.

Regards,
-Denis


--===============7467137593656420756==--

