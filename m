Content-Type: multipart/mixed; boundary="===============5166606239142862057=="
MIME-Version: 1.0
From: Vijay.Nayani@elektrobit.com
Subject: RE: [RFC PATCH 17/20] atmodem: add lte specific functions
Date: Tue, 12 Apr 2011 13:11:31 +0300
Message-ID: <AA48DD8077D5D945A49BD1782C1140F1EBB1FD@fioues08.ebgroup.elektrobit.com>
In-Reply-To: <4DA35C78.3020606@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5166606239142862057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =


> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

> Sent: 11 April 2011 22:55
> To: ofono(a)ofono.org
> Cc: Nayani Vijay
> Subject: Re: [RFC PATCH 17/20] atmodem: add lte specific functions
> =

> On 04/11/2011 05:20 AM, Vijay Nayani wrote:
> > Changes include: Registration of CEREG events, registration status =

> > query based on registered technology, handling of ME PDN ACT CGEV =

> > event, reading of default context params and notification =

> of default =

> > context params to the core.
> > ---
> >  drivers/atmodem/packet-service.c |  238 =

> > ++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 238 insertions(+), 0 deletions(-)
> > =

> > diff --git a/drivers/atmodem/packet-service.c =

> > b/drivers/atmodem/packet-service.c
> > index 9999d9d..b766a3b 100644
> > --- a/drivers/atmodem/packet-service.c
> > +++ b/drivers/atmodem/packet-service.c
> > @@ -4,6 +4,7 @@
> >   *
> >   *  Copyright (C) 2008-2010  Intel Corporation. All rights =

> reserved.
> >   *  Copyright (C) 2010 ST-Ericsson AB.
> > + *  Copyright 2011 EB(Elektrobit).
> >   *
> >   *  This program is free software; you can redistribute it =

> and/or modify
> >   *  it under the terms of the GNU General Public License =

> version 2 as =

> > @@ -40,17 +41,23 @@  #include "gatchat.h"
> >  #include "gatresult.h"
> >  =

> > +#include  "common.h"
> > +
> >  #include "atmodem.h"
> >  #include "vendor.h"
> >  =

> >  static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };  static =

> > const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
> > +static const char *cereg_prefix[] =3D { "+CEREG:", NULL }; =

> static const =

> > +char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
> >  static const char *none_prefix[] =3D { NULL };
> >  =

> >  struct packet_service_data {
> >  	GAtChat *chat;
> >  	int default_cid;
> >  	int default_context_type;
> > +	int cid_min;
> > +	int cid_max;
> >  	unsigned int vendor;
> >  };
> >  =

> > @@ -109,6 +116,134 @@ static void at_cgreg_cb(gboolean ok, =

> GAtResult *result, gpointer user_data)
> >  	cb(&error, status, cbd->data);
> >  }
> >  =

> > +static void at_cereg_cb(gboolean ok, GAtResult *result, gpointer =

> > +user_data) {
> > +	struct cb_data *cbd =3D user_data;
> > +	ofono_packet_service_status_cb_t cb =3D cbd->cb;
> > +	struct ofono_error error;
> > +	int status;
> > +	struct packet_service_data *psd =3D cbd->user;
> > +
> > +	decode_at_error(&error, g_at_result_final_response(result));
> > +
> > +	if (!ok) {
> > +		cb(&error, -1, cbd->data);
> > +		return;
> > +	}
> > +
> > +	if (at_util_parse_reg(result, "+CEREG:", NULL, &status,
> > +				NULL, NULL, NULL, psd->vendor) =

> =3D=3D FALSE) {
> > +		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> > +		return;
> > +	}
> > +
> > +	cb(&error, status, cbd->data);
> > +}
> > +
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
> =

> This is really not working out, since you still need to get =

> the interface for this context.  The fact that a context is =

> active does not necessarily mean that all the resources have =

> been properly allocated.
> Namely a gprs-context allocated and all the implications =

> (e.g. AT channel dedicated to the gprs-context is taken, ppp =

> / high speed data connection established, etc.)
> =

> Only the core can do the context allocation, so you still =

> need to let the core decide what to do.
> =


I agree on your comments here.
Infact have missed out to put a todo here on interface assignment so
that this can be taken up when we work with real modem.

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
> > +
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
> =

> This is really just a bad idea.  The core needs to understand =

> the concept of CEREG properly, not try to hide this in the driver.
> =

Intention here is to hide to the core on details of registraion
technology.
If core needs these awareness and want to fire relevent
API/functionality based on current access tech, would bring in new APIs
to driver for 3G registraion status and LTE registraion status.
This will also result in core to base it behaviour depending on acess
technology.
> Regards,
> -Denis
>=20

--===============5166606239142862057==--

