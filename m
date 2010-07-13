Content-Type: multipart/mixed; boundary="===============1768060417071915447=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/9] stkutil: display text attributes as html
Date: Tue, 13 Jul 2010 15:38:07 -0500
Message-ID: <4C3CCEAF.9070101@gmail.com>
In-Reply-To: <1279024855-10586-2-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1768060417071915447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,
> +	/* add any color */
> +	if (fg)
> +		g_string_append_printf(string, "color: %s;", html_colors[fg]);
> +	if (bg)
> +		g_string_append_printf(string, "background-color: %s;",
> +						html_colors[bg]);

I applied the patch however I changed this part afterward.  Black
background / foreground should still be set explicitly.

Regards,
-Denis

--===============1768060417071915447==--

