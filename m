Content-Type: multipart/mixed; boundary="===============1040392657344424789=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 05/26] gathdlc: add mechansim to detect '+++' escape
 sequence
Date: Mon, 02 May 2011 07:22:20 -0500
Message-ID: <4DBEA1FC.20800@gmail.com>
In-Reply-To: <1301648188-7208-6-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1040392657344424789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> @@ -197,6 +257,29 @@ out:
>  =

>  	if (hdlc->destroyed)
>  		g_free(hdlc);
> +
> +	/*
> +	 * If there were no data pause for GUARD_TIMEOUTS ms,
> +	 * we try again to check it.
> +	 */
> +	if (!hdlc->paused)
> +		hdlc->pause_timeout =3D g_timeout_add (GUARD_TIMEOUTS,
> +							paused_timeout_cb,
> +							hdlc);

So you just caused a crash here...

> +
> +	return;
> +
> +suspend:
> +	/*
> +	 * Restart the counter and reset the ring buffer.
> +	 */
> +	hdlc->cmpt =3D 0;
> +
> +	/*
> +	 * Wait for another pause of GUARD_TIMEOUTS ms before returning to comm=
and mode.
> +	 */
> +	hdlc->paused =3D FALSE;
> +	hdlc->pause_timeout =3D g_timeout_add (GUARD_TIMEOUTS, hdlc_suspend, hd=
lc);
>  }
>  =

>  GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)

Some general comments:

Your implementation assumes too much about the contents of the read
buffer.  You have to make sure that it works even in different timings
of the received information.  You should also not try to process the
escape sequence through the main HDLC parser...

I've pushed my own version, which I have not tested at all.  The
relevant commits are 94d6d505eeda4db0a28aea99bf3ab23a62a65f2c and
dc86e864463a61d3f99a21c948c11ba274c6ef84.  Please review and let me know
how well it works.

Regards,
-Denis

--===============1040392657344424789==--

