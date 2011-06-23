Content-Type: multipart/mixed; boundary="===============2431231357147915764=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] GAtPPP: Add ACFC option support
Date: Thu, 23 Jun 2011 13:58:06 -0500
Message-ID: <4E038CBE.9010006@gmail.com>
In-Reply-To: <1308225321-21611-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2431231357147915764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 06/16/2011 06:55 AM, Guillaume Zajac wrote:
> ---
>  gatchat/gatppp.c  |  116 ++++++++++++++++++++++++++++++++++++++++++-----=
-----
>  gatchat/ppp.h     |    7 +++
>  gatchat/ppp_lcp.c |   27 +++++++++++-
>  3 files changed, 124 insertions(+), 26 deletions(-)
> =

> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index 5fb4146..a505db1 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -83,6 +83,9 @@ struct _GAtPPP {
>  	int fd;
>  	guint guard_timeout_source;
>  	gboolean suspended;
> +	gboolean acfc;
> +	guint8 address;
> +	guint8 control;

I'm lost as to the purpose of the address and control variables in the
GAtPPP structure?

>  };
>  =

>  void ppp_debug(GAtPPP *ppp, const char *str)
> @@ -168,17 +171,39 @@ static inline gboolean ppp_drop_packet(GAtPPP *ppp,=
 guint16 protocol)
>  static void ppp_receive(const unsigned char *buf, gsize len, void *data)
>  {
>  	GAtPPP *ppp =3D data;
> -	guint16 protocol =3D ppp_proto(buf);
> -	const guint8 *packet =3D ppp_info(buf);
> +	struct ppp_header *header =3D (struct ppp_header *) buf;
> +	gboolean acfc_frame =3D (header->address !=3D PPP_ADDR_FIELD
> +			|| header->control !=3D PPP_CTRL);
> +	guint16 protocol;
> +	const guint8 *packet;
> +
> +	if (acfc_frame) {
> +		protocol =3D ppp_acfc_proto(buf);
> +		packet =3D ppp_acfc_info(buf);
> +	} else {
> +		protocol =3D ppp_proto(buf);
> +		packet =3D ppp_info(buf);
> +	}
>  =


Looks good to me

>  	if (ppp_drop_packet(ppp, protocol))
>  		return;
>  =

> +	/*
> +	 * RFC 1661:
> +	 * If we received PPP packets with Adress and Control Field Compressed
> +	 * although ACFC had not been negociated, we silently discard them.
> +	 */
> +	if (!ppp->acfc && acfc_frame)
> +		return;
> +

Please use ppp->acfc =3D=3D FALSE here

>  	switch (protocol) {
>  	case PPP_IP_PROTO:
>  		ppp_net_process_packet(ppp->net, packet);
>  		break;
>  	case LCP_PROTOCOL:
> +		/* Those values will be tested while negociating ACFC option */
> +		ppp->address =3D header->address;
> +		ppp->control =3D header->control;
>  		pppcp_process_packet(ppp->lcp, packet);
>  		break;
>  	case IPCP_PROTO:
> @@ -196,37 +221,29 @@ static void ppp_receive(const unsigned char *buf, g=
size len, void *data)
>  	};
>  }
>  =

> -/*
> - * transmit out through the lower layer interface
> - *
> - * infolen - length of the information part of the packet
> - */
> -void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen)
> +static void ppp_send_lcp_frame(GAtPPP *ppp, guint8 *packet, guint infole=
n)
>  {
>  	struct ppp_header *header =3D (struct ppp_header *) packet;
> -	guint16 proto =3D ppp_proto(packet);
>  	guint8 code;
> -	gboolean lcp =3D (proto =3D=3D LCP_PROTOCOL);
>  	guint32 xmit_accm =3D 0;
>  	gboolean sta =3D FALSE;
> +	gboolean lcp;
>  =

>  	/*
>  	 * all LCP Link Configuration, Link Termination, and Code-Reject
>  	 * packets must be sent with the default sending ACCM
>  	 */
> -	if (lcp) {
> -		code =3D pppcp_get_code(packet);
> -		lcp =3D code > 0 && code < 8;
> -
> -		/*
> -		 * If we're going down, we try to make sure to send the final
> -		 * ack before informing the upper layers via the ppp_disconnect
> -		 * function.  Once we enter PPP_DEAD phase, no further packets
> -		 * will be sent
> -		 */
> -		if (code =3D=3D PPPCP_CODE_TYPE_TERMINATE_ACK)
> -			sta =3D TRUE;
> -	}
> +	code =3D pppcp_get_code(packet);
> +	lcp =3D code > 0 && code < 8;
> +
> +	/*
> +	 * If we're going down, we try to make sure to send the final
> +	 * ack before informing the upper layers via the ppp_disconnect
> +	 * function.  Once we enter PPP_DEAD phase, no further packets
> +	 * will be sent
> +	 */
> +	if (code =3D=3D PPPCP_CODE_TYPE_TERMINATE_ACK)
> +		sta =3D TRUE;
>  =

>  	if (lcp) {
>  		xmit_accm =3D g_at_hdlc_get_xmit_accm(ppp->hdlc);
> @@ -251,6 +268,42 @@ void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint=
 infolen)
>  		g_at_hdlc_set_xmit_accm(ppp->hdlc, xmit_accm);
>  }
>  =

> +static void ppp_send_acfc_frame(GAtPPP *ppp, guint8 *packet,
> +					guint infolen)
> +{
> +	struct ppp_header *header =3D (struct ppp_header *) packet;
> +	guint offset =3D 0;
> +
> +	if (ppp->acfc)
> +		offset =3D 2;
> +
> +	if (g_at_hdlc_send(ppp->hdlc, packet + offset,
> +				infolen + sizeof(*header) - offset)
> +			=3D=3D FALSE)
> +		DBG(ppp, "Failed to send a frame\n");
> +}
> +
> +/*
> + * transmit out through the lower layer interface
> + *
> + * infolen - length of the information part of the packet
> + */
> +void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen)
> +{
> +	guint16 proto =3D ppp_proto(packet);
> +
> +	switch (proto) {
> +	case LCP_PROTOCOL:
> +		ppp_send_lcp_frame(ppp, packet, infolen);
> +		break;
> +	case CHAP_PROTOCOL:
> +	case IPCP_PROTO:
> +	case PPP_IP_PROTO:
> +		ppp_send_acfc_frame(ppp, packet, infolen);
> +		break;
> +	}
> +}
> +

Looks fine to me

>  static inline void ppp_enter_phase(GAtPPP *ppp, enum ppp_phase phase)
>  {
>  	DBG(ppp, "%d", phase);
> @@ -390,6 +443,23 @@ void ppp_set_mtu(GAtPPP *ppp, const guint8 *data)
>  	ppp->mtu =3D mtu;
>  }
>  =

> +gboolean ppp_set_acfc_enabled(GAtPPP *ppp, gboolean acfc)
> +{
> +	/*
> +	 * RFC 1662:
> +	 * When using the standard HDLC-like framing, the Address and Control
> +	 * fields contain the hexadecimal values 0xff and 0x03 respectively.
> +	 * When other Address or Control field values are in use, Address-
> +	 * and-Control-Field-Compression MUST NOT be negotiated.
> +	 */
> +	if (ppp->address =3D=3D 0xFF && ppp->control =3D=3D 0x03)
> +		ppp->acfc =3D acfc;

There is no need for this check.  The sender is responsible for not
compressing the packets if the address / control do not correspond to
the well known ones.

> +	else
> +		ppp->acfc =3D FALSE;
> +
> +	return ppp->acfc;
> +}
> +

So this seems wrong to me.  The purpose of ppp_set_acfc_enabled is twofold:

- Whether we should send the ACFC option to the peer (e.g. we can accept
ACFC packets)
- Whether we should try to send ACFC packets (assuming the peer tells us
it is capable of doing so)

So what this function should be doing is setting lcp->req_options
accordingly (somehow).

ppp->acfc should not really change 'per packet', but a global setting
for the GAtPPP object

>  static void io_disconnect(gpointer user_data)
>  {
>  	GAtPPP *ppp =3D user_data;
> diff --git a/gatchat/ppp.h b/gatchat/ppp.h
> index 023d779..3cf11f7 100644
> --- a/gatchat/ppp.h
> +++ b/gatchat/ppp.h
> @@ -85,6 +85,12 @@ static inline void __put_unaligned_short(void *p, guin=
t16 val)
>  #define ppp_proto(packet) \
>  	(get_host_short(packet + 2))
>  =

> +#define ppp_acfc_info(packet) \
> +	(packet + 2)
> +
> +#define ppp_acfc_proto(packet) \
> +	(get_host_short(packet))
> +
>  /* LCP related functions */
>  struct pppcp_data *lcp_new(GAtPPP *ppp, gboolean dormant);
>  void lcp_free(struct pppcp_data *lcp);
> @@ -125,4 +131,5 @@ void ppp_lcp_finished_notify(GAtPPP *ppp);
>  void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
>  void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm);
>  void ppp_set_mtu(GAtPPP *ppp, const guint8 *data);
> +gboolean ppp_set_acfc_enabled(GAtPPP *ppp, gboolean acfc);

This function should be g_at_ppp_set_acfc_enabled() and be in gatppp.h

>  struct ppp_header *ppp_packet_new(gsize infolen, guint16 protocol);
> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> index ce9dae2..24e7bae 100644
> --- a/gatchat/ppp_lcp.c
> +++ b/gatchat/ppp_lcp.c
> @@ -58,11 +58,12 @@ enum lcp_options {
>  	ACFC			=3D 8,
>  };
>  =

> -/* Maximum size of all options, we only ever request ACCM and MRU */ =

> -#define MAX_CONFIG_OPTION_SIZE 10
> +/* Maximum size of all options, we only ever request ACCM, MRU and ACFC =
*/
> +#define MAX_CONFIG_OPTION_SIZE 12
>  =

>  #define REQ_OPTION_ACCM	0x1
>  #define REQ_OPTION_MRU	0x2
> +#define REQ_OPTION_ACFC	0x4
>  =

>  struct lcp_data {
>  	guint8 options[MAX_CONFIG_OPTION_SIZE];
> @@ -100,6 +101,13 @@ static void lcp_generate_config_options(struct lcp_d=
ata *lcp)
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

> @@ -110,6 +118,12 @@ static void lcp_reset_config_options(struct lcp_data=
 *lcp)
>  	lcp_generate_config_options(lcp);
>  }
>  =

> +static void lcp_set_acfc_config_option(struct lcp_data *lcp)
> +{
> +	lcp->req_options |=3D REQ_OPTION_ACFC;
> +	lcp_generate_config_options(lcp);
> +}
> +
>  /*
>   * signal the Up event to the NCP
>   */
> @@ -286,9 +300,16 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pp=
pcp,
>  			break;
>  		case MAGIC_NUMBER:
>  		case PFC:
> -		case ACFC:
>  			/* don't care */
>  			break;
> +		case ACFC:
> +			if (ppp_set_acfc_enabled(ppp, TRUE)) {
> +				struct lcp_data *lcp =3D pppcp_get_data(pppcp);
> +				lcp_set_acfc_config_option(lcp);
> +				pppcp_set_local_options(pppcp, lcp->options,
> +							lcp->options_len);
> +			}
> +			break;

Again, this seems wrong.  What is happening here is that the peer just
told us that 'Yes, I can accept ACFC packets'.

What you're trying to do is set whether our end can accept ACFC packets
based on whether the peer can.  In fact, they are completely
independent.  The relationship can be asymmetric, e.g. client that can
send ACFC packets, but not accept them, and vice versa.  You need to
account for this.

>  		}
>  	}
>  =


Regards,
-Denis

--===============2431231357147915764==--

