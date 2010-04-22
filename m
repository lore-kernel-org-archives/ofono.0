Content-Type: multipart/mixed; boundary="===============4505939755706734506=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ppp: alert ipcp when lcp is down
Date: Thu, 22 Apr 2010 15:12:47 -0500
Message-ID: <201004221512.48947.denkenz@gmail.com>
In-Reply-To: <1271966102-8857-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4505939755706734506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

>  	lcp_reset_config_options(lcp);
>  	pppcp_set_local_options(pppcp, lcp->options, lcp->options_len);
> +	ppp_lcp_down_notify(pppcp_get_ppp(pppcp));
>  	ppp_enter_phase(pppcp_get_ppp(pppcp), PPP_PHASE_TERMINATION);
>  }
> =


I fixed this somewhat different by calling down & close on ipcp layer from =

within the termination phase.

Regards,
-Denis

--===============4505939755706734506==--

