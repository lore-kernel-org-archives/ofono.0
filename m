Content-Type: multipart/mixed; boundary="===============1387627735101150250=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] ppp: Add MAX_IPCP_FAILURE to avoid timeout quickly
Date: Fri, 09 Jul 2010 05:43:19 -0300
Message-ID: <1278664999.10421.98.camel@localhost.localdomain>
In-Reply-To: <1278664835-21295-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1387627735101150250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> We use IPCP NAK response to stall the progress of acquiring the client
> IP address from DHCP server. So we need to increase the max failure of
> NAKs in IPCP handshaking.
> ---
>  gatchat/ppp_cp.c   |    8 ++++++--
>  gatchat/ppp_cp.h   |    2 +-
>  gatchat/ppp_ipcp.c |   10 +++++++++-
>  gatchat/ppp_lcp.c  |    2 +-
>  4 files changed, 17 insertions(+), 5 deletions(-)
> =

> diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
> index 647e241..e013283 100644
> --- a/gatchat/ppp_cp.c
> +++ b/gatchat/ppp_cp.c
> @@ -997,7 +997,7 @@ void pppcp_set_local_options(struct pppcp_data *pppcp,
>  }
>  =

>  struct pppcp_data *pppcp_new(GAtPPP *ppp, const struct pppcp_proto *prot=
o,
> -				gboolean dormant)
> +				gboolean dormant, int max_failure)

since the value is actually unsigned here, please also use guint and not
int for this parameter.

Regards

Marcel



--===============1387627735101150250==--

