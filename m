Content-Type: multipart/mixed; boundary="===============0072376467562067101=="
MIME-Version: 1.0
From: Vijay.Nayani@elektrobit.com
Subject: RE: [RFC PATCH 17/20] atmodem: add lte specific functions
Date: Tue, 12 Apr 2011 15:48:55 +0300
Message-ID: <AA48DD8077D5D945A49BD1782C1140F1EBB237@fioues08.ebgroup.elektrobit.com>
In-Reply-To: <1302579839.2572.244.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0072376467562067101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, =


Let me thank for the comments.
I am happy to see default context stuff dominate our discussion which is
kind of my expectation as well.

I agree that these things are not so clear from the spec point of view
and hopeful that they will shape out via for discussion and some support
from modem friends in community.

Any how I would consider all these comments going forward.

More comments in line.

Regards
Vijay

> -----Original Message-----
> From: ofono-bounces(a)ofono.org =

> [mailto:ofono-bounces(a)ofono.org] On Behalf Of Marcel Holtmann
> Sent: 12 April 2011 06:44
> To: ofono(a)ofono.org
> Subject: Re: [RFC PATCH 17/20] atmodem: add lte specific functions
> =

> Hi Vijay,
> =

> > +static void at_cgcontrdp_cb(gboolean ok, GAtResult =

> *result, gpointer =

> > +user_data) {
> > +	struct ofono_packet_service *ps =3D user_data;
> > +	struct packet_service_data *psd =3D =

> ofono_packet_service_get_data(ps);
> > +	GAtResultIter iter;
> > +	int cid, bearer_id;
> > +	const char *apn, *address, *gateway, *dns1, *dns2;
> > +	const char *dns[3];
> > +	struct ofono_default_context_param *param;
> > +
> > +	if (!ok)
> > +		return;
> > +
> > +	g_at_result_iter_init(&iter, result);
> > +
> > +	if (g_at_result_iter_next(&iter, "+CGCONTRDP:") =3D=3D FALSE)
> > +		return;
> > +
> > +	if (g_at_result_iter_next_number(&iter, &cid) =3D=3D FALSE)
> > +		return;
> > +
> > +	if (g_at_result_iter_next_number(&iter, &bearer_id) =3D=3D FALSE)
> > +		return;
> > +
> > +	if (g_at_result_iter_next_string(&iter, &apn) =3D=3D FALSE)
> > +		return;
> > +
> > +	if (g_at_result_iter_next_string(&iter, &address) =3D=3D FALSE)
> > +		goto out;
> > +
> > +	if (g_at_result_iter_next_string(&iter, &gateway) =3D=3D FALSE)
> > +		goto out;
> > +
> > +	if (g_at_result_iter_next_string(&iter, &dns1) =3D=3D FALSE)
> > +		goto out;
> > +
> > +	if (g_at_result_iter_next_string(&iter, &dns2) =3D=3D FALSE)
> > +		goto out;
> > +
> > +	dns[0] =3D dns1;
> > +	dns[1] =3D dns2;
> > +	dns[2] =3D 0;
> > +
> > +out:
> > +	param =3D g_new0(struct ofono_default_context_param, 1);
> > +	if (param =3D=3D NULL)
> > +		return;
> > +
> > +	param->cid =3D cid;
> > +	param->proto =3D psd->default_context_type;
> > +	param->apn =3D apn;
> > +	param->address =3D address;
> > +	param->gateway =3D gateway;
> > +	param->dns =3D dns;
> > +
> > +	ofono_packet_service_default_context_notify(ps, param);
> > +
> > +	g_free(param);
> > +	param =3D NULL;
> > +}
> > +
> > +static void at_cgdcont_cb(gboolean ok, GAtResult *result, gpointer =

> > +user_data) {
> > +	struct ofono_packet_service *ps =3D user_data;
> > +	struct packet_service_data *psd =3D =

> ofono_packet_service_get_data(ps);
> > +	GAtResultIter iter;
> > +	int cid;
> > +	const char *pdp_type;
> > +	char buf[64];
> > +	gboolean found =3D FALSE;
> > +
> > +	if (!ok)
> > +		return;
> > +
> > +	g_at_result_iter_init(&iter, result);
> > +
> > +	while (!found && g_at_result_iter_next(&iter, "+CGDCONT:")) {
> > +		if (g_at_result_iter_next_number(&iter, &cid) =3D=3D FALSE)
> > +			return;
> > +
> > +		if (psd->default_cid !=3D cid)
> > +			continue;
> > +
> > +		g_at_result_iter_next_string(&iter, &pdp_type);
> > +
> > +		found =3D TRUE;
> > +	}
> > +
> > +	if (found =3D=3D FALSE)
> > +		return;
> > +
> > +	if (g_str_equal(pdp_type, "IP"))
> > +		psd->default_context_type =3D OFONO_PACKET_PROTO_IP;
> > +	else if (g_str_equal(pdp_type, "IPV6"))
> > +		psd->default_context_type =3D OFONO_PACKET_PROTO_IPV6;
> > +	else if (g_str_equal(pdp_type, "IPV4V6"))
> > +		psd->default_context_type =3D OFONO_PACKET_PROTO_IPV4V6;
> > +
> > +	snprintf(buf, sizeof(buf), "AT+CGCONTRDP=3D%i", psd->default_cid);
> =

> this looks wrong to me. Reading the CGDCONT information is =

> not going to help us. We should just read CGCONTRDP if =

> available or CGADDR it not.
> =

> If we are a dual stack, then we will see two lines of =

> CGCONTRDP, if not then I assume we can tell from the address =

> if we are IP or IPV6. Same applies to CGADDR in case =

> CGCONTRDP is not available.
> =

> And of course we need to keep CGPIAF in mind.

Agreed that we can just do with CGCONTRDP and aviod CGDCONT.
Hope you are saying to differentiate IP and IPV6 based on the address
format.

> =

> For me it is also important if <IM_CN_Signalling_Flag> is set =

> or not since that tells us that this is the IMS context. And =

> I would expect that all networks will use that one as default context.
> =

> > +	g_at_chat_send(psd->chat, buf, cgcontrdp_prefix, =

> at_cgcontrdp_cb,
> > +								=

> ps, NULL);
> > +}
> > +
> >  static void at_packet_service_registration_status(
> >  					struct ofono_packet_service *ps,
> >  					=

> ofono_packet_service_status_cb_t cb, @@ -138,6 +273,13 @@ static =

> > void at_packet_service_registration_status(
> >  		break;
> >  	}
> >  =

> > +	if (ofono_packet_service_get_technology(ps) =3D=3D
> > +						=

> ACCESS_TECHNOLOGY_EUTRAN) {
> > +		if (g_at_chat_send(psd->chat, "AT+CEREG?", cereg_prefix,
> > +					at_cereg_cb, cbd, g_free) > 0)
> > +			return;
> > +	}
> > +
> >  	if (g_at_chat_send(psd->chat, "AT+CGREG?", cgreg_prefix,
> >  				at_cgreg_cb, cbd, g_free) > 0)
> >  		return;
> > @@ -160,9 +302,23 @@ static void cgreg_notify(GAtResult =

> *result, gpointer user_data)
> >  	ofono_packet_service_status_notify(ps, status);  }
> >  =

> > +static void cereg_notify(GAtResult *result, gpointer user_data) {
> > +	struct ofono_packet_service *ps =3D user_data;
> > +	int status;
> > +	struct packet_service_data *psd =3D =

> ofono_packet_service_get_data(ps);
> > +
> > +	if (at_util_parse_reg_unsolicited(result, "+CEREG:", &status,
> > +				NULL, NULL, NULL, psd->vendor) =3D=3D FALSE)
> > +		return;
> > +
> > +	ofono_packet_service_status_notify(ps, status); }
> > +
> >  static void cgev_notify(GAtResult *result, gpointer user_data)  {
> >  	struct ofono_packet_service *ps =3D user_data;
> > +	struct packet_service_data *psd =3D =

> ofono_packet_service_get_data(ps);
> >  	GAtResultIter iter;
> >  	const char *event;
> >  =

> > @@ -179,6 +335,35 @@ static void cgev_notify(GAtResult =

> *result, gpointer user_data)
> >  		ofono_packet_service_detached_notify(ps);
> >  		return;
> >  	}
> > +
> > +	if (g_str_has_prefix(event, "ME PDN ACT")) {
> > +		/*
> > +		 * As per 27.007, this even it sent when the =

> mobile termination
> > +		 * has activated a context. The context represents a PDN
> > +		 * connection in LTE or a Primary PDP context =

> in GSM/UMTS.
> > +		 * The <cid> for this context is provided to =

> the TE. This event
> > +		 * is sent either in result of explicit context =

> activation
> > +		 * request (+CGACT), or in result of implicit =

> context activation
> > +		 * request associated to attach request (+CGATT=3D1).
> > +		 */
> > +		int cid;
> > +
> > +		cid =3D g_ascii_strtoll(&event[11], NULL, 0);
> > +
> > +		/*
> > +		 * Assumption: context id for default EPS =

> context will have
> > +		 * value outside the ranges indicated in the =

> test form of
> > +		 * the command +CGDCONT.
> > +		 */
> =

> That is still an assumption that needs to be confirmed. So =

> does the default context activation from just uses APN =3D=3D "" =

> and then the network picks the APN to activate. Or does it =

> just use the APN value from CID 1 for example.
> =


At this point , if the returned cid is out of range it is assumed this
would be default context (already activated).
Network has the APN and other required mandatory parameters required for
activation of default context.
This is done part of implicit attach process.

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>=20

--===============0072376467562067101==--

