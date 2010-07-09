Content-Type: multipart/mixed; boundary="===============6844848490118585564=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Make fetch command function as external
Date: Fri, 09 Jul 2010 12:17:09 -0500
Message-ID: <4C375995.9090606@gmail.com>
In-Reply-To: <1278687128-8983-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6844848490118585564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

>  static gboolean sim_status_poll(gpointer user_data)
> @@ -317,3 +266,4 @@ void atmodem_poll_enable(struct ofono_modem *modem, G=
AtChat *chat)
>  		sim_watch(sim_atom,
>  				OFONO_ATOM_WATCH_CONDITION_REGISTERED, spd);
>  }
> +

Please note that I also get an error applying this patch:

Applying: Make fetch command function as external
/home/denkenz/ofono-master/.git/rebase-apply/patch:101: new blank line
at EOF.
+
fatal: 1 line adds whitespace errors.

> +void at_sim_fetch_command(GAtChat *chat, struct ofono_stk *stk, int leng=
th)
> +{
> +	char buf[64];
> +	struct cb_data *cbd =3D cb_data_new(chat, stk);
> +
> +	snprintf(buf, sizeof(buf), "AT+CSIM=3D10,A0120000%02hhX", length);
> +	g_at_chat_send(chat, buf, csim_prefix, csim_fetch_cb, cbd, g_free);
> +}
> +

There's no reason to pass in the chat object.  The stk_data hanging off
ofono_stk object already has a chat inside it.  So simply using that one
is enough.  This also means you don't need to create a cbd, passing stk
into g_at_chat_send is enough.

Regards,
-Denis

--===============6844848490118585564==--

