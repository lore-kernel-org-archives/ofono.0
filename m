Content-Type: multipart/mixed; boundary="===============4044544791390889185=="
MIME-Version: 1.0
From: Zhang, Caiwen <caiwen.zhang@intel.com>
Subject: RE: [PATCH] rilmodem: Fix GPRS feature inavailable issue
Date: Thu, 14 Jan 2016 06:14:08 +0000
Message-ID: <DA62CA5DDF4CA640AA25B1684E5D141102069F97@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <5696BD5C.40805@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4044544791390889185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi tony,

Thanks for your reply. =


In fact I have ever considered the way you mentioned. But l found in most p=
lugins, atoms (gprs, gprs_context, sms, =

call_forwarding ...) are created at post_sim phrase. It seems post_online p=
hrase is more reasonable. There should
be some reason that the atom creation is brought forward. Does anyone know =
the reason?

Thanks,
Caiwen

> -----Original Message-----
> From: ofono [mailto:ofono-bounces(a)ofono.org] On Behalf Of Tony Espy
> Sent: Thursday, January 14, 2016 5:11 AM
> To: ofono(a)ofono.org
> Subject: Re: [PATCH] rilmodem: Fix GPRS feature inavailable issue
> =

> On 01/11/2016 10:42 PM, caiwen.zhang(a)intel.com wrote:
> > From: Caiwen Zhang <caiwen.zhang@intel.com>
> >
> > When query max cid if rild radio status isn't RADIO_STATUS_ON, it may
> > fail, gprs atom will be removed, gprs feature will always be inavailabl=
e.
> > ---
> >   drivers/rilmodem/gprs.c | 43
> ++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 42 insertions(+), 1 deletion(-)
> =

> Thanks for the patch Caiwen!
> =

> That said instead of extending the gprs atom to listen to radio state
> changes ( which may not reliably work on all rild-based devices ), it
> probably makes more sense to defer the creation of the gprs atom in the
> ril device plugin till the post_online phase ( vs. post_sim ).
> =

> Regards,
> /tony
> =

> =

> > diff --git a/drivers/rilmodem/gprs.c b/drivers/rilmodem/gprs.c index
> > 0ec9d5f..f3bdc86 100644
> > --- a/drivers/rilmodem/gprs.c
> > +++ b/drivers/rilmodem/gprs.c
> > @@ -54,8 +54,11 @@ struct ril_gprs_data {
> >   	gboolean ofono_attached;
> >   	int rild_status;
> >   	int pending_deact_req;
> > +	gboolean registered;
> >   };
> >
> > +static void query_max_cids(struct ofono_gprs *gprs);
> > +
> >   /*
> >    * This module is the ofono_gprs_driver implementation for
> rilmodem.
> >    *
> > @@ -300,6 +303,34 @@ static void ril_gprs_registration_status(struct
> ofono_gprs *gprs,
> >   	}
> >   }
> >
> > +static void ril_radio_state_changed(struct ril_msg *message,
> > +							gpointer user_data)
> > +{
> > +	struct ofono_gprs *gprs =3D user_data;
> > +	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
> > +	struct parcel rilp;
> > +	int radio_state;
> > +
> > +	if (gd->registered)
> > +		return;
> > +
> > +	g_ril_init_parcel(message, &rilp);
> > +	radio_state =3D parcel_r_int32(&rilp);
> > +
> > +	if (rilp.malformed) {
> > +		ofono_error("%s: malformed parcel received", __func__);
> > +		return;
> > +	}
> > +
> > +	g_ril_append_print_buf(gd->ril, "(state: %s)",
> > +				ril_radio_state_to_string(radio_state));
> > +	g_ril_print_unsol(gd->ril, message);
> > +
> > +	if (radio_state =3D=3D RADIO_STATE_ON) {
> > +		query_max_cids(gprs);
> > +	}
> > +}
> > +
> >   static void query_max_cids_cb(struct ril_msg *message, gpointer
> user_data)
> >   {
> >   	struct ofono_gprs *gprs =3D user_data; @@ -315,7 +346,14 @@
> static
> > void query_max_cids_cb(struct ril_msg *message, gpointer user_data)
> >   		ofono_error("%s: DATA_REGISTRATION_STATE reply
> failure: %s",
> >   				__func__,
> >   				ril_error_to_string(message->error));
> > -		goto error;
> > +
> > +		if (message->error !=3D RIL_E_RADIO_NOT_AVAILABLE)
> > +			goto error;
> > +		else {
> > +		  g_ril_register(gd->ril,
> RIL_UNSOL_RESPONSE_RADIO_STATE_CHANGED,
> > +					ril_radio_state_changed, gprs);
> > +			return;
> > +		}
> >   	}
> >
> >   	g_ril_init_parcel(message, &rilp);
> > @@ -341,6 +379,7 @@ reg_atom:
> >   	g_strfreev(strv);
> >   	ofono_gprs_set_cid_range(gprs, 1, max_calls);
> >   	ofono_gprs_register(gprs);
> > +	gd->registered =3D TRUE;
> >   	return;
> >
> >   error_free:
> > @@ -380,6 +419,7 @@ static void query_max_cids(struct ofono_gprs
> *gprs)
> >   	if (g_ril_vendor(gd->ril) =3D=3D OFONO_RIL_VENDOR_MTK) {
> >   		ofono_gprs_set_cid_range(gprs, 1, 3);
> >   		ofono_gprs_register(gprs);
> > +		gd->registered =3D TRUE;
> >   		return;
> >   	}
> >
> > @@ -495,6 +535,7 @@ static int ril_gprs_probe(struct ofono_gprs
> *gprs, unsigned int vendor,
> >   	gd->ril =3D g_ril_clone(ril);
> >   	gd->ofono_attached =3D FALSE;
> >   	gd->rild_status =3D -1;
> > +	gd->registered =3D FALSE;
> >
> >   	ofono_gprs_set_data(gprs, gd);
> >
> >
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============4044544791390889185==--

