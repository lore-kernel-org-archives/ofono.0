Content-Type: multipart/mixed; boundary="===============6339595286444156461=="
MIME-Version: 1.0
From: Marit Sofie Henriksen <maritsofie.henriksen8@gmail.com>
Subject: Re: [PATCH] unit: Added unit test for STE
Date: Thu, 24 Feb 2011 10:04:22 +0100
Message-ID: <AANLkTincwj200CBrcxH2B=syvxw-CFZT_AWH+rP-Bnc1@mail.gmail.com>
In-Reply-To: <1297759781-3113-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6339595286444156461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/2/15 Marit Henriksen <tomasz.gregorek@gmail.com>

> From: Marit Henriksen <marit.henriksen@stericsson.com>
>
>
Hi,
has anyone had the time to look at this patch?

br Marit



> ---
>  Makefile.am     |   17 +-
>  unit/test-ste.c | 1153
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 1169 insertions(+), 1 deletions(-)
>  create mode 100755 unit/test-ste.c
>
> diff --git a/Makefile.am b/Makefile.am
> index 42ad86f..0806e1e 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -499,7 +499,7 @@ dist_man_MANS =3D doc/ofonod.8
>  noinst_PROGRAMS =3D unit/test-common unit/test-util unit/test-idmap \
>                                        unit/test-sms unit/test-simutil \
>                                        unit/test-mux unit/test-caif \
> -                                       unit/test-stkutil
> +                                       unit/test-stkutil unit/test-ste
>
>  unit_objects =3D
>
> @@ -540,6 +540,21 @@ unit_test_caif_SOURCES =3D unit/test-caif.c
> $(gatchat_sources) \
>  unit_test_caif_LDADD =3D @GLIB_LIBS@
>  unit_objects +=3D $(unit_test_caif_OBJECTS)
>
> +unit_test_ste_SOURCES =3D unit/test-ste.c $(gatchat_sources) \
> +                                       $(gdbus_sources) $(local_headers)=
 \
> +                                       src/common.c src/util.c \
> +                                       drivers/stemodem/stemodem.h \
> +                                       drivers/atmodem/atutil.h \
> +                                       drivers/atmodem/atutil.c \
> +                                       drivers/stemodem/radio-settings.c=
 \
> +                                       drivers/stemodem/gprs-context.c \
> +                                       drivers/stemodem/voicecall.c \
> +                                       drivers/stemodem/caif_socket.h \
> +                                       drivers/stemodem/if_caif.h
> +
> +unit_test_ste_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
> +unit_objects +=3D $(unit_test_ste_OBJECTS)
> +
>  if TOOLS
>  noinst_PROGRAMS +=3D tools/huawei-audio tools/auto-enable
>
> diff --git a/unit/test-ste.c b/unit/test-ste.c
> new file mode 100755
> index 0000000..b078aaf
> --- /dev/null
> +++ b/unit/test-ste.c
> @@ -0,0 +1,1153 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010 ST-Ericsson AB.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
>  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <glib.h>
> +#include <gatchat.h>
> +#include <gatresult.h>
> +#include <log.h>
> +#include <ofono/modem.h>
> +#include <ofono/voicecall.h>
> +#include <ofono/radio-settings.h>
> +#include <ofono/gprs-context.h>
> +#include <drivers/stemodem/stemodem.h>
> +#include <drivers/stemodem/caif_rtnl.h>
> +#include "common.h"
> +
> +/* Generic test code decls */
> +static GAtChat *chat;
> +static GMainLoop *event_loop;
> +static int phone_fd;
> +
> +#define ASSERT_AT(s) g_assert(assert_at(s));
> +
> +/* Send a simulated AT response */
> +static void at_response(char *resp)
> +{
> +       int r;
> +
> +       /*
> +        * Send AT response to g_at_chat and give main look a kick to run
> +        * one iteration.
> +        */
> +       r =3D write(phone_fd, resp, strlen(resp));
> +       g_assert(r > 0);
> +       (void)g_main_context_iteration(NULL, TRUE);
> +}
> +
> +static gboolean assert_at(char *match)
> +{
> +       char req[256];
> +       int r;
> +
> +       if (g_main_context_iteration(NULL, TRUE) =3D=3D TRUE) {
> +
> +               /* Read what g_at_chan has written to "modem" */
> +               r =3D read(phone_fd, req, sizeof(req));
> +
> +               if (r > 1)
> +                       req[r-1] =3D 0;
> +
> +               if (strcmp(match, req) =3D=3D 0)
> +                       return TRUE;
> +       }
> +
> +       g_print("AT request did not match:%s !=3D %s\n", match, req);
> +       return FALSE;
> +}
> +
> +
> +/* Stubs from src/voicecall.c */
> +struct ofono_voicecall;
> +const struct ofono_voicecall_driver *voicecall_driver;
> +void *voicecall_data;
> +static unsigned int expected_id;
> +static int expected_status;
> +static char expected_number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
> +static int expected_reason;
> +
> +void ofono_voicecall_register(struct ofono_voicecall *vc)
> +{
> +}
> +
> +void ofono_voicecall_remove(struct ofono_voicecall *vc)
> +{
> +}
> +
> +int ofono_voicecall_driver_register(const struct ofono_voicecall_driver
> *d)
> +{
> +       voicecall_driver =3D d;
> +       return 0;
> +}
> +
> +void ofono_voicecall_driver_unregister(const struct ofono_voicecall_driv=
er
> *d)
> +{
> +}
> +
> +void ofono_voicecall_set_data(struct ofono_voicecall *vc, void *data)
> +{
> +       voicecall_data =3D data;
> +}
> +
> +void *ofono_voicecall_get_data(struct ofono_voicecall *vc)
> +{
> +       return voicecall_data;
> +}
> +
> +void ofono_voicecall_notify(struct ofono_voicecall *vc,
> +                               const struct ofono_call *call)
> +{
> +       g_assert_cmpint(expected_id, =3D=3D, call->id);
> +       g_assert_cmpint(expected_status, =3D=3D, call->status);
> +       g_assert_cmpstr(expected_number, =3D=3D, call->phone_number.numbe=
r);
> +}
> +
> +void ofono_voicecall_disconnected(struct ofono_voicecall *vc, int id,
> +                               enum ofono_disconnect_reason reason,
> +                               const struct ofono_error *error)
> +{
> +       g_assert_cmpint(expected_id, =3D=3D, id);
> +       g_assert_cmpint(expected_reason, =3D=3D, reason);
> +       g_assert(error =3D=3D NULL);
> +}
> +
> +/* Stubs from src/radio-settings.c */
> +struct ofono_radio_settings;
> +const struct ofono_radio_settings_driver *radio_settings_driver;
> +void *radio_settings_data;
> +
> +void ofono_radio_settings_register(struct ofono_radio_settings *rs)
> +{
> +}
> +
> +void ofono_radio_settings_remove(struct ofono_radio_settings *rs)
> +{
> +}
> +
> +void ofono_radio_settings_set_data(struct ofono_radio_settings *rs, void
> *data)
> +{
> +       radio_settings_data =3D data;
> +}
> +
> +void *ofono_radio_settings_get_data(struct ofono_radio_settings *rs)
> +{
> +       return radio_settings_data;
> +}
> +
> +int ofono_radio_settings_driver_register(
> +                               const struct ofono_radio_settings_driver
> *d)
> +{
> +       radio_settings_driver =3D d;
> +       return 0;
> +}
> +
> +void ofono_radio_settings_driver_unregister(
> +                               const struct ofono_radio_settings_driver
> *d)
> +{
> +}
> +
> +/* Stubs from src/gprs-context.c */
> +struct ofono_gprs_context;
> +const struct ofono_gprs_context_driver *gprs_context_driver;
> +void *gprs_context_data;
> +
> +int caif_rtnl_create_interface(int type, int connid, int loop,
> +                               caif_rtnl_create_cb_t cb, void *user_data)
> +{
> +       cb(0, "caif0", user_data);
> +       return 0;
> +}
> +
> +int caif_rtnl_delete_interface(int ifid)
> +{
> +       return 0;
> +}
> +
> +int caif_rtnl_init(void)
> +{
> +       return 0;
> +}
> +
> +void caif_rtnl_exit(void)
> +{
> +}
> +
> +void ofono_gprs_context_remove(struct ofono_gprs_context *rs)
> +{
> +}
> +
> +void ofono_gprs_context_set_data(struct ofono_gprs_context *rs, void
> *data)
> +{
> +       gprs_context_data =3D data;
> +}
> +
> +void *ofono_gprs_context_get_data(struct ofono_gprs_context *rs)
> +{
> +       return gprs_context_data;
> +}
> +
> +int ofono_gprs_context_driver_register(
> +                               const struct ofono_gprs_context_driver *d)
> +{
> +       gprs_context_driver =3D d;
> +       return 0;
> +}
> +
> +void ofono_gprs_context_driver_unregister(
> +                               const struct ofono_gprs_context_driver *d)
> +{
> +}
> +
> +void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
> +                                       unsigned int cid)
> +{
> +}
> +
> +/* Test Fixture for context activation */
> +static struct ofono_gprs_primary_context ctx =3D {
> +       5, 1, "apn", "user", "pwd", OFONO_GPRS_PROTO_IP
> +};
> +
> +/*
> + * These vars are used to validate test case and are
> + * checked in callback functions.
> + */
> +static enum ofono_error_type expected_errtype;
> +static int expected_error;
> +
> +static void gprs_context_up_cb(const struct ofono_error *error,
> +                               const char *interface, ofono_bool_t
> static_ip,
> +                               const char *address, const char *netmask,
> +                               const char *gw, const char **dns, void
> *data)
> +{
> +       g_assert_cmpint(expected_errtype, =3D=3D, error->type);
> +}
> +
> +static void ofono_generic_cb(const struct ofono_error *error, void *data)
> +{
> +       g_assert_cmpint(expected_errtype, =3D=3D, error->type);
> +       g_assert_cmpint(expected_error, =3D=3D, error->error);
> +
> +}
> +
> +static void gprs_activate_helper(void)
> +{
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +
> +       gprs_context_driver->
> +               activate_primary(0, &ctx,
> +                                (ofono_gprs_context_up_cb_t)
> +                                gprs_context_up_cb, 0);
> +
> +       ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
> +       at_response("\r\nOK\r\n");
> +
> +       ASSERT_AT("AT*EIAAUW=3D5,1,\"user\",\"pwd\"");
> +       at_response("\r\nOK\r\n");
> +
> +       ASSERT_AT("AT*EPPSD=3D1,1,5");
> +       at_response(
> +                       "\r\n"
> +                       "<?xml version=3D\"1.0\"?>\r\n"
> +                       "<connection_parameters>\r\n"
> +                       "<ip_address>10.64.151.14</ip_address>\r\n"
> +                       "<subnet_mask>255.255.255.255</subnet_mask>\r\n"
> +                       "<mtu>1500</mtu>\r\n"
> +                       "<dns_server>10.64.148.4</dns_server>\r\n"
> +                       "<dns_server>10.64.148.5</dns_server>\r\n"
> +                       "</connection_parameters>\r\n"
> +                       "\r\nOK\r\n");
> +}
> +
> +static void test_gprs_normal(void)
> +{
> +       ste_gprs_context_init();
> +
> +       gprs_context_driver->probe(NULL, 0, chat);
> +       gprs_activate_helper();
> +
> +       gprs_context_driver->remove(gprs_context_data);
> +       ste_gprs_context_exit();
> +}
> +
> +static void test_gprs_deactivate(void)
> +{
> +       ste_gprs_context_init();
> +
> +       gprs_context_driver->probe(NULL, 0, chat);
> +       gprs_activate_helper();
> +
> +       gprs_context_driver->
> +               deactivate_primary(0, ctx.cid,
> +                                (ofono_gprs_context_cb_t)
> +                                ofono_generic_cb, 0);
> +       ASSERT_AT("AT*EPPSD=3D0,1,5");
> +       at_response("\r\nOK\r\n");
> +
> +       gprs_context_driver->remove(gprs_context_data);
> +       ste_gprs_context_exit();
> +}
> +
> +static void test_gprs_nw_deact(void)
> +{
> +       ste_gprs_context_init();
> +
> +       gprs_context_driver->probe(NULL, 0, chat);
> +       gprs_activate_helper();
> +
> +       at_response("\r\n+CGEV: NW DEACT \r\n");
> +       ASSERT_AT("AT+CGACT?");
> +       at_response("\r\n+CGACT: 5,0\r\nOK\r\n");
> +
> +       gprs_context_driver->remove(gprs_context_data);
> +       ste_gprs_context_exit();
> +}
> +
> +static void test_gprs_deactivate_fail(void)
> +{
> +       ste_gprs_context_init();
> +
> +       gprs_context_driver->probe(NULL, 0, chat);
> +       gprs_activate_helper();
> +
> +       gprs_context_driver->
> +               deactivate_primary(0, ctx.cid,
> +                                (ofono_gprs_context_cb_t)
> +                                ofono_generic_cb, 0);
> +       ASSERT_AT("AT*EPPSD=3D0,1,5");
> +       expected_errtype =3D OFONO_ERROR_TYPE_CME;
> +       expected_error =3D 100;
> +       at_response("\r\n+CME ERROR:100\r\n");
> +
> +       gprs_context_driver->remove(gprs_context_data);
> +       ste_gprs_context_exit();
> +}
> +
> +static void test_gprs_deactivate_err(void)
> +{
> +       ste_gprs_context_init();
> +
> +       gprs_context_driver->probe(NULL, 0, chat);
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
> +       expected_error =3D 0;
> +       gprs_context_driver->
> +               deactivate_primary(0, ctx.cid,
> +                                (ofono_gprs_context_cb_t)
> +                                ofono_generic_cb, 0);
> +
> +       gprs_context_driver->remove(gprs_context_data);
> +       ste_gprs_context_exit();
> +}
> +
> +static void test_gprs_deact_fail_then_ok(void)
> +{
> +       ste_gprs_context_init();
> +
> +       gprs_context_driver->probe(NULL, 0, chat);
> +       gprs_activate_helper();
> +
> +       gprs_context_driver->
> +               deactivate_primary(0, ctx.cid,
> +                                (ofono_gprs_context_cb_t)
> +                                ofono_generic_cb, 0);
> +       expected_errtype =3D OFONO_ERROR_TYPE_CME;
> +       expected_error =3D 100;
> +       at_response("\r\n+CME ERROR:100\r\n");
> +
> +       gprs_context_driver->
> +               deactivate_primary(0, ctx.cid,
> +                                (ofono_gprs_context_cb_t)
> +                                ofono_generic_cb, 0);
> +       ASSERT_AT("AT*EPPSD=3D0,1,5");
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +       at_response("\r\nOK\r\n");
> +
> +       gprs_context_driver->remove(gprs_context_data);
> +       ste_gprs_context_exit();
> +}
> +
> +static void test_gprs_eppsd_err(void)
> +{
> +       ste_gprs_context_init();
> +
> +       gprs_context_driver->probe(NULL, 0, chat);
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       gprs_context_driver->
> +               activate_primary(0, &ctx,
> +                                (ofono_gprs_context_up_cb_t)
> +                                gprs_context_up_cb, 0);
> +       ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
> +       at_response("\r\nOK\r\n");
> +       ASSERT_AT("AT*EIAAUW=3D5,1,\"user\",\"pwd\"");
> +       at_response("\r\nOK\r\n");
> +
> +       ASSERT_AT("AT*EPPSD=3D1,1,5");
> +       expected_errtype =3D OFONO_ERROR_TYPE_CME;
> +       expected_error =3D 100;
> +       at_response("\r\n+CME ERROR:100\r\n");
> +
> +       gprs_context_driver->remove(gprs_context_data);
> +       ste_gprs_context_exit();
> +}
> +
> +static void test_gprs_cgdcont_err(void)
> +{
> +       ste_gprs_context_init();
> +
> +       gprs_context_driver->probe(NULL, 0, chat);
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       gprs_context_driver->
> +               activate_primary(0, &ctx,
> +                                (ofono_gprs_context_up_cb_t)
> +                                gprs_context_up_cb, 0);
> +       ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
> +       expected_errtype =3D OFONO_ERROR_TYPE_CME;
> +       expected_error =3D 100;
> +       at_response("\r\n+CME ERROR:100\r\n");
> +
> +       gprs_context_driver->remove(gprs_context_data);
> +       ste_gprs_context_exit();
> +}
> +
> +static void test_gprs_xmlerr(void)
> +{
> +       ste_gprs_context_init();
> +
> +       gprs_context_driver->probe(NULL, 0, chat);
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       gprs_context_driver->
> +               activate_primary(0, &ctx,
> +                                (ofono_gprs_context_up_cb_t)
> +                                gprs_context_up_cb, 0);
> +       ASSERT_AT("AT+CGDCONT=3D5,\"IP\",\"apn\"");
> +       at_response("\r\nOK\r\n");
> +
> +       ASSERT_AT("AT*EIAAUW=3D5,1,\"user\",\"pwd\"");
> +       at_response("\r\nOK\r\n");
> +
> +       ASSERT_AT("AT*EPPSD=3D1,1,5");
> +       expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
> +       expected_error =3D 0;
> +       at_response(
> +                       "\r\n"
> +                       "<?xml version=3D\"1.0\"?>\r\n"
> +                       "<connection_parameters>\r\n"
> +                       "XML-ERROR"
> +                       "\r\nOK\r\n");
> +
> +       gprs_context_driver->remove(gprs_context_data);
> +       ste_gprs_context_exit();
> +}
> +
> +static enum ofono_radio_access_mode expected_mode;
> +
> +static void radio_rat_mode_query_callback(const struct ofono_error *erro=
r,
> +                                       enum ofono_radio_access_mode mode,
> +                                       void *data)
> +{
> +       g_assert_cmpint(expected_errtype, =3D=3D, error->type);
> +       g_assert_cmpint(expected_mode, =3D=3D, mode);
> +}
> +
> +
> +#define QUERY_RAT()                                    \
> +       do {                                            \
> +               radio_settings_driver->         \
> +                       query_rat_mode(0,               \
> +                               (ofono_radio_settings_rat_mode_query_cb_t)
> \
> +                                       radio_rat_mode_query_callback, 0);
> \
> +               ASSERT_AT("AT+CFUN?");                  \
> +       } while (0)
> +
> +static void test_radiosettings_all(void)
> +{
> +       ste_radio_settings_init();
> +
> +       radio_settings_driver->probe(NULL, 0, chat);
> +
> +       /* Normal Cases */
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
> +       QUERY_RAT();
> +       at_response("\r\n+CFUN: 1\r\n\r\nOK\r\n");
> +
> +       QUERY_RAT();
> +       expected_mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
> +       at_response("\r\n+CFUN: 5\r\n\r\nOK\r\n");
> +
> +       QUERY_RAT();
> +       expected_mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
> +       at_response("\r\n+CFUN: 6\r\n\r\nOK\r\n");
> +
> +       /* Unexpected values */
> +       expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
> +       expected_mode =3D -1;
> +       QUERY_RAT();
> +       at_response("\r\n+CFUN: 0\r\n\r\nOK\r\n");
> +
> +       QUERY_RAT();
> +       at_response("\r\n+CFUN: 4\r\n\r\nOK\r\n");
> +
> +       QUERY_RAT();
> +       at_response("\r\n+CFUN: 11\r\n\r\nOK\r\n");
> +
> +       /* Error cases */
> +       QUERY_RAT();
> +       expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
> +       expected_mode =3D -1;
> +       at_response("\r\nERROR\r\n");
> +
> +       QUERY_RAT();
> +       expected_errtype =3D OFONO_ERROR_TYPE_CME;
> +       expected_error =3D 100;
> +       at_response("\r\n+CME ERROR:100\r\n");
> +
> +       radio_settings_driver->remove(radio_settings_data);
> +       ste_radio_settings_exit();
> +}
> +
> +/* Test Phone number */
> +static struct ofono_phone_number ph =3D {"4425993003739", 145 };
> +
> +static void voicecall_activate_helper(void)
> +{
> +       ste_voicecall_init();
> +       voicecall_driver->probe(NULL, 0, chat);
> +
> +       ASSERT_AT("AT*ECAM=3D2");
> +       at_response("\r\nOK\r\n");
> +}
> +
> +static void test_voicecall_dial(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       voicecall_driver->dial(0, &ph, 0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("ATD+4425993003739;");
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +       at_response("\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_dial_colp(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       voicecall_driver->dial(0, &ph, 0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("ATD+4425993003739;");
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +       expected_status =3D CALL_STATUS_DIALING;
> +       sprintf(expected_number, "+4425993003739");
> +       at_response("\r\n+COLP: \"+4425993003739\",129\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_dial_erroneous_colp(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       voicecall_driver->dial(0, &ph, 0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("ATD+4425993003739;");
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +       expected_status =3D CALL_STATUS_DIALING;
> +       sprintf(expected_number, "+4425993003739");
> +       at_response("\r\n+COLP:\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_dial_fail(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       voicecall_driver->dial(0, &ph, 0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("ATD+4425993003739;");
> +       expected_errtype =3D OFONO_ERROR_TYPE_CME;
> +       expected_error =3D 423; /* Network problem */
> +       at_response("\r\n+CME ERROR:423\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_dial_busy(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       voicecall_driver->dial(0, &ph, 0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("ATD+4425993003739;");
> +       expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
> +       expected_error =3D 0;
> +       at_response("\r\nBUSY\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_dial_no_dialtone(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       voicecall_driver->dial(0, &ph, 0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("ATD+4425993003739;");
> +       expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
> +       expected_error =3D 0;
> +       at_response("\r\nNO DIALTONE\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_hangup(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +
> +       /* Hangup */
> +       voicecall_driver->hangup_active(0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("AT+CHUP");
> +       at_response("\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_hangup_fail(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       /* Hangup */
> +       voicecall_driver->hangup_active(0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("AT+CHUP");
> +       expected_errtype =3D OFONO_ERROR_TYPE_CME;
> +       expected_error =3D 100;
> +       at_response("\r\n+CME ERROR:100\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_hold(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +
> +       /* Hold Call */
> +       voicecall_driver->hold_all_active(0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("AT+CHLD=3D2");
> +       at_response("\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_release_all_held(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +
> +       /* Release Call */
> +       voicecall_driver->release_all_held(0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("AT+CHLD=3D0");
> +       at_response("\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_release_all_active(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +
> +       /* Release Call */
> +       voicecall_driver->release_all_active(0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("AT+CHLD=3D1");
> +       at_response("\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_answer(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       /* Answer Call */
> +       voicecall_driver->answer(0, (ofono_voicecall_cb_t)ofono_generic_c=
b,
> 0);
> +       ASSERT_AT("ATA");
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +       at_response("\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_answer_error(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       /* Answer Call */
> +       voicecall_driver->answer(0, (ofono_voicecall_cb_t)ofono_generic_c=
b,
> 0);
> +       ASSERT_AT("ATA");
> +       expected_errtype =3D OFONO_ERROR_TYPE_FAILURE;
> +       expected_error =3D 0;
> +       at_response("\r\nNO CARRIER\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_multiparty(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +
> +       /* Multiparty */
> +       voicecall_driver->create_multiparty(0,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("AT+CHLD=3D3");
> +       at_response("\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_transfer(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +
> +       /* Transfer */
> +       voicecall_driver->transfer(0,
> +               (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("AT+CHLD=3D4");
> +       at_response("\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_deflect(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +
> +       /* Transfer */
> +       voicecall_driver->deflect(0, &ph,
> +               (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("AT+CTFR=3D\"4425993003739\",145");
> +       at_response("\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_send_tones(void)
> +{
> +       const char *test =3D "8,9";
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +
> +       /* Send DTMF tone */
> +       voicecall_driver->send_tones(0, test,
> +               (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("AT+VTS=3D8,9");
> +       at_response("\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_release_specific(void)
> +{
> +       /* Voice call initialisation */
> +       voicecall_activate_helper();
> +
> +       expected_errtype =3D OFONO_ERROR_TYPE_NO_ERROR;
> +       expected_error =3D 0;
> +
> +       /* Release Call */
> +       voicecall_driver->release_specific(0, 3,
> +                       (ofono_voicecall_cb_t)ofono_generic_cb, 0);
> +       ASSERT_AT("AT+CHLD=3D13");
> +       at_response("\r\nOK\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +
> +static void test_voicecall_ecav_alerting(void)
> +{
> +       voicecall_activate_helper();
> +
> +       expected_id =3D 1;
> +       expected_status =3D CALL_STATUS_INCOMING;
> +       sprintf(expected_number, "+4425993005133");
> +       at_response("\r\n*ECAV: 1,6,1,,,\"+4425993005133\",145\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_ecav_alerting_number_withheld(void)
> +{
> +       voicecall_activate_helper();
> +
> +       expected_id =3D 1;
> +       expected_status =3D CALL_STATUS_INCOMING;
> +       strcpy(expected_number, "");
> +       at_response("\r\n*ECAV: 1,6,1\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_ecav_waiting(void)
> +{
> +       voicecall_activate_helper();
> +
> +       expected_id =3D 1;
> +       expected_status =3D CALL_STATUS_WAITING;
> +       sprintf(expected_number, "+4425993005133");
> +       at_response("\r\n*ECAV: 1,5,1,,,\"+4425993005133\",145\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_ecav_waiting_number_withheld(void)
> +{
> +       voicecall_activate_helper();
> +
> +       expected_id =3D 1;
> +       expected_status =3D CALL_STATUS_WAITING;
> +       strcpy(expected_number, "");
> +       at_response("\r\n*ECAV: 1,5,1\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_ecav_calling(void)
> +{
> +       voicecall_activate_helper();
> +
> +       expected_id =3D 1;
> +       expected_status =3D CALL_STATUS_DIALING;
> +       sprintf(expected_number, "+4425993005133");
> +       at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_ecav_idle(void)
> +{
> +       voicecall_activate_helper();
> +
> +       expected_id =3D 1;
> +       expected_status =3D CALL_STATUS_DIALING;
> +       sprintf(expected_number, "+4425993005133");
> +       at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
> +
> +       expected_reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
> +       at_response("\r\n*ECAV: 1,0,1,08,016\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_ecav_connecting(void)
> +{
> +       voicecall_activate_helper();
> +
> +       expected_id =3D 1;
> +       expected_status =3D CALL_STATUS_DIALING;
> +       sprintf(expected_number, "+4425993005133");
> +       at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
> +
> +       expected_status =3D CALL_STATUS_ALERTING;
> +       at_response("\r\n*ECAV: 1,2,1\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_ecav_active(void)
> +{
> +       voicecall_activate_helper();
> +
> +       expected_id =3D 1;
> +       expected_status =3D CALL_STATUS_DIALING;
> +       sprintf(expected_number, "+4425993005133");
> +       at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
> +
> +       expected_status =3D CALL_STATUS_ACTIVE;
> +       at_response("\r\n*ECAV: 1,3,1\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_ecav_held(void)
> +{
> +       voicecall_activate_helper();
> +
> +       expected_id =3D 1;
> +       expected_status =3D CALL_STATUS_DIALING;
> +       sprintf(expected_number, "+4425993005133");
> +       at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
> +
> +       expected_status =3D CALL_STATUS_HELD;
> +       at_response("\r\n*ECAV: 1,4,1\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void test_voicecall_ecav_busy(void)
> +{
> +       voicecall_activate_helper();
> +
> +       expected_id =3D 1;
> +       expected_status =3D CALL_STATUS_DIALING;
> +       sprintf(expected_number, "+4425993005133");
> +       at_response("\r\n*ECAV: 1,1,1,,,\"+4425993005133\",145\r\n");
> +
> +       expected_reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
> +       at_response("\r\n*ECAV: 1,7,1\r\n");
> +
> +       voicecall_driver->remove(voicecall_data);
> +       ste_voicecall_exit();
> +}
> +
> +static void ste_test_add()
> +{
> +       g_test_add_func("/ste/gprs_nw_deact", test_gprs_nw_deact);
> +       g_test_add_func("/ste/gprs_normal", test_gprs_normal);
> +       g_test_add_func("/ste/gprs_cgdcont_err", test_gprs_cgdcont_err);
> +       g_test_add_func("/ste/gprs_xmlerr", test_gprs_xmlerr);
> +       g_test_add_func("/ste/gprs_deact", test_gprs_deactivate);
> +       g_test_add_func("/ste/gprs_deact_err", test_gprs_deactivate_err);
> +       g_test_add_func("/ste/gprs_deact_err_ok",
> +                       test_gprs_deact_fail_then_ok);
> +       g_test_add_func("/ste/gprs_deact_fail", test_gprs_deactivate_fail=
);
> +       g_test_add_func("/ste/gprs_eppsd_err", test_gprs_eppsd_err);
> +       g_test_add_func("/ste/radiosettings_all", test_radiosettings_all);
> +       g_test_add_func("/ste/test_voicecall_dial", test_voicecall_dial);
> +       g_test_add_func("/ste/test_voicecall_dial_colp",
> +                       test_voicecall_dial_colp);
> +       g_test_add_func("/ste/test_voicecall_dial_erroneous_colp",
> +                               test_voicecall_dial_erroneous_colp);
> +       g_test_add_func("/ste/test_voicecall_dial_fail",
> +               test_voicecall_dial_fail);
> +       g_test_add_func("/ste/test_voicecall_dial_busy",
> +               test_voicecall_dial_busy);
> +       g_test_add_func("/ste/test_voicecall_hangup",
> test_voicecall_hangup);
> +       g_test_add_func("/ste/test_voicecall_hangup_fail",
> +               test_voicecall_hangup_fail);
> +       g_test_add_func("/ste/test_voicecall_hold", test_voicecall_hold);
> +       g_test_add_func("/ste/test_voicecall_release_all_held",
> +               test_voicecall_release_all_held);
> +       g_test_add_func("/ste/test_voicecall_release_all_active",
> +               test_voicecall_release_all_active);
> +       g_test_add_func("/ste/test_voicecall_answer",
> test_voicecall_answer);
> +       g_test_add_func("/ste/test_voicecall_dial_no_dialtone",
> +               test_voicecall_dial_no_dialtone);
> +       g_test_add_func("/ste/test_voicecall_answer_error",
> +               test_voicecall_answer_error);
> +       g_test_add_func("/ste/test_voicecall_multiparty",
> +               test_voicecall_multiparty);
> +       g_test_add_func("/ste/test_voicecall_transfer",
> +               test_voicecall_transfer);
> +       g_test_add_func("/ste/test_voicecall_deflect",
> test_voicecall_deflect);
> +       g_test_add_func("/ste/test_voicecall_send_tones",
> +               test_voicecall_send_tones);
> +       g_test_add_func("/ste/test_voicecall_release_specific",
> +               test_voicecall_release_specific);
> +       g_test_add_func("/ste/test_voicecall_ecav_alerting",
> +               test_voicecall_ecav_alerting);
> +
> g_test_add_func("/ste/test_voicecall_ecav_alerting_number_withheld",
> +               test_voicecall_ecav_alerting_number_withheld);
> +       g_test_add_func("/ste/test_voicecall_ecav_waiting",
> +               test_voicecall_ecav_waiting);
> +       g_test_add_func("/ste/test_voicecall_ecav_waiting_number_withheld=
",
> +                       test_voicecall_ecav_waiting_number_withheld);
> +       g_test_add_func("/ste/test_voicecall_ecav_calling",
> +               test_voicecall_ecav_calling);
> +       g_test_add_func("/ste/test_voicecall_ecav_held",
> +               test_voicecall_ecav_held);
> +       g_test_add_func("/ste/test_voicecall_ecav_busy",
> +               test_voicecall_ecav_busy);
> +       g_test_add_func("/ste/test_voicecall_ecav_idle",
> +               test_voicecall_ecav_idle);
> +       g_test_add_func("/ste/test_voicecall_ecav_connecting",
> +               test_voicecall_ecav_connecting);
> +       g_test_add_func("/ste/test_voicecall_ecav_active",
> +               test_voicecall_ecav_active);
> +       return;
> +}
> +
> +void ofono_debug(const char *format, ...)
> +{
> +       va_list ap;
> +
> +       va_start(ap, format);
> +       if (g_test_verbose())
> +               vprintf(format, ap);
> +       va_end(ap);
> +}
> +
> +void ofono_error(const char *format, ...)
> +{
> +       va_list ap;
> +
> +       va_start(ap, format);
> +       vprintf(format, ap);
> +       va_end(ap);
> +}
> +
> +static void ste_debug(const char *str, void *user_data)
> +{
> +       if (g_test_verbose())
> +               g_print("%s\n", str);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       GIOChannel *channel =3D NULL;
> +       GAtSyntax *syntax =3D NULL;
> +       int pair[2];
> +
> +       if (socketpair(AF_UNIX, SOCK_STREAM, PF_UNIX, pair) < 0)
> +               goto err;
> +
> +       /*
> +        * Give one end of the socket pair, for simulating modem
> +        * responses.
> +        */
> +       phone_fd =3D pair[1];
> +
> +
> +       /* And the other end of the socket pair to at_chan */
> +       channel =3D g_io_channel_unix_new(pair[0]);
> +       if (channel =3D=3D NULL)
> +               goto err;
> +
> +       g_io_channel_set_close_on_unref(channel, TRUE);
> +       syntax =3D g_at_syntax_new_gsm_permissive();
> +       if (syntax =3D=3D NULL)
> +               goto err;
> +
> +       chat =3D g_at_chat_new_blocking(channel, syntax);
> +       if (chat =3D=3D NULL)
> +               goto err;
> +
> +       g_at_syntax_unref(syntax);
> +       g_io_channel_unref(channel);
> +       g_at_chat_set_debug(chat, ste_debug, NULL);
> +
> +       event_loop =3D g_main_loop_new(NULL, FALSE);
> +
> +       g_test_init(&argc, &argv, NULL);
> +       ste_test_add();
> +       g_test_run();
> +
> +       g_main_loop_unref(event_loop);
> +       g_at_chat_unref(chat);
> +
> +       return 0;
> +
> +err:
> +       if (syntax !=3D NULL)
> +               g_at_syntax_unref(syntax);
> +
> +       if (channel !=3D NULL)
> +               g_io_channel_unref(channel);
> +
> +       g_print("error\n");
> +       return 10;
> +}
> --
> 1.7.1
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============6339595286444156461==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMS8yLzE1IE1hcml0IEhlbnJpa3Nl
biA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzp0b21hc3ouZ3JlZ29yZWtAZ21h
aWwuY29tIj50b21hc3ouZ3JlZ29yZWtAZ21haWwuY29tPC9hPiZndDs8L3NwYW4+PGJyPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44
ZXg7IGJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxl
ZnQ6IDFleDsiPgpGcm9tOiBNYXJpdCBIZW5yaWtzZW4gJmx0OzxhIGhyZWY9Im1haWx0bzptYXJp
dC5oZW5yaWtzZW5Ac3Rlcmljc3Nvbi5jb20iPm1hcml0LmhlbnJpa3NlbkBzdGVyaWNzc29uLmNv
bTwvYT4mZ3Q7PGJyPgo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPkhpLDxicj5oYXMgYW55b25l
IGhhZCB0aGUgdGltZSB0byBsb29rIGF0IHRoaXMgcGF0Y2g/PGJyPjxicj5iciBNYXJpdDxicj48
YnI+oDxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIw
NCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KCi0tLTxicj4KoE1ha2VmaWxlLmFtIKAgoCB8
IKAgMTcgKy08YnI+CqB1bml0L3Rlc3Qtc3RlLmMgfCAxMTUzICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKys8YnI+CqAyIGZpbGVzIGNoYW5nZWQs
IDExNjkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSk8YnI+CqBjcmVhdGUgbW9kZSAxMDA3
NTUgdW5pdC90ZXN0LXN0ZS5jPGJyPgo8YnI+CmRpZmYgLS1naXQgYS9NYWtlZmlsZS5hbSBiL01h
a2VmaWxlLmFtPGJyPgppbmRleCA0MmFkODZmLi4wODA2ZTFlIDEwMDY0NDxicj4KLS0tIGEvTWFr
ZWZpbGUuYW08YnI+CisrKyBiL01ha2VmaWxlLmFtPGJyPgpAQCAtNDk5LDcgKzQ5OSw3IEBAIGRp
c3RfbWFuX01BTlMgPSBkb2Mvb2Zvbm9kLjg8YnI+CqBub2luc3RfUFJPR1JBTVMgPSB1bml0L3Rl
c3QtY29tbW9uIHVuaXQvdGVzdC11dGlsIHVuaXQvdGVzdC1pZG1hcCBcPGJyPgogoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgdW5pdC90ZXN0LXNtcyB1bml0L3Rlc3Qtc2lt
dXRpbCBcPGJyPgogoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgdW5pdC90
ZXN0LW11eCB1bml0L3Rlc3QtY2FpZiBcPGJyPgotIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgdW5pdC90ZXN0LXN0a3V0aWw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCB1bml0L3Rlc3Qtc3RrdXRpbCB1bml0L3Rlc3Qtc3RlPGJyPgo8YnI+
CqB1bml0X29iamVjdHMgPTxicj4KPGJyPgpAQCAtNTQwLDYgKzU0MCwyMSBAQCB1bml0X3Rlc3Rf
Y2FpZl9TT1VSQ0VTID0gdW5pdC90ZXN0LWNhaWYuYyAkKGdhdGNoYXRfc291cmNlcykgXDxicj4K
oHVuaXRfdGVzdF9jYWlmX0xEQUREID0gQEdMSUJfTElCU0A8YnI+CqB1bml0X29iamVjdHMgKz0g
JCh1bml0X3Rlc3RfY2FpZl9PQkpFQ1RTKTxicj4KPGJyPgordW5pdF90ZXN0X3N0ZV9TT1VSQ0VT
ID0gdW5pdC90ZXN0LXN0ZS5jICQoZ2F0Y2hhdF9zb3VyY2VzKSBcPGJyPgorIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgJChnZGJ1c19zb3VyY2VzKSAkKGxvY2FsX2hlYWRl
cnMpIFw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBzcmMvY29t
bW9uLmMgc3JjL3V0aWwuYyBcPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgZHJpdmVycy9zdGVtb2RlbS9zdGVtb2RlbS5oIFw8YnI+CisgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBkcml2ZXJzL2F0bW9kZW0vYXR1dGlsLmggXDxicj4KKyCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGRyaXZlcnMvYXRtb2RlbS9hdHV0
aWwuYyBcPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgZHJpdmVy
cy9zdGVtb2RlbS9yYWRpby1zZXR0aW5ncy5jIFw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCBkcml2ZXJzL3N0ZW1vZGVtL2dwcnMtY29udGV4dC5jIFw8YnI+Cisg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBkcml2ZXJzL3N0ZW1vZGVtL3Zv
aWNlY2FsbC5jIFw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBk
cml2ZXJzL3N0ZW1vZGVtL2NhaWZfc29ja2V0LmggXDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIGRyaXZlcnMvc3RlbW9kZW0vaWZfY2FpZi5oPGJyPgorPGJyPgor
dW5pdF90ZXN0X3N0ZV9MREFERCA9IEBHTElCX0xJQlNAIEBEQlVTX0xJQlNAPGJyPgordW5pdF9v
YmplY3RzICs9ICQodW5pdF90ZXN0X3N0ZV9PQkpFQ1RTKTxicj4KKzxicj4KoGlmIFRPT0xTPGJy
Pgqgbm9pbnN0X1BST0dSQU1TICs9IHRvb2xzL2h1YXdlaS1hdWRpbyB0b29scy9hdXRvLWVuYWJs
ZTxicj4KPGJyPgpkaWZmIC0tZ2l0IGEvdW5pdC90ZXN0LXN0ZS5jIGIvdW5pdC90ZXN0LXN0ZS5j
PGJyPgpuZXcgZmlsZSBtb2RlIDEwMDc1NTxicj4KaW5kZXggMDAwMDAwMC4uYjA3OGFhZjxicj4K
LS0tIC9kZXYvbnVsbDxicj4KKysrIGIvdW5pdC90ZXN0LXN0ZS5jPGJyPgpAQCAtMCwwICsxLDEx
NTMgQEA8YnI+CisvKjxicj4KKyAqPGJyPgorICogoG9Gb25vIC0gT3BlbiBTb3VyY2UgVGVsZXBo
b255PGJyPgorICo8YnI+CisgKiCgQ29weXJpZ2h0IChDKSAyMDEwIFNULUVyaWNzc29uIEFCLjxi
cj4KKyAqPGJyPgorICogoFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJl
ZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5PGJyPgorICogoGl0IHVuZGVyIHRoZSB0ZXJtcyBv
ZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzPGJyPgorICogoHB1
Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLjxicj4KKyAqPGJyPgorICog
oFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUg
dXNlZnVsLDxicj4KKyAqIKBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0
aGUgaW1wbGllZCB3YXJyYW50eSBvZjxicj4KKyAqIKBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVT
UyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuIKBTZWUgdGhlPGJyPgorICogoEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuPGJyPgorICo8YnI+CisgKiCgWW91IHNo
b3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2U8YnI+CisgKiCgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhl
IEZyZWUgU29mdHdhcmU8YnI+CisgKiCgRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3Qs
IEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIKAwMjExMC0xMzAxIKBVU0E8YnI+CisgKjxicj4KKyAq
Lzxicj4KKzxicj4KKyNpZmRlZiBIQVZFX0NPTkZJR19IPGJyPgorI2luY2x1ZGUgJmx0O2NvbmZp
Zy5oJmd0Ozxicj4KKyNlbmRpZjxicj4KKyNpbmNsdWRlICZsdDt1bmlzdGQuaCZndDs8YnI+Cisj
aW5jbHVkZSAmbHQ7c3RkaW8uaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7c3RyaW5nLmgmZ3Q7PGJy
PgorI2luY2x1ZGUgJmx0O3N5cy9zb2NrZXQuaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7Z2xpYi5o
Jmd0Ozxicj4KKyNpbmNsdWRlICZsdDtnYXRjaGF0LmgmZ3Q7PGJyPgorI2luY2x1ZGUgJmx0O2dh
dHJlc3VsdC5oJmd0Ozxicj4KKyNpbmNsdWRlICZsdDtsb2cuaCZndDs8YnI+CisjaW5jbHVkZSAm
bHQ7b2Zvbm8vbW9kZW0uaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7b2Zvbm8vdm9pY2VjYWxsLmgm
Z3Q7PGJyPgorI2luY2x1ZGUgJmx0O29mb25vL3JhZGlvLXNldHRpbmdzLmgmZ3Q7PGJyPgorI2lu
Y2x1ZGUgJmx0O29mb25vL2dwcnMtY29udGV4dC5oJmd0Ozxicj4KKyNpbmNsdWRlICZsdDtkcml2
ZXJzL3N0ZW1vZGVtL3N0ZW1vZGVtLmgmZ3Q7PGJyPgorI2luY2x1ZGUgJmx0O2RyaXZlcnMvc3Rl
bW9kZW0vY2FpZl9ydG5sLmgmZ3Q7PGJyPgorI2luY2x1ZGUgJnF1b3Q7Y29tbW9uLmgmcXVvdDs8
YnI+Cis8YnI+CisvKiBHZW5lcmljIHRlc3QgY29kZSBkZWNscyAqLzxicj4KK3N0YXRpYyBHQXRD
aGF0ICpjaGF0Ozxicj4KK3N0YXRpYyBHTWFpbkxvb3AgKmV2ZW50X2xvb3A7PGJyPgorc3RhdGlj
IGludCBwaG9uZV9mZDs8YnI+Cis8YnI+CisjZGVmaW5lIEFTU0VSVF9BVChzKSBnX2Fzc2VydChh
c3NlcnRfYXQocykpOzxicj4KKzxicj4KKy8qIFNlbmQgYSBzaW11bGF0ZWQgQVQgcmVzcG9uc2Ug
Ki88YnI+CitzdGF0aWMgdm9pZCBhdF9yZXNwb25zZShjaGFyICpyZXNwKTxicj4KK3s8YnI+Cisg
oCCgIKAgaW50IHI7PGJyPgorPGJyPgorIKAgoCCgIC8qPGJyPgorIKAgoCCgIKAqIFNlbmQgQVQg
cmVzcG9uc2UgdG8gZ19hdF9jaGF0IGFuZCBnaXZlIG1haW4gbG9vayBhIGtpY2sgdG8gcnVuPGJy
PgorIKAgoCCgIKAqIG9uZSBpdGVyYXRpb24uPGJyPgorIKAgoCCgIKAqLzxicj4KKyCgIKAgoCBy
ID0gd3JpdGUocGhvbmVfZmQsIHJlc3AsIHN0cmxlbihyZXNwKSk7PGJyPgorIKAgoCCgIGdfYXNz
ZXJ0KHIgJmd0OyAwKTs8YnI+CisgoCCgIKAgKHZvaWQpZ19tYWluX2NvbnRleHRfaXRlcmF0aW9u
KE5VTEwsIFRSVUUpOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgZ2Jvb2xlYW4gYXNzZXJ0X2F0
KGNoYXIgKm1hdGNoKTxicj4KK3s8YnI+CisgoCCgIKAgY2hhciByZXFbMjU2XTs8YnI+CisgoCCg
IKAgaW50IHI7PGJyPgorPGJyPgorIKAgoCCgIGlmIChnX21haW5fY29udGV4dF9pdGVyYXRpb24o
TlVMTCwgVFJVRSkgPT0gVFJVRSkgezxicj4KKzxicj4KKyCgIKAgoCCgIKAgoCCgIC8qIFJlYWQg
d2hhdCBnX2F0X2NoYW4gaGFzIHdyaXR0ZW4gdG8gJnF1b3Q7bW9kZW0mcXVvdDsgKi88YnI+Cisg
oCCgIKAgoCCgIKAgoCByID0gcmVhZChwaG9uZV9mZCwgcmVxLCBzaXplb2YocmVxKSk7PGJyPgor
PGJyPgorIKAgoCCgIKAgoCCgIKAgaWYgKHIgJmd0OyAxKTxicj4KKyCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgcmVxW3ItMV0gPSAwOzxicj4KKzxicj4KKyCgIKAgoCCgIKAgoCCgIGlmIChzdHJjbXAo
bWF0Y2gsIHJlcSkgPT0gMCk8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIHJldHVybiBUUlVF
Ozxicj4KKyCgIKAgoCB9PGJyPgorPGJyPgorIKAgoCCgIGdfcHJpbnQoJnF1b3Q7QVQgcmVxdWVz
dCBkaWQgbm90IG1hdGNoOiVzICE9ICVzXG4mcXVvdDssIG1hdGNoLCByZXEpOzxicj4KKyCgIKAg
oCByZXR1cm4gRkFMU0U7PGJyPgorfTxicj4KKzxicj4KKzxicj4KKy8qIFN0dWJzIGZyb20gc3Jj
L3ZvaWNlY2FsbC5jICovPGJyPgorc3RydWN0IG9mb25vX3ZvaWNlY2FsbDs8YnI+Citjb25zdCBz
dHJ1Y3Qgb2Zvbm9fdm9pY2VjYWxsX2RyaXZlciAqdm9pY2VjYWxsX2RyaXZlcjs8YnI+Cit2b2lk
ICp2b2ljZWNhbGxfZGF0YTs8YnI+CitzdGF0aWMgdW5zaWduZWQgaW50IGV4cGVjdGVkX2lkOzxi
cj4KK3N0YXRpYyBpbnQgZXhwZWN0ZWRfc3RhdHVzOzxicj4KK3N0YXRpYyBjaGFyIGV4cGVjdGVk
X251bWJlcltPRk9OT19NQVhfUEhPTkVfTlVNQkVSX0xFTkdUSCArIDFdOzxicj4KK3N0YXRpYyBp
bnQgZXhwZWN0ZWRfcmVhc29uOzxicj4KKzxicj4KK3ZvaWQgb2Zvbm9fdm9pY2VjYWxsX3JlZ2lz
dGVyKHN0cnVjdCBvZm9ub192b2ljZWNhbGwgKnZjKTxicj4KK3s8YnI+Cit9PGJyPgorPGJyPgor
dm9pZCBvZm9ub192b2ljZWNhbGxfcmVtb3ZlKHN0cnVjdCBvZm9ub192b2ljZWNhbGwgKnZjKTxi
cj4KK3s8YnI+Cit9PGJyPgorPGJyPgoraW50IG9mb25vX3ZvaWNlY2FsbF9kcml2ZXJfcmVnaXN0
ZXIoY29uc3Qgc3RydWN0IG9mb25vX3ZvaWNlY2FsbF9kcml2ZXIgKmQpPGJyPgorezxicj4KKyCg
IKAgoCB2b2ljZWNhbGxfZHJpdmVyID0gZDs8YnI+CisgoCCgIKAgcmV0dXJuIDA7PGJyPgorfTxi
cj4KKzxicj4KK3ZvaWQgb2Zvbm9fdm9pY2VjYWxsX2RyaXZlcl91bnJlZ2lzdGVyKGNvbnN0IHN0
cnVjdCBvZm9ub192b2ljZWNhbGxfZHJpdmVyICpkKTxicj4KK3s8YnI+Cit9PGJyPgorPGJyPgor
dm9pZCBvZm9ub192b2ljZWNhbGxfc2V0X2RhdGEoc3RydWN0IG9mb25vX3ZvaWNlY2FsbCAqdmMs
IHZvaWQgKmRhdGEpPGJyPgorezxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZGF0YSA9IGRhdGE7PGJy
PgorfTxicj4KKzxicj4KK3ZvaWQgKm9mb25vX3ZvaWNlY2FsbF9nZXRfZGF0YShzdHJ1Y3Qgb2Zv
bm9fdm9pY2VjYWxsICp2Yyk8YnI+Cit7PGJyPgorIKAgoCCgIHJldHVybiB2b2ljZWNhbGxfZGF0
YTs8YnI+Cit9PGJyPgorPGJyPgordm9pZCBvZm9ub192b2ljZWNhbGxfbm90aWZ5KHN0cnVjdCBv
Zm9ub192b2ljZWNhbGwgKnZjLDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBj
b25zdCBzdHJ1Y3Qgb2Zvbm9fY2FsbCAqY2FsbCk8YnI+Cit7PGJyPgorIKAgoCCgIGdfYXNzZXJ0
X2NtcGludChleHBlY3RlZF9pZCwgPT0sIGNhbGwtJmd0O2lkKTs8YnI+CisgoCCgIKAgZ19hc3Nl
cnRfY21waW50KGV4cGVjdGVkX3N0YXR1cywgPT0sIGNhbGwtJmd0O3N0YXR1cyk7PGJyPgorIKAg
oCCgIGdfYXNzZXJ0X2NtcHN0cihleHBlY3RlZF9udW1iZXIsID09LCBjYWxsLSZndDtwaG9uZV9u
dW1iZXIubnVtYmVyKTs8YnI+Cit9PGJyPgorPGJyPgordm9pZCBvZm9ub192b2ljZWNhbGxfZGlz
Y29ubmVjdGVkKHN0cnVjdCBvZm9ub192b2ljZWNhbGwgKnZjLCBpbnQgaWQsPGJyPgorIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGVudW0gb2Zvbm9fZGlzY29ubmVjdF9yZWFzb24gcmVh
c29uLDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBjb25zdCBzdHJ1Y3Qgb2Zv
bm9fZXJyb3IgKmVycm9yKTxicj4KK3s8YnI+CisgoCCgIKAgZ19hc3NlcnRfY21waW50KGV4cGVj
dGVkX2lkLCA9PSwgaWQpOzxicj4KKyCgIKAgoCBnX2Fzc2VydF9jbXBpbnQoZXhwZWN0ZWRfcmVh
c29uLCA9PSwgcmVhc29uKTs8YnI+CisgoCCgIKAgZ19hc3NlcnQoZXJyb3IgPT0gTlVMTCk7PGJy
PgorfTxicj4KKzxicj4KKy8qIFN0dWJzIGZyb20gc3JjL3JhZGlvLXNldHRpbmdzLmMgKi88YnI+
CitzdHJ1Y3Qgb2Zvbm9fcmFkaW9fc2V0dGluZ3M7PGJyPgorY29uc3Qgc3RydWN0IG9mb25vX3Jh
ZGlvX3NldHRpbmdzX2RyaXZlciAqcmFkaW9fc2V0dGluZ3NfZHJpdmVyOzxicj4KK3ZvaWQgKnJh
ZGlvX3NldHRpbmdzX2RhdGE7PGJyPgorPGJyPgordm9pZCBvZm9ub19yYWRpb19zZXR0aW5nc19y
ZWdpc3RlcihzdHJ1Y3Qgb2Zvbm9fcmFkaW9fc2V0dGluZ3MgKnJzKTxicj4KK3s8YnI+Cit9PGJy
PgorPGJyPgordm9pZCBvZm9ub19yYWRpb19zZXR0aW5nc19yZW1vdmUoc3RydWN0IG9mb25vX3Jh
ZGlvX3NldHRpbmdzICpycyk8YnI+Cit7PGJyPgorfTxicj4KKzxicj4KK3ZvaWQgb2Zvbm9fcmFk
aW9fc2V0dGluZ3Nfc2V0X2RhdGEoc3RydWN0IG9mb25vX3JhZGlvX3NldHRpbmdzICpycywgdm9p
ZCAqZGF0YSk8YnI+Cit7PGJyPgorIKAgoCCgIHJhZGlvX3NldHRpbmdzX2RhdGEgPSBkYXRhOzxi
cj4KK308YnI+Cis8YnI+Cit2b2lkICpvZm9ub19yYWRpb19zZXR0aW5nc19nZXRfZGF0YShzdHJ1
Y3Qgb2Zvbm9fcmFkaW9fc2V0dGluZ3MgKnJzKTxicj4KK3s8YnI+CisgoCCgIKAgcmV0dXJuIHJh
ZGlvX3NldHRpbmdzX2RhdGE7PGJyPgorfTxicj4KKzxicj4KK2ludCBvZm9ub19yYWRpb19zZXR0
aW5nc19kcml2ZXJfcmVnaXN0ZXIoPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IGNvbnN0IHN0cnVjdCBvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXIgKmQpPGJyPgorezxicj4K
KyCgIKAgoCByYWRpb19zZXR0aW5nc19kcml2ZXIgPSBkOzxicj4KKyCgIKAgoCByZXR1cm4gMDs8
YnI+Cit9PGJyPgorPGJyPgordm9pZCBvZm9ub19yYWRpb19zZXR0aW5nc19kcml2ZXJfdW5yZWdp
c3Rlcig8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgY29uc3Qgc3RydWN0IG9m
b25vX3JhZGlvX3NldHRpbmdzX2RyaXZlciAqZCk8YnI+Cit7PGJyPgorfTxicj4KKzxicj4KKy8q
IFN0dWJzIGZyb20gc3JjL2dwcnMtY29udGV4dC5jICovPGJyPgorc3RydWN0IG9mb25vX2dwcnNf
Y29udGV4dDs8YnI+Citjb25zdCBzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0X2RyaXZlciAqZ3By
c19jb250ZXh0X2RyaXZlcjs8YnI+Cit2b2lkICpncHJzX2NvbnRleHRfZGF0YTs8YnI+Cis8YnI+
CitpbnQgY2FpZl9ydG5sX2NyZWF0ZV9pbnRlcmZhY2UoaW50IHR5cGUsIGludCBjb25uaWQsIGlu
dCBsb29wLDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBjYWlmX3J0bmxfY3Jl
YXRlX2NiX3QgY2IsIHZvaWQgKnVzZXJfZGF0YSk8YnI+Cit7PGJyPgorIKAgoCCgIGNiKDAsICZx
dW90O2NhaWYwJnF1b3Q7LCB1c2VyX2RhdGEpOzxicj4KKyCgIKAgoCByZXR1cm4gMDs8YnI+Cit9
PGJyPgorPGJyPgoraW50IGNhaWZfcnRubF9kZWxldGVfaW50ZXJmYWNlKGludCBpZmlkKTxicj4K
K3s8YnI+CisgoCCgIKAgcmV0dXJuIDA7PGJyPgorfTxicj4KKzxicj4KK2ludCBjYWlmX3J0bmxf
aW5pdCh2b2lkKTxicj4KK3s8YnI+CisgoCCgIKAgcmV0dXJuIDA7PGJyPgorfTxicj4KKzxicj4K
K3ZvaWQgY2FpZl9ydG5sX2V4aXQodm9pZCk8YnI+Cit7PGJyPgorfTxicj4KKzxicj4KK3ZvaWQg
b2Zvbm9fZ3Byc19jb250ZXh0X3JlbW92ZShzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0ICpycyk8
YnI+Cit7PGJyPgorfTxicj4KKzxicj4KK3ZvaWQgb2Zvbm9fZ3Byc19jb250ZXh0X3NldF9kYXRh
KHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHQgKnJzLCB2b2lkICpkYXRhKTxicj4KK3s8YnI+Cisg
oCCgIKAgZ3Byc19jb250ZXh0X2RhdGEgPSBkYXRhOzxicj4KK308YnI+Cis8YnI+Cit2b2lkICpv
Zm9ub19ncHJzX2NvbnRleHRfZ2V0X2RhdGEoc3RydWN0IG9mb25vX2dwcnNfY29udGV4dCAqcnMp
PGJyPgorezxicj4KKyCgIKAgoCByZXR1cm4gZ3Byc19jb250ZXh0X2RhdGE7PGJyPgorfTxicj4K
Kzxicj4KK2ludCBvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyX3JlZ2lzdGVyKDxicj4KKyCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBjb25zdCBzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0
X2RyaXZlciAqZCk8YnI+Cit7PGJyPgorIKAgoCCgIGdwcnNfY29udGV4dF9kcml2ZXIgPSBkOzxi
cj4KKyCgIKAgoCByZXR1cm4gMDs8YnI+Cit9PGJyPgorPGJyPgordm9pZCBvZm9ub19ncHJzX2Nv
bnRleHRfZHJpdmVyX3VucmVnaXN0ZXIoPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIGNvbnN0IHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyICpkKTxicj4KK3s8YnI+
Cit9PGJyPgorPGJyPgordm9pZCBvZm9ub19ncHJzX2NvbnRleHRfZGVhY3RpdmF0ZWQoc3RydWN0
IG9mb25vX2dwcnNfY29udGV4dCAqZ2MsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgdW5zaWduZWQgaW50IGNpZCk8YnI+Cit7PGJyPgorfTxicj4KKzxicj4KKy8q
IFRlc3QgRml4dHVyZSBmb3IgY29udGV4dCBhY3RpdmF0aW9uICovPGJyPgorc3RhdGljIHN0cnVj
dCBvZm9ub19ncHJzX3ByaW1hcnlfY29udGV4dCBjdHggPSB7PGJyPgorIKAgoCCgIDUsIDEsICZx
dW90O2FwbiZxdW90OywgJnF1b3Q7dXNlciZxdW90OywgJnF1b3Q7cHdkJnF1b3Q7LCBPRk9OT19H
UFJTX1BST1RPX0lQPGJyPgorfTs8YnI+Cis8YnI+CisvKjxicj4KKyAqIFRoZXNlIHZhcnMgYXJl
IHVzZWQgdG8gdmFsaWRhdGUgdGVzdCBjYXNlIGFuZCBhcmU8YnI+CisgKiBjaGVja2VkIGluIGNh
bGxiYWNrIGZ1bmN0aW9ucy48YnI+CisgKi88YnI+CitzdGF0aWMgZW51bSBvZm9ub19lcnJvcl90
eXBlIGV4cGVjdGVkX2VycnR5cGU7PGJyPgorc3RhdGljIGludCBleHBlY3RlZF9lcnJvcjs8YnI+
Cis8YnI+CitzdGF0aWMgdm9pZCBncHJzX2NvbnRleHRfdXBfY2IoY29uc3Qgc3RydWN0IG9mb25v
X2Vycm9yICplcnJvciw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgY29uc3Qg
Y2hhciAqaW50ZXJmYWNlLCBvZm9ub19ib29sX3Qgc3RhdGljX2lwLDxicj4KKyCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCBjb25zdCBjaGFyICphZGRyZXNzLCBjb25zdCBjaGFyICpuZXRt
YXNrLDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBjb25zdCBjaGFyICpndywg
Y29uc3QgY2hhciAqKmRucywgdm9pZCAqZGF0YSk8YnI+Cit7PGJyPgorIKAgoCCgIGdfYXNzZXJ0
X2NtcGludChleHBlY3RlZF9lcnJ0eXBlLCA9PSwgZXJyb3ItJmd0O3R5cGUpOzxicj4KK308YnI+
Cis8YnI+CitzdGF0aWMgdm9pZCBvZm9ub19nZW5lcmljX2NiKGNvbnN0IHN0cnVjdCBvZm9ub19l
cnJvciAqZXJyb3IsIHZvaWQgKmRhdGEpPGJyPgorezxicj4KKyCgIKAgoCBnX2Fzc2VydF9jbXBp
bnQoZXhwZWN0ZWRfZXJydHlwZSwgPT0sIGVycm9yLSZndDt0eXBlKTs8YnI+CisgoCCgIKAgZ19h
c3NlcnRfY21waW50KGV4cGVjdGVkX2Vycm9yLCA9PSwgZXJyb3ItJmd0O2Vycm9yKTs8YnI+Cis8
YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgZ3Byc19hY3RpdmF0ZV9oZWxwZXIodm9pZCk8
YnI+Cit7PGJyPgorIKAgoCCgIGV4cGVjdGVkX2VycnR5cGUgPSBPRk9OT19FUlJPUl9UWVBFX05P
X0VSUk9SOzxicj4KKzxicj4KKyCgIKAgoCBncHJzX2NvbnRleHRfZHJpdmVyLSZndDs8YnI+Cisg
oCCgIKAgoCCgIKAgoCBhY3RpdmF0ZV9wcmltYXJ5KDAsICZhbXA7Y3R4LDxicj4KKyCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgKG9mb25vX2dwcnNfY29udGV4dF91cF9jYl90KTxicj4K
KyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgZ3Byc19jb250ZXh0X3VwX2NiLCAwKTs8
YnI+Cis8YnI+CisgoCCgIKAgQVNTRVJUX0FUKCZxdW90O0FUK0NHRENPTlQ9NSxcJnF1b3Q7SVBc
JnF1b3Q7LFwmcXVvdDthcG5cJnF1b3Q7JnF1b3Q7KTs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2Uo
JnF1b3Q7XHJcbk9LXHJcbiZxdW90Oyk7PGJyPgorPGJyPgorIKAgoCCgIEFTU0VSVF9BVCgmcXVv
dDtBVCpFSUFBVVc9NSwxLFwmcXVvdDt1c2VyXCZxdW90OyxcJnF1b3Q7cHdkXCZxdW90OyZxdW90
Oyk7PGJyPgorIKAgoCCgIGF0X3Jlc3BvbnNlKCZxdW90O1xyXG5PS1xyXG4mcXVvdDspOzxicj4K
Kzxicj4KKyCgIKAgoCBBU1NFUlRfQVQoJnF1b3Q7QVQqRVBQU0Q9MSwxLDUmcXVvdDspOzxicj4K
KyCgIKAgoCBhdF9yZXNwb25zZSg8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgICZxdW90O1xy
XG4mcXVvdDs8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgICZxdW90OyZsdDs/eG1sIHZlcnNp
b249XCZxdW90OzEuMFwmcXVvdDs/Jmd0O1xyXG4mcXVvdDs8YnI+CisgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgICZxdW90OyZsdDtjb25uZWN0aW9uX3BhcmFtZXRlcnMmZ3Q7XHJcbiZxdW90Ozxicj4K
KyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgJnF1b3Q7Jmx0O2lwX2FkZHJlc3MmZ3Q7MTAuNjQuMTUx
LjE0Jmx0Oy9pcF9hZGRyZXNzJmd0O1xyXG4mcXVvdDs8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgICZxdW90OyZsdDtzdWJuZXRfbWFzayZndDsyNTUuMjU1LjI1NS4yNTUmbHQ7L3N1Ym5ldF9t
YXNrJmd0O1xyXG4mcXVvdDs8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgICZxdW90OyZsdDtt
dHUmZ3Q7MTUwMCZsdDsvbXR1Jmd0O1xyXG4mcXVvdDs8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgICZxdW90OyZsdDtkbnNfc2VydmVyJmd0OzEwLjY0LjE0OC40Jmx0Oy9kbnNfc2VydmVyJmd0
O1xyXG4mcXVvdDs8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgICZxdW90OyZsdDtkbnNfc2Vy
dmVyJmd0OzEwLjY0LjE0OC41Jmx0Oy9kbnNfc2VydmVyJmd0O1xyXG4mcXVvdDs8YnI+CisgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgICZxdW90OyZsdDsvY29ubmVjdGlvbl9wYXJhbWV0ZXJzJmd0O1xy
XG4mcXVvdDs8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgICZxdW90O1xyXG5PS1xyXG4mcXVv
dDspOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCB0ZXN0X2dwcnNfbm9ybWFsKHZvaWQp
PGJyPgorezxicj4KKyCgIKAgoCBzdGVfZ3Byc19jb250ZXh0X2luaXQoKTs8YnI+Cis8YnI+Cisg
oCCgIKAgZ3Byc19jb250ZXh0X2RyaXZlci0mZ3Q7cHJvYmUoTlVMTCwgMCwgY2hhdCk7PGJyPgor
IKAgoCCgIGdwcnNfYWN0aXZhdGVfaGVscGVyKCk7PGJyPgorPGJyPgorIKAgoCCgIGdwcnNfY29u
dGV4dF9kcml2ZXItJmd0O3JlbW92ZShncHJzX2NvbnRleHRfZGF0YSk7PGJyPgorIKAgoCCgIHN0
ZV9ncHJzX2NvbnRleHRfZXhpdCgpOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCB0ZXN0
X2dwcnNfZGVhY3RpdmF0ZSh2b2lkKTxicj4KK3s8YnI+CisgoCCgIKAgc3RlX2dwcnNfY29udGV4
dF9pbml0KCk7PGJyPgorPGJyPgorIKAgoCCgIGdwcnNfY29udGV4dF9kcml2ZXItJmd0O3Byb2Jl
KE5VTEwsIDAsIGNoYXQpOzxicj4KKyCgIKAgoCBncHJzX2FjdGl2YXRlX2hlbHBlcigpOzxicj4K
Kzxicj4KKyCgIKAgoCBncHJzX2NvbnRleHRfZHJpdmVyLSZndDs8YnI+CisgoCCgIKAgoCCgIKAg
oCBkZWFjdGl2YXRlX3ByaW1hcnkoMCwgY3R4LmNpZCw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoChvZm9ub19ncHJzX2NvbnRleHRfY2JfdCk8YnI+CisgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoG9mb25vX2dlbmVyaWNfY2IsIDApOzxicj4KKyCgIKAgoCBBU1NF
UlRfQVQoJnF1b3Q7QVQqRVBQU0Q9MCwxLDUmcXVvdDspOzxicj4KKyCgIKAgoCBhdF9yZXNwb25z
ZSgmcXVvdDtcclxuT0tcclxuJnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAgZ3Byc19jb250ZXh0
X2RyaXZlci0mZ3Q7cmVtb3ZlKGdwcnNfY29udGV4dF9kYXRhKTs8YnI+CisgoCCgIKAgc3RlX2dw
cnNfY29udGV4dF9leGl0KCk7PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lkIHRlc3RfZ3By
c19ud19kZWFjdCh2b2lkKTxicj4KK3s8YnI+CisgoCCgIKAgc3RlX2dwcnNfY29udGV4dF9pbml0
KCk7PGJyPgorPGJyPgorIKAgoCCgIGdwcnNfY29udGV4dF9kcml2ZXItJmd0O3Byb2JlKE5VTEws
IDAsIGNoYXQpOzxicj4KKyCgIKAgoCBncHJzX2FjdGl2YXRlX2hlbHBlcigpOzxicj4KKzxicj4K
KyCgIKAgoCBhdF9yZXNwb25zZSgmcXVvdDtcclxuK0NHRVY6IE5XIERFQUNUIFxyXG4mcXVvdDsp
Ozxicj4KKyCgIKAgoCBBU1NFUlRfQVQoJnF1b3Q7QVQrQ0dBQ1Q/JnF1b3Q7KTs8YnI+CisgoCCg
IKAgYXRfcmVzcG9uc2UoJnF1b3Q7XHJcbitDR0FDVDogNSwwXHJcbk9LXHJcbiZxdW90Oyk7PGJy
PgorPGJyPgorIKAgoCCgIGdwcnNfY29udGV4dF9kcml2ZXItJmd0O3JlbW92ZShncHJzX2NvbnRl
eHRfZGF0YSk7PGJyPgorIKAgoCCgIHN0ZV9ncHJzX2NvbnRleHRfZXhpdCgpOzxicj4KK308YnI+
Cis8YnI+CitzdGF0aWMgdm9pZCB0ZXN0X2dwcnNfZGVhY3RpdmF0ZV9mYWlsKHZvaWQpPGJyPgor
ezxicj4KKyCgIKAgoCBzdGVfZ3Byc19jb250ZXh0X2luaXQoKTs8YnI+Cis8YnI+CisgoCCgIKAg
Z3Byc19jb250ZXh0X2RyaXZlci0mZ3Q7cHJvYmUoTlVMTCwgMCwgY2hhdCk7PGJyPgorIKAgoCCg
IGdwcnNfYWN0aXZhdGVfaGVscGVyKCk7PGJyPgorPGJyPgorIKAgoCCgIGdwcnNfY29udGV4dF9k
cml2ZXItJmd0Ozxicj4KKyCgIKAgoCCgIKAgoCCgIGRlYWN0aXZhdGVfcHJpbWFyeSgwLCBjdHgu
Y2lkLDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgKG9mb25vX2dwcnNfY29u
dGV4dF9jYl90KTxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgb2Zvbm9fZ2Vu
ZXJpY19jYiwgMCk7PGJyPgorIKAgoCCgIEFTU0VSVF9BVCgmcXVvdDtBVCpFUFBTRD0wLDEsNSZx
dW90Oyk7PGJyPgorIKAgoCCgIGV4cGVjdGVkX2VycnR5cGUgPSBPRk9OT19FUlJPUl9UWVBFX0NN
RTs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJyb3IgPSAxMDA7PGJyPgorIKAgoCCgIGF0X3Jlc3Bv
bnNlKCZxdW90O1xyXG4rQ01FIEVSUk9SOjEwMFxyXG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAg
oCBncHJzX2NvbnRleHRfZHJpdmVyLSZndDtyZW1vdmUoZ3Byc19jb250ZXh0X2RhdGEpOzxicj4K
KyCgIKAgoCBzdGVfZ3Byc19jb250ZXh0X2V4aXQoKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGlj
IHZvaWQgdGVzdF9ncHJzX2RlYWN0aXZhdGVfZXJyKHZvaWQpPGJyPgorezxicj4KKyCgIKAgoCBz
dGVfZ3Byc19jb250ZXh0X2luaXQoKTs8YnI+Cis8YnI+CisgoCCgIKAgZ3Byc19jb250ZXh0X2Ry
aXZlci0mZ3Q7cHJvYmUoTlVMTCwgMCwgY2hhdCk7PGJyPgorPGJyPgorIKAgoCCgIGV4cGVjdGVk
X2VycnR5cGUgPSBPRk9OT19FUlJPUl9UWVBFX0ZBSUxVUkU7PGJyPgorIKAgoCCgIGV4cGVjdGVk
X2Vycm9yID0gMDs8YnI+CisgoCCgIKAgZ3Byc19jb250ZXh0X2RyaXZlci0mZ3Q7PGJyPgorIKAg
oCCgIKAgoCCgIKAgZGVhY3RpdmF0ZV9wcmltYXJ5KDAsIGN0eC5jaWQsPGJyPgorIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAob2Zvbm9fZ3Byc19jb250ZXh0X2NiX3QpPGJyPgorIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKBvZm9ub19nZW5lcmljX2NiLCAwKTs8YnI+Cis8
YnI+CisgoCCgIKAgZ3Byc19jb250ZXh0X2RyaXZlci0mZ3Q7cmVtb3ZlKGdwcnNfY29udGV4dF9k
YXRhKTs8YnI+CisgoCCgIKAgc3RlX2dwcnNfY29udGV4dF9leGl0KCk7PGJyPgorfTxicj4KKzxi
cj4KK3N0YXRpYyB2b2lkIHRlc3RfZ3Byc19kZWFjdF9mYWlsX3RoZW5fb2sodm9pZCk8YnI+Cit7
PGJyPgorIKAgoCCgIHN0ZV9ncHJzX2NvbnRleHRfaW5pdCgpOzxicj4KKzxicj4KKyCgIKAgoCBn
cHJzX2NvbnRleHRfZHJpdmVyLSZndDtwcm9iZShOVUxMLCAwLCBjaGF0KTs8YnI+CisgoCCgIKAg
Z3Byc19hY3RpdmF0ZV9oZWxwZXIoKTs8YnI+Cis8YnI+CisgoCCgIKAgZ3Byc19jb250ZXh0X2Ry
aXZlci0mZ3Q7PGJyPgorIKAgoCCgIKAgoCCgIKAgZGVhY3RpdmF0ZV9wcmltYXJ5KDAsIGN0eC5j
aWQsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAob2Zvbm9fZ3Byc19jb250
ZXh0X2NiX3QpPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKBvZm9ub19nZW5l
cmljX2NiLCAwKTs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJydHlwZSA9IE9GT05PX0VSUk9SX1RZ
UEVfQ01FOzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJvciA9IDEwMDs8YnI+CisgoCCgIKAgYXRf
cmVzcG9uc2UoJnF1b3Q7XHJcbitDTUUgRVJST1I6MTAwXHJcbiZxdW90Oyk7PGJyPgorPGJyPgor
IKAgoCCgIGdwcnNfY29udGV4dF9kcml2ZXItJmd0Ozxicj4KKyCgIKAgoCCgIKAgoCCgIGRlYWN0
aXZhdGVfcHJpbWFyeSgwLCBjdHguY2lkLDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgKG9mb25vX2dwcnNfY29udGV4dF9jYl90KTxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgb2Zvbm9fZ2VuZXJpY19jYiwgMCk7PGJyPgorIKAgoCCgIEFTU0VSVF9BVCgm
cXVvdDtBVCpFUFBTRD0wLDEsNSZxdW90Oyk7PGJyPgorIKAgoCCgIGV4cGVjdGVkX2VycnR5cGUg
PSBPRk9OT19FUlJPUl9UWVBFX05PX0VSUk9SOzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJvciA9
IDA7PGJyPgorIKAgoCCgIGF0X3Jlc3BvbnNlKCZxdW90O1xyXG5PS1xyXG4mcXVvdDspOzxicj4K
Kzxicj4KKyCgIKAgoCBncHJzX2NvbnRleHRfZHJpdmVyLSZndDtyZW1vdmUoZ3Byc19jb250ZXh0
X2RhdGEpOzxicj4KKyCgIKAgoCBzdGVfZ3Byc19jb250ZXh0X2V4aXQoKTs8YnI+Cit9PGJyPgor
PGJyPgorc3RhdGljIHZvaWQgdGVzdF9ncHJzX2VwcHNkX2Vycih2b2lkKTxicj4KK3s8YnI+Cisg
oCCgIKAgc3RlX2dwcnNfY29udGV4dF9pbml0KCk7PGJyPgorPGJyPgorIKAgoCCgIGdwcnNfY29u
dGV4dF9kcml2ZXItJmd0O3Byb2JlKE5VTEwsIDAsIGNoYXQpOzxicj4KKzxicj4KKyCgIKAgoCBl
eHBlY3RlZF9lcnJ0eXBlID0gT0ZPTk9fRVJST1JfVFlQRV9OT19FUlJPUjs8YnI+CisgoCCgIKAg
Z3Byc19jb250ZXh0X2RyaXZlci0mZ3Q7PGJyPgorIKAgoCCgIKAgoCCgIKAgYWN0aXZhdGVfcHJp
bWFyeSgwLCAmYW1wO2N0eCw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoChv
Zm9ub19ncHJzX2NvbnRleHRfdXBfY2JfdCk8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoGdwcnNfY29udGV4dF91cF9jYiwgMCk7PGJyPgorIKAgoCCgIEFTU0VSVF9BVCgmcXVv
dDtBVCtDR0RDT05UPTUsXCZxdW90O0lQXCZxdW90OyxcJnF1b3Q7YXBuXCZxdW90OyZxdW90Oyk7
PGJyPgorIKAgoCCgIGF0X3Jlc3BvbnNlKCZxdW90O1xyXG5PS1xyXG4mcXVvdDspOzxicj4KKyCg
IKAgoCBBU1NFUlRfQVQoJnF1b3Q7QVQqRUlBQVVXPTUsMSxcJnF1b3Q7dXNlclwmcXVvdDssXCZx
dW90O3B3ZFwmcXVvdDsmcXVvdDspOzxicj4KKyCgIKAgoCBhdF9yZXNwb25zZSgmcXVvdDtcclxu
T0tcclxuJnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAgQVNTRVJUX0FUKCZxdW90O0FUKkVQUFNE
PTEsMSw1JnF1b3Q7KTs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJydHlwZSA9IE9GT05PX0VSUk9S
X1RZUEVfQ01FOzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJvciA9IDEwMDs8YnI+CisgoCCgIKAg
YXRfcmVzcG9uc2UoJnF1b3Q7XHJcbitDTUUgRVJST1I6MTAwXHJcbiZxdW90Oyk7PGJyPgorPGJy
PgorIKAgoCCgIGdwcnNfY29udGV4dF9kcml2ZXItJmd0O3JlbW92ZShncHJzX2NvbnRleHRfZGF0
YSk7PGJyPgorIKAgoCCgIHN0ZV9ncHJzX2NvbnRleHRfZXhpdCgpOzxicj4KK308YnI+Cis8YnI+
CitzdGF0aWMgdm9pZCB0ZXN0X2dwcnNfY2dkY29udF9lcnIodm9pZCk8YnI+Cit7PGJyPgorIKAg
oCCgIHN0ZV9ncHJzX2NvbnRleHRfaW5pdCgpOzxicj4KKzxicj4KKyCgIKAgoCBncHJzX2NvbnRl
eHRfZHJpdmVyLSZndDtwcm9iZShOVUxMLCAwLCBjaGF0KTs8YnI+CisgoCCgIKAgZXhwZWN0ZWRf
ZXJydHlwZSA9IE9GT05PX0VSUk9SX1RZUEVfTk9fRVJST1I7PGJyPgorIKAgoCCgIGdwcnNfY29u
dGV4dF9kcml2ZXItJmd0Ozxicj4KKyCgIKAgoCCgIKAgoCCgIGFjdGl2YXRlX3ByaW1hcnkoMCwg
JmFtcDtjdHgsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAob2Zvbm9fZ3By
c19jb250ZXh0X3VwX2NiX3QpPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKBn
cHJzX2NvbnRleHRfdXBfY2IsIDApOzxicj4KKyCgIKAgoCBBU1NFUlRfQVQoJnF1b3Q7QVQrQ0dE
Q09OVD01LFwmcXVvdDtJUFwmcXVvdDssXCZxdW90O2FwblwmcXVvdDsmcXVvdDspOzxicj4KKyCg
IKAgoCBleHBlY3RlZF9lcnJ0eXBlID0gT0ZPTk9fRVJST1JfVFlQRV9DTUU7PGJyPgorIKAgoCCg
IGV4cGVjdGVkX2Vycm9yID0gMTAwOzxicj4KKyCgIKAgoCBhdF9yZXNwb25zZSgmcXVvdDtcclxu
K0NNRSBFUlJPUjoxMDBcclxuJnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAgZ3Byc19jb250ZXh0
X2RyaXZlci0mZ3Q7cmVtb3ZlKGdwcnNfY29udGV4dF9kYXRhKTs8YnI+CisgoCCgIKAgc3RlX2dw
cnNfY29udGV4dF9leGl0KCk7PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lkIHRlc3RfZ3By
c194bWxlcnIodm9pZCk8YnI+Cit7PGJyPgorIKAgoCCgIHN0ZV9ncHJzX2NvbnRleHRfaW5pdCgp
Ozxicj4KKzxicj4KKyCgIKAgoCBncHJzX2NvbnRleHRfZHJpdmVyLSZndDtwcm9iZShOVUxMLCAw
LCBjaGF0KTs8YnI+Cis8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJydHlwZSA9IE9GT05PX0VSUk9S
X1RZUEVfTk9fRVJST1I7PGJyPgorIKAgoCCgIGdwcnNfY29udGV4dF9kcml2ZXItJmd0Ozxicj4K
KyCgIKAgoCCgIKAgoCCgIGFjdGl2YXRlX3ByaW1hcnkoMCwgJmFtcDtjdHgsPGJyPgorIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAob2Zvbm9fZ3Byc19jb250ZXh0X3VwX2NiX3QpPGJy
PgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKBncHJzX2NvbnRleHRfdXBfY2IsIDAp
Ozxicj4KKyCgIKAgoCBBU1NFUlRfQVQoJnF1b3Q7QVQrQ0dEQ09OVD01LFwmcXVvdDtJUFwmcXVv
dDssXCZxdW90O2FwblwmcXVvdDsmcXVvdDspOzxicj4KKyCgIKAgoCBhdF9yZXNwb25zZSgmcXVv
dDtcclxuT0tcclxuJnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAgQVNTRVJUX0FUKCZxdW90O0FU
KkVJQUFVVz01LDEsXCZxdW90O3VzZXJcJnF1b3Q7LFwmcXVvdDtwd2RcJnF1b3Q7JnF1b3Q7KTs8
YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7XHJcbk9LXHJcbiZxdW90Oyk7PGJyPgorPGJy
PgorIKAgoCCgIEFTU0VSVF9BVCgmcXVvdDtBVCpFUFBTRD0xLDEsNSZxdW90Oyk7PGJyPgorIKAg
oCCgIGV4cGVjdGVkX2VycnR5cGUgPSBPRk9OT19FUlJPUl9UWVBFX0ZBSUxVUkU7PGJyPgorIKAg
oCCgIGV4cGVjdGVkX2Vycm9yID0gMDs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoPGJyPgorIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCAmcXVvdDtcclxuJnF1b3Q7PGJyPgorIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCAmcXVvdDsmbHQ7P3htbCB2ZXJzaW9uPVwmcXVvdDsxLjBcJnF1b3Q7PyZndDtcclxu
JnF1b3Q7PGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAmcXVvdDsmbHQ7Y29ubmVjdGlvbl9w
YXJhbWV0ZXJzJmd0O1xyXG4mcXVvdDs8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgICZxdW90
O1hNTC1FUlJPUiZxdW90Ozxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgJnF1b3Q7XHJcbk9L
XHJcbiZxdW90Oyk7PGJyPgorPGJyPgorIKAgoCCgIGdwcnNfY29udGV4dF9kcml2ZXItJmd0O3Jl
bW92ZShncHJzX2NvbnRleHRfZGF0YSk7PGJyPgorIKAgoCCgIHN0ZV9ncHJzX2NvbnRleHRfZXhp
dCgpOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgZW51bSBvZm9ub19yYWRpb19hY2Nlc3NfbW9k
ZSBleHBlY3RlZF9tb2RlOzxicj4KKzxicj4KK3N0YXRpYyB2b2lkIHJhZGlvX3JhdF9tb2RlX3F1
ZXJ5X2NhbGxiYWNrKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJyb3IsPGJyPgorIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgZW51bSBvZm9ub19yYWRpb19hY2Nlc3Nf
bW9kZSBtb2RlLDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIHZv
aWQgKmRhdGEpPGJyPgorezxicj4KKyCgIKAgoCBnX2Fzc2VydF9jbXBpbnQoZXhwZWN0ZWRfZXJy
dHlwZSwgPT0sIGVycm9yLSZndDt0eXBlKTs8YnI+CisgoCCgIKAgZ19hc3NlcnRfY21waW50KGV4
cGVjdGVkX21vZGUsID09LCBtb2RlKTs8YnI+Cit9PGJyPgorPGJyPgorPGJyPgorI2RlZmluZSBR
VUVSWV9SQVQoKSCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoFw8YnI+CisgoCCg
IKAgZG8geyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgXDxicj4K
KyCgIKAgoCCgIKAgoCCgIHJhZGlvX3NldHRpbmdzX2RyaXZlci0mZ3Q7IKAgoCCgIKAgXDxicj4K
KyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgcXVlcnlfcmF0X21vZGUoMCwgoCCgIKAgoCCgIKAgoCBc
PGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIChvZm9ub19yYWRpb19zZXR0aW5n
c19yYXRfbW9kZV9xdWVyeV9jYl90KSBcPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgcmFkaW9fcmF0X21vZGVfcXVlcnlfY2FsbGJhY2ssIDApOyBcPGJyPgorIKAg
oCCgIKAgoCCgIKAgQVNTRVJUX0FUKCZxdW90O0FUK0NGVU4/JnF1b3Q7KTsgoCCgIKAgoCCgIKAg
oCCgIKBcPGJyPgorIKAgoCCgIH0gd2hpbGUgKDApPGJyPgorPGJyPgorc3RhdGljIHZvaWQgdGVz
dF9yYWRpb3NldHRpbmdzX2FsbCh2b2lkKTxicj4KK3s8YnI+CisgoCCgIKAgc3RlX3JhZGlvX3Nl
dHRpbmdzX2luaXQoKTs8YnI+Cis8YnI+CisgoCCgIKAgcmFkaW9fc2V0dGluZ3NfZHJpdmVyLSZn
dDtwcm9iZShOVUxMLCAwLCBjaGF0KTs8YnI+Cis8YnI+CisgoCCgIKAgLyogTm9ybWFsIENhc2Vz
ICovPGJyPgorIKAgoCCgIGV4cGVjdGVkX2VycnR5cGUgPSBPRk9OT19FUlJPUl9UWVBFX05PX0VS
Uk9SOzxicj4KKyCgIKAgoCBleHBlY3RlZF9tb2RlID0gT0ZPTk9fUkFESU9fQUNDRVNTX01PREVf
QU5ZOzxicj4KKyCgIKAgoCBRVUVSWV9SQVQoKTs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1
b3Q7XHJcbitDRlVOOiAxXHJcblxyXG5PS1xyXG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCBR
VUVSWV9SQVQoKTs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfbW9kZSA9IE9GT05PX1JBRElPX0FDQ0VT
U19NT0RFX0dTTTs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7XHJcbitDRlVOOiA1XHJc
blxyXG5PS1xyXG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCBRVUVSWV9SQVQoKTs8YnI+Cisg
oCCgIKAgZXhwZWN0ZWRfbW9kZSA9IE9GT05PX1JBRElPX0FDQ0VTU19NT0RFX1VNVFM7PGJyPgor
IKAgoCCgIGF0X3Jlc3BvbnNlKCZxdW90O1xyXG4rQ0ZVTjogNlxyXG5cclxuT0tcclxuJnF1b3Q7
KTs8YnI+Cis8YnI+CisgoCCgIKAgLyogVW5leHBlY3RlZCB2YWx1ZXMgKi88YnI+CisgoCCgIKAg
ZXhwZWN0ZWRfZXJydHlwZSA9IE9GT05PX0VSUk9SX1RZUEVfRkFJTFVSRTs8YnI+CisgoCCgIKAg
ZXhwZWN0ZWRfbW9kZSA9IC0xOzxicj4KKyCgIKAgoCBRVUVSWV9SQVQoKTs8YnI+CisgoCCgIKAg
YXRfcmVzcG9uc2UoJnF1b3Q7XHJcbitDRlVOOiAwXHJcblxyXG5PS1xyXG4mcXVvdDspOzxicj4K
Kzxicj4KKyCgIKAgoCBRVUVSWV9SQVQoKTs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7
XHJcbitDRlVOOiA0XHJcblxyXG5PS1xyXG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCBRVUVS
WV9SQVQoKTs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7XHJcbitDRlVOOiAxMVxyXG5c
clxuT0tcclxuJnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAgLyogRXJyb3IgY2FzZXMgKi88YnI+
CisgoCCgIKAgUVVFUllfUkFUKCk7PGJyPgorIKAgoCCgIGV4cGVjdGVkX2VycnR5cGUgPSBPRk9O
T19FUlJPUl9UWVBFX0ZBSUxVUkU7PGJyPgorIKAgoCCgIGV4cGVjdGVkX21vZGUgPSAtMTs8YnI+
CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7XHJcbkVSUk9SXHJcbiZxdW90Oyk7PGJyPgorPGJy
PgorIKAgoCCgIFFVRVJZX1JBVCgpOzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJ0eXBlID0gT0ZP
Tk9fRVJST1JfVFlQRV9DTUU7PGJyPgorIKAgoCCgIGV4cGVjdGVkX2Vycm9yID0gMTAwOzxicj4K
KyCgIKAgoCBhdF9yZXNwb25zZSgmcXVvdDtcclxuK0NNRSBFUlJPUjoxMDBcclxuJnF1b3Q7KTs8
YnI+Cis8YnI+CisgoCCgIKAgcmFkaW9fc2V0dGluZ3NfZHJpdmVyLSZndDtyZW1vdmUocmFkaW9f
c2V0dGluZ3NfZGF0YSk7PGJyPgorIKAgoCCgIHN0ZV9yYWRpb19zZXR0aW5nc19leGl0KCk7PGJy
PgorfTxicj4KKzxicj4KKy8qIFRlc3QgUGhvbmUgbnVtYmVyICovPGJyPgorc3RhdGljIHN0cnVj
dCBvZm9ub19waG9uZV9udW1iZXIgcGggPSB7JnF1b3Q7NDQyNTk5MzAwMzczOSZxdW90OywgMTQ1
IH07PGJyPgorPGJyPgorc3RhdGljIHZvaWQgdm9pY2VjYWxsX2FjdGl2YXRlX2hlbHBlcih2b2lk
KTxicj4KK3s8YnI+CisgoCCgIKAgc3RlX3ZvaWNlY2FsbF9pbml0KCk7PGJyPgorIKAgoCCgIHZv
aWNlY2FsbF9kcml2ZXItJmd0O3Byb2JlKE5VTEwsIDAsIGNoYXQpOzxicj4KKzxicj4KKyCgIKAg
oCBBU1NFUlRfQVQoJnF1b3Q7QVQqRUNBTT0yJnF1b3Q7KTs8YnI+CisgoCCgIKAgYXRfcmVzcG9u
c2UoJnF1b3Q7XHJcbk9LXHJcbiZxdW90Oyk7PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lk
IHRlc3Rfdm9pY2VjYWxsX2RpYWwodm9pZCk8YnI+Cit7PGJyPgorIKAgoCCgIC8qIFZvaWNlIGNh
bGwgaW5pdGlhbGlzYXRpb24gKi88YnI+CisgoCCgIKAgdm9pY2VjYWxsX2FjdGl2YXRlX2hlbHBl
cigpOzxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJpdmVyLSZndDtkaWFsKDAsICZhbXA7
cGgsIDAsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAob2Zvbm9fdm9pY2VjYWxsX2NiX3Qp
b2Zvbm9fZ2VuZXJpY19jYiwgMCk7PGJyPgorIKAgoCCgIEFTU0VSVF9BVCgmcXVvdDtBVEQrNDQy
NTk5MzAwMzczOTsmcXVvdDspOzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJ0eXBlID0gT0ZPTk9f
RVJST1JfVFlQRV9OT19FUlJPUjs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJyb3IgPSAwOzxicj4K
KyCgIKAgoCBhdF9yZXNwb25zZSgmcXVvdDtcclxuT0tcclxuJnF1b3Q7KTs8YnI+Cis8YnI+Cisg
oCCgIKAgdm9pY2VjYWxsX2RyaXZlci0mZ3Q7cmVtb3ZlKHZvaWNlY2FsbF9kYXRhKTs8YnI+Cisg
oCCgIKAgc3RlX3ZvaWNlY2FsbF9leGl0KCk7PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lk
IHRlc3Rfdm9pY2VjYWxsX2RpYWxfY29scCh2b2lkKTxicj4KK3s8YnI+CisgoCCgIKAgLyogVm9p
Y2UgY2FsbCBpbml0aWFsaXNhdGlvbiAqLzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfYWN0aXZhdGVf
aGVscGVyKCk7PGJyPgorPGJyPgorIKAgoCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O2RpYWwoMCwg
JmFtcDtwaCwgMCw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIChvZm9ub192b2ljZWNhbGxf
Y2JfdClvZm9ub19nZW5lcmljX2NiLCAwKTs8YnI+CisgoCCgIKAgQVNTRVJUX0FUKCZxdW90O0FU
RCs0NDI1OTkzMDAzNzM5OyZxdW90Oyk7PGJyPgorIKAgoCCgIGV4cGVjdGVkX2VycnR5cGUgPSBP
Rk9OT19FUlJPUl9UWVBFX05PX0VSUk9SOzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJvciA9IDA7
PGJyPgorIKAgoCCgIGV4cGVjdGVkX3N0YXR1cyA9IENBTExfU1RBVFVTX0RJQUxJTkc7PGJyPgor
IKAgoCCgIHNwcmludGYoZXhwZWN0ZWRfbnVtYmVyLCAmcXVvdDsrNDQyNTk5MzAwMzczOSZxdW90
Oyk7PGJyPgorIKAgoCCgIGF0X3Jlc3BvbnNlKCZxdW90O1xyXG4rQ09MUDogXCZxdW90Oys0NDI1
OTkzMDAzNzM5XCZxdW90OywxMjlcclxuT0tcclxuJnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAg
dm9pY2VjYWxsX2RyaXZlci0mZ3Q7cmVtb3ZlKHZvaWNlY2FsbF9kYXRhKTs8YnI+CisgoCCgIKAg
c3RlX3ZvaWNlY2FsbF9leGl0KCk7PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lkIHRlc3Rf
dm9pY2VjYWxsX2RpYWxfZXJyb25lb3VzX2NvbHAodm9pZCk8YnI+Cit7PGJyPgorIKAgoCCgIC8q
IFZvaWNlIGNhbGwgaW5pdGlhbGlzYXRpb24gKi88YnI+CisgoCCgIKAgdm9pY2VjYWxsX2FjdGl2
YXRlX2hlbHBlcigpOzxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJpdmVyLSZndDtkaWFs
KDAsICZhbXA7cGgsIDAsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAob2Zvbm9fdm9pY2Vj
YWxsX2NiX3Qpb2Zvbm9fZ2VuZXJpY19jYiwgMCk7PGJyPgorIKAgoCCgIEFTU0VSVF9BVCgmcXVv
dDtBVEQrNDQyNTk5MzAwMzczOTsmcXVvdDspOzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJ0eXBl
ID0gT0ZPTk9fRVJST1JfVFlQRV9OT19FUlJPUjs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJyb3Ig
PSAwOzxicj4KKyCgIKAgoCBleHBlY3RlZF9zdGF0dXMgPSBDQUxMX1NUQVRVU19ESUFMSU5HOzxi
cj4KKyCgIKAgoCBzcHJpbnRmKGV4cGVjdGVkX251bWJlciwgJnF1b3Q7KzQ0MjU5OTMwMDM3Mzkm
cXVvdDspOzxicj4KKyCgIKAgoCBhdF9yZXNwb25zZSgmcXVvdDtcclxuK0NPTFA6XHJcbk9LXHJc
biZxdW90Oyk7PGJyPgorPGJyPgorIKAgoCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O3JlbW92ZSh2
b2ljZWNhbGxfZGF0YSk7PGJyPgorIKAgoCCgIHN0ZV92b2ljZWNhbGxfZXhpdCgpOzxicj4KK308
YnI+Cis8YnI+CitzdGF0aWMgdm9pZCB0ZXN0X3ZvaWNlY2FsbF9kaWFsX2ZhaWwodm9pZCk8YnI+
Cit7PGJyPgorIKAgoCCgIC8qIFZvaWNlIGNhbGwgaW5pdGlhbGlzYXRpb24gKi88YnI+CisgoCCg
IKAgdm9pY2VjYWxsX2FjdGl2YXRlX2hlbHBlcigpOzxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNh
bGxfZHJpdmVyLSZndDtkaWFsKDAsICZhbXA7cGgsIDAsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCAob2Zvbm9fdm9pY2VjYWxsX2NiX3Qpb2Zvbm9fZ2VuZXJpY19jYiwgMCk7PGJyPgorIKAg
oCCgIEFTU0VSVF9BVCgmcXVvdDtBVEQrNDQyNTk5MzAwMzczOTsmcXVvdDspOzxicj4KKyCgIKAg
oCBleHBlY3RlZF9lcnJ0eXBlID0gT0ZPTk9fRVJST1JfVFlQRV9DTUU7PGJyPgorIKAgoCCgIGV4
cGVjdGVkX2Vycm9yID0gNDIzOyAvKiBOZXR3b3JrIHByb2JsZW0gKi88YnI+CisgoCCgIKAgYXRf
cmVzcG9uc2UoJnF1b3Q7XHJcbitDTUUgRVJST1I6NDIzXHJcbiZxdW90Oyk7PGJyPgorPGJyPgor
IKAgoCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O3JlbW92ZSh2b2ljZWNhbGxfZGF0YSk7PGJyPgor
IKAgoCCgIHN0ZV92b2ljZWNhbGxfZXhpdCgpOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9p
ZCB0ZXN0X3ZvaWNlY2FsbF9kaWFsX2J1c3kodm9pZCk8YnI+Cit7PGJyPgorIKAgoCCgIC8qIFZv
aWNlIGNhbGwgaW5pdGlhbGlzYXRpb24gKi88YnI+CisgoCCgIKAgdm9pY2VjYWxsX2FjdGl2YXRl
X2hlbHBlcigpOzxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJpdmVyLSZndDtkaWFsKDAs
ICZhbXA7cGgsIDAsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAob2Zvbm9fdm9pY2VjYWxs
X2NiX3Qpb2Zvbm9fZ2VuZXJpY19jYiwgMCk7PGJyPgorIKAgoCCgIEFTU0VSVF9BVCgmcXVvdDtB
VEQrNDQyNTk5MzAwMzczOTsmcXVvdDspOzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJ0eXBlID0g
T0ZPTk9fRVJST1JfVFlQRV9GQUlMVVJFOzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJvciA9IDA7
PGJyPgorIKAgoCCgIGF0X3Jlc3BvbnNlKCZxdW90O1xyXG5CVVNZXHJcbiZxdW90Oyk7PGJyPgor
PGJyPgorIKAgoCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O3JlbW92ZSh2b2ljZWNhbGxfZGF0YSk7
PGJyPgorIKAgoCCgIHN0ZV92b2ljZWNhbGxfZXhpdCgpOzxicj4KK308YnI+Cis8YnI+CitzdGF0
aWMgdm9pZCB0ZXN0X3ZvaWNlY2FsbF9kaWFsX25vX2RpYWx0b25lKHZvaWQpPGJyPgorezxicj4K
KyCgIKAgoCAvKiBWb2ljZSBjYWxsIGluaXRpYWxpc2F0aW9uICovPGJyPgorIKAgoCCgIHZvaWNl
Y2FsbF9hY3RpdmF0ZV9oZWxwZXIoKTs8YnI+Cis8YnI+CisgoCCgIKAgdm9pY2VjYWxsX2RyaXZl
ci0mZ3Q7ZGlhbCgwLCAmYW1wO3BoLCAwLDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgKG9m
b25vX3ZvaWNlY2FsbF9jYl90KW9mb25vX2dlbmVyaWNfY2IsIDApOzxicj4KKyCgIKAgoCBBU1NF
UlRfQVQoJnF1b3Q7QVREKzQ0MjU5OTMwMDM3Mzk7JnF1b3Q7KTs8YnI+CisgoCCgIKAgZXhwZWN0
ZWRfZXJydHlwZSA9IE9GT05PX0VSUk9SX1RZUEVfRkFJTFVSRTs8YnI+CisgoCCgIKAgZXhwZWN0
ZWRfZXJyb3IgPSAwOzxicj4KKyCgIKAgoCBhdF9yZXNwb25zZSgmcXVvdDtcclxuTk8gRElBTFRP
TkVcclxuJnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAgdm9pY2VjYWxsX2RyaXZlci0mZ3Q7cmVt
b3ZlKHZvaWNlY2FsbF9kYXRhKTs8YnI+CisgoCCgIKAgc3RlX3ZvaWNlY2FsbF9leGl0KCk7PGJy
PgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lkIHRlc3Rfdm9pY2VjYWxsX2hhbmd1cCh2b2lkKTxi
cj4KK3s8YnI+CisgoCCgIKAgLyogVm9pY2UgY2FsbCBpbml0aWFsaXNhdGlvbiAqLzxicj4KKyCg
IKAgoCB2b2ljZWNhbGxfYWN0aXZhdGVfaGVscGVyKCk7PGJyPgorPGJyPgorIKAgoCCgIGV4cGVj
dGVkX2VycnR5cGUgPSBPRk9OT19FUlJPUl9UWVBFX05PX0VSUk9SOzxicj4KKyCgIKAgoCBleHBl
Y3RlZF9lcnJvciA9IDA7PGJyPgorPGJyPgorIKAgoCCgIC8qIEhhbmd1cCAqLzxicj4KKyCgIKAg
oCB2b2ljZWNhbGxfZHJpdmVyLSZndDtoYW5ndXBfYWN0aXZlKDAsPGJyPgorIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCAob2Zvbm9fdm9pY2VjYWxsX2NiX3Qpb2Zvbm9fZ2VuZXJpY19jYiwgMCk7PGJy
PgorIKAgoCCgIEFTU0VSVF9BVCgmcXVvdDtBVCtDSFVQJnF1b3Q7KTs8YnI+CisgoCCgIKAgYXRf
cmVzcG9uc2UoJnF1b3Q7XHJcbk9LXHJcbiZxdW90Oyk7PGJyPgorPGJyPgorIKAgoCCgIHZvaWNl
Y2FsbF9kcml2ZXItJmd0O3JlbW92ZSh2b2ljZWNhbGxfZGF0YSk7PGJyPgorIKAgoCCgIHN0ZV92
b2ljZWNhbGxfZXhpdCgpOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCB0ZXN0X3ZvaWNl
Y2FsbF9oYW5ndXBfZmFpbCh2b2lkKTxicj4KK3s8YnI+CisgoCCgIKAgLyogVm9pY2UgY2FsbCBp
bml0aWFsaXNhdGlvbiAqLzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfYWN0aXZhdGVfaGVscGVyKCk7
PGJyPgorPGJyPgorIKAgoCCgIC8qIEhhbmd1cCAqLzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJp
dmVyLSZndDtoYW5ndXBfYWN0aXZlKDAsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAob2Zv
bm9fdm9pY2VjYWxsX2NiX3Qpb2Zvbm9fZ2VuZXJpY19jYiwgMCk7PGJyPgorIKAgoCCgIEFTU0VS
VF9BVCgmcXVvdDtBVCtDSFVQJnF1b3Q7KTs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJydHlwZSA9
IE9GT05PX0VSUk9SX1RZUEVfQ01FOzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJvciA9IDEwMDs8
YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7XHJcbitDTUUgRVJST1I6MTAwXHJcbiZxdW90
Oyk7PGJyPgorPGJyPgorIKAgoCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O3JlbW92ZSh2b2ljZWNh
bGxfZGF0YSk7PGJyPgorIKAgoCCgIHN0ZV92b2ljZWNhbGxfZXhpdCgpOzxicj4KK308YnI+Cis8
YnI+CitzdGF0aWMgdm9pZCB0ZXN0X3ZvaWNlY2FsbF9ob2xkKHZvaWQpPGJyPgorezxicj4KKyCg
IKAgoCAvKiBWb2ljZSBjYWxsIGluaXRpYWxpc2F0aW9uICovPGJyPgorIKAgoCCgIHZvaWNlY2Fs
bF9hY3RpdmF0ZV9oZWxwZXIoKTs8YnI+Cis8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJydHlwZSA9
IE9GT05PX0VSUk9SX1RZUEVfTk9fRVJST1I7PGJyPgorIKAgoCCgIGV4cGVjdGVkX2Vycm9yID0g
MDs8YnI+Cis8YnI+CisgoCCgIKAgLyogSG9sZCBDYWxsICovPGJyPgorIKAgoCCgIHZvaWNlY2Fs
bF9kcml2ZXItJmd0O2hvbGRfYWxsX2FjdGl2ZSgwLDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgKG9mb25vX3ZvaWNlY2FsbF9jYl90KW9mb25vX2dlbmVyaWNfY2IsIDApOzxicj4KKyCgIKAg
oCBBU1NFUlRfQVQoJnF1b3Q7QVQrQ0hMRD0yJnF1b3Q7KTs8YnI+CisgoCCgIKAgYXRfcmVzcG9u
c2UoJnF1b3Q7XHJcbk9LXHJcbiZxdW90Oyk7PGJyPgorPGJyPgorIKAgoCCgIHZvaWNlY2FsbF9k
cml2ZXItJmd0O3JlbW92ZSh2b2ljZWNhbGxfZGF0YSk7PGJyPgorIKAgoCCgIHN0ZV92b2ljZWNh
bGxfZXhpdCgpOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCB0ZXN0X3ZvaWNlY2FsbF9y
ZWxlYXNlX2FsbF9oZWxkKHZvaWQpPGJyPgorezxicj4KKyCgIKAgoCAvKiBWb2ljZSBjYWxsIGlu
aXRpYWxpc2F0aW9uICovPGJyPgorIKAgoCCgIHZvaWNlY2FsbF9hY3RpdmF0ZV9oZWxwZXIoKTs8
YnI+Cis8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJydHlwZSA9IE9GT05PX0VSUk9SX1RZUEVfTk9f
RVJST1I7PGJyPgorIKAgoCCgIGV4cGVjdGVkX2Vycm9yID0gMDs8YnI+Cis8YnI+CisgoCCgIKAg
LyogUmVsZWFzZSBDYWxsICovPGJyPgorIKAgoCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O3JlbGVh
c2VfYWxsX2hlbGQoMCw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIChvZm9ub192b2ljZWNh
bGxfY2JfdClvZm9ub19nZW5lcmljX2NiLCAwKTs8YnI+CisgoCCgIKAgQVNTRVJUX0FUKCZxdW90
O0FUK0NITEQ9MCZxdW90Oyk7PGJyPgorIKAgoCCgIGF0X3Jlc3BvbnNlKCZxdW90O1xyXG5PS1xy
XG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJpdmVyLSZndDtyZW1vdmUo
dm9pY2VjYWxsX2RhdGEpOzxicj4KKyCgIKAgoCBzdGVfdm9pY2VjYWxsX2V4aXQoKTs8YnI+Cit9
PGJyPgorPGJyPgorc3RhdGljIHZvaWQgdGVzdF92b2ljZWNhbGxfcmVsZWFzZV9hbGxfYWN0aXZl
KHZvaWQpPGJyPgorezxicj4KKyCgIKAgoCAvKiBWb2ljZSBjYWxsIGluaXRpYWxpc2F0aW9uICov
PGJyPgorIKAgoCCgIHZvaWNlY2FsbF9hY3RpdmF0ZV9oZWxwZXIoKTs8YnI+Cis8YnI+CisgoCCg
IKAgZXhwZWN0ZWRfZXJydHlwZSA9IE9GT05PX0VSUk9SX1RZUEVfTk9fRVJST1I7PGJyPgorIKAg
oCCgIGV4cGVjdGVkX2Vycm9yID0gMDs8YnI+Cis8YnI+CisgoCCgIKAgLyogUmVsZWFzZSBDYWxs
ICovPGJyPgorIKAgoCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O3JlbGVhc2VfYWxsX2FjdGl2ZSgw
LDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgKG9mb25vX3ZvaWNlY2FsbF9jYl90KW9mb25v
X2dlbmVyaWNfY2IsIDApOzxicj4KKyCgIKAgoCBBU1NFUlRfQVQoJnF1b3Q7QVQrQ0hMRD0xJnF1
b3Q7KTs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7XHJcbk9LXHJcbiZxdW90Oyk7PGJy
PgorPGJyPgorIKAgoCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O3JlbW92ZSh2b2ljZWNhbGxfZGF0
YSk7PGJyPgorIKAgoCCgIHN0ZV92b2ljZWNhbGxfZXhpdCgpOzxicj4KK308YnI+Cis8YnI+Citz
dGF0aWMgdm9pZCB0ZXN0X3ZvaWNlY2FsbF9hbnN3ZXIodm9pZCk8YnI+Cit7PGJyPgorIKAgoCCg
IC8qIFZvaWNlIGNhbGwgaW5pdGlhbGlzYXRpb24gKi88YnI+CisgoCCgIKAgdm9pY2VjYWxsX2Fj
dGl2YXRlX2hlbHBlcigpOzxicj4KKzxicj4KKyCgIKAgoCAvKiBBbnN3ZXIgQ2FsbCAqLzxicj4K
KyCgIKAgoCB2b2ljZWNhbGxfZHJpdmVyLSZndDthbnN3ZXIoMCwgKG9mb25vX3ZvaWNlY2FsbF9j
Yl90KW9mb25vX2dlbmVyaWNfY2IsIDApOzxicj4KKyCgIKAgoCBBU1NFUlRfQVQoJnF1b3Q7QVRB
JnF1b3Q7KTs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJydHlwZSA9IE9GT05PX0VSUk9SX1RZUEVf
Tk9fRVJST1I7PGJyPgorIKAgoCCgIGV4cGVjdGVkX2Vycm9yID0gMDs8YnI+CisgoCCgIKAgYXRf
cmVzcG9uc2UoJnF1b3Q7XHJcbk9LXHJcbiZxdW90Oyk7PGJyPgorPGJyPgorIKAgoCCgIHZvaWNl
Y2FsbF9kcml2ZXItJmd0O3JlbW92ZSh2b2ljZWNhbGxfZGF0YSk7PGJyPgorIKAgoCCgIHN0ZV92
b2ljZWNhbGxfZXhpdCgpOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCB0ZXN0X3ZvaWNl
Y2FsbF9hbnN3ZXJfZXJyb3Iodm9pZCk8YnI+Cit7PGJyPgorIKAgoCCgIC8qIFZvaWNlIGNhbGwg
aW5pdGlhbGlzYXRpb24gKi88YnI+CisgoCCgIKAgdm9pY2VjYWxsX2FjdGl2YXRlX2hlbHBlcigp
Ozxicj4KKzxicj4KKyCgIKAgoCAvKiBBbnN3ZXIgQ2FsbCAqLzxicj4KKyCgIKAgoCB2b2ljZWNh
bGxfZHJpdmVyLSZndDthbnN3ZXIoMCwgKG9mb25vX3ZvaWNlY2FsbF9jYl90KW9mb25vX2dlbmVy
aWNfY2IsIDApOzxicj4KKyCgIKAgoCBBU1NFUlRfQVQoJnF1b3Q7QVRBJnF1b3Q7KTs8YnI+Cisg
oCCgIKAgZXhwZWN0ZWRfZXJydHlwZSA9IE9GT05PX0VSUk9SX1RZUEVfRkFJTFVSRTs8YnI+Cisg
oCCgIKAgZXhwZWN0ZWRfZXJyb3IgPSAwOzxicj4KKyCgIKAgoCBhdF9yZXNwb25zZSgmcXVvdDtc
clxuTk8gQ0FSUklFUlxyXG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJp
dmVyLSZndDtyZW1vdmUodm9pY2VjYWxsX2RhdGEpOzxicj4KKyCgIKAgoCBzdGVfdm9pY2VjYWxs
X2V4aXQoKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgdGVzdF92b2ljZWNhbGxfbXVs
dGlwYXJ0eSh2b2lkKTxicj4KK3s8YnI+CisgoCCgIKAgLyogVm9pY2UgY2FsbCBpbml0aWFsaXNh
dGlvbiAqLzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfYWN0aXZhdGVfaGVscGVyKCk7PGJyPgorPGJy
PgorIKAgoCCgIGV4cGVjdGVkX2VycnR5cGUgPSBPRk9OT19FUlJPUl9UWVBFX05PX0VSUk9SOzxi
cj4KKyCgIKAgoCBleHBlY3RlZF9lcnJvciA9IDA7PGJyPgorPGJyPgorIKAgoCCgIC8qIE11bHRp
cGFydHkgKi88YnI+CisgoCCgIKAgdm9pY2VjYWxsX2RyaXZlci0mZ3Q7Y3JlYXRlX211bHRpcGFy
dHkoMCw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIChvZm9ub192b2ljZWNhbGxfY2JfdClv
Zm9ub19nZW5lcmljX2NiLCAwKTs8YnI+CisgoCCgIKAgQVNTRVJUX0FUKCZxdW90O0FUK0NITEQ9
MyZxdW90Oyk7PGJyPgorIKAgoCCgIGF0X3Jlc3BvbnNlKCZxdW90O1xyXG5PS1xyXG4mcXVvdDsp
Ozxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJpdmVyLSZndDtyZW1vdmUodm9pY2VjYWxs
X2RhdGEpOzxicj4KKyCgIKAgoCBzdGVfdm9pY2VjYWxsX2V4aXQoKTs8YnI+Cit9PGJyPgorPGJy
Pgorc3RhdGljIHZvaWQgdGVzdF92b2ljZWNhbGxfdHJhbnNmZXIodm9pZCk8YnI+Cit7PGJyPgor
IKAgoCCgIC8qIFZvaWNlIGNhbGwgaW5pdGlhbGlzYXRpb24gKi88YnI+CisgoCCgIKAgdm9pY2Vj
YWxsX2FjdGl2YXRlX2hlbHBlcigpOzxicj4KKzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJ0eXBl
ID0gT0ZPTk9fRVJST1JfVFlQRV9OT19FUlJPUjs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJyb3Ig
PSAwOzxicj4KKzxicj4KKyCgIKAgoCAvKiBUcmFuc2ZlciAqLzxicj4KKyCgIKAgoCB2b2ljZWNh
bGxfZHJpdmVyLSZndDt0cmFuc2ZlcigwLDxicj4KKyCgIKAgoCCgIKAgoCCgIChvZm9ub192b2lj
ZWNhbGxfY2JfdClvZm9ub19nZW5lcmljX2NiLCAwKTs8YnI+CisgoCCgIKAgQVNTRVJUX0FUKCZx
dW90O0FUK0NITEQ9NCZxdW90Oyk7PGJyPgorIKAgoCCgIGF0X3Jlc3BvbnNlKCZxdW90O1xyXG5P
S1xyXG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJpdmVyLSZndDtyZW1v
dmUodm9pY2VjYWxsX2RhdGEpOzxicj4KKyCgIKAgoCBzdGVfdm9pY2VjYWxsX2V4aXQoKTs8YnI+
Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgdGVzdF92b2ljZWNhbGxfZGVmbGVjdCh2b2lkKTxi
cj4KK3s8YnI+CisgoCCgIKAgLyogVm9pY2UgY2FsbCBpbml0aWFsaXNhdGlvbiAqLzxicj4KKyCg
IKAgoCB2b2ljZWNhbGxfYWN0aXZhdGVfaGVscGVyKCk7PGJyPgorPGJyPgorIKAgoCCgIGV4cGVj
dGVkX2VycnR5cGUgPSBPRk9OT19FUlJPUl9UWVBFX05PX0VSUk9SOzxicj4KKyCgIKAgoCBleHBl
Y3RlZF9lcnJvciA9IDA7PGJyPgorPGJyPgorIKAgoCCgIC8qIFRyYW5zZmVyICovPGJyPgorIKAg
oCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O2RlZmxlY3QoMCwgJmFtcDtwaCw8YnI+CisgoCCgIKAg
oCCgIKAgoCAob2Zvbm9fdm9pY2VjYWxsX2NiX3Qpb2Zvbm9fZ2VuZXJpY19jYiwgMCk7PGJyPgor
IKAgoCCgIEFTU0VSVF9BVCgmcXVvdDtBVCtDVEZSPVwmcXVvdDs0NDI1OTkzMDAzNzM5XCZxdW90
OywxNDUmcXVvdDspOzxicj4KKyCgIKAgoCBhdF9yZXNwb25zZSgmcXVvdDtcclxuT0tcclxuJnF1
b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAgdm9pY2VjYWxsX2RyaXZlci0mZ3Q7cmVtb3ZlKHZvaWNl
Y2FsbF9kYXRhKTs8YnI+CisgoCCgIKAgc3RlX3ZvaWNlY2FsbF9leGl0KCk7PGJyPgorfTxicj4K
Kzxicj4KK3N0YXRpYyB2b2lkIHRlc3Rfdm9pY2VjYWxsX3NlbmRfdG9uZXModm9pZCk8YnI+Cit7
PGJyPgorIKAgoCCgIGNvbnN0IGNoYXIgKnRlc3QgPSAmcXVvdDs4LDkmcXVvdDs7PGJyPgorIKAg
oCCgIC8qIFZvaWNlIGNhbGwgaW5pdGlhbGlzYXRpb24gKi88YnI+CisgoCCgIKAgdm9pY2VjYWxs
X2FjdGl2YXRlX2hlbHBlcigpOzxicj4KKzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJ0eXBlID0g
T0ZPTk9fRVJST1JfVFlQRV9OT19FUlJPUjs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfZXJyb3IgPSAw
Ozxicj4KKzxicj4KKyCgIKAgoCAvKiBTZW5kIERUTUYgdG9uZSAqLzxicj4KKyCgIKAgoCB2b2lj
ZWNhbGxfZHJpdmVyLSZndDtzZW5kX3RvbmVzKDAsIHRlc3QsPGJyPgorIKAgoCCgIKAgoCCgIKAg
KG9mb25vX3ZvaWNlY2FsbF9jYl90KW9mb25vX2dlbmVyaWNfY2IsIDApOzxicj4KKyCgIKAgoCBB
U1NFUlRfQVQoJnF1b3Q7QVQrVlRTPTgsOSZxdW90Oyk7PGJyPgorIKAgoCCgIGF0X3Jlc3BvbnNl
KCZxdW90O1xyXG5PS1xyXG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJp
dmVyLSZndDtyZW1vdmUodm9pY2VjYWxsX2RhdGEpOzxicj4KKyCgIKAgoCBzdGVfdm9pY2VjYWxs
X2V4aXQoKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgdGVzdF92b2ljZWNhbGxfcmVs
ZWFzZV9zcGVjaWZpYyh2b2lkKTxicj4KK3s8YnI+CisgoCCgIKAgLyogVm9pY2UgY2FsbCBpbml0
aWFsaXNhdGlvbiAqLzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfYWN0aXZhdGVfaGVscGVyKCk7PGJy
PgorPGJyPgorIKAgoCCgIGV4cGVjdGVkX2VycnR5cGUgPSBPRk9OT19FUlJPUl9UWVBFX05PX0VS
Uk9SOzxicj4KKyCgIKAgoCBleHBlY3RlZF9lcnJvciA9IDA7PGJyPgorPGJyPgorIKAgoCCgIC8q
IFJlbGVhc2UgQ2FsbCAqLzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJpdmVyLSZndDtyZWxlYXNl
X3NwZWNpZmljKDAsIDMsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAob2Zvbm9fdm9pY2Vj
YWxsX2NiX3Qpb2Zvbm9fZ2VuZXJpY19jYiwgMCk7PGJyPgorIKAgoCCgIEFTU0VSVF9BVCgmcXVv
dDtBVCtDSExEPTEzJnF1b3Q7KTs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7XHJcbk9L
XHJcbiZxdW90Oyk7PGJyPgorPGJyPgorIKAgoCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O3JlbW92
ZSh2b2ljZWNhbGxfZGF0YSk7PGJyPgorIKAgoCCgIHN0ZV92b2ljZWNhbGxfZXhpdCgpOzxicj4K
K308YnI+Cis8YnI+Cis8YnI+CitzdGF0aWMgdm9pZCB0ZXN0X3ZvaWNlY2FsbF9lY2F2X2FsZXJ0
aW5nKHZvaWQpPGJyPgorezxicj4KKyCgIKAgoCB2b2ljZWNhbGxfYWN0aXZhdGVfaGVscGVyKCk7
PGJyPgorPGJyPgorIKAgoCCgIGV4cGVjdGVkX2lkID0gMTs8YnI+CisgoCCgIKAgZXhwZWN0ZWRf
c3RhdHVzID0gQ0FMTF9TVEFUVVNfSU5DT01JTkc7PGJyPgorIKAgoCCgIHNwcmludGYoZXhwZWN0
ZWRfbnVtYmVyLCAmcXVvdDsrNDQyNTk5MzAwNTEzMyZxdW90Oyk7PGJyPgorIKAgoCCgIGF0X3Jl
c3BvbnNlKCZxdW90O1xyXG4qRUNBVjogMSw2LDEsLCxcJnF1b3Q7KzQ0MjU5OTMwMDUxMzNcJnF1
b3Q7LDE0NVxyXG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJpdmVyLSZn
dDtyZW1vdmUodm9pY2VjYWxsX2RhdGEpOzxicj4KKyCgIKAgoCBzdGVfdm9pY2VjYWxsX2V4aXQo
KTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgdGVzdF92b2ljZWNhbGxfZWNhdl9hbGVy
dGluZ19udW1iZXJfd2l0aGhlbGQodm9pZCk8YnI+Cit7PGJyPgorIKAgoCCgIHZvaWNlY2FsbF9h
Y3RpdmF0ZV9oZWxwZXIoKTs8YnI+Cis8YnI+CisgoCCgIKAgZXhwZWN0ZWRfaWQgPSAxOzxicj4K
KyCgIKAgoCBleHBlY3RlZF9zdGF0dXMgPSBDQUxMX1NUQVRVU19JTkNPTUlORzs8YnI+CisgoCCg
IKAgc3RyY3B5KGV4cGVjdGVkX251bWJlciwgJnF1b3Q7JnF1b3Q7KTs8YnI+CisgoCCgIKAgYXRf
cmVzcG9uc2UoJnF1b3Q7XHJcbipFQ0FWOiAxLDYsMVxyXG4mcXVvdDspOzxicj4KKzxicj4KKyCg
IKAgoCB2b2ljZWNhbGxfZHJpdmVyLSZndDtyZW1vdmUodm9pY2VjYWxsX2RhdGEpOzxicj4KKyCg
IKAgoCBzdGVfdm9pY2VjYWxsX2V4aXQoKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQg
dGVzdF92b2ljZWNhbGxfZWNhdl93YWl0aW5nKHZvaWQpPGJyPgorezxicj4KKyCgIKAgoCB2b2lj
ZWNhbGxfYWN0aXZhdGVfaGVscGVyKCk7PGJyPgorPGJyPgorIKAgoCCgIGV4cGVjdGVkX2lkID0g
MTs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfc3RhdHVzID0gQ0FMTF9TVEFUVVNfV0FJVElORzs8YnI+
CisgoCCgIKAgc3ByaW50ZihleHBlY3RlZF9udW1iZXIsICZxdW90Oys0NDI1OTkzMDA1MTMzJnF1
b3Q7KTs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7XHJcbipFQ0FWOiAxLDUsMSwsLFwm
cXVvdDsrNDQyNTk5MzAwNTEzM1wmcXVvdDssMTQ1XHJcbiZxdW90Oyk7PGJyPgorPGJyPgorIKAg
oCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O3JlbW92ZSh2b2ljZWNhbGxfZGF0YSk7PGJyPgorIKAg
oCCgIHN0ZV92b2ljZWNhbGxfZXhpdCgpOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCB0
ZXN0X3ZvaWNlY2FsbF9lY2F2X3dhaXRpbmdfbnVtYmVyX3dpdGhoZWxkKHZvaWQpPGJyPgorezxi
cj4KKyCgIKAgoCB2b2ljZWNhbGxfYWN0aXZhdGVfaGVscGVyKCk7PGJyPgorPGJyPgorIKAgoCCg
IGV4cGVjdGVkX2lkID0gMTs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfc3RhdHVzID0gQ0FMTF9TVEFU
VVNfV0FJVElORzs8YnI+CisgoCCgIKAgc3RyY3B5KGV4cGVjdGVkX251bWJlciwgJnF1b3Q7JnF1
b3Q7KTs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7XHJcbipFQ0FWOiAxLDUsMVxyXG4m
cXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNhbGxfZHJpdmVyLSZndDtyZW1vdmUodm9p
Y2VjYWxsX2RhdGEpOzxicj4KKyCgIKAgoCBzdGVfdm9pY2VjYWxsX2V4aXQoKTs8YnI+Cit9PGJy
PgorPGJyPgorc3RhdGljIHZvaWQgdGVzdF92b2ljZWNhbGxfZWNhdl9jYWxsaW5nKHZvaWQpPGJy
Pgorezxicj4KKyCgIKAgoCB2b2ljZWNhbGxfYWN0aXZhdGVfaGVscGVyKCk7PGJyPgorPGJyPgor
IKAgoCCgIGV4cGVjdGVkX2lkID0gMTs8YnI+CisgoCCgIKAgZXhwZWN0ZWRfc3RhdHVzID0gQ0FM
TF9TVEFUVVNfRElBTElORzs8YnI+CisgoCCgIKAgc3ByaW50ZihleHBlY3RlZF9udW1iZXIsICZx
dW90Oys0NDI1OTkzMDA1MTMzJnF1b3Q7KTs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7
XHJcbipFQ0FWOiAxLDEsMSwsLFwmcXVvdDsrNDQyNTk5MzAwNTEzM1wmcXVvdDssMTQ1XHJcbiZx
dW90Oyk7PGJyPgorPGJyPgorIKAgoCCgIHZvaWNlY2FsbF9kcml2ZXItJmd0O3JlbW92ZSh2b2lj
ZWNhbGxfZGF0YSk7PGJyPgorIKAgoCCgIHN0ZV92b2ljZWNhbGxfZXhpdCgpOzxicj4KK308YnI+
Cis8YnI+CitzdGF0aWMgdm9pZCB0ZXN0X3ZvaWNlY2FsbF9lY2F2X2lkbGUodm9pZCk8YnI+Cit7
PGJyPgorIKAgoCCgIHZvaWNlY2FsbF9hY3RpdmF0ZV9oZWxwZXIoKTs8YnI+Cis8YnI+CisgoCCg
IKAgZXhwZWN0ZWRfaWQgPSAxOzxicj4KKyCgIKAgoCBleHBlY3RlZF9zdGF0dXMgPSBDQUxMX1NU
QVRVU19ESUFMSU5HOzxicj4KKyCgIKAgoCBzcHJpbnRmKGV4cGVjdGVkX251bWJlciwgJnF1b3Q7
KzQ0MjU5OTMwMDUxMzMmcXVvdDspOzxicj4KKyCgIKAgoCBhdF9yZXNwb25zZSgmcXVvdDtcclxu
KkVDQVY6IDEsMSwxLCwsXCZxdW90Oys0NDI1OTkzMDA1MTMzXCZxdW90OywxNDVcclxuJnF1b3Q7
KTs8YnI+Cis8YnI+CisgoCCgIKAgZXhwZWN0ZWRfcmVhc29uID0gT0ZPTk9fRElTQ09OTkVDVF9S
RUFTT05fUkVNT1RFX0hBTkdVUDs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7XHJcbipF
Q0FWOiAxLDAsMSwwOCwwMTZcclxuJnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAgdm9pY2VjYWxs
X2RyaXZlci0mZ3Q7cmVtb3ZlKHZvaWNlY2FsbF9kYXRhKTs8YnI+CisgoCCgIKAgc3RlX3ZvaWNl
Y2FsbF9leGl0KCk7PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lkIHRlc3Rfdm9pY2VjYWxs
X2VjYXZfY29ubmVjdGluZyh2b2lkKTxicj4KK3s8YnI+CisgoCCgIKAgdm9pY2VjYWxsX2FjdGl2
YXRlX2hlbHBlcigpOzxicj4KKzxicj4KKyCgIKAgoCBleHBlY3RlZF9pZCA9IDE7PGJyPgorIKAg
oCCgIGV4cGVjdGVkX3N0YXR1cyA9IENBTExfU1RBVFVTX0RJQUxJTkc7PGJyPgorIKAgoCCgIHNw
cmludGYoZXhwZWN0ZWRfbnVtYmVyLCAmcXVvdDsrNDQyNTk5MzAwNTEzMyZxdW90Oyk7PGJyPgor
IKAgoCCgIGF0X3Jlc3BvbnNlKCZxdW90O1xyXG4qRUNBVjogMSwxLDEsLCxcJnF1b3Q7KzQ0MjU5
OTMwMDUxMzNcJnF1b3Q7LDE0NVxyXG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCBleHBlY3Rl
ZF9zdGF0dXMgPSBDQUxMX1NUQVRVU19BTEVSVElORzs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2Uo
JnF1b3Q7XHJcbipFQ0FWOiAxLDIsMVxyXG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCB2b2lj
ZWNhbGxfZHJpdmVyLSZndDtyZW1vdmUodm9pY2VjYWxsX2RhdGEpOzxicj4KKyCgIKAgoCBzdGVf
dm9pY2VjYWxsX2V4aXQoKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgdGVzdF92b2lj
ZWNhbGxfZWNhdl9hY3RpdmUodm9pZCk8YnI+Cit7PGJyPgorIKAgoCCgIHZvaWNlY2FsbF9hY3Rp
dmF0ZV9oZWxwZXIoKTs8YnI+Cis8YnI+CisgoCCgIKAgZXhwZWN0ZWRfaWQgPSAxOzxicj4KKyCg
IKAgoCBleHBlY3RlZF9zdGF0dXMgPSBDQUxMX1NUQVRVU19ESUFMSU5HOzxicj4KKyCgIKAgoCBz
cHJpbnRmKGV4cGVjdGVkX251bWJlciwgJnF1b3Q7KzQ0MjU5OTMwMDUxMzMmcXVvdDspOzxicj4K
KyCgIKAgoCBhdF9yZXNwb25zZSgmcXVvdDtcclxuKkVDQVY6IDEsMSwxLCwsXCZxdW90Oys0NDI1
OTkzMDA1MTMzXCZxdW90OywxNDVcclxuJnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAgZXhwZWN0
ZWRfc3RhdHVzID0gQ0FMTF9TVEFUVVNfQUNUSVZFOzxicj4KKyCgIKAgoCBhdF9yZXNwb25zZSgm
cXVvdDtcclxuKkVDQVY6IDEsMywxXHJcbiZxdW90Oyk7PGJyPgorPGJyPgorIKAgoCCgIHZvaWNl
Y2FsbF9kcml2ZXItJmd0O3JlbW92ZSh2b2ljZWNhbGxfZGF0YSk7PGJyPgorIKAgoCCgIHN0ZV92
b2ljZWNhbGxfZXhpdCgpOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCB0ZXN0X3ZvaWNl
Y2FsbF9lY2F2X2hlbGQodm9pZCk8YnI+Cit7PGJyPgorIKAgoCCgIHZvaWNlY2FsbF9hY3RpdmF0
ZV9oZWxwZXIoKTs8YnI+Cis8YnI+CisgoCCgIKAgZXhwZWN0ZWRfaWQgPSAxOzxicj4KKyCgIKAg
oCBleHBlY3RlZF9zdGF0dXMgPSBDQUxMX1NUQVRVU19ESUFMSU5HOzxicj4KKyCgIKAgoCBzcHJp
bnRmKGV4cGVjdGVkX251bWJlciwgJnF1b3Q7KzQ0MjU5OTMwMDUxMzMmcXVvdDspOzxicj4KKyCg
IKAgoCBhdF9yZXNwb25zZSgmcXVvdDtcclxuKkVDQVY6IDEsMSwxLCwsXCZxdW90Oys0NDI1OTkz
MDA1MTMzXCZxdW90OywxNDVcclxuJnF1b3Q7KTs8YnI+Cis8YnI+CisgoCCgIKAgZXhwZWN0ZWRf
c3RhdHVzID0gQ0FMTF9TVEFUVVNfSEVMRDs8YnI+CisgoCCgIKAgYXRfcmVzcG9uc2UoJnF1b3Q7
XHJcbipFQ0FWOiAxLDQsMVxyXG4mcXVvdDspOzxicj4KKzxicj4KKyCgIKAgoCB2b2ljZWNhbGxf
ZHJpdmVyLSZndDtyZW1vdmUodm9pY2VjYWxsX2RhdGEpOzxicj4KKyCgIKAgoCBzdGVfdm9pY2Vj
YWxsX2V4aXQoKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgdGVzdF92b2ljZWNhbGxf
ZWNhdl9idXN5KHZvaWQpPGJyPgorezxicj4KKyCgIKAgoCB2b2ljZWNhbGxfYWN0aXZhdGVfaGVs
cGVyKCk7PGJyPgorPGJyPgorIKAgoCCgIGV4cGVjdGVkX2lkID0gMTs8YnI+CisgoCCgIKAgZXhw
ZWN0ZWRfc3RhdHVzID0gQ0FMTF9TVEFUVVNfRElBTElORzs8YnI+CisgoCCgIKAgc3ByaW50Zihl
eHBlY3RlZF9udW1iZXIsICZxdW90Oys0NDI1OTkzMDA1MTMzJnF1b3Q7KTs8YnI+CisgoCCgIKAg
YXRfcmVzcG9uc2UoJnF1b3Q7XHJcbipFQ0FWOiAxLDEsMSwsLFwmcXVvdDsrNDQyNTk5MzAwNTEz
M1wmcXVvdDssMTQ1XHJcbiZxdW90Oyk7PGJyPgorPGJyPgorIKAgoCCgIGV4cGVjdGVkX3JlYXNv
biA9IE9GT05PX0RJU0NPTk5FQ1RfUkVBU09OX1JFTU9URV9IQU5HVVA7PGJyPgorIKAgoCCgIGF0
X3Jlc3BvbnNlKCZxdW90O1xyXG4qRUNBVjogMSw3LDFcclxuJnF1b3Q7KTs8YnI+Cis8YnI+Cisg
oCCgIKAgdm9pY2VjYWxsX2RyaXZlci0mZ3Q7cmVtb3ZlKHZvaWNlY2FsbF9kYXRhKTs8YnI+Cisg
oCCgIKAgc3RlX3ZvaWNlY2FsbF9leGl0KCk7PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lk
IHN0ZV90ZXN0X2FkZCgpPGJyPgorezxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7
L3N0ZS9ncHJzX253X2RlYWN0JnF1b3Q7LCB0ZXN0X2dwcnNfbndfZGVhY3QpOzxicj4KKyCgIKAg
oCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7L3N0ZS9ncHJzX25vcm1hbCZxdW90OywgdGVzdF9ncHJz
X25vcm1hbCk7PGJyPgorIKAgoCCgIGdfdGVzdF9hZGRfZnVuYygmcXVvdDsvc3RlL2dwcnNfY2dk
Y29udF9lcnImcXVvdDssIHRlc3RfZ3Byc19jZ2Rjb250X2Vycik7PGJyPgorIKAgoCCgIGdfdGVz
dF9hZGRfZnVuYygmcXVvdDsvc3RlL2dwcnNfeG1sZXJyJnF1b3Q7LCB0ZXN0X2dwcnNfeG1sZXJy
KTs8YnI+CisgoCCgIKAgZ190ZXN0X2FkZF9mdW5jKCZxdW90Oy9zdGUvZ3Byc19kZWFjdCZxdW90
OywgdGVzdF9ncHJzX2RlYWN0aXZhdGUpOzxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1
b3Q7L3N0ZS9ncHJzX2RlYWN0X2VyciZxdW90OywgdGVzdF9ncHJzX2RlYWN0aXZhdGVfZXJyKTs8
YnI+CisgoCCgIKAgZ190ZXN0X2FkZF9mdW5jKCZxdW90Oy9zdGUvZ3Byc19kZWFjdF9lcnJfb2sm
cXVvdDssPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCB0ZXN0X2dwcnNfZGVhY3RfZmFpbF90
aGVuX29rKTs8YnI+CisgoCCgIKAgZ190ZXN0X2FkZF9mdW5jKCZxdW90Oy9zdGUvZ3Byc19kZWFj
dF9mYWlsJnF1b3Q7LCB0ZXN0X2dwcnNfZGVhY3RpdmF0ZV9mYWlsKTs8YnI+CisgoCCgIKAgZ190
ZXN0X2FkZF9mdW5jKCZxdW90Oy9zdGUvZ3Byc19lcHBzZF9lcnImcXVvdDssIHRlc3RfZ3Byc19l
cHBzZF9lcnIpOzxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7L3N0ZS9yYWRpb3Nl
dHRpbmdzX2FsbCZxdW90OywgdGVzdF9yYWRpb3NldHRpbmdzX2FsbCk7PGJyPgorIKAgoCCgIGdf
dGVzdF9hZGRfZnVuYygmcXVvdDsvc3RlL3Rlc3Rfdm9pY2VjYWxsX2RpYWwmcXVvdDssIHRlc3Rf
dm9pY2VjYWxsX2RpYWwpOzxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7L3N0ZS90
ZXN0X3ZvaWNlY2FsbF9kaWFsX2NvbHAmcXVvdDssPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCB0ZXN0X3ZvaWNlY2FsbF9kaWFsX2NvbHApOzxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1bmMo
JnF1b3Q7L3N0ZS90ZXN0X3ZvaWNlY2FsbF9kaWFsX2Vycm9uZW91c19jb2xwJnF1b3Q7LDxicj4K
KyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCB0ZXN0X3ZvaWNlY2FsbF9kaWFsX2Vycm9u
ZW91c19jb2xwKTs8YnI+CisgoCCgIKAgZ190ZXN0X2FkZF9mdW5jKCZxdW90Oy9zdGUvdGVzdF92
b2ljZWNhbGxfZGlhbF9mYWlsJnF1b3Q7LDxicj4KKyCgIKAgoCCgIKAgoCCgIHRlc3Rfdm9pY2Vj
YWxsX2RpYWxfZmFpbCk7PGJyPgorIKAgoCCgIGdfdGVzdF9hZGRfZnVuYygmcXVvdDsvc3RlL3Rl
c3Rfdm9pY2VjYWxsX2RpYWxfYnVzeSZxdW90Oyw8YnI+CisgoCCgIKAgoCCgIKAgoCB0ZXN0X3Zv
aWNlY2FsbF9kaWFsX2J1c3kpOzxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7L3N0
ZS90ZXN0X3ZvaWNlY2FsbF9oYW5ndXAmcXVvdDssIHRlc3Rfdm9pY2VjYWxsX2hhbmd1cCk7PGJy
PgorIKAgoCCgIGdfdGVzdF9hZGRfZnVuYygmcXVvdDsvc3RlL3Rlc3Rfdm9pY2VjYWxsX2hhbmd1
cF9mYWlsJnF1b3Q7LDxicj4KKyCgIKAgoCCgIKAgoCCgIHRlc3Rfdm9pY2VjYWxsX2hhbmd1cF9m
YWlsKTs8YnI+CisgoCCgIKAgZ190ZXN0X2FkZF9mdW5jKCZxdW90Oy9zdGUvdGVzdF92b2ljZWNh
bGxfaG9sZCZxdW90OywgdGVzdF92b2ljZWNhbGxfaG9sZCk7PGJyPgorIKAgoCCgIGdfdGVzdF9h
ZGRfZnVuYygmcXVvdDsvc3RlL3Rlc3Rfdm9pY2VjYWxsX3JlbGVhc2VfYWxsX2hlbGQmcXVvdDss
PGJyPgorIKAgoCCgIKAgoCCgIKAgdGVzdF92b2ljZWNhbGxfcmVsZWFzZV9hbGxfaGVsZCk7PGJy
PgorIKAgoCCgIGdfdGVzdF9hZGRfZnVuYygmcXVvdDsvc3RlL3Rlc3Rfdm9pY2VjYWxsX3JlbGVh
c2VfYWxsX2FjdGl2ZSZxdW90Oyw8YnI+CisgoCCgIKAgoCCgIKAgoCB0ZXN0X3ZvaWNlY2FsbF9y
ZWxlYXNlX2FsbF9hY3RpdmUpOzxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7L3N0
ZS90ZXN0X3ZvaWNlY2FsbF9hbnN3ZXImcXVvdDssIHRlc3Rfdm9pY2VjYWxsX2Fuc3dlcik7PGJy
PgorIKAgoCCgIGdfdGVzdF9hZGRfZnVuYygmcXVvdDsvc3RlL3Rlc3Rfdm9pY2VjYWxsX2RpYWxf
bm9fZGlhbHRvbmUmcXVvdDssPGJyPgorIKAgoCCgIKAgoCCgIKAgdGVzdF92b2ljZWNhbGxfZGlh
bF9ub19kaWFsdG9uZSk7PGJyPgorIKAgoCCgIGdfdGVzdF9hZGRfZnVuYygmcXVvdDsvc3RlL3Rl
c3Rfdm9pY2VjYWxsX2Fuc3dlcl9lcnJvciZxdW90Oyw8YnI+CisgoCCgIKAgoCCgIKAgoCB0ZXN0
X3ZvaWNlY2FsbF9hbnN3ZXJfZXJyb3IpOzxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1
b3Q7L3N0ZS90ZXN0X3ZvaWNlY2FsbF9tdWx0aXBhcnR5JnF1b3Q7LDxicj4KKyCgIKAgoCCgIKAg
oCCgIHRlc3Rfdm9pY2VjYWxsX211bHRpcGFydHkpOzxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1
bmMoJnF1b3Q7L3N0ZS90ZXN0X3ZvaWNlY2FsbF90cmFuc2ZlciZxdW90Oyw8YnI+CisgoCCgIKAg
oCCgIKAgoCB0ZXN0X3ZvaWNlY2FsbF90cmFuc2Zlcik7PGJyPgorIKAgoCCgIGdfdGVzdF9hZGRf
ZnVuYygmcXVvdDsvc3RlL3Rlc3Rfdm9pY2VjYWxsX2RlZmxlY3QmcXVvdDssIHRlc3Rfdm9pY2Vj
YWxsX2RlZmxlY3QpOzxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7L3N0ZS90ZXN0
X3ZvaWNlY2FsbF9zZW5kX3RvbmVzJnF1b3Q7LDxicj4KKyCgIKAgoCCgIKAgoCCgIHRlc3Rfdm9p
Y2VjYWxsX3NlbmRfdG9uZXMpOzxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7L3N0
ZS90ZXN0X3ZvaWNlY2FsbF9yZWxlYXNlX3NwZWNpZmljJnF1b3Q7LDxicj4KKyCgIKAgoCCgIKAg
oCCgIHRlc3Rfdm9pY2VjYWxsX3JlbGVhc2Vfc3BlY2lmaWMpOzxicj4KKyCgIKAgoCBnX3Rlc3Rf
YWRkX2Z1bmMoJnF1b3Q7L3N0ZS90ZXN0X3ZvaWNlY2FsbF9lY2F2X2FsZXJ0aW5nJnF1b3Q7LDxi
cj4KKyCgIKAgoCCgIKAgoCCgIHRlc3Rfdm9pY2VjYWxsX2VjYXZfYWxlcnRpbmcpOzxicj4KKyCg
IKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7L3N0ZS90ZXN0X3ZvaWNlY2FsbF9lY2F2X2FsZXJ0
aW5nX251bWJlcl93aXRoaGVsZCZxdW90Oyw8YnI+CisgoCCgIKAgoCCgIKAgoCB0ZXN0X3ZvaWNl
Y2FsbF9lY2F2X2FsZXJ0aW5nX251bWJlcl93aXRoaGVsZCk7PGJyPgorIKAgoCCgIGdfdGVzdF9h
ZGRfZnVuYygmcXVvdDsvc3RlL3Rlc3Rfdm9pY2VjYWxsX2VjYXZfd2FpdGluZyZxdW90Oyw8YnI+
CisgoCCgIKAgoCCgIKAgoCB0ZXN0X3ZvaWNlY2FsbF9lY2F2X3dhaXRpbmcpOzxicj4KKyCgIKAg
oCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7L3N0ZS90ZXN0X3ZvaWNlY2FsbF9lY2F2X3dhaXRpbmdf
bnVtYmVyX3dpdGhoZWxkJnF1b3Q7LDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgdGVzdF92
b2ljZWNhbGxfZWNhdl93YWl0aW5nX251bWJlcl93aXRoaGVsZCk7PGJyPgorIKAgoCCgIGdfdGVz
dF9hZGRfZnVuYygmcXVvdDsvc3RlL3Rlc3Rfdm9pY2VjYWxsX2VjYXZfY2FsbGluZyZxdW90Oyw8
YnI+CisgoCCgIKAgoCCgIKAgoCB0ZXN0X3ZvaWNlY2FsbF9lY2F2X2NhbGxpbmcpOzxicj4KKyCg
IKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7L3N0ZS90ZXN0X3ZvaWNlY2FsbF9lY2F2X2hlbGQm
cXVvdDssPGJyPgorIKAgoCCgIKAgoCCgIKAgdGVzdF92b2ljZWNhbGxfZWNhdl9oZWxkKTs8YnI+
CisgoCCgIKAgZ190ZXN0X2FkZF9mdW5jKCZxdW90Oy9zdGUvdGVzdF92b2ljZWNhbGxfZWNhdl9i
dXN5JnF1b3Q7LDxicj4KKyCgIKAgoCCgIKAgoCCgIHRlc3Rfdm9pY2VjYWxsX2VjYXZfYnVzeSk7
PGJyPgorIKAgoCCgIGdfdGVzdF9hZGRfZnVuYygmcXVvdDsvc3RlL3Rlc3Rfdm9pY2VjYWxsX2Vj
YXZfaWRsZSZxdW90Oyw8YnI+CisgoCCgIKAgoCCgIKAgoCB0ZXN0X3ZvaWNlY2FsbF9lY2F2X2lk
bGUpOzxicj4KKyCgIKAgoCBnX3Rlc3RfYWRkX2Z1bmMoJnF1b3Q7L3N0ZS90ZXN0X3ZvaWNlY2Fs
bF9lY2F2X2Nvbm5lY3RpbmcmcXVvdDssPGJyPgorIKAgoCCgIKAgoCCgIKAgdGVzdF92b2ljZWNh
bGxfZWNhdl9jb25uZWN0aW5nKTs8YnI+CisgoCCgIKAgZ190ZXN0X2FkZF9mdW5jKCZxdW90Oy9z
dGUvdGVzdF92b2ljZWNhbGxfZWNhdl9hY3RpdmUmcXVvdDssPGJyPgorIKAgoCCgIKAgoCCgIKAg
dGVzdF92b2ljZWNhbGxfZWNhdl9hY3RpdmUpOzxicj4KKyCgIKAgoCByZXR1cm47PGJyPgorfTxi
cj4KKzxicj4KK3ZvaWQgb2Zvbm9fZGVidWcoY29uc3QgY2hhciAqZm9ybWF0LCAuLi4pPGJyPgor
ezxicj4KKyCgIKAgoCB2YV9saXN0IGFwOzxicj4KKzxicj4KKyCgIKAgoCB2YV9zdGFydChhcCwg
Zm9ybWF0KTs8YnI+CisgoCCgIKAgaWYgKGdfdGVzdF92ZXJib3NlKCkpPGJyPgorIKAgoCCgIKAg
oCCgIKAgdnByaW50Zihmb3JtYXQsIGFwKTs8YnI+CisgoCCgIKAgdmFfZW5kKGFwKTs8YnI+Cit9
PGJyPgorPGJyPgordm9pZCBvZm9ub19lcnJvcihjb25zdCBjaGFyICpmb3JtYXQsIC4uLik8YnI+
Cit7PGJyPgorIKAgoCCgIHZhX2xpc3QgYXA7PGJyPgorPGJyPgorIKAgoCCgIHZhX3N0YXJ0KGFw
LCBmb3JtYXQpOzxicj4KKyCgIKAgoCB2cHJpbnRmKGZvcm1hdCwgYXApOzxicj4KKyCgIKAgoCB2
YV9lbmQoYXApOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCBzdGVfZGVidWcoY29uc3Qg
Y2hhciAqc3RyLCB2b2lkICp1c2VyX2RhdGEpPGJyPgorezxicj4KKyCgIKAgoCBpZiAoZ190ZXN0
X3ZlcmJvc2UoKSk8YnI+CisgoCCgIKAgoCCgIKAgoCBnX3ByaW50KCZxdW90OyVzXG4mcXVvdDss
IHN0cik7PGJyPgorfTxicj4KKzxicj4KK2ludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndik8
YnI+Cit7PGJyPgorIKAgoCCgIEdJT0NoYW5uZWwgKmNoYW5uZWwgPSBOVUxMOzxicj4KKyCgIKAg
oCBHQXRTeW50YXggKnN5bnRheCA9IE5VTEw7PGJyPgorIKAgoCCgIGludCBwYWlyWzJdOzxicj4K
Kzxicj4KKyCgIKAgoCBpZiAoc29ja2V0cGFpcihBRl9VTklYLCBTT0NLX1NUUkVBTSwgUEZfVU5J
WCwgcGFpcikgJmx0OyAwKTxicj4KKyCgIKAgoCCgIKAgoCCgIGdvdG8gZXJyOzxicj4KKzxicj4K
KyCgIKAgoCAvKjxicj4KKyCgIKAgoCCgKiBHaXZlIG9uZSBlbmQgb2YgdGhlIHNvY2tldCBwYWly
LCBmb3Igc2ltdWxhdGluZyBtb2RlbTxicj4KKyCgIKAgoCCgKiByZXNwb25zZXMuPGJyPgorIKAg
oCCgIKAqLzxicj4KKyCgIKAgoCBwaG9uZV9mZCA9IHBhaXJbMV07PGJyPgorPGJyPgorPGJyPgor
IKAgoCCgIC8qIEFuZCB0aGUgb3RoZXIgZW5kIG9mIHRoZSBzb2NrZXQgcGFpciB0byBhdF9jaGFu
ICovPGJyPgorIKAgoCCgIGNoYW5uZWwgPSBnX2lvX2NoYW5uZWxfdW5peF9uZXcocGFpclswXSk7
PGJyPgorIKAgoCCgIGlmIChjaGFubmVsID09IE5VTEwpPGJyPgorIKAgoCCgIKAgoCCgIKAgZ290
byBlcnI7PGJyPgorPGJyPgorIKAgoCCgIGdfaW9fY2hhbm5lbF9zZXRfY2xvc2Vfb25fdW5yZWYo
Y2hhbm5lbCwgVFJVRSk7PGJyPgorIKAgoCCgIHN5bnRheCA9IGdfYXRfc3ludGF4X25ld19nc21f
cGVybWlzc2l2ZSgpOzxicj4KKyCgIKAgoCBpZiAoc3ludGF4ID09IE5VTEwpPGJyPgorIKAgoCCg
IKAgoCCgIKAgZ290byBlcnI7PGJyPgorPGJyPgorIKAgoCCgIGNoYXQgPSBnX2F0X2NoYXRfbmV3
X2Jsb2NraW5nKGNoYW5uZWwsIHN5bnRheCk7PGJyPgorIKAgoCCgIGlmIChjaGF0ID09IE5VTEwp
PGJyPgorIKAgoCCgIKAgoCCgIKAgZ290byBlcnI7PGJyPgorPGJyPgorIKAgoCCgIGdfYXRfc3lu
dGF4X3VucmVmKHN5bnRheCk7PGJyPgorIKAgoCCgIGdfaW9fY2hhbm5lbF91bnJlZihjaGFubmVs
KTs8YnI+CisgoCCgIKAgZ19hdF9jaGF0X3NldF9kZWJ1ZyhjaGF0LCBzdGVfZGVidWcsIE5VTEwp
Ozxicj4KKzxicj4KKyCgIKAgoCBldmVudF9sb29wID0gZ19tYWluX2xvb3BfbmV3KE5VTEwsIEZB
TFNFKTs8YnI+Cis8YnI+CisgoCCgIKAgZ190ZXN0X2luaXQoJmFtcDthcmdjLCAmYW1wO2FyZ3Ys
IE5VTEwpOzxicj4KKyCgIKAgoCBzdGVfdGVzdF9hZGQoKTs8YnI+CisgoCCgIKAgZ190ZXN0X3J1
bigpOzxicj4KKzxicj4KKyCgIKAgoCBnX21haW5fbG9vcF91bnJlZihldmVudF9sb29wKTs8YnI+
CisgoCCgIKAgZ19hdF9jaGF0X3VucmVmKGNoYXQpOzxicj4KKzxicj4KKyCgIKAgoCByZXR1cm4g
MDs8YnI+Cis8YnI+CitlcnI6PGJyPgorIKAgoCCgIGlmIChzeW50YXggIT0gTlVMTCk8YnI+Cisg
oCCgIKAgoCCgIKAgoCBnX2F0X3N5bnRheF91bnJlZihzeW50YXgpOzxicj4KKzxicj4KKyCgIKAg
oCBpZiAoY2hhbm5lbCAhPSBOVUxMKTxicj4KKyCgIKAgoCCgIKAgoCCgIGdfaW9fY2hhbm5lbF91
bnJlZihjaGFubmVsKTs8YnI+Cis8YnI+CisgoCCgIKAgZ19wcmludCgmcXVvdDtlcnJvclxuJnF1
b3Q7KTs8YnI+CisgoCCgIKAgcmV0dXJuIDEwOzxicj4KK308YnI+Cjxmb250IGNvbG9yPSIjODg4
ODg4Ij4tLTxicj4KMS43LjE8YnI+Cjxicj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFp
bHRvOm9mb25vQG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KPGEgaHJlZj0iaHR0
cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6
Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8L2ZvbnQ+PC9ibG9ja3F1
b3RlPjwvZGl2Pjxicj4K

--===============6339595286444156461==--

