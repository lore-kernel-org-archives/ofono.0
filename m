Content-Type: multipart/mixed; boundary="===============2152354741860230807=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/2] gemaltomodem: added Gemalto-specific gprs-context
 atom This atom name is not the same as the driver,
 because it might be necessary to add other grps-context atoms,
 according to the needs. The name is therefore referring to the main command
 used, AT^SWWAN.
Date: Sat, 22 Sep 2018 07:47:02 +0200
Message-ID: <CAKSBH7GCFk-ZoG9KB-YOOtUV4Xy_m24Syx-B1vOGXo8P_71xog@mail.gmail.com>
In-Reply-To: <3d535a95-ca0c-7cec-5d53-abec34bccde5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2152354741860230807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Sep 21, 2018 at 6:12 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> So please fix your commit description in the next version.
>

certainly.


>
> On 09/19/2018 10:50 PM, Giacinto Cifelli wrote:
> > ---
> >   drivers/gemaltomodem/gemaltomodem.c      |   2 +
> >   drivers/gemaltomodem/gemaltomodem.h      |   3 +
> >   drivers/gemaltomodem/gprs-context-wwan.c | 446
> +++++++++++++++++++++++++++++++
> >   3 files changed, 451 insertions(+)
> >   create mode 100644 drivers/gemaltomodem/gprs-context-wwan.c
> >
> > diff --git a/drivers/gemaltomodem/gemaltomodem.c
> b/drivers/gemaltomodem/gemaltomodem.c
> > index 614ca81..7afd3c1 100644
> > --- a/drivers/gemaltomodem/gemaltomodem.c
> > +++ b/drivers/gemaltomodem/gemaltomodem.c
> > @@ -35,6 +35,7 @@
> >   static int gemaltomodem_init(void)
> >   {
> >       gemalto_location_reporting_init();
> > +     gemaltowwan_gprs_context_init();
> >       gemalto_voicecall_init();
> >       return 0;
> >   }
> > @@ -42,6 +43,7 @@ static int gemaltomodem_init(void)
> >   static void gemaltomodem_exit(void)
> >   {
> >       gemalto_location_reporting_exit();
> > +     gemaltowwan_gprs_context_exit();
>
> I'm not really a fan of the name.  How many of gprs_context types do you
> have, and what is fundamentally different between them that they cannot
> be handled by the same driver?
>
>
Ok, I will rename it.

>       gemalto_voicecall_exit();
> >   }
> >
> > diff --git a/drivers/gemaltomodem/gemaltomodem.h
> b/drivers/gemaltomodem/gemaltomodem.h
> > index 4e6ed16..f45aea9 100644
> > --- a/drivers/gemaltomodem/gemaltomodem.h
> > +++ b/drivers/gemaltomodem/gemaltomodem.h
> > @@ -24,5 +24,8 @@
> >   extern void gemalto_location_reporting_init();
> >   extern void gemalto_location_reporting_exit();
> >
> > +extern void gemaltowwan_gprs_context_init();
> > +extern void gemaltowwan_gprs_context_exit();
> > +
> >   extern void gemalto_voicecall_init();
> >   extern void gemalto_voicecall_exit();
> > diff --git a/drivers/gemaltomodem/gprs-context-wwan.c
> b/drivers/gemaltomodem/gprs-context-wwan.c
> > new file mode 100644
> > index 0000000..12378a3
> > --- /dev/null
> > +++ b/drivers/gemaltomodem/gprs-context-wwan.c
> > @@ -0,0 +1,446 @@
> > +/*
> > + *
> > + *  oFono - Open Source Telephony
> > + *
> > + *  Copyright (C) 2017 Piotr Haber. All rights reserved.
> > + *  Copyright (C) 2018 Sebastian Arnd. All rights reserved.
> > + *  Copyright (C) 2018 Gemalto M2M
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
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#define _GNU_SOURCE
> > +#include <string.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <errno.h>
> > +#include <sys/stat.h>
> > +
> > +#include <glib.h>
> > +
> > +#include <ofono/log.h>
> > +#include <ofono/modem.h>
> > +#include <ofono/gprs-context.h>
> > +
> > +#include "gatchat.h"
> > +#include "gatresult.h"
> > +
> > +#include "gemaltomodem.h"
> > +
> > +static const char *none_prefix[] =3D { NULL };
> > +
> > +enum state {
> > +     STATE_IDLE,
> > +     STATE_ENABLING,
> > +     STATE_DISABLING,
> > +     STATE_ACTIVE,
> > +};
> > +
> > +struct gprs_context_data {
> > +     GAtChat *chat;
> > +     unsigned int active_context;
> > +     char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
> > +     char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
> > +     enum ofono_gprs_auth_method auth_method;
> > +     enum state state;
> > +     enum ofono_gprs_proto proto;
> > +     char address[64];
> > +     char netmask[64];
> > +     char gateway[64];
> > +     char dns1[64];
> > +     char dns2[64];
> > +     ofono_gprs_context_cb_t cb;
> > +     void *cb_data;
> > +     int use_wwan;
> > +};
> > +
> > +static gboolean gemalto_get_auth_command(struct ofono_modem *modem, int
> cid,
> > +                             enum ofono_gprs_auth_method auth_method,
> > +                             const char *username, const char *passwor=
d,
> > +                             char *buf, guint buflen)
> > +{
> > +     int gto_auth =3D ofono_modem_get_integer(modem, "Gemalto_Auth");
>
> Please use a CamelCase-d variable for this.  E.g. GemaltoAuthType
>

ok. This is new for this code, because I have always seen only variables
with underscores, but no problem.
Personally I would prefer camelCase 'gemaltoAuthType', because it is more
coherent in case of 1-part names like 'user',
but I'll do as you say.


>
> > +     int len;
> > +     /*
> > +      * 0: use cgauth
> > +      * 1: use sgauth(pwd, user)
> > +      * 2: use sgauth(user, pwd)
> > +      */
> > +
> > +     int auth_type;
> > +
> > +     switch (auth_method) {
> > +     case OFONO_GPRS_AUTH_METHOD_PAP:
> > +             auth_type =3D 1;
> > +             break;
> > +     case OFONO_GPRS_AUTH_METHOD_CHAP:
> > +             auth_type =3D 2;
> > +             break;
> > +     case OFONO_GPRS_AUTH_METHOD_NONE:
>
> So until the GPRS_AUTH_METHOD_NONE is actually introduced, you might
> want to just get this upstream with the existing enumeration.  E.g. just
> assume that if username & password is empty, the auth method is none.
>

I have pushed the new method NONE again, and I prefer to wait until it is
taken.

The current solution is really a non-documented hack.
Checking whether user&password are empty to change the type of
authentication goes against the caller settings.
It is better to give an error so that there is a chance to have good
settings.


>
> > +     default:
> > +             auth_type =3D 0;
> > +             break;
> > +     }
> > +
> > +     if (auth_type !=3D 0 && (!*username || !*password)) > +
>  return FALSE;
> > +
> > +     switch (gto_auth) {
> > +     case 1:
> > +     case 2:
> > +             len =3D snprintf(buf, buflen, "AT^SGAUTH=3D%d", cid);
> > +             break;
> > +     case 0:
> > +     default:
> > +             len =3D snprintf(buf, buflen, "AT+CGAUTH=3D%d", cid);
> > +             break;
> > +     }
> > +
> > +     buflen -=3D len;
> > +
> > +     switch(auth_type) {
> > +     case 0:
> > +
> > +             switch (gto_auth) {
> > +             case 2:
> > +                     snprintf(buf+len, buflen, ",0,\"\",\"\"");
> > +                     break;
> > +             case 0:
> > +             case 1:
> > +             default:
> > +                     snprintf(buf+len, buflen, ",0");
> > +                     break;
> > +             }
> > +             break;
>
> This switch might be more compact as an if statement.  Also the coding
> style is all wrong in this function.  See doc/coding-style.txt item M3
> in particular.
>

the idea of the switch is to let a reader see the differences among the
various cases,
but in reality there are 2 or 3 flags in this variable, so I am going to
restructure the eval as a bitmap,
and then I will call if's instead of switch's.
Thank you for this review, it helped pointing out the flaw in the design.


>
> > +
> > +     case 1:
> > +     case 2:
> > +
> > +             switch (gto_auth) {
> > +             case 1:
> > +                     snprintf(buf+len, buflen, ",%d,\"%s\",\"%s\"",
> > +                                     auth_type, password, username);
> > +                     break;
> > +             case 0:
> > +             case 2:
> > +             default:
> > +                     snprintf(buf+len, buflen, ",%d,\"%s\",\"%s\"",
> > +                                     auth_type, username, password);
> > +             }
> > +             break;
> > +
> > +     default:
> > +             return FALSE;
> > +     }
> > +
> > +     return TRUE;
> > +}
> > +
> > +static void gemalto_get_cgdcont_command(struct ofono_modem *modem,
> > +                     guint cid, enum ofono_gprs_proto proto, const char
> *apn,
> > +                                                     char *buf, guint
> buflen)
> > +{
> > +     int len =3D snprintf(buf, buflen, "AT+CGDCONT=3D%u", cid);
> > +     buflen -=3D len;
> > +
> > +     if (!apn) /* it will remove the context */
> > +             return;
> > +
> > +     switch (proto) {
> > +     case OFONO_GPRS_PROTO_IPV6:
> > +             snprintf(buf+len, buflen, ",\"IPV6\",\"%s\"", apn);
> > +             break;
> > +     case OFONO_GPRS_PROTO_IPV4V6:
> > +             snprintf(buf+len, buflen, ",\"IPV4V6\",\"%s\"", apn);
> > +             break;
> > +     case OFONO_GPRS_PROTO_IP:
> > +     default:
> > +             snprintf(buf+len, buflen, ",\"IP\",\"%s\"", apn);
> > +             break;
> > +     }
> > +}
> > +
> > +static void failed_setup(struct ofono_gprs_context *gc,
> > +                             GAtResult *result, gboolean deactivate)
> > +{
> > +     struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> > +     struct ofono_error error;
> > +     char buf[64];
> > +
> > +     DBG("deactivate %d", deactivate);
> > +
> > +     if (deactivate =3D=3D TRUE) {
> > +
> > +             if (gcd->use_wwan)
> > +                     sprintf(buf, "AT^SWWAN=3D0,%u", gcd->active_conte=
xt);
> > +             else
> > +                     sprintf(buf, "AT+CGACT=3D0,%u", gcd->active_conte=
xt);
> > +
> > +             g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL,
> NULL);
> > +     }
> > +
> > +     gcd->active_context =3D 0;
> > +     gcd->state =3D STATE_IDLE;
> > +
> > +     if (result =3D=3D NULL) {
> > +             CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
> > +             return;
> > +     }
> > +
> > +     decode_at_error(&error, g_at_result_final_response(result));
> > +     gcd->cb(&error, gcd->cb_data);
> > +}
> > +
> > +static void activate_cb(gboolean ok, GAtResult *result, gpointer
> user_data)
> > +{
> > +     struct ofono_gprs_context *gc =3D user_data;
> > +     struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> > +
> > +     DBG("ok %d", ok);
> > +
> > +     if (!ok) {
> > +             ofono_error("Unable activate context");
> > +             /*
> > +              * We've reported sucess already, so can't just call
> > +              * failed_setup we call ofono_gprs_context_deactivated
> instead.
> > +              * Thats not a clean solution at all, but as it seems
> there is
> > +              * no clean way to determine whether it is possible to
> activate
> > +              * the context before issuing AT^SWWAN. A possible
> workaround
> > +              * might be to issue AT+CGACT=3D1 and AT+CGACT=3D0 and tr=
y if
> that
> > +              * works, before calling CALLBACK_WITH_SUCCESS.
> > +              */
> > +             ofono_gprs_context_deactivated(gc, gcd->active_context);
> > +             gcd->active_context =3D 0;
> > +             gcd->state =3D STATE_IDLE;
> > +             return;
> > +     }
> > +     /* We've reported sucess already */
> > +}
> > +
> > +static void setup_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> > +{
> > +     struct ofono_gprs_context *gc =3D user_data;
> > +     struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> > +     char buf[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
> > +                                     OFONO_GPRS_MAX_PASSWORD_LENGTH +1=
];
> > +     struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
> > +     const char *interface;
> > +
> > +     if (!ok) {
> > +             ofono_error("Failed to setup context");
> > +             failed_setup(gc, result, FALSE);
> > +             return;
> > +     }
> > +
> > +     if (gemalto_get_auth_command(modem, gcd->active_context,
> > +                             gcd->auth_method, gcd->username,
> gcd->password,
> > +                                                     buf, sizeof(buf)))
> {
> > +             if (!g_at_chat_send(gcd->chat, buf, none_prefix, NULL,
> NULL,
> > +
>  NULL))
> > +             goto error;
>
> indentation is wrong here?
>

yes, i will fix it.


>
> > +     }
> > +     /*
> > +      * note that if the auth command is not ok we skip it and continue
> > +      * but if the sending fails we do an error
> > +      */
> > +
> > +     if (gcd->use_wwan)
> > +             sprintf(buf, "AT^SWWAN=3D1,%u", gcd->active_context);
> > +     else
> > +             sprintf(buf, "AT+CGACT=3D%u,1", gcd->active_context);
> > +
> > +     if (g_at_chat_send(gcd->chat, buf, none_prefix,
> > +                                     activate_cb, gc, NULL) > 0){
> > +
> > +             interface =3D ofono_modem_get_string(modem,
> "NetworkInterface");
> > +
> > +             ofono_gprs_context_set_interface(gc, interface);
> > +             ofono_gprs_context_set_ipv4_address(gc, NULL, FALSE);
> > +
> > +             /*
> > +              * We report sucess already here because some modules need
> a
> > +              * DHCP request to complete the AT^SWWAN command
> sucessfully
> > +              */
> > +             gcd->state =3D STATE_ACTIVE;
> > +
> > +             CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
>
> So why are you calling SUCCESS even in the case of +CGACT?   Also,
> context activations via +CGACT need to be queried for static IPs, no?
> E.g. via +CGCONTRDP?  I don't see you doing that.
>
> Fundamentally, your context activation has succeeded or it didn't.  The
> DHCP operation is purely local between the modem and the host.  No other
> vendor in the world has this weird setup that you do.  So I don't really
> know what to tell you here as this ^SWWAN interaction is fundamentally
> broken and it can't go upstream in this form.
>
> Can ^SWWAN support static ip reporting instead of DHCP?  That would be
> preferred anyway as DHCP is slow and unneeded.
>

This is a discussion about how Gemalto products work.

Admittedly, there are a few models, in the high-volume low-price range
(already deployed),
that won't return from AT^SWWAN until a DHCP exchange is performed, as per
Sebastian's comment above.

The rest (which are the large majority) of the modules would allow a
'standard' treatment, but also work with the code above.

As per DHCP vs static, we have both, depending on the module.

Just for information, I have stepped upon networks *requiring* DHCP:
in this kind of networks, an MBIM module that would normally return a
static settings,
returns 0x00 in the "IPv4 configuration Available" field in of the
IP_CONFIGURATION answer,
instead of the usual 0x0F (address, gateway, dns, mtu).
So, it looks like that DHCP has to be considered as a valid alternative
also in this case.

We cannot change every module and every network to fit our wishes.

Back to the code, I don't see a solution at the moment other than that one.
I can add an 'if' to filter only the models that need it, but cannot remove
it completely.
And this code would be specific for the driver, I don't see why it couldn't
go upstream.



> > +
> > +             return;
> > +     }
> > +
> > +error:
> > +     failed_setup(gc, NULL, FALSE);
> > +}
> > +
> > +static void gemaltowwan_gprs_activate_primary(struct ofono_gprs_context
> *gc,
> > +                             const struct ofono_gprs_primary_context
> *ctx,
> > +                             ofono_gprs_context_cb_t cb, void *data)
> > +{
> > +     struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> > +     char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
> > +     struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
> > +
> > +     DBG("cid %u", ctx->cid);
> > +
> > +     gcd->use_wwan =3D ofono_modem_get_integer(modem, "Gemalto_WWAN");
> > +     gcd->active_context =3D ctx->cid;
> > +     gcd->cb =3D cb;
> > +     gcd->cb_data =3D data;
> > +     memcpy(gcd->username, ctx->username, sizeof(ctx->username));
> > +     memcpy(gcd->password, ctx->password, sizeof(ctx->password));
> > +     gcd->state =3D STATE_ENABLING;
> > +     gcd->proto =3D ctx->proto;
> > +     gcd->auth_method =3D ctx->auth_method;
> > +
> > +     gemalto_get_cgdcont_command(modem, ctx->cid, ctx->proto, ctx->apn,
> buf,
> > +
>  sizeof(buf));
> > +
> > +     if (g_at_chat_send(gcd->chat, buf, none_prefix,
> > +                             setup_cb, gc, NULL) > 0)
> > +             return;
> > +
> > +     CALLBACK_WITH_FAILURE(cb, data);
> > +}
> > +
> > +static void deactivate_cb(gboolean ok, GAtResult *result, gpointer
> user_data)
> > +{
> > +     struct ofono_gprs_context *gc =3D user_data;
> > +     struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> > +
> > +     DBG("ok %d", ok);
> > +
> > +     gcd->active_context =3D 0;
> > +     gcd->state =3D STATE_IDLE;
> > +
> > +     CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> > +}
> > +
> > +static void gemaltowwan_gprs_deactivate_primary(struct
> ofono_gprs_context *gc,
> > +                                     unsigned int cid,
> > +                                     ofono_gprs_context_cb_t cb, void
> *data)
> > +{
> > +     struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> > +     char buf[64];
> > +
> > +     DBG("cid %u", cid);
> > +
> > +     gcd->state =3D STATE_DISABLING;
> > +     gcd->cb =3D cb;
> > +     gcd->cb_data =3D data;
> > +
> > +     if (gcd->use_wwan)
> > +             sprintf(buf, "AT^SWWAN=3D0,%u", gcd->active_context);
> > +     else
> > +             sprintf(buf, "AT+CGACT=3D%u,0", gcd->active_context);
> > +
> > +     if (g_at_chat_send(gcd->chat, buf, none_prefix,
> > +                             deactivate_cb, gc, NULL) > 0)
> > +             return;
> > +
> > +     CALLBACK_WITH_SUCCESS(cb, data);
> > +}
> > +
> > +static void cgev_notify(GAtResult *result, gpointer user_data)
> > +{
> > +     struct ofono_gprs_context *gc =3D user_data;
> > +     struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> > +     const char *event;
> > +     int cid =3D 0;
> > +     GAtResultIter iter;
> > +
> > +     g_at_result_iter_init(&iter, result);
> > +
> > +     if (!g_at_result_iter_next(&iter, "+CGEV:"))
> > +             return;
> > +
> > +     if (!g_at_result_iter_next_unquoted_string(&iter, &event))
> > +             return;
> > +
> > +     if (!g_str_has_prefix(event, "ME PDN DEACT"))
> > +             return;
> > +
> > +     sscanf(event, "%*s %*s %*s %u", &cid);
> > +
> > +     DBG("cid %d", cid);
> > +
> > +     if ((unsigned int) cid !=3D gcd->active_context)
> > +             return;
> > +
> > +     ofono_gprs_context_deactivated(gc, gcd->active_context);
> > +
> > +     gcd->active_context =3D 0;
> > +     gcd->state =3D STATE_IDLE;
> > +}
> > +
> > +static int gemaltowwan_gprs_context_probe(struct ofono_gprs_context *g=
c,
> > +                                     unsigned int model, void *data)
> > +{
> > +     GAtChat *chat =3D data;
> > +     struct gprs_context_data *gcd;
> > +     struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
> > +
> > +     DBG("");
> > +
> > +     gcd =3D g_try_new0(struct gprs_context_data, 1);
> > +     if (gcd =3D=3D NULL)
> > +             return -ENOMEM;
> > +
> > +     if (modem)
> > +             gcd->use_wwan =3D ofono_modem_get_integer(modem,
> "Gemalto_WWAN");
> > +     gcd->chat =3D g_at_chat_clone(chat);
> > +     ofono_gprs_context_set_data(gc, gcd);
> > +     g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
> > +
> > +     return 0;
> > +}
> > +
> > +static void gemaltowwan_gprs_context_remove(struct ofono_gprs_context
> *gc)
> > +{
> > +     struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> > +
> > +     DBG("");
> > +
> > +     ofono_gprs_context_set_data(gc, NULL);
> > +
> > +     g_at_chat_unref(gcd->chat);
> > +     g_free(gcd);
> > +}
> > +
> > +static void gemaltowwan_gprs_detach_shutdown(struct ofono_gprs_context
> *gc,
> > +                                     unsigned int cid)
> > +{
> > +     DBG("cid %u", cid);
> > +
> > +     ofono_gprs_context_deactivated(gc, cid);
> > +}
> > +
> > +static struct ofono_gprs_context_driver driver =3D {
> > +     .name                   =3D "gemaltowwanmodem",
> > +     .probe                  =3D gemaltowwan_gprs_context_probe,
> > +     .remove                 =3D gemaltowwan_gprs_context_remove,
> > +     .activate_primary       =3D gemaltowwan_gprs_activate_primary,
> > +     .deactivate_primary     =3D gemaltowwan_gprs_deactivate_primary,
> > +     .detach_shutdown        =3D gemaltowwan_gprs_detach_shutdown,
> > +};
> > +
> > +void gemaltowwan_gprs_context_init(void)
> > +{
> > +     ofono_gprs_context_driver_register(&driver);
> > +}
> > +
> > +void gemaltowwan_gprs_context_exit(void)
> > +{
> > +     ofono_gprs_context_driver_unregister(&driver);
> > +}
> >
>
> Regards,
> -Denis
>

Regards,
Giacinto

--===============2152354741860230807==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gRnJpLCBTZXAgMjEsIDIwMTggYXQgNjox
MiBQTSBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20i
PmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXIt
bGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBHaWFj
aW50byw8YnI+Cjxicj4KU28gcGxlYXNlIGZpeCB5b3VyIGNvbW1pdCBkZXNjcmlwdGlvbiBpbiB0
aGUgbmV4dCB2ZXJzaW9uLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5jZXJ0
YWlubHkuPC9kaXY+PGRpdj7CoDxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KT24gMDkvMTkvMjAxOCAx
MDo1MCBQTSwgR2lhY2ludG8gQ2lmZWxsaSB3cm90ZTo8YnI+CiZndDsgLS0tPGJyPgomZ3Q7wqAg
wqBkcml2ZXJzL2dlbWFsdG9tb2RlbS9nZW1hbHRvbW9kZW0uY8KgIMKgIMKgIHzCoCDCoDIgKzxi
cj4KJmd0O8KgIMKgZHJpdmVycy9nZW1hbHRvbW9kZW0vZ2VtYWx0b21vZGVtLmjCoCDCoCDCoCB8
wqAgwqAzICs8YnI+CiZndDvCoCDCoGRyaXZlcnMvZ2VtYWx0b21vZGVtL2dwcnMtY29udGV4dC13
d2FuLmMgfCA0NDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKzxicj4KJmd0O8KgIMKg
MyBmaWxlcyBjaGFuZ2VkLCA0NTEgaW5zZXJ0aW9ucygrKTxicj4KJmd0O8KgIMKgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvZ2VtYWx0b21vZGVtL2dwcnMtY29udGV4dC13d2FuLmM8YnI+CiZn
dDsgPGJyPgomZ3Q7IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dlbWFsdG9tb2RlbS9nZW1hbHRvbW9k
ZW0uYyBiL2RyaXZlcnMvZ2VtYWx0b21vZGVtL2dlbWFsdG9tb2RlbS5jPGJyPgomZ3Q7IGluZGV4
IDYxNGNhODEuLjdhZmQzYzEgMTAwNjQ0PGJyPgomZ3Q7IC0tLSBhL2RyaXZlcnMvZ2VtYWx0b21v
ZGVtL2dlbWFsdG9tb2RlbS5jPGJyPgomZ3Q7ICsrKyBiL2RyaXZlcnMvZ2VtYWx0b21vZGVtL2dl
bWFsdG9tb2RlbS5jPGJyPgomZ3Q7IEBAIC0zNSw2ICszNSw3IEBAPGJyPgomZ3Q7wqAgwqBzdGF0
aWMgaW50IGdlbWFsdG9tb2RlbV9pbml0KHZvaWQpPGJyPgomZ3Q7wqAgwqB7PGJyPgomZ3Q7wqAg
wqAgwqAgwqBnZW1hbHRvX2xvY2F0aW9uX3JlcG9ydGluZ19pbml0KCk7PGJyPgomZ3Q7ICvCoCDC
oCDCoGdlbWFsdG93d2FuX2dwcnNfY29udGV4dF9pbml0KCk7PGJyPgomZ3Q7wqAgwqAgwqAgwqBn
ZW1hbHRvX3ZvaWNlY2FsbF9pbml0KCk7PGJyPgomZ3Q7wqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+
CiZndDvCoCDCoH08YnI+CiZndDsgQEAgLTQyLDYgKzQzLDcgQEAgc3RhdGljIGludCBnZW1hbHRv
bW9kZW1faW5pdCh2b2lkKTxicj4KJmd0O8KgIMKgc3RhdGljIHZvaWQgZ2VtYWx0b21vZGVtX2V4
aXQodm9pZCk8YnI+CiZndDvCoCDCoHs8YnI+CiZndDvCoCDCoCDCoCDCoGdlbWFsdG9fbG9jYXRp
b25fcmVwb3J0aW5nX2V4aXQoKTs8YnI+CiZndDsgK8KgIMKgIMKgZ2VtYWx0b3d3YW5fZ3Byc19j
b250ZXh0X2V4aXQoKTs8YnI+Cjxicj4KSSYjMzk7bSBub3QgcmVhbGx5IGEgZmFuIG9mIHRoZSBu
YW1lLsKgIEhvdyBtYW55IG9mIGdwcnNfY29udGV4dCB0eXBlcyBkbyB5b3UgPGJyPgpoYXZlLCBh
bmQgd2hhdCBpcyBmdW5kYW1lbnRhbGx5IGRpZmZlcmVudCBiZXR3ZWVuIHRoZW0gdGhhdCB0aGV5
IGNhbm5vdCA8YnI+CmJlIGhhbmRsZWQgYnkgdGhlIHNhbWUgZHJpdmVyPzxicj4KPGJyPjwvYmxv
Y2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pk9rLCBJIHdpbGwgcmVuYW1lIGl0LjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KJmd0O8KgIMKgIMKgIMKgZ2VtYWx0b192b2ljZWNhbGxfZXhp
dCgpOzxicj4KJmd0O8KgIMKgfTxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dlbWFsdG9tb2RlbS9nZW1hbHRvbW9kZW0uaCBiL2RyaXZlcnMvZ2VtYWx0b21vZGVt
L2dlbWFsdG9tb2RlbS5oPGJyPgomZ3Q7IGluZGV4IDRlNmVkMTYuLmY0NWFlYTkgMTAwNjQ0PGJy
PgomZ3Q7IC0tLSBhL2RyaXZlcnMvZ2VtYWx0b21vZGVtL2dlbWFsdG9tb2RlbS5oPGJyPgomZ3Q7
ICsrKyBiL2RyaXZlcnMvZ2VtYWx0b21vZGVtL2dlbWFsdG9tb2RlbS5oPGJyPgomZ3Q7IEBAIC0y
NCw1ICsyNCw4IEBAPGJyPgomZ3Q7wqAgwqBleHRlcm4gdm9pZCBnZW1hbHRvX2xvY2F0aW9uX3Jl
cG9ydGluZ19pbml0KCk7PGJyPgomZ3Q7wqAgwqBleHRlcm4gdm9pZCBnZW1hbHRvX2xvY2F0aW9u
X3JlcG9ydGluZ19leGl0KCk7PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDsgK2V4dGVybiB2b2lkIGdl
bWFsdG93d2FuX2dwcnNfY29udGV4dF9pbml0KCk7PGJyPgomZ3Q7ICtleHRlcm4gdm9pZCBnZW1h
bHRvd3dhbl9ncHJzX2NvbnRleHRfZXhpdCgpOzxicj4KJmd0OyArPGJyPgomZ3Q7wqAgwqBleHRl
cm4gdm9pZCBnZW1hbHRvX3ZvaWNlY2FsbF9pbml0KCk7PGJyPgomZ3Q7wqAgwqBleHRlcm4gdm9p
ZCBnZW1hbHRvX3ZvaWNlY2FsbF9leGl0KCk7PGJyPgomZ3Q7IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dlbWFsdG9tb2RlbS9ncHJzLWNvbnRleHQtd3dhbi5jIGIvZHJpdmVycy9nZW1hbHRvbW9kZW0v
Z3Bycy1jb250ZXh0LXd3YW4uYzxicj4KJmd0OyBuZXcgZmlsZSBtb2RlIDEwMDY0NDxicj4KJmd0
OyBpbmRleCAwMDAwMDAwLi4xMjM3OGEzPGJyPgomZ3Q7IC0tLSAvZGV2L251bGw8YnI+CiZndDsg
KysrIGIvZHJpdmVycy9nZW1hbHRvbW9kZW0vZ3Bycy1jb250ZXh0LXd3YW4uYzxicj4KJmd0OyBA
QCAtMCwwICsxLDQ0NiBAQDxicj4KJmd0OyArLyo8YnI+CiZndDsgKyAqPGJyPgomZ3Q7ICsgKsKg
IG9Gb25vIC0gT3BlbiBTb3VyY2UgVGVsZXBob255PGJyPgomZ3Q7ICsgKjxicj4KJmd0OyArICrC
oCBDb3B5cmlnaHQgKEMpIDIwMTcgUGlvdHIgSGFiZXIuIEFsbCByaWdodHMgcmVzZXJ2ZWQuPGJy
PgomZ3Q7ICsgKsKgIENvcHlyaWdodCAoQykgMjAxOCBTZWJhc3RpYW4gQXJuZC4gQWxsIHJpZ2h0
cyByZXNlcnZlZC48YnI+CiZndDsgKyAqwqAgQ29weXJpZ2h0IChDKSAyMDE4IEdlbWFsdG8gTTJN
PGJyPgomZ3Q7ICsgKjxicj4KJmd0OyArICrCoCBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2Fy
ZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeTxicj4KJmd0OyArICrCoCBp
dCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNp
b24gMiBhczxicj4KJmd0OyArICrCoCBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbi48YnI+CiZndDsgKyAqPGJyPgomZ3Q7ICsgKsKgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0
cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLDxicj4KJmd0OyArICrC
oCBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJy
YW50eSBvZjxicj4KJmd0OyArICrCoCBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSIFBVUlBPU0UuwqAgU2VlIHRoZTxicj4KJmd0OyArICrCoCBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLjxicj4KJmd0OyArICo8YnI+CiZndDsgKyAq
Lzxicj4KJmd0OyArPGJyPgomZ3Q7ICsjaWZkZWYgSEFWRV9DT05GSUdfSDxicj4KJmd0OyArI2lu
Y2x1ZGUgJmx0O2NvbmZpZy5oJmd0Ozxicj4KJmd0OyArI2VuZGlmPGJyPgomZ3Q7ICs8YnI+CiZn
dDsgKyNkZWZpbmUgX0dOVV9TT1VSQ0U8YnI+CiZndDsgKyNpbmNsdWRlICZsdDtzdHJpbmcuaCZn
dDs8YnI+CiZndDsgKyNpbmNsdWRlICZsdDtzdGRsaWIuaCZndDs8YnI+CiZndDsgKyNpbmNsdWRl
ICZsdDtzdGRpby5oJmd0Ozxicj4KJmd0OyArI2luY2x1ZGUgJmx0O2Vycm5vLmgmZ3Q7PGJyPgom
Z3Q7ICsjaW5jbHVkZSAmbHQ7c3lzL3N0YXQuaCZndDs8YnI+CiZndDsgKzxicj4KJmd0OyArI2lu
Y2x1ZGUgJmx0O2dsaWIuaCZndDs8YnI+CiZndDsgKzxicj4KJmd0OyArI2luY2x1ZGUgJmx0O29m
b25vL2xvZy5oJmd0Ozxicj4KJmd0OyArI2luY2x1ZGUgJmx0O29mb25vL21vZGVtLmgmZ3Q7PGJy
PgomZ3Q7ICsjaW5jbHVkZSAmbHQ7b2Zvbm8vZ3Bycy1jb250ZXh0LmgmZ3Q7PGJyPgomZ3Q7ICs8
YnI+CiZndDsgKyNpbmNsdWRlICZxdW90O2dhdGNoYXQuaCZxdW90Ozxicj4KJmd0OyArI2luY2x1
ZGUgJnF1b3Q7Z2F0cmVzdWx0LmgmcXVvdDs8YnI+CiZndDsgKzxicj4KJmd0OyArI2luY2x1ZGUg
JnF1b3Q7Z2VtYWx0b21vZGVtLmgmcXVvdDs8YnI+CiZndDsgKzxicj4KJmd0OyArc3RhdGljIGNv
bnN0IGNoYXIgKm5vbmVfcHJlZml4W10gPSB7IE5VTEwgfTs8YnI+CiZndDsgKzxicj4KJmd0OyAr
ZW51bSBzdGF0ZSB7PGJyPgomZ3Q7ICvCoCDCoCDCoFNUQVRFX0lETEUsPGJyPgomZ3Q7ICvCoCDC
oCDCoFNUQVRFX0VOQUJMSU5HLDxicj4KJmd0OyArwqAgwqAgwqBTVEFURV9ESVNBQkxJTkcsPGJy
PgomZ3Q7ICvCoCDCoCDCoFNUQVRFX0FDVElWRSw8YnI+CiZndDsgK307PGJyPgomZ3Q7ICs8YnI+
CiZndDsgK3N0cnVjdCBncHJzX2NvbnRleHRfZGF0YSB7PGJyPgomZ3Q7ICvCoCDCoCDCoEdBdENo
YXQgKmNoYXQ7PGJyPgomZ3Q7ICvCoCDCoCDCoHVuc2lnbmVkIGludCBhY3RpdmVfY29udGV4dDs8
YnI+CiZndDsgK8KgIMKgIMKgY2hhciB1c2VybmFtZVtPRk9OT19HUFJTX01BWF9VU0VSTkFNRV9M
RU5HVEggKyAxXTs8YnI+CiZndDsgK8KgIMKgIMKgY2hhciBwYXNzd29yZFtPRk9OT19HUFJTX01B
WF9QQVNTV09SRF9MRU5HVEggKyAxXTs8YnI+CiZndDsgK8KgIMKgIMKgZW51bSBvZm9ub19ncHJz
X2F1dGhfbWV0aG9kIGF1dGhfbWV0aG9kOzxicj4KJmd0OyArwqAgwqAgwqBlbnVtIHN0YXRlIHN0
YXRlOzxicj4KJmd0OyArwqAgwqAgwqBlbnVtIG9mb25vX2dwcnNfcHJvdG8gcHJvdG87PGJyPgom
Z3Q7ICvCoCDCoCDCoGNoYXIgYWRkcmVzc1s2NF07PGJyPgomZ3Q7ICvCoCDCoCDCoGNoYXIgbmV0
bWFza1s2NF07PGJyPgomZ3Q7ICvCoCDCoCDCoGNoYXIgZ2F0ZXdheVs2NF07PGJyPgomZ3Q7ICvC
oCDCoCDCoGNoYXIgZG5zMVs2NF07PGJyPgomZ3Q7ICvCoCDCoCDCoGNoYXIgZG5zMls2NF07PGJy
PgomZ3Q7ICvCoCDCoCDCoG9mb25vX2dwcnNfY29udGV4dF9jYl90IGNiOzxicj4KJmd0OyArwqAg
wqAgwqB2b2lkICpjYl9kYXRhOzxicj4KJmd0OyArwqAgwqAgwqBpbnQgdXNlX3d3YW47PGJyPgom
Z3Q7ICt9Ozxicj4KJmd0OyArPGJyPgomZ3Q7ICtzdGF0aWMgZ2Jvb2xlYW4gZ2VtYWx0b19nZXRf
YXV0aF9jb21tYW5kKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sIGludCBjaWQsPGJyPgomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVudW0gb2Zvbm9f
Z3Byc19hdXRoX21ldGhvZCBhdXRoX21ldGhvZCw8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3QgY2hhciAqdXNlcm5hbWUsIGNvbnN0IGNo
YXIgKnBhc3N3b3JkLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjaGFyICpidWYsIGd1aW50IGJ1Zmxlbik8YnI+CiZndDsgK3s8YnI+CiZndDsg
K8KgIMKgIMKgaW50IGd0b19hdXRoID0gb2Zvbm9fbW9kZW1fZ2V0X2ludGVnZXIobW9kZW0sICZx
dW90O0dlbWFsdG9fQXV0aCZxdW90Oyk7PGJyPgo8YnI+ClBsZWFzZSB1c2UgYSBDYW1lbENhc2Ut
ZCB2YXJpYWJsZSBmb3IgdGhpcy7CoCBFLmcuIEdlbWFsdG9BdXRoVHlwZTxicj48L2Jsb2NrcXVv
dGU+PGRpdj48YnI+PC9kaXY+PGRpdj5vay4gVGhpcyBpcyBuZXcgZm9yIHRoaXMgY29kZSwgYmVj
YXVzZSBJIGhhdmUgYWx3YXlzIHNlZW4gb25seSB2YXJpYWJsZXMgd2l0aCB1bmRlcnNjb3Jlcywg
YnV0IG5vIHByb2JsZW0uPC9kaXY+PGRpdj5QZXJzb25hbGx5IEkgd291bGQgcHJlZmVyIGNhbWVs
Q2FzZSAmIzM5O2dlbWFsdG9BdXRoVHlwZSYjMzk7LCBiZWNhdXNlIGl0IGlzIG1vcmUgY29oZXJl
bnQgaW4gY2FzZSBvZiAxLXBhcnQgbmFtZXMgbGlrZSAmIzM5O3VzZXImIzM5Oyw8L2Rpdj48ZGl2
PmJ1dCBJJiMzOTtsbCBkbyBhcyB5b3Ugc2F5LjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxi
cj4KJmd0OyArwqAgwqAgwqBpbnQgbGVuOzxicj4KJmd0OyArwqAgwqAgwqAvKjxicj4KJmd0OyAr
wqAgwqAgwqAgKiAwOiB1c2UgY2dhdXRoPGJyPgomZ3Q7ICvCoCDCoCDCoCAqIDE6IHVzZSBzZ2F1
dGgocHdkLCB1c2VyKTxicj4KJmd0OyArwqAgwqAgwqAgKiAyOiB1c2Ugc2dhdXRoKHVzZXIsIHB3
ZCk8YnI+CiZndDsgK8KgIMKgIMKgICovPGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgaW50
IGF1dGhfdHlwZTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBzd2l0Y2ggKGF1dGhfbWV0
aG9kKSB7PGJyPgomZ3Q7ICvCoCDCoCDCoGNhc2UgT0ZPTk9fR1BSU19BVVRIX01FVEhPRF9QQVA6
PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGF1dGhfdHlwZSA9IDE7PGJyPgomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4KJmd0OyArwqAgwqAgwqBjYXNlIE9GT05PX0dQ
UlNfQVVUSF9NRVRIT0RfQ0hBUDo8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYXV0aF90
eXBlID0gMjs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPgomZ3Q7ICvC
oCDCoCDCoGNhc2UgT0ZPTk9fR1BSU19BVVRIX01FVEhPRF9OT05FOjxicj4KPGJyPgpTbyB1bnRp
bCB0aGUgR1BSU19BVVRIX01FVEhPRF9OT05FIGlzIGFjdHVhbGx5IGludHJvZHVjZWQsIHlvdSBt
aWdodCA8YnI+CndhbnQgdG8ganVzdCBnZXQgdGhpcyB1cHN0cmVhbSB3aXRoIHRoZSBleGlzdGlu
ZyBlbnVtZXJhdGlvbi7CoCBFLmcuIGp1c3QgPGJyPgphc3N1bWUgdGhhdCBpZiB1c2VybmFtZSAm
YW1wOyBwYXNzd29yZCBpcyBlbXB0eSwgdGhlIGF1dGggbWV0aG9kIGlzIG5vbmUuPGJyPjwvYmxv
Y2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgaGF2ZSBwdXNoZWQgdGhlIG5ldyBtZXRob2Qg
Tk9ORSBhZ2FpbiwgYW5kIEkgcHJlZmVyIHRvIHdhaXQgdW50aWwgaXQgaXMgdGFrZW4uPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgY3VycmVudCBzb2x1dGlvbiBpcyByZWFsbHkgYSBub24t
ZG9jdW1lbnRlZCBoYWNrLjwvZGl2PjxkaXY+Q2hlY2tpbmcgd2hldGhlciB1c2VyJmFtcDtwYXNz
d29yZCBhcmUgZW1wdHkgdG8gY2hhbmdlIHRoZSB0eXBlIG9mIGF1dGhlbnRpY2F0aW9uIGdvZXMg
YWdhaW5zdCB0aGXCoGNhbGxlciBzZXR0aW5ncy48L2Rpdj48ZGl2Pkl0IGlzIGJldHRlciB0byBn
aXZlIGFuIGVycm9yIHNvIHRoYXQgdGhlcmUgaXMgYSBjaGFuY2UgdG8gaGF2ZSBnb29kIHNldHRp
bmdzLjwvZGl2PjxkaXY+wqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CiZndDsgK8KgIMKgIMKgZGVm
YXVsdDo8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYXV0aF90eXBlID0gMDs8YnI+CiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPgomZ3Q7ICvCoCDCoCDCoH08YnI+CiZn
dDsgKzxicj4KJmd0OyArwqAgwqAgwqBpZiAoYXV0aF90eXBlICE9IDAgJmFtcDsmYW1wOyAoISp1
c2VybmFtZSB8fCAhKnBhc3N3b3JkKSkgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gRkFM
U0U7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgc3dpdGNoIChndG9fYXV0aCkgezxicj4K
Jmd0OyArwqAgwqAgwqBjYXNlIDE6PGJyPgomZ3Q7ICvCoCDCoCDCoGNhc2UgMjo8YnI+CiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgbGVuID0gc25wcmludGYoYnVmLCBidWZsZW4sICZxdW90O0FU
XlNHQVVUSD0lZCZxdW90OywgY2lkKTs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYnJl
YWs7PGJyPgomZ3Q7ICvCoCDCoCDCoGNhc2UgMDo8YnI+CiZndDsgK8KgIMKgIMKgZGVmYXVsdDo8
YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgbGVuID0gc25wcmludGYoYnVmLCBidWZsZW4s
ICZxdW90O0FUK0NHQVVUSD0lZCZxdW90OywgY2lkKTs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgYnJlYWs7PGJyPgomZ3Q7ICvCoCDCoCDCoH08YnI+CiZndDsgKzxicj4KJmd0OyArwqAg
wqAgwqBidWZsZW4gLT0gbGVuOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoHN3aXRjaChh
dXRoX3R5cGUpIHs8YnI+CiZndDsgK8KgIMKgIMKgY2FzZSAwOjxicj4KJmd0OyArPGJyPgomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHN3aXRjaCAoZ3RvX2F1dGgpIHs8YnI+CiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgY2FzZSAyOjxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzbnByaW50ZihidWYrbGVuLCBidWZsZW4sICZxdW90OywwLFwmcXVvdDtcJnF1b3Q7
LFwmcXVvdDtcJnF1b3Q7JnF1b3Q7KTs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYnJlYWs7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgMDo8YnI+
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSAxOjxicj4KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqBkZWZhdWx0Ojxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzbnByaW50ZihidWYrbGVuLCBidWZsZW4sICZxdW90OywwJnF1b3Q7KTs8YnI+CiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPgomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoH08YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPgo8YnI+
ClRoaXMgc3dpdGNoIG1pZ2h0IGJlIG1vcmUgY29tcGFjdCBhcyBhbiBpZiBzdGF0ZW1lbnQuwqAg
QWxzbyB0aGUgY29kaW5nIDxicj4Kc3R5bGUgaXMgYWxsIHdyb25nIGluIHRoaXMgZnVuY3Rpb24u
wqAgU2VlIGRvYy9jb2Rpbmctc3R5bGUudHh0IGl0ZW0gTTMgPGJyPgppbiBwYXJ0aWN1bGFyLjxi
cj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj50aGUgaWRlYSBvZiB0aGUgc3dpdGNo
IGlzIHRvIGxldCBhIHJlYWRlciBzZWUgdGhlIGRpZmZlcmVuY2VzIGFtb25nIHRoZSB2YXJpb3Vz
IGNhc2VzLDwvZGl2PjxkaXY+YnV0IGluIHJlYWxpdHkgdGhlcmUgYXJlIDIgb3IgMyBmbGFncyBp
biB0aGlzIHZhcmlhYmxlLCBzbyBJIGFtIGdvaW5nIHRvIHJlc3RydWN0dXJlIHRoZSBldmFsIGFz
IGEgYml0bWFwLDwvZGl2PjxkaXY+YW5kIHRoZW4gSSB3aWxsIGNhbGwgaWYmIzM5O3MgaW5zdGVh
ZCBvZiBzd2l0Y2gmIzM5O3MuPC9kaXY+PGRpdj5UaGFuayB5b3UgZm9yIHRoaXMgcmV2aWV3LCBp
dCBoZWxwZWQgcG9pbnRpbmcgb3V0IHRoZSBmbGF3IGluIHRoZSBkZXNpZ24uPC9kaXY+PGRpdj7C
oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRk
aW5nLWxlZnQ6MWV4Ij4KPGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgY2FzZSAxOjxicj4K
Jmd0OyArwqAgwqAgwqBjYXNlIDI6PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgc3dpdGNoIChndG9fYXV0aCkgezxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBj
YXNlIDE6PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNucHJpbnRm
KGJ1ZitsZW4sIGJ1ZmxlbiwgJnF1b3Q7LCVkLFwmcXVvdDslc1wmcXVvdDssXCZxdW90OyVzXCZx
dW90OyZxdW90Oyw8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgYXV0aF90eXBlLCBwYXNzd29yZCwgdXNlcm5hbWUpOzxicj4K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+CiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgY2FzZSAwOjxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBj
YXNlIDI6PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGRlZmF1bHQ6PGJyPgomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNucHJpbnRmKGJ1ZitsZW4sIGJ1Zmxlbiwg
JnF1b3Q7LCVkLFwmcXVvdDslc1wmcXVvdDssXCZxdW90OyVzXCZxdW90OyZxdW90Oyw8YnI+CiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgYXV0aF90eXBlLCB1c2VybmFtZSwgcGFzc3dvcmQpOzxicj4KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqB9PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4KJmd0OyAr
PGJyPgomZ3Q7ICvCoCDCoCDCoGRlZmF1bHQ6PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldHVybiBGQUxTRTs8YnI+CiZndDsgK8KgIMKgIMKgfTxicj4KJmd0OyArPGJyPgomZ3Q7ICvC
oCDCoCDCoHJldHVybiBUUlVFOzxicj4KJmd0OyArfTxicj4KJmd0OyArPGJyPgomZ3Q7ICtzdGF0
aWMgdm9pZCBnZW1hbHRvX2dldF9jZ2Rjb250X2NvbW1hbmQoc3RydWN0IG9mb25vX21vZGVtICpt
b2RlbSw8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ3VpbnQgY2lk
LCBlbnVtIG9mb25vX2dwcnNfcHJvdG8gcHJvdG8sIGNvbnN0IGNoYXIgKmFwbiw8YnI+CiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2hhciAqYnVmLCBndWludCBidWZsZW4pPGJyPgomZ3Q7
ICt7PGJyPgomZ3Q7ICvCoCDCoCDCoGludCBsZW4gPSBzbnByaW50ZihidWYsIGJ1ZmxlbiwgJnF1
b3Q7QVQrQ0dEQ09OVD0ldSZxdW90OywgY2lkKTs8YnI+CiZndDsgK8KgIMKgIMKgYnVmbGVuIC09
IGxlbjs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBpZiAoIWFwbikgLyogaXQgd2lsbCBy
ZW1vdmUgdGhlIGNvbnRleHQgKi88YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
Ozxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoHN3aXRjaCAocHJvdG8pIHs8YnI+CiZndDsg
K8KgIMKgIMKgY2FzZSBPRk9OT19HUFJTX1BST1RPX0lQVjY6PGJyPgomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoHNucHJpbnRmKGJ1ZitsZW4sIGJ1ZmxlbiwgJnF1b3Q7LFwmcXVvdDtJUFY2XCZx
dW90OyxcJnF1b3Q7JXNcJnF1b3Q7JnF1b3Q7LCBhcG4pOzxicj4KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqBicmVhazs8YnI+CiZndDsgK8KgIMKgIMKgY2FzZSBPRk9OT19HUFJTX1BST1RPX0lQ
VjRWNjo8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgc25wcmludGYoYnVmK2xlbiwgYnVm
bGVuLCAmcXVvdDssXCZxdW90O0lQVjRWNlwmcXVvdDssXCZxdW90OyVzXCZxdW90OyZxdW90Oywg
YXBuKTs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPgomZ3Q7ICvCoCDC
oCDCoGNhc2UgT0ZPTk9fR1BSU19QUk9UT19JUDo8YnI+CiZndDsgK8KgIMKgIMKgZGVmYXVsdDo8
YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgc25wcmludGYoYnVmK2xlbiwgYnVmbGVuLCAm
cXVvdDssXCZxdW90O0lQXCZxdW90OyxcJnF1b3Q7JXNcJnF1b3Q7JnF1b3Q7LCBhcG4pOzxicj4K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+CiZndDsgK8KgIMKgIMKgfTxicj4K
Jmd0OyArfTxicj4KJmd0OyArPGJyPgomZ3Q7ICtzdGF0aWMgdm9pZCBmYWlsZWRfc2V0dXAoc3Ry
dWN0IG9mb25vX2dwcnNfY29udGV4dCAqZ2MsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEdBdFJlc3VsdCAqcmVzdWx0LCBnYm9vbGVhbiBkZWFj
dGl2YXRlKTxicj4KJmd0OyArezxicj4KJmd0OyArwqAgwqAgwqBzdHJ1Y3QgZ3Byc19jb250ZXh0
X2RhdGEgKmdjZCA9IG9mb25vX2dwcnNfY29udGV4dF9nZXRfZGF0YShnYyk7PGJyPgomZ3Q7ICvC
oCDCoCDCoHN0cnVjdCBvZm9ub19lcnJvciBlcnJvcjs8YnI+CiZndDsgK8KgIMKgIMKgY2hhciBi
dWZbNjRdOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoERCRygmcXVvdDtkZWFjdGl2YXRl
ICVkJnF1b3Q7LCBkZWFjdGl2YXRlKTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBpZiAo
ZGVhY3RpdmF0ZSA9PSBUUlVFKSB7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgaWYgKGdjZC0mZ3Q7dXNlX3d3YW4pPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHNwcmludGYoYnVmLCAmcXVvdDtBVF5TV1dBTj0wLCV1JnF1b3Q7LCBnY2Qt
Jmd0O2FjdGl2ZV9jb250ZXh0KTs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZTxi
cj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzcHJpbnRmKGJ1ZiwgJnF1
b3Q7QVQrQ0dBQ1Q9MCwldSZxdW90OywgZ2NkLSZndDthY3RpdmVfY29udGV4dCk7PGJyPgomZ3Q7
ICs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZ19hdF9jaGF0X3NlbmQoZ2NkLSZndDtj
aGF0LCBidWYsIG5vbmVfcHJlZml4LCBOVUxMLCBOVUxMLCBOVUxMKTs8YnI+CiZndDsgK8KgIMKg
IMKgfTxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGdjZC0mZ3Q7YWN0aXZlX2NvbnRleHQg
PSAwOzxicj4KJmd0OyArwqAgwqAgwqBnY2QtJmd0O3N0YXRlID0gU1RBVEVfSURMRTs8YnI+CiZn
dDsgKzxicj4KJmd0OyArwqAgwqAgwqBpZiAocmVzdWx0ID09IE5VTEwpIHs8YnI+CiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgQ0FMTEJBQ0tfV0lUSF9GQUlMVVJFKGdjZC0mZ3Q7Y2IsIGdjZC0m
Z3Q7Y2JfZGF0YSk7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjs8YnI+CiZn
dDsgK8KgIMKgIMKgfTxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGRlY29kZV9hdF9lcnJv
cigmYW1wO2Vycm9yLCBnX2F0X3Jlc3VsdF9maW5hbF9yZXNwb25zZShyZXN1bHQpKTs8YnI+CiZn
dDsgK8KgIMKgIMKgZ2NkLSZndDtjYigmYW1wO2Vycm9yLCBnY2QtJmd0O2NiX2RhdGEpOzxicj4K
Jmd0OyArfTxicj4KJmd0OyArPGJyPgomZ3Q7ICtzdGF0aWMgdm9pZCBhY3RpdmF0ZV9jYihnYm9v
bGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+CiZndDsg
K3s8YnI+CiZndDsgK8KgIMKgIMKgc3RydWN0IG9mb25vX2dwcnNfY29udGV4dCAqZ2MgPSB1c2Vy
X2RhdGE7PGJyPgomZ3Q7ICvCoCDCoCDCoHN0cnVjdCBncHJzX2NvbnRleHRfZGF0YSAqZ2NkID0g
b2Zvbm9fZ3Byc19jb250ZXh0X2dldF9kYXRhKGdjKTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAg
wqAgwqBEQkcoJnF1b3Q7b2sgJWQmcXVvdDssIG9rKTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAg
wqAgwqBpZiAoIW9rKSB7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoG9mb25vX2Vycm9y
KCZxdW90O1VuYWJsZSBhY3RpdmF0ZSBjb250ZXh0JnF1b3Q7KTs8YnI+CiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgLyo8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICogV2UmIzM5O3Zl
IHJlcG9ydGVkIHN1Y2VzcyBhbHJlYWR5LCBzbyBjYW4mIzM5O3QganVzdCBjYWxsPGJyPgomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIGZhaWxlZF9zZXR1cCB3ZSBjYWxsIG9mb25vX2dwcnNf
Y29udGV4dF9kZWFjdGl2YXRlZCBpbnN0ZWFkLjxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgKiBUaGF0cyBub3QgYSBjbGVhbiBzb2x1dGlvbiBhdCBhbGwsIGJ1dCBhcyBpdCBzZWVtcyB0
aGVyZSBpczxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBubyBjbGVhbiB3YXkgdG8g
ZGV0ZXJtaW5lIHdoZXRoZXIgaXQgaXMgcG9zc2libGUgdG8gYWN0aXZhdGU8YnI+CiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgICogdGhlIGNvbnRleHQgYmVmb3JlIGlzc3VpbmcgQVReU1dXQU4u
IEEgcG9zc2libGUgd29ya2Fyb3VuZDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBt
aWdodCBiZSB0byBpc3N1ZSBBVCtDR0FDVD0xIGFuZCBBVCtDR0FDVD0wIGFuZCB0cnkgaWYgdGhh
dDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiB3b3JrcywgYmVmb3JlIGNhbGxpbmcg
Q0FMTEJBQ0tfV0lUSF9TVUNDRVNTLjxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi88
YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgb2Zvbm9fZ3Byc19jb250ZXh0X2RlYWN0aXZh
dGVkKGdjLCBnY2QtJmd0O2FjdGl2ZV9jb250ZXh0KTs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgZ2NkLSZndDthY3RpdmVfY29udGV4dCA9IDA7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoGdjZC0mZ3Q7c3RhdGUgPSBTVEFURV9JRExFOzxicj4KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm47PGJyPgomZ3Q7ICvCoCDCoCDCoH08YnI+CiZndDsgK8KgIMKgIMKgLyog
V2UmIzM5O3ZlIHJlcG9ydGVkIHN1Y2VzcyBhbHJlYWR5ICovPGJyPgomZ3Q7ICt9PGJyPgomZ3Q7
ICs8YnI+CiZndDsgK3N0YXRpYyB2b2lkIHNldHVwX2NiKGdib29sZWFuIG9rLCBHQXRSZXN1bHQg
KnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKTxicj4KJmd0OyArezxicj4KJmd0OyArwqAgwqAg
wqBzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0ICpnYyA9IHVzZXJfZGF0YTs8YnI+CiZndDsgK8Kg
IMKgIMKgc3RydWN0IGdwcnNfY29udGV4dF9kYXRhICpnY2QgPSBvZm9ub19ncHJzX2NvbnRleHRf
Z2V0X2RhdGEoZ2MpOzxicj4KJmd0OyArwqAgwqAgwqBjaGFyIGJ1ZlszMiArIE9GT05PX0dQUlNf
TUFYX1VTRVJOQU1FX0xFTkdUSCArPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE9GT05PX0dQUlNfTUFYX1BBU1NXT1JEX0xF
TkdUSCArMV07PGJyPgomZ3Q7ICvCoCDCoCDCoHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0gPSBv
Zm9ub19ncHJzX2NvbnRleHRfZ2V0X21vZGVtKGdjKTs8YnI+CiZndDsgK8KgIMKgIMKgY29uc3Qg
Y2hhciAqaW50ZXJmYWNlOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGlmICghb2spIHs8
YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgb2Zvbm9fZXJyb3IoJnF1b3Q7RmFpbGVkIHRv
IHNldHVwIGNvbnRleHQmcXVvdDspOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBmYWls
ZWRfc2V0dXAoZ2MsIHJlc3VsdCwgRkFMU0UpOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm47PGJyPgomZ3Q7ICvCoCDCoCDCoH08YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAg
wqBpZiAoZ2VtYWx0b19nZXRfYXV0aF9jb21tYW5kKG1vZGVtLCBnY2QtJmd0O2FjdGl2ZV9jb250
ZXh0LDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBnY2QtJmd0O2F1dGhfbWV0aG9kLCBnY2QtJmd0O3VzZXJuYW1lLCBnY2QtJmd0O3Bhc3N3b3Jk
LDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBidWYsIHNpemVvZihidWYpKSkgezxi
cj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIWdfYXRfY2hhdF9zZW5kKGdjZC0mZ3Q7
Y2hhdCwgYnVmLCBub25lX3ByZWZpeCwgTlVMTCwgTlVMTCw8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCkpPGJyPgomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyb3I7PGJyPgo8YnI+CmluZGVudGF0aW9uIGlzIHdyb25n
IGhlcmU/PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PnllcywgaSB3aWxsIGZp
eCBpdC48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CiZndDsgK8KgIMKgIMKgfTxicj4K
Jmd0OyArwqAgwqAgwqAvKjxicj4KJmd0OyArwqAgwqAgwqAgKiBub3RlIHRoYXQgaWYgdGhlIGF1
dGggY29tbWFuZCBpcyBub3Qgb2sgd2Ugc2tpcCBpdCBhbmQgY29udGludWU8YnI+CiZndDsgK8Kg
IMKgIMKgICogYnV0IGlmIHRoZSBzZW5kaW5nIGZhaWxzIHdlIGRvIGFuIGVycm9yPGJyPgomZ3Q7
ICvCoCDCoCDCoCAqLzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGlmIChnY2QtJmd0O3Vz
ZV93d2FuKTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBzcHJpbnRmKGJ1ZiwgJnF1b3Q7
QVReU1dXQU49MSwldSZxdW90OywgZ2NkLSZndDthY3RpdmVfY29udGV4dCk7PGJyPgomZ3Q7ICvC
oCDCoCDCoGVsc2U8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgc3ByaW50ZihidWYsICZx
dW90O0FUK0NHQUNUPSV1LDEmcXVvdDssIGdjZC0mZ3Q7YWN0aXZlX2NvbnRleHQpOzxicj4KJmd0
OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGlmIChnX2F0X2NoYXRfc2VuZChnY2QtJmd0O2NoYXQsIGJ1
Ziwgbm9uZV9wcmVmaXgsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFjdGl2YXRlX2NiLCBnYywgTlVMTCkgJmd0OyAwKXs8
YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnRlcmZhY2UgPSBvZm9u
b19tb2RlbV9nZXRfc3RyaW5nKG1vZGVtLCAmcXVvdDtOZXR3b3JrSW50ZXJmYWNlJnF1b3Q7KTs8
YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBvZm9ub19ncHJzX2NvbnRl
eHRfc2V0X2ludGVyZmFjZShnYywgaW50ZXJmYWNlKTs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgb2Zvbm9fZ3Byc19jb250ZXh0X3NldF9pcHY0X2FkZHJlc3MoZ2MsIE5VTEwsIEZBTFNF
KTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAvKjxicj4KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBXZSByZXBvcnQgc3VjZXNzIGFscmVhZHkgaGVyZSBiZWNh
dXNlIHNvbWUgbW9kdWxlcyBuZWVkIGE8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICog
REhDUCByZXF1ZXN0IHRvIGNvbXBsZXRlIHRoZSBBVF5TV1dBTiBjb21tYW5kIHN1Y2Vzc2Z1bGx5
PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAqLzxicj4KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqBnY2QtJmd0O3N0YXRlID0gU1RBVEVfQUNUSVZFOzxicj4KJmd0OyArPGJyPgomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoENBTExCQUNLX1dJVEhfU1VDQ0VTUyhnY2QtJmd0O2NiLCBn
Y2QtJmd0O2NiX2RhdGEpOzxicj4KPGJyPgpTbyB3aHkgYXJlIHlvdSBjYWxsaW5nIFNVQ0NFU1Mg
ZXZlbiBpbiB0aGUgY2FzZSBvZiArQ0dBQ1Q/wqAgwqBBbHNvLCA8YnI+CmNvbnRleHQgYWN0aXZh
dGlvbnMgdmlhICtDR0FDVCBuZWVkIHRvIGJlIHF1ZXJpZWQgZm9yIHN0YXRpYyBJUHMsIG5vPyA8
YnI+CkUuZy4gdmlhICtDR0NPTlRSRFA/wqAgSSBkb24mIzM5O3Qgc2VlIHlvdSBkb2luZyB0aGF0
Ljxicj4KPGJyPgpGdW5kYW1lbnRhbGx5LCB5b3VyIGNvbnRleHQgYWN0aXZhdGlvbiBoYXMgc3Vj
Y2VlZGVkIG9yIGl0IGRpZG4mIzM5O3QuwqAgVGhlIDxicj4KREhDUCBvcGVyYXRpb24gaXMgcHVy
ZWx5IGxvY2FsIGJldHdlZW4gdGhlIG1vZGVtIGFuZCB0aGUgaG9zdC7CoCBObyBvdGhlciA8YnI+
CnZlbmRvciBpbiB0aGUgd29ybGQgaGFzIHRoaXMgd2VpcmQgc2V0dXAgdGhhdCB5b3UgZG8uwqAg
U28gSSBkb24mIzM5O3QgcmVhbGx5IDxicj4Ka25vdyB3aGF0IHRvIHRlbGwgeW91IGhlcmUgYXMg
dGhpcyBeU1dXQU4gaW50ZXJhY3Rpb24gaXMgZnVuZGFtZW50YWxseSA8YnI+CmJyb2tlbiBhbmQg
aXQgY2FuJiMzOTt0IGdvIHVwc3RyZWFtIGluIHRoaXMgZm9ybS48YnI+Cjxicj4KQ2FuIF5TV1dB
TiBzdXBwb3J0IHN0YXRpYyBpcCByZXBvcnRpbmcgaW5zdGVhZCBvZiBESENQP8KgIFRoYXQgd291
bGQgYmUgPGJyPgpwcmVmZXJyZWQgYW55d2F5IGFzIERIQ1AgaXMgc2xvdyBhbmQgdW5uZWVkZWQu
PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoaXMgaXMgYSBkaXNjdXNzaW9u
IGFib3V0IGhvdyBHZW1hbHRvIHByb2R1Y3RzIHdvcmsuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5BZG1pdHRlZGx5LCB0aGVyZSBhcmUgYSBmZXcgbW9kZWxzLCBpbiB0aGUgaGlnaC12b2x1bWUg
bG93LXByaWNlIHJhbmdlIChhbHJlYWR5IGRlcGxveWVkKSw8L2Rpdj48ZGl2PnRoYXQgd29uJiMz
OTt0IHJldHVybiBmcm9tIEFUXlNXV0FOIHVudGlsIGEgREhDUCBleGNoYW5nZSBpcyBwZXJmb3Jt
ZWQsIGFzIHBlciBTZWJhc3RpYW4mIzM5O3MgY29tbWVudCBhYm92ZS48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PlRoZSByZXN0ICh3aGljaCBhcmUgdGhlIGxhcmdlIG1ham9yaXR5KSBvZiB0aGUg
bW9kdWxlcyB3b3VsZCBhbGxvdyBhICYjMzk7c3RhbmRhcmQmIzM5OyB0cmVhdG1lbnQsIGJ1dCBh
bHNvIHdvcmsgd2l0aCB0aGUgY29kZSBhYm92ZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFz
IHBlciBESENQIHZzIHN0YXRpYywgd2UgaGF2ZSBib3RoLCBkZXBlbmRpbmcgb24gdGhlIG1vZHVs
ZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkp1c3QgZm9yIGluZm9ybWF0aW9uLCBJIGhhdmUg
c3RlcHBlZCB1cG9uIG5ldHdvcmtzICpyZXF1aXJpbmcqIERIQ1A6PC9kaXY+PGRpdj5pbiB0aGlz
IGtpbmQgb2YgbmV0d29ya3MsIGFuIE1CSU0gbW9kdWxlIHRoYXQgd291bGQgbm9ybWFsbHkgcmV0
dXJuIGEgc3RhdGljIHNldHRpbmdzLDwvZGl2PjxkaXY+cmV0dXJucyAweDAwIGluIHRoZSAmcXVv
dDtJUHY0IGNvbmZpZ3VyYXRpb24gQXZhaWxhYmxlJnF1b3Q7IGZpZWxkIGluIG9mIHRoZSBJUF9D
T05GSUdVUkFUSU9OIGFuc3dlciw8L2Rpdj48ZGl2Pmluc3RlYWQgb2YgdGhlIHVzdWFsIDB4MEYg
KGFkZHJlc3MsIGdhdGV3YXksIGRucywgbXR1KS48L2Rpdj48ZGl2PlNvLCBpdCBsb29rcyBsaWtl
IHRoYXQgREhDUCBoYXMgdG8gYmUgY29uc2lkZXJlZCBhcyBhIHZhbGlkIGFsdGVybmF0aXZlIGFs
c28gaW4gdGhpcyBjYXNlLjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PldlIGNhbm5vdCBj
aGFuZ2UgZXZlcnkgbW9kdWxlIGFuZCBldmVyeSBuZXR3b3JrIHRvIGZpdCBvdXIgd2lzaGVzLjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QmFjayB0byB0aGUgY29kZSwgSSBkb24mIzM5O3Qgc2Vl
IGEgc29sdXRpb24gYXQgdGhlIG1vbWVudCBvdGhlciB0aGFuIHRoYXQgb25lLjwvZGl2PjxkaXY+
SSBjYW4gYWRkIGFuICYjMzk7aWYmIzM5OyB0byBmaWx0ZXIgb25seSB0aGUgbW9kZWxzIHRoYXQg
bmVlZCBpdCwgYnV0IGNhbm5vdCByZW1vdmUgaXQgY29tcGxldGVseS48YnI+QW5kIHRoaXMgY29k
ZSB3b3VsZCBiZSBzcGVjaWZpYyBmb3IgdGhlIGRyaXZlciwgSSBkb24mIzM5O3Qgc2VlIHdoeSBp
dCBjb3VsZG4mIzM5O3QgZ28gdXBzdHJlYW0uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPgo8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm47PGJyPgomZ3Q7ICvCoCDCoCDCoH08YnI+CiZndDsgKzxicj4KJmd0OyArZXJyb3I6PGJy
PgomZ3Q7ICvCoCDCoCDCoGZhaWxlZF9zZXR1cChnYywgTlVMTCwgRkFMU0UpOzxicj4KJmd0OyAr
fTxicj4KJmd0OyArPGJyPgomZ3Q7ICtzdGF0aWMgdm9pZCBnZW1hbHRvd3dhbl9ncHJzX2FjdGl2
YXRlX3ByaW1hcnkoc3RydWN0IG9mb25vX2dwcnNfY29udGV4dCAqZ2MsPGJyPgomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IHN0cnVjdCBvZm9u
b19ncHJzX3ByaW1hcnlfY29udGV4dCAqY3R4LDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvZm9ub19ncHJzX2NvbnRleHRfY2JfdCBjYiwgdm9p
ZCAqZGF0YSk8YnI+CiZndDsgK3s8YnI+CiZndDsgK8KgIMKgIMKgc3RydWN0IGdwcnNfY29udGV4
dF9kYXRhICpnY2QgPSBvZm9ub19ncHJzX2NvbnRleHRfZ2V0X2RhdGEoZ2MpOzxicj4KJmd0OyAr
wqAgwqAgwqBjaGFyIGJ1ZltPRk9OT19HUFJTX01BWF9BUE5fTEVOR1RIICsgMTI4XTs8YnI+CiZn
dDsgK8KgIMKgIMKgc3RydWN0IG9mb25vX21vZGVtICptb2RlbSA9IG9mb25vX2dwcnNfY29udGV4
dF9nZXRfbW9kZW0oZ2MpOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoERCRygmcXVvdDtj
aWQgJXUmcXVvdDssIGN0eC0mZ3Q7Y2lkKTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBn
Y2QtJmd0O3VzZV93d2FuID0gb2Zvbm9fbW9kZW1fZ2V0X2ludGVnZXIobW9kZW0sICZxdW90O0dl
bWFsdG9fV1dBTiZxdW90Oyk7PGJyPgomZ3Q7ICvCoCDCoCDCoGdjZC0mZ3Q7YWN0aXZlX2NvbnRl
eHQgPSBjdHgtJmd0O2NpZDs8YnI+CiZndDsgK8KgIMKgIMKgZ2NkLSZndDtjYiA9IGNiOzxicj4K
Jmd0OyArwqAgwqAgwqBnY2QtJmd0O2NiX2RhdGEgPSBkYXRhOzxicj4KJmd0OyArwqAgwqAgwqBt
ZW1jcHkoZ2NkLSZndDt1c2VybmFtZSwgY3R4LSZndDt1c2VybmFtZSwgc2l6ZW9mKGN0eC0mZ3Q7
dXNlcm5hbWUpKTs8YnI+CiZndDsgK8KgIMKgIMKgbWVtY3B5KGdjZC0mZ3Q7cGFzc3dvcmQsIGN0
eC0mZ3Q7cGFzc3dvcmQsIHNpemVvZihjdHgtJmd0O3Bhc3N3b3JkKSk7PGJyPgomZ3Q7ICvCoCDC
oCDCoGdjZC0mZ3Q7c3RhdGUgPSBTVEFURV9FTkFCTElORzs8YnI+CiZndDsgK8KgIMKgIMKgZ2Nk
LSZndDtwcm90byA9IGN0eC0mZ3Q7cHJvdG87PGJyPgomZ3Q7ICvCoCDCoCDCoGdjZC0mZ3Q7YXV0
aF9tZXRob2QgPSBjdHgtJmd0O2F1dGhfbWV0aG9kOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDC
oCDCoGdlbWFsdG9fZ2V0X2NnZGNvbnRfY29tbWFuZChtb2RlbSwgY3R4LSZndDtjaWQsIGN0eC0m
Z3Q7cHJvdG8sIGN0eC0mZ3Q7YXBuLCBidWYsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHNpemVvZihidWYpKTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAg
wqBpZiAoZ19hdF9jaGF0X3NlbmQoZ2NkLSZndDtjaGF0LCBidWYsIG5vbmVfcHJlZml4LDxicj4K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZXR1cF9j
YiwgZ2MsIE5VTEwpICZndDsgMCk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
Ozxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoENBTExCQUNLX1dJVEhfRkFJTFVSRShjYiwg
ZGF0YSk7PGJyPgomZ3Q7ICt9PGJyPgomZ3Q7ICs8YnI+CiZndDsgK3N0YXRpYyB2b2lkIGRlYWN0
aXZhdGVfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2Rh
dGEpPGJyPgomZ3Q7ICt7PGJyPgomZ3Q7ICvCoCDCoCDCoHN0cnVjdCBvZm9ub19ncHJzX2NvbnRl
eHQgKmdjID0gdXNlcl9kYXRhOzxicj4KJmd0OyArwqAgwqAgwqBzdHJ1Y3QgZ3Byc19jb250ZXh0
X2RhdGEgKmdjZCA9IG9mb25vX2dwcnNfY29udGV4dF9nZXRfZGF0YShnYyk7PGJyPgomZ3Q7ICs8
YnI+CiZndDsgK8KgIMKgIMKgREJHKCZxdW90O29rICVkJnF1b3Q7LCBvayk7PGJyPgomZ3Q7ICs8
YnI+CiZndDsgK8KgIMKgIMKgZ2NkLSZndDthY3RpdmVfY29udGV4dCA9IDA7PGJyPgomZ3Q7ICvC
oCDCoCDCoGdjZC0mZ3Q7c3RhdGUgPSBTVEFURV9JRExFOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvC
oCDCoCDCoENBTExCQUNLX1dJVEhfU1VDQ0VTUyhnY2QtJmd0O2NiLCBnY2QtJmd0O2NiX2RhdGEp
Ozxicj4KJmd0OyArfTxicj4KJmd0OyArPGJyPgomZ3Q7ICtzdGF0aWMgdm9pZCBnZW1hbHRvd3dh
bl9ncHJzX2RlYWN0aXZhdGVfcHJpbWFyeShzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0ICpnYyw8
YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgdW5zaWduZWQgaW50IGNpZCw8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb2Zvbm9fZ3Byc19jb250ZXh0X2Ni
X3QgY2IsIHZvaWQgKmRhdGEpPGJyPgomZ3Q7ICt7PGJyPgomZ3Q7ICvCoCDCoCDCoHN0cnVjdCBn
cHJzX2NvbnRleHRfZGF0YSAqZ2NkID0gb2Zvbm9fZ3Byc19jb250ZXh0X2dldF9kYXRhKGdjKTs8
YnI+CiZndDsgK8KgIMKgIMKgY2hhciBidWZbNjRdOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDC
oCDCoERCRygmcXVvdDtjaWQgJXUmcXVvdDssIGNpZCk7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8Kg
IMKgIMKgZ2NkLSZndDtzdGF0ZSA9IFNUQVRFX0RJU0FCTElORzs8YnI+CiZndDsgK8KgIMKgIMKg
Z2NkLSZndDtjYiA9IGNiOzxicj4KJmd0OyArwqAgwqAgwqBnY2QtJmd0O2NiX2RhdGEgPSBkYXRh
Ozxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGlmIChnY2QtJmd0O3VzZV93d2FuKTxicj4K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBzcHJpbnRmKGJ1ZiwgJnF1b3Q7QVReU1dXQU49MCwl
dSZxdW90OywgZ2NkLSZndDthY3RpdmVfY29udGV4dCk7PGJyPgomZ3Q7ICvCoCDCoCDCoGVsc2U8
YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgc3ByaW50ZihidWYsICZxdW90O0FUK0NHQUNU
PSV1LDAmcXVvdDssIGdjZC0mZ3Q7YWN0aXZlX2NvbnRleHQpOzxicj4KJmd0OyArPGJyPgomZ3Q7
ICvCoCDCoCDCoGlmIChnX2F0X2NoYXRfc2VuZChnY2QtJmd0O2NoYXQsIGJ1Ziwgbm9uZV9wcmVm
aXgsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGRlYWN0aXZhdGVfY2IsIGdjLCBOVUxMKSAmZ3Q7IDApPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybjs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBDQUxMQkFDS19XSVRI
X1NVQ0NFU1MoY2IsIGRhdGEpOzxicj4KJmd0OyArfTxicj4KJmd0OyArPGJyPgomZ3Q7ICtzdGF0
aWMgdm9pZCBjZ2V2X25vdGlmeShHQXRSZXN1bHQgKnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRh
KTxicj4KJmd0OyArezxicj4KJmd0OyArwqAgwqAgwqBzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0
ICpnYyA9IHVzZXJfZGF0YTs8YnI+CiZndDsgK8KgIMKgIMKgc3RydWN0IGdwcnNfY29udGV4dF9k
YXRhICpnY2QgPSBvZm9ub19ncHJzX2NvbnRleHRfZ2V0X2RhdGEoZ2MpOzxicj4KJmd0OyArwqAg
wqAgwqBjb25zdCBjaGFyICpldmVudDs8YnI+CiZndDsgK8KgIMKgIMKgaW50IGNpZCA9IDA7PGJy
PgomZ3Q7ICvCoCDCoCDCoEdBdFJlc3VsdEl0ZXIgaXRlcjs8YnI+CiZndDsgKzxicj4KJmd0OyAr
wqAgwqAgwqBnX2F0X3Jlc3VsdF9pdGVyX2luaXQoJmFtcDtpdGVyLCByZXN1bHQpOzxicj4KJmd0
OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0KCZhbXA7aXRl
ciwgJnF1b3Q7K0NHRVY6JnF1b3Q7KSk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0
dXJuOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGlmICghZ19hdF9yZXN1bHRfaXRlcl9u
ZXh0X3VucXVvdGVkX3N0cmluZygmYW1wO2l0ZXIsICZhbXA7ZXZlbnQpKTxicj4KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgaWYg
KCFnX3N0cl9oYXNfcHJlZml4KGV2ZW50LCAmcXVvdDtNRSBQRE4gREVBQ1QmcXVvdDspKTxicj4K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8Kg
IMKgIMKgc3NjYW5mKGV2ZW50LCAmcXVvdDslKnMgJSpzICUqcyAldSZxdW90OywgJmFtcDtjaWQp
Ozxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoERCRygmcXVvdDtjaWQgJWQmcXVvdDssIGNp
ZCk7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgaWYgKCh1bnNpZ25lZCBpbnQpIGNpZCAh
PSBnY2QtJmd0O2FjdGl2ZV9jb250ZXh0KTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm47PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgb2Zvbm9fZ3Byc19jb250ZXh0X2Rl
YWN0aXZhdGVkKGdjLCBnY2QtJmd0O2FjdGl2ZV9jb250ZXh0KTs8YnI+CiZndDsgKzxicj4KJmd0
OyArwqAgwqAgwqBnY2QtJmd0O2FjdGl2ZV9jb250ZXh0ID0gMDs8YnI+CiZndDsgK8KgIMKgIMKg
Z2NkLSZndDtzdGF0ZSA9IFNUQVRFX0lETEU7PGJyPgomZ3Q7ICt9PGJyPgomZ3Q7ICs8YnI+CiZn
dDsgK3N0YXRpYyBpbnQgZ2VtYWx0b3d3YW5fZ3Byc19jb250ZXh0X3Byb2JlKHN0cnVjdCBvZm9u
b19ncHJzX2NvbnRleHQgKmdjLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgbW9kZWwsIHZvaWQgKmRh
dGEpPGJyPgomZ3Q7ICt7PGJyPgomZ3Q7ICvCoCDCoCDCoEdBdENoYXQgKmNoYXQgPSBkYXRhOzxi
cj4KJmd0OyArwqAgwqAgwqBzdHJ1Y3QgZ3Byc19jb250ZXh0X2RhdGEgKmdjZDs8YnI+CiZndDsg
K8KgIMKgIMKgc3RydWN0IG9mb25vX21vZGVtICptb2RlbSA9IG9mb25vX2dwcnNfY29udGV4dF9n
ZXRfbW9kZW0oZ2MpOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoERCRygmcXVvdDsmcXVv
dDspOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGdjZCA9IGdfdHJ5X25ldzAoc3RydWN0
IGdwcnNfY29udGV4dF9kYXRhLCAxKTs8YnI+CiZndDsgK8KgIMKgIMKgaWYgKGdjZCA9PSBOVUxM
KTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVOT01FTTs8YnI+CiZndDsg
Kzxicj4KJmd0OyArwqAgwqAgwqBpZiAobW9kZW0pPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoGdjZC0mZ3Q7dXNlX3d3YW4gPSBvZm9ub19tb2RlbV9nZXRfaW50ZWdlcihtb2RlbSwgJnF1
b3Q7R2VtYWx0b19XV0FOJnF1b3Q7KTs8YnI+CiZndDsgK8KgIMKgIMKgZ2NkLSZndDtjaGF0ID0g
Z19hdF9jaGF0X2Nsb25lKGNoYXQpOzxicj4KJmd0OyArwqAgwqAgwqBvZm9ub19ncHJzX2NvbnRl
eHRfc2V0X2RhdGEoZ2MsIGdjZCk7PGJyPgomZ3Q7ICvCoCDCoCDCoGdfYXRfY2hhdF9yZWdpc3Rl
cihjaGF0LCAmcXVvdDsrQ0dFVjomcXVvdDssIGNnZXZfbm90aWZ5LCBGQUxTRSwgZ2MsIE5VTEwp
Ozxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoHJldHVybiAwOzxicj4KJmd0OyArfTxicj4K
Jmd0OyArPGJyPgomZ3Q7ICtzdGF0aWMgdm9pZCBnZW1hbHRvd3dhbl9ncHJzX2NvbnRleHRfcmVt
b3ZlKHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHQgKmdjKTxicj4KJmd0OyArezxicj4KJmd0OyAr
wqAgwqAgwqBzdHJ1Y3QgZ3Byc19jb250ZXh0X2RhdGEgKmdjZCA9IG9mb25vX2dwcnNfY29udGV4
dF9nZXRfZGF0YShnYyk7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgREJHKCZxdW90OyZx
dW90Oyk7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgb2Zvbm9fZ3Byc19jb250ZXh0X3Nl
dF9kYXRhKGdjLCBOVUxMKTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBnX2F0X2NoYXRf
dW5yZWYoZ2NkLSZndDtjaGF0KTs8YnI+CiZndDsgK8KgIMKgIMKgZ19mcmVlKGdjZCk7PGJyPgom
Z3Q7ICt9PGJyPgomZ3Q7ICs8YnI+CiZndDsgK3N0YXRpYyB2b2lkIGdlbWFsdG93d2FuX2dwcnNf
ZGV0YWNoX3NodXRkb3duKHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHQgKmdjLDxicj4KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1
bnNpZ25lZCBpbnQgY2lkKTxicj4KJmd0OyArezxicj4KJmd0OyArwqAgwqAgwqBEQkcoJnF1b3Q7
Y2lkICV1JnF1b3Q7LCBjaWQpOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoG9mb25vX2dw
cnNfY29udGV4dF9kZWFjdGl2YXRlZChnYywgY2lkKTs8YnI+CiZndDsgK308YnI+CiZndDsgKzxi
cj4KJmd0OyArc3RhdGljIHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyIGRyaXZlciA9
IHs8YnI+CiZndDsgK8KgIMKgIMKgLm5hbWXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoD0g
JnF1b3Q7Z2VtYWx0b3d3YW5tb2RlbSZxdW90Oyw8YnI+CiZndDsgK8KgIMKgIMKgLnByb2JlwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPSBnZW1hbHRvd3dhbl9ncHJzX2NvbnRleHRfcHJvYmUs
PGJyPgomZ3Q7ICvCoCDCoCDCoC5yZW1vdmXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoD0gZ2Vt
YWx0b3d3YW5fZ3Byc19jb250ZXh0X3JlbW92ZSw8YnI+CiZndDsgK8KgIMKgIMKgLmFjdGl2YXRl
X3ByaW1hcnnCoCDCoCDCoCDCoD0gZ2VtYWx0b3d3YW5fZ3Byc19hY3RpdmF0ZV9wcmltYXJ5LDxi
cj4KJmd0OyArwqAgwqAgwqAuZGVhY3RpdmF0ZV9wcmltYXJ5wqAgwqAgwqA9IGdlbWFsdG93d2Fu
X2dwcnNfZGVhY3RpdmF0ZV9wcmltYXJ5LDxicj4KJmd0OyArwqAgwqAgwqAuZGV0YWNoX3NodXRk
b3duwqAgwqAgwqAgwqAgPSBnZW1hbHRvd3dhbl9ncHJzX2RldGFjaF9zaHV0ZG93biw8YnI+CiZn
dDsgK307PGJyPgomZ3Q7ICs8YnI+CiZndDsgK3ZvaWQgZ2VtYWx0b3d3YW5fZ3Byc19jb250ZXh0
X2luaXQodm9pZCk8YnI+CiZndDsgK3s8YnI+CiZndDsgK8KgIMKgIMKgb2Zvbm9fZ3Byc19jb250
ZXh0X2RyaXZlcl9yZWdpc3RlcigmYW1wO2RyaXZlcik7PGJyPgomZ3Q7ICt9PGJyPgomZ3Q7ICs8
YnI+CiZndDsgK3ZvaWQgZ2VtYWx0b3d3YW5fZ3Byc19jb250ZXh0X2V4aXQodm9pZCk8YnI+CiZn
dDsgK3s8YnI+CiZndDsgK8KgIMKgIMKgb2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlcl91bnJlZ2lz
dGVyKCZhbXA7ZHJpdmVyKTs8YnI+CiZndDsgK308YnI+CiZndDsgPGJyPgo8YnI+ClJlZ2FyZHMs
PGJyPgotRGVuaXM8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8
L2Rpdj48ZGl2PkdpYWNpbnRvPC9kaXY+PGRpdj7CoDwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============2152354741860230807==--

