Content-Type: multipart/mixed; boundary="===============2086990375151796599=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: Re: [PATCH 02/12] include: add gnss.h file
Date: Fri, 18 Mar 2011 14:24:17 +0200
Message-ID: <1300451057.9383.7.camel@poutijar-desktop>
In-Reply-To: <4D82DFBE.1000403@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2086990375151796599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 2011-03-18 at 06:29 +0200, Denis Kenzior wrote:
> Hi Jarko,
> =

> On 03/11/2011 06:22 AM, Jarko Poutiainen wrote:
> > ---
> >  Makefile.am    |    2 +-
> >  include/gnss.h |   76 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 77 insertions(+), 1 deletions(-)
> >  create mode 100644 include/gnss.h
> > =

> > diff --git a/Makefile.am b/Makefile.am
> > index 3f20717..7d6acce 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -15,7 +15,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h=
 include/history.h \
> >  			include/ctm.h include/cdma-voicecall.h \
> >  			include/cdma-sms.h include/sim-auth.h \
> >  			include/gprs-provision.h include/emulator.h \
> > -			include/location-reporting.h
> > +			include/location-reporting.h include/gnss.h
> >  =

> >  nodist_pkginclude_HEADERS =3D include/version.h
> >  =

> > diff --git a/include/gnss.h b/include/gnss.h
> > new file mode 100644
> > index 0000000..d10ab11
> > --- /dev/null
> > +++ b/include/gnss.h
> > @@ -0,0 +1,76 @@
> > +/*
> > + *
> > + *  oFono - Open Source Telephony
> > + *
> > + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
> > + *  Copyright (C) 2011 ST-Ericsson AB.
> > + *
> > + *  This program is free software; you can redistribute it and/or modi=
fy
> > + *  it under the terms of the GNU General Public License version 2 as
> > + *  published by the Free Software Foundation.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1=
301  USA
> > + *
> > + */
> > +
> > +#ifndef __OFONO_GNSS_H
> > +#define __OFONO_GNSS_H
> > +
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> > +#include <ofono/types.h>
> > +
> > +struct ofono_gnss;
> > +
> > +typedef void (*ofono_gnss_position_report_cb_t)(const struct ofono_err=
or *error,
> > +							void *data);
> > +
> > +typedef void (*ofono_gnss_send_element_cb_t)(const struct ofono_error =
*error,
> > +						void *data);
> > +
> > +typedef void (*ofono_gnss_report_reset_cb_t)(const struct ofono_error =
*error,
> > +						void *data);
> =

> Please just combine these into a single callback, they have the same
> signature.  E.g. something like ofono_gnss_cb_t
> =

That's a good point, thank you.

> > +
> > +struct ofono_gnss_driver {
> > +	const char *name;
> > +	int (*probe)(struct ofono_gnss *gnss, unsigned int vendor, void *data=
);
> > +	void (*remove)(struct ofono_gnss *gnss);
> > +	void (*send_element)(struct ofono_gnss *gnss,
> > +				const char *xml,
> > +				ofono_gnss_send_element_cb_t cb, void *data);
> > +	void (*position_reporting)(struct ofono_gnss *gnss,
> > +					ofono_bool_t enable,
> > +					ofono_gnss_position_report_cb_t cb,
> > +					void *data);
> =

> Please name this set_position_reporting or set_posr
> =

Ok I'll name it set_position_reporting.

> > +};
> > +
> > +void ofono_gnss_receive_request(struct ofono_gnss *gnss, const char *x=
ml);
> > +void ofono_gnss_receive_reset(struct ofono_gnss *gnss);
> =

> Please use notify instead of receive.  E.g. ofono_gnss_notify_posr_reset
> and ofono_gnss_notify_posr_request
> =

Ok I'll do that.

> > +int ofono_gnss_driver_register(const struct ofono_gnss_driver *d);
> > +void ofono_gnss_driver_unregister(const struct ofono_gnss_driver *d);
> > +
> > +struct ofono_gnss *ofono_gnss_create(struct ofono_modem *modem,
> > +					unsigned int vendor,
> > +					const char *driver, void *data);
> > +
> > +void ofono_gnss_register(struct ofono_gnss *gnss);
> > +void ofono_gnss_remove(struct ofono_gnss *gnss);
> > +
> > +void ofono_gnss_set_data(struct ofono_gnss *gnss, void *data);
> > +void *ofono_gnss_get_data(struct ofono_gnss *gnss);
> > +
> > +
> > +#ifdef __cplusplus
> > +}
> > +#endif
> > +
> > +#endif /* __OFONO_GNSS_H */
> =

> Regards,
> -Denis
Br,
Jarko



--===============2086990375151796599==--

