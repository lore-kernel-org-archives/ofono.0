Content-Type: multipart/mixed; boundary="===============5595481090427669278=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] atmodem: timeout for gprs context deactivation
Date: Tue, 25 May 2010 14:36:00 +0200
Message-ID: <1274790960.27220.133.camel@localhost.localdomain>
In-Reply-To: <20100525113908.6786.72506.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5595481090427669278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Huawei modems have an annoying feature to hangup the chat line
> after ppp shutdown. Basically what happens is this:
> =

> 14:15:08 ofonod[11768]: > AT+CGACT=3D0,1\r
> 14:15:09 ofonod[11768]: EventChannel: < \r\n^BOOT:38645652,0,0,0,87\r\n
> 14:15:10 ofonod[11768]: EventChannel: < \r\n^RSSI:22\r\n

we might wanna@least decode the ^BOOT messages as extra debug
information.

> ofono sends AT+CGACT to the modem but does not get any reply and will
> wait forever.
> =

> Workaround the issue by adding a five second timeout for the CGACT comman=
d.
> This makes it possible to properly use huawei modems with connman. Without
> this patch you can connect only once from connman and then you have to
> restart connman.

We don't need to re-open the TTY or anything alike. Just waiting for the
timeout is enough? After that the TTY starts responding to commands
again?

>  		ofono_gprs_context_up_cb_t up_cb;       /* Up callback */
>  	};
>  	void *cb_data;                                  /* Callback data */
> +	gint cgact_timeout;
>  };

The timeouts are GSources and so normally guint actually.
 =

>  static void at_cgact_down_cb(gboolean ok, GAtResult *result, gpointer us=
er_data)
>  {
>  	struct cb_data *cbd =3D user_data;
> @@ -73,6 +96,13 @@ static void at_cgact_down_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
>  	struct ofono_error error;
>  =

> +	if (gcd->cgact_timeout =3D=3D 0)
> +		/* already timed out */
> +		return;
> +

In theory you are correct with no { } since it is a single statement,
but if you put a comment on top of it, then please use the { } to make
it easier for the reader.

> +	g_source_remove(gcd->cgact_timeout);
> +	gcd->cgact_timeout =3D 0;
> +
>  	if (ok)
>  		gcd->active_context =3D 0;
>  =

> @@ -136,6 +166,11 @@ static void ppp_disconnect(GAtPPPDisconnectReason re=
ason, gpointer user_data)
>  			g_free(cbd);
>  			goto out;
>  		}
> +
> +		/* workaround for huawei hangup problem */
> +		gcd->cgact_timeout =3D g_timeout_add_seconds(5, cgact_timeout,
> +							cbd);
> +

I think we should include this into a Huawei specific quirk.

Regards

Marcel



--===============5595481090427669278==--

