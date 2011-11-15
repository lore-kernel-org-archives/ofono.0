Content-Type: multipart/mixed; boundary="===============6590529236170283035=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 5/6] gatppp: Add IPv6 CP connect, disconnect callbacks
Date: Mon, 14 Nov 2011 20:59:33 -0600
Message-ID: <4EC1D595.9040202@gmail.com>
In-Reply-To: <1320756418-30890-6-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6590529236170283035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 11/08/2011 06:46 AM, Oleg Zhurakivskyy wrote:
> ---
>  gatchat/gatppp.c |   38 ++++++++++++++++++++++++++++++++++++++
>  gatchat/gatppp.h |    9 ++++++++-
>  2 files changed, 46 insertions(+), 1 deletions(-)
> =

> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index c425eae..5a34535 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -64,6 +64,7 @@ struct _GAtPPP {
>  	struct pppcp_data *ipcp;
>  	struct pppcp_data *ipv6cp;
>  	struct ppp_net *net;
> +	struct ppp_net *net6;

Actually you can't do it this way.  There's only a single IP layer, so
it is considered 'live' as soon as one of the NCPs (e.g. IPCP or IPv6CP)
has been negotiated (e.g. went to 'up' state).

>  	struct ppp_chap *chap;
>  	GAtHDLC *hdlc;
>  	gint mru;
> @@ -75,6 +76,10 @@ struct _GAtPPP {
>  	GAtPPPDisconnectFunc disconnect_cb;
>  	gpointer disconnect_data;
>  	GAtPPPDisconnectReason disconnect_reason;
> +	GAtPPPConnect6Func connect6_cb;
> +	gpointer connect6_data;

I can see this one, but...

> +	GAtPPPDisconnectFunc disconnect6_cb;
> +	gpointer disconnect6_data;

Why do you need this one?

>  	GAtDebugFunc debugf;
>  	gpointer debug_data;
>  	gboolean sta_pending;
> @@ -454,7 +459,19 @@ void ppp_ipv6cp_up_notify(GAtPPP *ppp, const char *l=
ocal, const char *peer)
>  {
>  	DBG(ppp, "local: %s, peer: %s", local, peer);
>  =

> +	ppp->net6 =3D ppp_net_new(ppp, -1);
> +
> +	if (ppp->net6 =3D=3D NULL) {
> +		ppp->disconnect_reason =3D G_AT_PPP_REASON_NET_FAIL;
> +		pppcp_signal_close(ppp->lcp);
> +		return;
> +	}
> +
>  	ppp_enter_phase(ppp, PPP_PHASE_LINK_UP);
> +
> +	if (ppp->connect6_cb)
> +		ppp->connect6_cb(ppp_net_get_interface(ppp->net6),
> +					local, peer, ppp->connect6_data);

See my previous comments, entering of the LINK_UP phase can happen as
soon as one of IPCP or IPV6CP has been negotiated, so this needs to be
reworked a bit.  If it makes things easier, for now we can assume that
if IPCP or IPV6CP goes down, then the other one should probably be shut
down as well, if it exists.

>  }
>  =

>  void ppp_ipv6cp_down_notify(GAtPPP *ppp)
> @@ -831,6 +848,27 @@ gboolean g_at_ppp_set_ipv6cp_info(GAtPPP *ppp, gbool=
ean is_server,
>  	return TRUE;
>  }
>  =

> +void g_at_ppp_set_ipv6_connect_function(GAtPPP *ppp, GAtPPPConnect6Func =
func,
> +							gpointer user_data)
> +{
> +	if (func =3D=3D NULL)
> +		return;
> +
> +	ppp->connect6_cb =3D func;
> +	ppp->connect6_data =3D user_data;
> +}
> +
> +void g_at_ppp_set_ipv6_disconnect_function(GAtPPP *ppp,
> +						GAtPPPDisconnectFunc func,
> +						gpointer user_data)
> +{
> +	if (func =3D=3D NULL)
> +		return;
> +
> +	ppp->disconnect6_cb =3D func;
> +	ppp->disconnect6_data =3D user_data;
> +}
> +
>  static GAtPPP *ppp_init_common(gboolean is_server, guint32 ip)
>  {
>  	GAtPPP *ppp;
> diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
> index a41bf08..8fa1cd4 100644
> --- a/gatchat/gatppp.h
> +++ b/gatchat/gatppp.h
> @@ -50,7 +50,8 @@ typedef void (*GAtPPPConnectFunc)(const char *iface, co=
nst char *local,
>  					gpointer user_data);
>  typedef void (*GAtPPPDisconnectFunc)(GAtPPPDisconnectReason reason,
>  					gpointer user_data);
> -
> +typedef void (*GAtPPPConnect6Func)(const char *iface, const char *local,
> +					const char *peer, gpointer user_data);
>  GAtPPP *g_at_ppp_new(void);
>  GAtPPP *g_at_ppp_server_new(const char *local);
>  GAtPPP *g_at_ppp_server_new_full(const char *local, int fd);
> @@ -84,6 +85,12 @@ void g_at_ppp_set_acfc_enabled(GAtPPP *ppp, gboolean e=
nabled);
>  void g_at_ppp_set_pfc_enabled(GAtPPP *ppp, gboolean enabled);
>  gboolean g_at_ppp_set_ipv6cp_info(GAtPPP *ppp, gboolean is_server,
>  					const char *local, const char *peer);
> +void g_at_ppp_set_ipv6_connect_function(GAtPPP *ppp,
> +					GAtPPPConnect6Func callback,
> +					gpointer user_data);
> +void g_at_ppp_set_ipv6_disconnect_function(GAtPPP *ppp,
> +						GAtPPPDisconnectFunc func,
> +						gpointer user_data);
>  =

>  #ifdef __cplusplus
>  }

Regards,
-Denis

--===============6590529236170283035==--

