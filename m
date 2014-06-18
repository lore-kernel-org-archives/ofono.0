Content-Type: multipart/mixed; boundary="===============5220248202009555409=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] gatchat: implement PAP authentication
Date: Wed, 18 Jun 2014 17:20:48 -0500
Message-ID: <53A210C0.9020501@gmail.com>
In-Reply-To: <1403042279-20598-2-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5220248202009555409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On 06/17/2014 04:57 PM, Philip Paeps wrote:
> Make the authentication method configurable, CHAP or PAP, defaulting to
> CHAP (i.e.: previous behaviour).
> =

> Implementation details:
> =

>  o If PAP is configured, we NAK the CHAP authentication protocol option
>    in LCP configuration requests and suggest PAP instead.  This works
>    around the amusing requirement of 3GPP TS 29.061 that modems must
>    send a forced positive acknowledgement of the authentication method
>    tried (i.e.: the modem will successfully accept any CHAP handshake,
>    but if the network only supports PAP, the modem will hang up when it
>    tries and fails to activate the PDP context)

In theory this is because CHAP authentication should always be accepted
by the network operator, but it seems there are still a few out there
that do not do this properly.

> =

>  o The PAP Authenticate-Request is resent a hard-coded three times at
>    ten-second intervals.  This may be a bit too persistent.  Chances
>    are if it doesn't work the first time, it'll never work, but the
>    RFC insists that we MUST retry.
> =

> Signed-off-by: Philip Paeps <philip@paeps.cx>

We do not use Signed-off-by, so please drop this one on your next
submission.

> ---
>  gatchat/gatppp.c   |   50 ++++++++++++++++++-
>  gatchat/gatppp.h   |    8 +++
>  gatchat/ppp.h      |    9 ++++
>  gatchat/ppp_auth.c |  139 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  gatchat/ppp_lcp.c  |   68 ++++++++++++++++++-------
>  5 files changed, 253 insertions(+), 21 deletions(-)
> =

> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index f767f4a..c75d7f5 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -64,11 +64,13 @@ struct _GAtPPP {
>  	struct pppcp_data *ipcp;
>  	struct ppp_net *net;
>  	struct ppp_chap *chap;
> +	struct ppp_pap *pap;
>  	GAtHDLC *hdlc;
>  	gint mru;
>  	gint mtu;
>  	char username[256];
>  	char password[256];
> +	GAtPPPAuthMethod auth_method;
>  	GAtPPPConnectFunc connect_cb;
>  	gpointer connect_data;
>  	GAtPPPDisconnectFunc disconnect_cb;
> @@ -150,13 +152,15 @@ static inline gboolean ppp_drop_packet(GAtPPP *ppp,=
 guint16 protocol)
>  			return TRUE;
>  		break;
>  	case PPP_PHASE_AUTHENTICATION:
> -		if (protocol !=3D LCP_PROTOCOL && protocol !=3D CHAP_PROTOCOL)
> +		if (protocol !=3D LCP_PROTOCOL && protocol !=3D CHAP_PROTOCOL &&
> +					protocol !=3D PAP_PROTOCOL)
>  			return TRUE;
>  		break;
>  	case PPP_PHASE_DEAD:
>  		return TRUE;
>  	case PPP_PHASE_NETWORK:
>  		if (protocol !=3D LCP_PROTOCOL && protocol !=3D CHAP_PROTOCOL &&
> +					protocol !=3D PAP_PROTOCOL &&
>  					protocol !=3D IPCP_PROTO)
>  			return TRUE;
>  		break;
> @@ -222,6 +226,12 @@ static void ppp_receive(const unsigned char *buf, gs=
ize len, void *data)
>  	case IPCP_PROTO:
>  		pppcp_process_packet(ppp->ipcp, packet, len - offset);
>  		break;
> +	case PAP_PROTOCOL:
> +		if (ppp->pap)
> +			ppp_pap_process_packet(ppp->pap, packet, len - offset);
> +		else
> +			pppcp_send_protocol_reject(ppp->lcp, buf, len);
> +		break;
>  	case CHAP_PROTOCOL:
>  		if (ppp->chap) {
>  			ppp_chap_process_packet(ppp->chap, packet,
> @@ -359,6 +369,12 @@ void ppp_set_auth(GAtPPP *ppp, const guint8* auth_da=
ta)
>  	guint16 proto =3D get_host_short(auth_data);
>  =

>  	switch (proto) {
> +	case PAP_PROTOCOL:
> +		if (ppp->pap)
> +			ppp_pap_free(ppp->pap);
> +
> +		ppp->pap =3D ppp_pap_new(ppp);
> +		break;
>  	case CHAP_PROTOCOL:
>  		if (ppp->chap)
>  			ppp_chap_free(ppp->chap);
> @@ -437,10 +453,18 @@ void ppp_ipcp_finished_notify(GAtPPP *ppp)
>  =

>  void ppp_lcp_up_notify(GAtPPP *ppp)
>  {
> -	/* Wait for the peer to send us a challenge if we expect auth */
>  	if (ppp->chap !=3D NULL) {
> +		/* Wait for the peer to send us a challenge. */
>  		ppp_enter_phase(ppp, PPP_PHASE_AUTHENTICATION);
>  		return;
> +	} else if (ppp->pap !=3D NULL) {
> +		/* Try to send an Authenticate-Request and wait for reply. */
> +		if (ppp_pap_start(ppp->pap) =3D=3D TRUE)
> +			ppp_enter_phase(ppp, PPP_PHASE_AUTHENTICATION);
> +		else
> +			/* It'll never work out. */
> +			ppp_auth_notify(ppp, FALSE);
> +		return;
>  	}
>  =

>  	/* Otherwise proceed as if auth succeeded */
> @@ -588,6 +612,22 @@ const char *g_at_ppp_get_password(GAtPPP *ppp)
>  	return ppp->password;
>  }
>  =

> +gboolean g_at_ppp_set_auth_method(GAtPPP *ppp, GAtPPPAuthMethod method)
> +{
> +	if (method !=3D G_AT_PPP_AUTH_METHOD_CHAP &&
> +	    method !=3D G_AT_PPP_AUTH_METHOD_PAP)

Please don't use spaces for indentation

> +		return FALSE;
> +
> +	ppp->auth_method =3D method;
> +
> +	return TRUE;
> +}
> +
> +GAtPPPAuthMethod g_at_ppp_get_auth_method(GAtPPP *ppp)
> +{
> +	return ppp->auth_method;
> +}
> +
>  void g_at_ppp_set_recording(GAtPPP *ppp, const char *filename)
>  {
>  	if (ppp =3D=3D NULL)
> @@ -727,6 +767,9 @@ void g_at_ppp_unref(GAtPPP *ppp)
>  	else if (ppp->fd >=3D 0)
>  		close(ppp->fd);
>  =

> +	if (ppp->pap)
> +		ppp_pap_free(ppp->pap);
> +
>  	if (ppp->chap)
>  		ppp_chap_free(ppp->chap);
>  =

> @@ -794,6 +837,9 @@ static GAtPPP *ppp_init_common(gboolean is_server, gu=
int32 ip)
>  	/* initialize IPCP state */
>  	ppp->ipcp =3D ipcp_new(ppp, is_server, ip);
>  =

> +	/* chap authentication by default */
> +	ppp->auth_method =3D G_AT_PPP_AUTH_METHOD_CHAP;
> +
>  	return ppp;
>  }
>  =

> diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
> index b5a2234..dab75a8 100644
> --- a/gatchat/gatppp.h
> +++ b/gatchat/gatppp.h
> @@ -74,6 +74,14 @@ gboolean g_at_ppp_set_credentials(GAtPPP *ppp, const c=
har *username,
>  const char *g_at_ppp_get_username(GAtPPP *ppp);
>  const char *g_at_ppp_get_password(GAtPPP *ppp);
>  =

> +typedef enum _GAtPPPAuthMethod {
> +	G_AT_PPP_AUTH_METHOD_CHAP,
> +	G_AT_PPP_AUTH_METHOD_PAP,
> +} GAtPPPAuthMethod;
> +

Please refer to doc/coding-style.txt item M9 for the preferred order of
declarations.

> +gboolean g_at_ppp_set_auth_method(GAtPPP *ppp, GAtPPPAuthMethod method);
> +GAtPPPAuthMethod g_at_ppp_get_auth_method(GAtPPP *ppp);
> +
>  void g_at_ppp_set_recording(GAtPPP *ppp, const char *filename);
>  =

>  void g_at_ppp_set_server_info(GAtPPP *ppp, const char *remote_ip,
> diff --git a/gatchat/ppp.h b/gatchat/ppp.h
> index 718575b..ac1a7ef 100644
> --- a/gatchat/ppp.h
> +++ b/gatchat/ppp.h
> @@ -22,6 +22,7 @@
>  #include "ppp_cp.h"
>  =

>  #define LCP_PROTOCOL	0xc021
> +#define PAP_PROTOCOL	0xc023
>  #define CHAP_PROTOCOL	0xc223
>  #define IPCP_PROTO	0x8021
>  #define IPV6CP_PROTO	0x8057
> @@ -38,6 +39,7 @@
>  =

>  struct ppp_chap;
>  struct ppp_net;
> +struct ppp_pap;
>  =

>  struct ppp_header {
>  	guint8 address;
> @@ -109,6 +111,13 @@ void ppp_chap_free(struct ppp_chap *chap);
>  void ppp_chap_process_packet(struct ppp_chap *chap, const guint8 *new_pa=
cket,
>  				gsize len);
>  =

> +/* PAP related functions */
> +struct ppp_pap *ppp_pap_new(GAtPPP *ppp);
> +void ppp_pap_free(struct ppp_pap *pap);
> +gboolean ppp_pap_start(struct ppp_pap *pap);
> +void ppp_pap_process_packet(struct ppp_pap *pap, const guint8 *new_packe=
t,
> +				gsize len);
> +
>  /* TUN / Network related functions */
>  struct ppp_net *ppp_net_new(GAtPPP *ppp, int fd);
>  const char *ppp_net_get_interface(struct ppp_net *net);
> diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
> index 1ddf762..46bbc65 100644
> --- a/gatchat/ppp_auth.c
> +++ b/gatchat/ppp_auth.c
> @@ -54,6 +54,38 @@ enum chap_code {
>  	FAILURE
>  };
>  =

> +struct pap_header {
> +	guint8 code;
> +	guint8 identifier;
> +	guint16 length;
> +	guint8 data[0];
> +} __attribute__((packed));
> +
> +struct	ppp_pap {

There should be a single space between struct and ppp_pap...

> +	GAtPPP *ppp;
> +	struct ppp_header *authreq;
> +	guint16 authreq_len;
> +	guint retry_timer;
> +	guint retries;
> +};
> +
> +enum pap_code {
> +	PAP_REQUEST =3D 1,
> +	PAP_ACK,
> +	PAP_NAK
> +};
> +
> +/*
> + * RFC 1334 2.1.1:
> + *   The Authenticate-Request packet MUST be repeated until a valid
> + *   reply packet is received, or an optional retry counter expires.
> + *
> + * If we don't get a reply after this many attempts, we can safely
> + * assume we're never going to get one.
> + */
> +#define PAP_MAX_RETRY	3  /* attempts */
> +#define PAP_TIMEOUT	10 /* seconds */
> +
>  static void chap_process_challenge(struct ppp_chap *chap, const guint8 *=
packet)
>  {
>  	const struct chap_header *header =3D (const struct chap_header *) packe=
t;
> @@ -166,3 +198,110 @@ struct ppp_chap *ppp_chap_new(GAtPPP *ppp, guint8 m=
ethod)
>  =

>  	return chap;
>  }
> +
> +void ppp_pap_process_packet(struct ppp_pap *pap, const guint8 *new_packe=
t,
> +				gsize len)
> +{
> +	guint8 code;
> +
> +	if (len < sizeof(struct pap_header))
> +		return;
> +
> +	code =3D new_packet[0];
> +
> +	switch (code) {
> +	case PAP_ACK:
> +		g_source_remove(pap->retry_timer);
> +		pap->retry_timer =3D 0;
> +		ppp_auth_notify(pap->ppp, TRUE);
> +		break;
> +	case PAP_NAK:
> +		g_source_remove(pap->retry_timer);
> +		pap->retry_timer =3D 0;
> +		ppp_auth_notify(pap->ppp, FALSE);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static gboolean ppp_pap_timeout(gpointer user_data)
> +{
> +	struct ppp_pap *pap =3D (struct ppp_pap *)user_data;
> +	struct pap_header *authreq;
> +
> +	if (++pap->retries >=3D PAP_MAX_RETRY) {
> +		pap->retry_timer =3D 0;
> +		ppp_auth_notify(pap->ppp, FALSE);
> +		return FALSE;
> +	}
> +
> +	/*
> +	 * RFC 1334 2.2.1:
> +	 * The Identifier field MUST be changed each time an
> +	 * Authenticate-Request packet is issued.
> +	 */
> +	authreq =3D (struct pap_header *)&pap->authreq->info;
> +	authreq->identifier =3D g_random_int() % G_MAXUINT8;

Is this sufficient to fulfill the requirement stated in the comment?  It
would be highly unlikely, but the identifier might still be repeated,
no?  Would it be easier to simply use a counter?

> +
> +	ppp_transmit(pap->ppp, (guint8 *)pap->authreq, pap->authreq_len);
> +
> +	return TRUE;
> +}
> +
> +gboolean ppp_pap_start(struct ppp_pap *pap)
> +{
> +	struct pap_header *authreq;
> +	struct ppp_header *packet;
> +	const char *username =3D g_at_ppp_get_username(pap->ppp);
> +	const char *password =3D g_at_ppp_get_password(pap->ppp);
> +	guint16 length;
> +
> +	length =3D sizeof(*authreq) + strlen(username) + strlen(password) + 2;
> +	packet =3D ppp_packet_new(length, PAP_PROTOCOL);
> +	if (packet =3D=3D NULL)
> +		return FALSE;
> +	pap->authreq =3D packet;
> +	pap->authreq_len =3D length;
> +
> +	authreq =3D (struct pap_header *)&packet->info;
> +	authreq->code =3D PAP_REQUEST;
> +	authreq->identifier =3D g_random_int() % G_MAXUINT8;
> +	authreq->length =3D htons(length);
> +
> +	authreq->data[0] =3D (char)strlen(username);

This cast seems fishy.  Shouldn't it be to an unsigned char or guint8?

> +	memcpy(authreq->data + 1, username, strlen(username));
> +	authreq->data[strlen(username) + 1] =3D (char)strlen(password);

Same as above.

> +	memcpy(authreq->data + 1 + strlen(username) + 1, password,
> +	    strlen(password));

No spaces for indentation please

> +
> +	/* Transmit the packet and schedule a retry. */
> +	ppp_transmit(pap->ppp, (guint8 *)packet, length);
> +	pap->retries =3D 0;
> +	pap->retry_timer =3D g_timeout_add_seconds(PAP_TIMEOUT,
> +	    ppp_pap_timeout, pap);
> +
> +	return TRUE;
> +}
> +
> +void ppp_pap_free(struct ppp_pap *pap)
> +{
> +	if (pap->retry_timer !=3D 0)
> +		g_source_remove(pap->retry_timer);
> +	if (pap->authreq !=3D NULL)
> +		g_free(pap->authreq);
> +	g_free(pap);
> +}
> +
> +struct ppp_pap *ppp_pap_new(GAtPPP *ppp)
> +{
> +	struct ppp_pap *pap;
> +
> +	pap =3D g_try_new0(struct ppp_pap, 1);
> +	if (pap =3D=3D NULL)
> +		return NULL;
> +
> +	pap->ppp =3D ppp;
> +
> +	return pap;
> +}
> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> index 4f420f1..1fdcb24 100644
> --- a/gatchat/ppp_lcp.c
> +++ b/gatchat/ppp_lcp.c
> @@ -238,25 +238,55 @@ static enum rcr_result lcp_rcr(struct pppcp_data *p=
ppcp,
>  			guint8 method =3D option_data[2];
>  			guint8 *option;
>  =

> -			if ((proto =3D=3D CHAP_PROTOCOL) && (method =3D=3D MD5))
> -				break;
> -
> -			/*
> -			 * try to suggest CHAP & MD5.  If we are out
> -			 * of memory, just reject.
> -			 */
> -
> -			option =3D g_try_malloc0(5);
> -			if (option =3D=3D NULL)
> -				return RCR_REJECT;
> -
> -			option[0] =3D AUTH_PROTO;
> -			option[1] =3D 5;
> -			put_network_short(&option[2], CHAP_PROTOCOL);
> -			option[4] =3D MD5;
> -			*new_options =3D option;
> -			*new_len =3D 5;
> -			return RCR_NAK;
> +			switch (g_at_ppp_get_auth_method(ppp)) {
> +			case G_AT_PPP_AUTH_METHOD_CHAP:
> +				if (proto =3D=3D CHAP_PROTOCOL && method =3D=3D MD5)
> +					break;
> +
> +				/*
> +				 * Try to suggest CHAP/MD5.
> +				 * Just reject if we run out of memory.
> +				 */
> +				option =3D g_try_malloc0(5);
> +				if (option =3D=3D NULL)
> +					return RCR_REJECT;
> +
> +				option[0] =3D AUTH_PROTO;
> +				option[1] =3D 5;
> +				put_network_short(&option[2], CHAP_PROTOCOL);
> +				option[4] =3D MD5;
> +				*new_options =3D option;
> +				*new_len =3D 5;
> +
> +				return RCR_NAK;
> +
> +			case G_AT_PPP_AUTH_METHOD_PAP:
> +				if (proto =3D=3D PAP_PROTOCOL)
> +					break;
> +
> +				/*
> +				 * Try to suggest PAP.
> +				 * Just reject if we run out of memory.
> +				 */
> +				option =3D g_try_malloc0(4);
> +				if (option =3D=3D NULL)
> +					return RCR_REJECT;
> +
> +				option[0] =3D AUTH_PROTO;
> +				option[1] =3D 4;
> +				put_network_short(&option[2], PAP_PROTOCOL);
> +				*new_options =3D option;
> +				*new_len =3D 4;
> +
> +				return RCR_NAK;
> +			default:
> +				/*
> +				 * We only support CHAP and PAP.
> +				 * Tough luck!
> +				 */
> +				return RCR_NAK;

Since this can never happen, we should probably not even include this
statement.

> +			}
> +			break;
>  		}
>  		case ACCM:
>  		case PFC:
> =


Regards,
-Denis

--===============5220248202009555409==--

