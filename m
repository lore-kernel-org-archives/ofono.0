Content-Type: multipart/mixed; boundary="===============3666883604699184490=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v3 1/4] GAtPPP: Add ACFC option support
Date: Tue, 28 Jun 2011 12:03:51 -0500
Message-ID: <4E0A0977.8050801@gmail.com>
In-Reply-To: <1309255427-10308-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3666883604699184490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> @@ -658,6 +703,11 @@ void g_at_ppp_set_server_info(GAtPPP *ppp, const cha=
r *remote,
>  	ipcp_set_server_info(ppp->ipcp, r, d1, d2);
>  }
>  =

> +void g_at_ppp_set_acfc_enabled(GAtPPP *ppp)

I really do want the signature to be g_at_ppp_set_acfc_enabled(GAtPPP
*ppp, gboolean enabled)

There are cases where we might re-use the PPP object with different
parameters.

> +{
> +	lcp_turn_on_acfc(ppp->lcp);
> +}
> +
>  static GAtPPP *ppp_init_common(gboolean is_server, guint32 ip)
>  {
>  	GAtPPP *ppp;

<snip>

> @@ -100,13 +101,19 @@ static void lcp_generate_config_options(struct lcp_=
data *lcp)
>  		len +=3D 4;
>  	}
>  =

> +	if (lcp->req_options & REQ_OPTION_ACFC) {
> +		lcp->options[len] =3D ACFC;
> +		lcp->options[len + 1] =3D 2;
> +
> +		len +=3D 2;
> +	}
> +
>  	lcp->options_len =3D len;
>  }
>  =

>  static void lcp_reset_config_options(struct lcp_data *lcp)
>  {
>  	/* Using the default ACCM */
> -

Please don't include random whitespace fixes as part of a larger patch,
send these separately.  And in this case the empty line is there on
purpose, since the comment does not refer to
lcp_generate_config_options, but to the fact that options by default are
empty.

>  	lcp_generate_config_options(lcp);
>  }
>  =

> @@ -286,9 +293,15 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pp=
pcp,
>  			break;
>  		case MAGIC_NUMBER:
>  		case PFC:
> -		case ACFC:
>  			/* don't care */
>  			break;
> +		case ACFC:
> +		{
> +			struct lcp_data *lcp =3D pppcp_get_data(pppcp);

Please add a newline here

> +			if (lcp->req_options & REQ_OPTION_ACFC)
> +				ppp_set_xmit_acfc(ppp, TRUE);

And a newline here

> +			break;
> +		}
>  		}
>  	}
>  =


Regards,
-Denis

--===============3666883604699184490==--

