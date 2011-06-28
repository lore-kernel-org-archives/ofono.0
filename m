Content-Type: multipart/mixed; boundary="===============0536386640151636637=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v2 1/2] GAtPPP: Add ACFC option support
Date: Tue, 28 Jun 2011 11:54:06 +0200
Message-ID: <4E09A4BE.7040101@linux.intel.com>
In-Reply-To: <4E08B06D.5040008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0536386640151636637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 27/06/2011 18:31, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 06/27/2011 11:15 AM, Guillaume Zajac wrote:
>> ---
>>   gatchat/gatppp.c  |   79 +++++++++++++++++++++++++++++++++++++++++++++=
+-------
>>   gatchat/gatppp.h  |    2 +
>>   gatchat/ppp.h     |    8 +++++
>>   gatchat/ppp_lcp.c |   28 ++++++++++++++++---
>>   4 files changed, 103 insertions(+), 14 deletions(-)
>>
>> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
>> index 5fb4146..2640985 100644
>> --- a/gatchat/gatppp.c
>> +++ b/gatchat/gatppp.c
>> @@ -83,6 +83,8 @@ struct _GAtPPP {
>>   	int fd;
>>   	guint guard_timeout_source;
>>   	gboolean suspended;
>> +	gboolean force_acfc_off;
> You don't need this variable, see below for more
>
>> +	gboolean acfc;
> Please name this xmit_acfc.
>
>>   };
>>
>>   void ppp_debug(GAtPPP *ppp, const char *str)
>> @@ -168,8 +170,19 @@ static inline gboolean ppp_drop_packet(GAtPPP *ppp,=
 guint16 protocol)
>>   static void ppp_receive(const unsigned char *buf, gsize len, void *dat=
a)
>>   {
>>   	GAtPPP *ppp =3D data;
>> -	guint16 protocol =3D ppp_proto(buf);
>> -	const guint8 *packet =3D ppp_info(buf);
>> +	struct ppp_header *header =3D (struct ppp_header *) buf;
>> +	gboolean acfc_frame =3D (header->address !=3D PPP_ADDR_FIELD
>> +			|| header->control !=3D PPP_CTRL);
>> +	guint16 protocol;
>> +	const guint8 *packet;
>> +
>> +	if (acfc_frame) {
>> +		protocol =3D ppp_acfc_proto(buf);
>> +		packet =3D ppp_acfc_info(buf);
>> +	} else {
>> +		protocol =3D ppp_proto(buf);
>> +		packet =3D ppp_info(buf);
>> +	}
>>
>>   	if (ppp_drop_packet(ppp, protocol))
>>   		return;
>> @@ -196,17 +209,11 @@ static void ppp_receive(const unsigned char *buf, =
gsize len, void *data)
>>   	};
>>   }
>>
>> -/*
>> - * transmit out through the lower layer interface
>> - *
>> - * infolen - length of the information part of the packet
>> - */
>> -void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen)
>> +static void ppp_send_common_frame(GAtPPP *ppp, guint8 *packet, guint in=
folen,
>> +					gboolean lcp)
> Shouldn't this be called send_lcp_frame?

Yes sorry I had an issue with git reflog. I will fix it in next version.

>>   {
>>   	struct ppp_header *header =3D (struct ppp_header *) packet;
>> -	guint16 proto =3D ppp_proto(packet);
>>   	guint8 code;
>> -	gboolean lcp =3D (proto =3D=3D LCP_PROTOCOL);
>>   	guint32 xmit_accm =3D 0;
>>   	gboolean sta =3D FALSE;
>>
>> @@ -251,6 +258,44 @@ void ppp_transmit(GAtPPP *ppp, guint8 *packet, guin=
t infolen)
>>   		g_at_hdlc_set_xmit_accm(ppp->hdlc, xmit_accm);
>>   }
>>
>> +static void ppp_send_acfc_frame(GAtPPP *ppp, guint8 *packet,
>> +					guint infolen)
>> +{
>> +	struct ppp_header *header =3D (struct ppp_header *) packet;
>> +	guint offset =3D 0;
>> +
>> +	if (ppp->acfc)
>> +		offset =3D 2;
>> +	else
>> +		offset =3D 0;
>> +
>> +	if (g_at_hdlc_send(ppp->hdlc, packet + offset,
>> +				infolen + sizeof(*header) - offset)
>> +			=3D=3D FALSE)
>> +		DBG(ppp, "Failed to send a frame\n");
>> +}
>> +
>> +/*
>> + * transmit out through the lower layer interface
>> + *
>> + * infolen - length of the information part of the packet
>> + */
>> +void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen)
>> +{
>> +	guint16 proto =3D ppp_proto(packet);
>> +
>> +	switch (proto) {
>> +	case LCP_PROTOCOL:
>> +		ppp_send_common_frame(ppp, packet, infolen, TRUE);
>> +		break;
>> +	case CHAP_PROTOCOL:
>> +	case IPCP_PROTO:
>> +	case PPP_IP_PROTO:
>> +		ppp_send_acfc_frame(ppp, packet, infolen);
>> +		break;
>> +	}
>> +}
>> +
>>   static inline void ppp_enter_phase(GAtPPP *ppp, enum ppp_phase phase)
>>   {
>>   	DBG(ppp, "%d", phase);
>> @@ -390,6 +435,14 @@ void ppp_set_mtu(GAtPPP *ppp, const guint8 *data)
>>   	ppp->mtu =3D mtu;
>>   }
>>
>> +void ppp_set_acfc_enabled(GAtPPP *ppp, gboolean acfc)
> Please name this function ppp_set_xmit_acfc(GAtPPP *ppp, gboolean acfc)
>
>> +{
>> +	if (ppp->force_acfc_off)
>> +		ppp->acfc =3D FALSE;
>> +	else
>> +		ppp->acfc =3D acfc;
> And set ppp->xmit_acfc directly from acfc...
>
>> +}
>> +
>>   static void io_disconnect(gpointer user_data)
>>   {
>>   	GAtPPP *ppp =3D user_data;
>> @@ -658,6 +711,12 @@ void g_at_ppp_set_server_info(GAtPPP *ppp, const ch=
ar *remote,
>>   	ipcp_set_server_info(ppp->ipcp, r, d1, d2);
>>   }
>>
>> +void g_at_ppp_force_acfc_off(GAtPPP *ppp, gboolean off)
> Please name this function g_at_ppp_set_acfc_enabled(GAtPPP *ppp,
> gboolean enabled)
>
>> +{
>> +	ppp->force_acfc_off =3D off;
>> +	lcp_turn_off_acfc(ppp->lcp);
> To help in regression testing lets turn off ACFC by default, and only
> enable it if someone has asked for it.
>
>> +}
>> +
>>   static GAtPPP *ppp_init_common(gboolean is_server, guint32 ip)
>>   {
>>   	GAtPPP *ppp;
>> diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
>> index f0930a7..d0231fc 100644
>> --- a/gatchat/gatppp.h
>> +++ b/gatchat/gatppp.h
>> @@ -79,6 +79,8 @@ void g_at_ppp_set_recording(GAtPPP *ppp, const char *f=
ilename);
>>   void g_at_ppp_set_server_info(GAtPPP *ppp, const char *remote_ip,
>>   				const char *dns1, const char *dns2);
>>
>> +void g_at_ppp_force_acfc_off(GAtPPP *ppp, gboolean off);
>> +
>>   #ifdef __cplusplus
>>   }
>>   #endif
>> diff --git a/gatchat/ppp.h b/gatchat/ppp.h
>> index 023d779..116b5db 100644
>> --- a/gatchat/ppp.h
>> +++ b/gatchat/ppp.h
>> @@ -85,10 +85,17 @@ static inline void __put_unaligned_short(void *p, gu=
int16 val)
>>   #define ppp_proto(packet) \
>>   	(get_host_short(packet + 2))
>>
>> +#define ppp_acfc_info(packet) \
>> +	(packet + 2)
>> +
>> +#define ppp_acfc_proto(packet) \
>> +	(get_host_short(packet))
>> +
>>   /* LCP related functions */
>>   struct pppcp_data *lcp_new(GAtPPP *ppp, gboolean dormant);
>>   void lcp_free(struct pppcp_data *lcp);
>>   void lcp_protocol_reject(struct pppcp_data *lcp, guint8 *packet, gsize=
 len);
>> +void lcp_turn_off_acfc(struct pppcp_data *pppcp);
>>
>>   /* IPCP related functions */
>>   struct pppcp_data *ipcp_new(GAtPPP *ppp, gboolean is_server, guint32 i=
p);
>> @@ -125,4 +132,5 @@ void ppp_lcp_finished_notify(GAtPPP *ppp);
>>   void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
>>   void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm);
>>   void ppp_set_mtu(GAtPPP *ppp, const guint8 *data);
>> +void ppp_set_acfc_enabled(GAtPPP *ppp, gboolean acfc);
>>   struct ppp_header *ppp_packet_new(gsize infolen, guint16 protocol);
>> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
>> index ce9dae2..3814ddf 100644
>> --- a/gatchat/ppp_lcp.c
>> +++ b/gatchat/ppp_lcp.c
>> @@ -58,11 +58,12 @@ enum lcp_options {
>>   	ACFC			=3D 8,
>>   };
>>
>> -/* Maximum size of all options, we only ever request ACCM and MRU */
>> -#define MAX_CONFIG_OPTION_SIZE 10
>> +/* Maximum size of all options, we only ever request ACCM, MRU and ACFC=
 */
>> +#define MAX_CONFIG_OPTION_SIZE 12
>>
>>   #define REQ_OPTION_ACCM	0x1
>>   #define REQ_OPTION_MRU	0x2
>> +#define REQ_OPTION_ACFC	0x4
>>
>>   struct lcp_data {
>>   	guint8 options[MAX_CONFIG_OPTION_SIZE];
>> @@ -100,13 +101,20 @@ static void lcp_generate_config_options(struct lcp=
_data *lcp)
>>   		len +=3D 4;
>>   	}
>>
>> +	if (lcp->req_options&  REQ_OPTION_ACFC) {
>> +		lcp->options[len] =3D ACFC;
>> +		lcp->options[len + 1] =3D 2;
>> +
>> +		len +=3D 2;
>> +	}
>> +
>>   	lcp->options_len =3D len;
>>   }
>>
>>   static void lcp_reset_config_options(struct lcp_data *lcp)
>>   {
>>   	/* Using the default ACCM */
>> -
>> +	lcp->req_options |=3D REQ_OPTION_ACFC;
>>   	lcp_generate_config_options(lcp);
>>   }
>>
>> @@ -286,9 +294,11 @@ static enum rcr_result lcp_rcr(struct pppcp_data *p=
ppcp,
>>   			break;
>>   		case MAGIC_NUMBER:
>>   		case PFC:
>> -		case ACFC:
>>   			/* don't care */
>>   			break;
>> +		case ACFC:
>> +			ppp_set_acfc_enabled(ppp, TRUE);
> You can check whether we turned on ACFC by checking whether ACFC option
> is being advertised to the peer.  E.g. lcp->req_options&  REQ_OPTION_ACFC=
...

Ok I will do it this way.
Then I will add ACFC and PFC options activation into emulator and gsmdial.

Kind regards,
Guillaume

--===============0536386640151636637==--

