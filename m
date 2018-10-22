Content-Type: multipart/mixed; boundary="===============2866388821589021771=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH v8 4/5] atmodem/atutil: shared functions for cgdcont
Date: Mon, 22 Oct 2018 19:03:20 +0200
Message-ID: <CAKSBH7ET2rDEX-OLri+yMW9xe9Syj8EEpbcCDuiQ35yhUcrg-A@mail.gmail.com>
In-Reply-To: <47cbda92-864c-50d8-824c-8f1fcad72db1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2866388821589021771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

ok for your comments, except ...

On Mon, Oct 22, 2018 at 6:56 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/19/2018 06:31 AM, Giacinto Cifelli wrote:
> > included two new functions:
> >
> > at_auth_type_from_method: converts the ofono enum ofono_gprs_auth_method
> >       into the value of the 3GPP 27.007 to pass to the AT command
> >
> > at_get_cgdcont_command: computes the AT+CGDCONT string, standard version
>
> That just screams for 2 separate commits.
>
> Also, everything in atutil.[ch] is prefixed by at_util_, so please
> follow that convention.
>
> > ---
> >   drivers/atmodem/atutil.c | 49 ++++++++++++++++++++++++++++++++++++++++
> >   drivers/atmodem/atutil.h |  6 +++++
> >   2 files changed, 55 insertions(+)
> >
> > diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
> > index 6f4e8a20..ed19e91b 100644
> > --- a/drivers/atmodem/atutil.c
> > +++ b/drivers/atmodem/atutil.c
> > @@ -3,6 +3,7 @@
> >    *  oFono - Open Source Telephony
> >    *
> >    *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> > + *  Copyright (C) 2018 Gemalto M2M
> >    *
> >    *  This program is free software; you can redistribute it and/or mod=
ify
> >    *  it under the terms of the GNU General Public License version 2 as
> > @@ -27,6 +28,7 @@
> >   #include <gatchat.h>
> >   #include <string.h>
> >   #include <stdlib.h>
> > +#include <stdio.h>
> >   #include <errno.h>
> >
> >   #define OFONO_API_SUBJECT_TO_CHANGE
> > @@ -654,3 +656,50 @@ int at_util_get_ipv4_address_and_netmask(const cha=
r *addrnetmask,
> >
> >       return ret;
> >   }
> > +
> > +int at_auth_type_from_method(enum ofono_gprs_auth_method auth_method)
> > +{
> > +     switch (auth_method) {
> > +     case OFONO_GPRS_AUTH_METHOD_PAP:
> > +             return 1;
> > +     case OFONO_GPRS_AUTH_METHOD_CHAP:
> > +             return 2;
> > +     case OFONO_GPRS_AUTH_METHOD_NONE:
> > +             return 0;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +char *at_get_cgdcont_command(guint cid, enum ofono_gprs_proto proto,
> > +                                                     const char *apn)
> > +{
> > +     size_t buflen =3D 32 + OFONO_GPRS_MAX_APN_LENGTH + 1;
> > +     char *buf =3D g_new(char, buflen);
> > +     int len;
> > +
> > +     len =3D snprintf(buf, buflen, "AT+CGDCONT=3D%u", cid);
> > +     buflen -=3D len;
> > +
> > +     /*
> > +      * if apn is null, it will remove the context.
> > +      * but if apn is empty, it will create a context with empty apn
> > +      */
> > +     if (!apn)
> > +             goto finished;
> > +
> > +     switch (proto) {
> > +     case OFONO_GPRS_PROTO_IPV6:
> > +             snprintf(buf+len, buflen, ",\"IPV6\",\"%s\"", apn);
> > +             break;
> > +     case OFONO_GPRS_PROTO_IPV4V6:
> > +             snprintf(buf+len, buflen, ",\"IPV4V6\",\"%s\"", apn);
> > +             break;
> > +     case OFONO_GPRS_PROTO_IP:
> > +             snprintf(buf+len, buflen, ",\"IP\",\"%s\"", apn);
> > +             break;
> > +     }
>
> Ugh.  Since you're allocating a new string anyway, why not something like:
>
> const char *pdp_type =3D at_util_gprs_proto_to_pdp_type(proto);
>
> if (!apn || apn[0] =3D=3D '\0')
>         return g_strdup_printf("AT+CGDCONT=3D%u", cid);

... these are 2 different cases:
if !apn (null string), then the PDP context is to be deleted, and the
command is like: AT+CGDCONT=3D7
but if apn is empty, then the DPD context is to be provisioned with a
default apn: AT+CGDCONT=3D7,"IP",""

I will add a comment in the header file to explain that.

>
> return g_strdup_printf("AT+CGDCONT=3D%u,\"%s\",\"%s\"", cid, pdp_type, ap=
n);
>
> > +
> > +finished:
> > +     return buf;
> > +}
> > diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
> > index 7113a4cd..447ce56b 100644
> > --- a/drivers/atmodem/atutil.h
> > +++ b/drivers/atmodem/atutil.h
> > @@ -3,6 +3,7 @@
> >    *  oFono - Open Source Telephony
> >    *
> >    *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> > + *  Copyright (C) 2018 Gemalto M2M
> >    *
> >    *  This program is free software; you can redistribute it and/or mod=
ify
> >    *  it under the terms of the GNU General Public License version 2 as
> > @@ -86,6 +87,11 @@ void at_util_sim_state_query_free(struct at_util_sim=
_state_query *req);
> >   int at_util_get_ipv4_address_and_netmask(const char *addrnetmask,
> >                                               char *address, char *netm=
ask);
> >
> > +int at_auth_type_from_method(enum ofono_gprs_auth_method auth_method);
> > +
> > +char *at_get_cgdcont_command(guint cid, enum ofono_gprs_proto proto,
> > +                                                     const char *apn);
> > +
> >   struct cb_data {
> >       void *cb;
> >       void *data;
> >
>
> Regards,
> -Denis

and I will split them in 2 commits.

Regards,
Giacinto

--===============2866388821589021771==--

