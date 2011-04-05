Content-Type: multipart/mixed; boundary="===============0696692857743942805=="
MIME-Version: 1.0
From: Ostermann, Christophe <Christophe.Ostermann@sicpa.com>
Subject: PATCH H24 early support
Date: Tue, 05 Apr 2011 08:03:54 +0200
Message-ID: <65D0035E6914AC478A46CFE3E20C3926017CC406@snch1xch53.sicpa-net.ads>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0696692857743942805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, =


 =


I have a first working support of Motorola H24 modem. I ve tested sms /
gprs / call.

Note that for call I have not fully tested since on my device I do not
have any microphone....

If patch is not in the right format, ask me to provide it in another
way. (I ve used quilt to generate it)

 =


BR,

Christophe

 =


---------

Index: ofono-0.45/Makefile.in

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- ofono-0.45.orig/Makefile.in     2011-03-15 15:11:23.000000000 +0100

+++ ofono-0.45/Makefile.in         2011-04-04 15:00:52.806400966 +0200

@@ -159,7 +159,7 @@

 =


 @ATMODEM_TRUE(a)am__append_14 =3D g1 gobi wavecom calypso mbm hso zte \

 @ATMODEM_TRUE@ huawei sierra novatel palmpre ifx ste stemgr \

-(a)ATMODEM_TRUE@ caif tc65 nokia nokiacdma linktop

+(a)ATMODEM_TRUE@            caif tc65 h24 nokia nokiacdma linktop

 @ATMODEM_TRUE(a)am__append_15 =3D plugins/g1.c plugins/gobi.c \

 @ATMODEM_TRUE@ plugins/wavecom.c plugins/calypso.c \

 @ATMODEM_TRUE@ plugins/mbm.c plugins/hso.c plugins/zte.c \

@@ -167,6 +167,7 @@

 @ATMODEM_TRUE@ plugins/novatel.c plugins/palmpre.c \

 @ATMODEM_TRUE@ plugins/ifx.c plugins/ste.c plugins/stemgr.c \

 @ATMODEM_TRUE@ plugins/caif.c plugins/tc65.c plugins/nokia.c \

+(a)ATMODEM_TRUE@            plugins/h24.c \

 @ATMODEM_TRUE@ plugins/nokiacdma.c plugins/linktop.c

 @ATMODEM_TRUE@@BLUETOOTH_TRUE(a)am__append_16 =3D bluetooth hfp hfp_ag \

 @ATMODEM_TRUE@@BLUETOOTH_TRUE@            dun_gw

@@ -338,6 +339,7 @@

            plugins/hso.c plugins/zte.c plugins/huawei.c
plugins/sierra.c \

            plugins/novatel.c plugins/palmpre.c plugins/ifx.c \

            plugins/ste.c plugins/stemgr.c plugins/caif.c plugins/tc65.c
\

+          plugins/h24.c \

            plugins/nokia.c plugins/nokiacdma.c plugins/linktop.c \

            plugins/bluetooth.c plugins/bluetooth.h plugins/hfp_hf.c \

            plugins/hfp_ag.c plugins/dun_gw.c btio/btio.h btio/btio.c \

@@ -457,6 +459,7 @@

 @ATMODEM_TRUE@ plugins/palmpre.$(OBJEXT) plugins/ifx.$(OBJEXT) \

 @ATMODEM_TRUE@ plugins/ste.$(OBJEXT) plugins/stemgr.$(OBJEXT) \

 @ATMODEM_TRUE@ plugins/caif.$(OBJEXT) plugins/tc65.$(OBJEXT) \

+(a)ATMODEM_TRUE@            plugins/h24.$(OBJEXT) \

 @ATMODEM_TRUE@ plugins/nokia.$(OBJEXT) \

 @ATMODEM_TRUE@ plugins/nokiacdma.$(OBJEXT) \

 @ATMODEM_TRUE@ plugins/linktop.$(OBJEXT)

@@ -1552,6 +1555,8 @@

            plugins/$(DEPDIR)/$(am__dirstamp)

 plugins/tc65.$(OBJEXT): plugins/$(am__dirstamp) \

            plugins/$(DEPDIR)/$(am__dirstamp)

+plugins/h24.$(OBJEXT): plugins/$(am__dirstamp) \

+          plugins/$(DEPDIR)/$(am__dirstamp)

 plugins/nokia.$(OBJEXT): plugins/$(am__dirstamp) \

            plugins/$(DEPDIR)/$(am__dirstamp)

 plugins/nokiacdma.$(OBJEXT): plugins/$(am__dirstamp) \

@@ -1918,6 +1923,7 @@

            -rm -f plugins/ste.$(OBJEXT)

            -rm -f plugins/stemgr.$(OBJEXT)

            -rm -f plugins/tc65.$(OBJEXT)

+          -rm -f plugins/h24.$(OBJEXT)

            -rm -f plugins/u8500.$(OBJEXT)

            -rm -f plugins/udev.$(OBJEXT)

            -rm -f plugins/wavecom.$(OBJEXT)

@@ -2122,6 +2128,7 @@

 @AMDEP_TRUE@@am__include@
@am__quote(a)plugins/$(DEPDIR)/ste.Po(a)am__quote@

 @AMDEP_TRUE@@am__include@
@am__quote(a)plugins/$(DEPDIR)/stemgr.Po(a)am__quote@

 @AMDEP_TRUE@@am__include@
@am__quote(a)plugins/$(DEPDIR)/tc65.Po(a)am__quote@

+(a)AMDEP_TRUE@@am__include@
@am__quote(a)plugins/$(DEPDIR)/h24.Po(a)am__quote@

 @AMDEP_TRUE@@am__include@
@am__quote(a)plugins/$(DEPDIR)/u8500.Po(a)am__quote@

 @AMDEP_TRUE@@am__include@
@am__quote(a)plugins/$(DEPDIR)/udev.Po(a)am__quote@

 @AMDEP_TRUE@@am__include@
@am__quote(a)plugins/$(DEPDIR)/wavecom.Po(a)am__quote@

Index: ofono-0.45/drivers/atmodem/sms.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- ofono-0.45.orig/drivers/atmodem/sms.c           2011-02-06
13:49:10.000000000 +0100

+++ ofono-0.45/drivers/atmodem/sms.c  2011-04-04 15:00:52.806400966
+0200

@@ -783,6 +783,7 @@

            case OFONO_VENDOR_QUALCOMM_MSM:

            case OFONO_VENDOR_NOVATEL:

            case OFONO_VENDOR_HUAWEI:

+          case OFONO_VENDOR_MOTOROLA:

                        /* MSM devices advertise support for mode 2, but
return an

                         * error if we attempt to actually use it. */

                        mode =3D "1";

Index: ofono-0.45/drivers/atmodem/vendor.h

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- ofono-0.45.orig/drivers/atmodem/vendor.h        2011-01-29
06:42:18.000000000 +0100

+++ ofono-0.45/drivers/atmodem/vendor.h           2011-04-04
15:00:52.806400966 +0200

@@ -35,4 +35,5 @@

            OFONO_VENDOR_WAVECOM,

            OFONO_VENDOR_NOKIA,

            OFONO_VENDOR_PHONESIM,

+          OFONO_VENDOR_MOTOROLA,

 };

Index: ofono-0.45/plugins/h24.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- /dev/null        1970-01-01 00:00:00.000000000 +0000

+++ ofono-0.45/plugins/h24.c     2011-04-04 15:02:42.591219603 +0200

@@ -0,0 +1,249 @@

+/*

+ *

+ *  oFono - Open Source Telephony

+ *

+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.

+ *

+ *  This program is free software; you can redistribute it and/or
modify

+ *  it under the terms of the GNU General Public License version 2 as

+ *  published by the Free Software Foundation.

+ *

+ *  This program is distributed in the hope that it will be useful,

+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of

+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the

+ *  GNU General Public License for more details.

+ *

+ *  You should have received a copy of the GNU General Public License

+ *  along with this program; if not, write to the Free Software

+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
02110-1301  USA

+ *

+ */

+

+#ifdef HAVE_CONFIG_H

+#include <config.h>

+#endif

+

+#include <errno.h>

+#include <stdlib.h>

+

+#include <glib.h>

+#include <gatchat.h>

+#include <gattty.h>

+

+#define OFONO_API_SUBJECT_TO_CHANGE

+#include <ofono/plugin.h>

+#include <ofono/log.h>

+#include <ofono/modem.h>

+#include <ofono/call-barring.h>

+#include <ofono/call-forwarding.h>

+#include <ofono/call-meter.h>

+#include <ofono/call-settings.h>

+#include <ofono/devinfo.h>

+#include <ofono/message-waiting.h>

+#include <ofono/netreg.h>

+#include <ofono/phonebook.h>

+#include <ofono/sim.h>

+#include <ofono/sms.h>

+#include <ofono/ussd.h>

+#include <ofono/voicecall.h>

+

+#include <drivers/atmodem/atutil.h>

+#include <drivers/atmodem/vendor.h>

+

+#include <ofono/gprs.h>

+#include <ofono/gprs-context.h>

+

+static int h24_probe(struct ofono_modem *modem)

+{

+          return 0;

+}

+

+static void h24_remove(struct ofono_modem *modem)

+{

+}

+

+static void h24_debug(const char *str, void *user_data)

+{

+          const char *prefix =3D user_data;

+

+          ofono_info("%s%s", prefix, str);

+}

+

+static int h24_enable(struct ofono_modem *modem)

+{

+          GAtChat *chat;

+          GIOChannel *channel;

+          GAtSyntax *syntax;

+          GHashTable *options;

+          const char *device;

+

+          DBG("%p", modem);

+

+          options =3D g_hash_table_new(g_str_hash, g_str_equal);

+          if (options =3D=3D NULL)

+                      return -ENOMEM;

+

+          device =3D ofono_modem_get_string(modem, "Device");

+          if (device =3D=3D NULL)

+                      return -EINVAL;

+

+          g_hash_table_insert(options, "Baud", "115200");

+          g_hash_table_insert(options, "StopBits", "1");

+          g_hash_table_insert(options, "DataBits", "8");

+          g_hash_table_insert(options, "Parity", "none");

+          g_hash_table_insert(options, "XonXoff", "off");

+          g_hash_table_insert(options, "RtsCts", "on");

+          g_hash_table_insert(options, "Local", "on");

+          g_hash_table_insert(options, "Read", "on");

+

+          channel =3D g_at_tty_open(device, options);

+          g_hash_table_destroy(options);

+

+          if (channel =3D=3D NULL)

+                      return -EIO;

+

+          /*

+          * H24 works almost as the 27.007 says. Today I

+         * just copied existing config from tc65.

+         * TODO: check if it works with a more stict parsing

+          */

+          syntax =3D g_at_syntax_new_gsm_permissive();

+

+          chat =3D g_at_chat_new(channel, syntax);

+          g_at_syntax_unref(syntax);

+          g_io_channel_unref(channel);

+

+          if (chat =3D=3D NULL)

+                      return -ENOMEM;

+

+          if (getenv("OFONO_AT_DEBUG"))

+                      g_at_chat_set_debug(chat, h24_debug, "");

+

+          ofono_modem_set_data(modem, chat);

+

+          return 0;

+}

+

+static int h24_disable(struct ofono_modem *modem)

+{

+          GAtChat *chat =3D ofono_modem_get_data(modem);

+

+          DBG("%p", modem);

+

+          ofono_modem_set_data(modem, NULL);

+

+          g_at_chat_send(chat, "AT+CFUN=3D4", NULL, NULL, NULL, NULL);

+

+          g_at_chat_unref(chat);

+

+          return 0;

+}

+

+static void set_online_cb(gboolean ok, GAtResult *result, gpointer
user_data)

+{

+          struct cb_data *cbd =3D user_data;

+          ofono_modem_online_cb_t cb =3D cbd->cb;

+          struct ofono_error error;

+

+          decode_at_error(&error, g_at_result_final_response(result));

+

+          cb(&error, cbd->data);

+}

+

+static void h24_set_online(struct ofono_modem *modem, ofono_bool_t
online,

+                                 ofono_modem_online_cb_t cb, void
*user_data)

+{

+          GAtChat *chat =3D ofono_modem_get_data(modem);

+          struct cb_data *cbd =3D cb_data_new(cb, user_data);

+          char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";

+

+          DBG("modem %p %s", modem, online ? "online" : "offline");

+

+          if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd,
g_free))

+                      return;

+

+          g_free(cbd);

+

+          CALLBACK_WITH_FAILURE(cb, cbd->data);

+}

+

+static void h24_pre_sim(struct ofono_modem *modem)

+{

+          GAtChat *chat =3D ofono_modem_get_data(modem);

+          struct ofono_sim *sim;

+

+          DBG("%p", modem);

+

+          ofono_devinfo_create(modem, 0, "atmodem", chat);

+          sim =3D ofono_sim_create(modem, 0, "atmodem", chat);

+          ofono_voicecall_create(modem, 0, "atmodem", chat);

+

+          if (sim)

+                      ofono_sim_inserted_notify(sim, TRUE);

+}

+

+static void h24_post_sim(struct ofono_modem *modem)

+{

+          GAtChat *chat =3D ofono_modem_get_data(modem);

+

+          DBG("%p", modem);

+

+          ofono_phonebook_create(modem, 0, "atmodem", chat);

+

+          ofono_sms_create(modem, OFONO_VENDOR_MOTOROLA, "atmodem",
chat);

+}

+

+static void h24_post_online(struct ofono_modem *modem)

+{

+          GAtChat *chat =3D ofono_modem_get_data(modem);

+          struct ofono_message_waiting *mw;

+          struct ofono_gprs *gprs;

+          struct ofono_gprs_context *gc;

+

+          DBG("%p", modem);

+

+          ofono_ussd_create(modem, 0, "atmodem", chat);

+          ofono_call_forwarding_create(modem, 0, "atmodem", chat);

+          ofono_call_settings_create(modem, 0, "atmodem", chat);

+          ofono_netreg_create(modem, 0, "atmodem", chat);

+          ofono_call_meter_create(modem, 0, "atmodem", chat);

+          ofono_call_barring_create(modem, 0, "atmodem", chat);

+

+          gprs =3D ofono_gprs_create(modem, 0, "atmodem", chat);

+          gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_MOTOROLA,
"atmodem", chat);

+

+          DBG("GPRS");

+          if (gprs && gc){

+          DBG("GPRS add context");

+

+                      ofono_gprs_add_context(gprs, gc);

+        }

+          mw =3D ofono_message_waiting_create(modem);

+          if (mw)

+                      ofono_message_waiting_register(mw);

+}

+

+static struct ofono_modem_driver h24_driver =3D {

+          .name                   =3D "h24",

+          .probe                  =3D h24_probe,

+          .remove                 =3D h24_remove,

+          .enable                 =3D h24_enable,

+          .disable                =3D h24_disable,

+          .set_online             =3D h24_set_online,

+          .pre_sim                =3D h24_pre_sim,

+          .post_sim               =3D h24_post_sim,

+          .post_online            =3D h24_post_online,

+};

+

+static int h24_init(void)

+{

+          return ofono_modem_driver_register(&h24_driver);

+}

+

+static void h24_exit(void)

+{

+          ofono_modem_driver_unregister(&h24_driver);

+}

+

+OFONO_PLUGIN_DEFINE(h24, "Motorola H24 driver plugin", VERSION,

+                      OFONO_PLUGIN_PRIORITY_DEFAULT, h24_init,
h24_exit)

Index: ofono-0.45/plugins/udev.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- ofono-0.45.orig/plugins/udev.c            2011-03-15
15:10:55.000000000 +0100

+++ ofono-0.45/plugins/udev.c    2011-04-04 15:00:52.806400966 +0200

@@ -545,6 +545,19 @@

            ofono_modem_register(modem);

 }

 =


+static void add_h24(struct ofono_modem *modem,

+                                 struct udev_device *udev_device)

+{

+          const char *devnode;

+

+          DBG("modem %p", modem);

+

+          devnode =3D udev_device_get_devnode(udev_device);

+          ofono_modem_set_string(modem, "Device", devnode);

+

+          ofono_modem_register(modem);

+}

+

 static void add_nokiacdma(struct ofono_modem *modem,

                                                           struct
udev_device *udev_device)

 {

@@ -682,6 +695,8 @@

                        add_calypso(modem, udev_device);

            else if (g_strcmp0(driver, "tc65") =3D=3D 0)

                        add_tc65(modem, udev_device);

+          else if (g_strcmp0(driver, "h24") =3D=3D 0)

+                      add_h24(modem, udev_device);

            else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)

                        add_nokiacdma(modem, udev_device);

         else if (g_strcmp0(driver, "linktop") =3D=3D 0)

Index: ofono-0.45/doc/h24-modem.txt

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- /dev/null        1970-01-01 00:00:00.000000000 +0000

+++ ofono-0.45/doc/h24-modem.txt        2011-04-04 15:00:52.806400966
+0200

@@ -0,0 +1,11 @@

+H24 modem usage

+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

+

+The H24 modem is presented by the kernel as serial device

+/dev/ACM0 if usb link to modem is used. To allow oFono to

+autodetect and use this, a simple udev rule is needed:

+

+KERNEL=3D=3D"ttyACM0", ENV{OFONO_DRIVER}=3D"h24"

+

+You can put this in any file in /lib/udev/rules.d.

+

Index: ofono-0.45/drivers/atmodem/gprs-context.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- ofono-0.45.orig/drivers/atmodem/gprs-context.c           2011-04-04
15:01:40.462401805 +0200

+++ ofono-0.45/drivers/atmodem/gprs-context.c  2011-04-04
15:19:17.956272112 +0200

@@ -41,6 +41,7 @@

 #include "gatppp.h"

 =


 #include "atmodem.h"

+#include "vendor.h"

 =


 #define TUN_SYSFS_DIR "/sys/devices/virtual/misc/tun"

 =


@@ -67,6 +68,7 @@

                        ofono_gprs_context_up_cb_t up_cb;       /* Up
callback */

            };

            void *cb_data;                                  /* Callback
data */

+          unsigned int vendor;

 };

 =


 static void ppp_debug(const char *str, void *data)

@@ -209,7 +211,11 @@

                        return;

            }

 =


-           sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);

+        if(gcd->vendor =3D=3D OFONO_VENDOR_MOTOROLA)

+                      sprintf(buf, "ATD*99***%u#",
gcd->active_context);

+        else

+                      sprintf(buf, "AT+CGDATA=3D\"PPP\",%u",
gcd->active_context);

+

            if (g_at_chat_send(gcd->chat, buf, none_prefix,

                                               at_cgdata_cb, gc, NULL) >
0)

                        return;

@@ -287,6 +293,8 @@

 =


            gcd->chat =3D g_at_chat_clone(chat);

 =


+          gcd->vendor =3D vendor;

+

            ofono_gprs_context_set_data(gc, gcd);

 =


            return 0;

---------- =


 =


----------

Christophe Ostermann =

Software Engineer
Devices Engineering

SICPA Security Solutions SA
Av. de Florissant 41, 1008 Prilly, Switzerland
Tel +41 21 627 59 70  Direct +41 21 627 63 68
Fax +41 21 620 06 22 =

christophe.ostermann(a)sicpa.com
<mailto:christophe.christophe.ostermann@sicpa.com>   www.sicpa.com
<http://www.sicpa.com/> =


 =


 =




This message was delivered through encrypted mechanism.


The information in this email and any attachments is confidential
and intended solely for the use of the individual(s) to whom it is
addressed or otherwise directed.
Please note that any views or opinions presented in this email are
solely those of the author and do not necessarily represent those
of the Company.
Finally, the recipient should check this email and any attachments
for the presence of viruses.
The Company accepts no liability for any damage caused by any virus
transmitted by this email.

--===============0696692857743942805==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWwgeG1sbnM6bz0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6b2ZmaWNlIiB4
bWxuczp3PSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTp3b3JkIiB4bWxuczpzdDE9
InVybjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOnNtYXJ0dGFncyIgeG1sbnM9Imh0dHA6
Ly93d3cudzMub3JnL1RSL1JFQy1odG1sNDAiDQp4bWxuczpuczA9InVybjpzY2hlbWFzLW1pY3Jv
c29mdC1jb206b2ZmaWNlOnNtYXJ0dGFncyI+DQoNCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVpdj1D
b250ZW50LVR5cGUgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXVzLWFzY2lpIj4NCjxtZXRh
IG5hbWU9R2VuZXJhdG9yIGNvbnRlbnQ9Ik1pY3Jvc29mdCBXb3JkIDExIChmaWx0ZXJlZCBtZWRp
dW0pIj4NCjxvOlNtYXJ0VGFnVHlwZSBuYW1lc3BhY2V1cmk9InVybjpzY2hlbWFzLW1pY3Jvc29m
dC1jb206b2ZmaWNlOnNtYXJ0dGFncyINCiBuYW1lPSJjb3VudHJ5LXJlZ2lvbiIvPg0KPG86U21h
cnRUYWdUeXBlIG5hbWVzcGFjZXVyaT0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6
c21hcnR0YWdzIg0KIG5hbWU9IlBvc3RhbENvZGUiLz4NCjxvOlNtYXJ0VGFnVHlwZSBuYW1lc3Bh
Y2V1cmk9InVybjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOnNtYXJ0dGFncyINCiBuYW1l
PSJTdGF0ZSIvPg0KPG86U21hcnRUYWdUeXBlIG5hbWVzcGFjZXVyaT0idXJuOnNjaGVtYXMtbWlj
cm9zb2Z0LWNvbTpvZmZpY2U6c21hcnR0YWdzIg0KIG5hbWU9IkNpdHkiLz4NCjxvOlNtYXJ0VGFn
VHlwZSBuYW1lc3BhY2V1cmk9InVybjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOnNtYXJ0
dGFncyINCiBuYW1lPSJwbGFjZSIvPg0KPG86U21hcnRUYWdUeXBlIG5hbWVzcGFjZXVyaT0idXJu
OnNjaGVtYXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6c21hcnR0YWdzIg0KIG5hbWU9IlN0cmVldCIv
Pg0KPG86U21hcnRUYWdUeXBlIG5hbWVzcGFjZXVyaT0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNv
bTpvZmZpY2U6c21hcnR0YWdzIg0KIG5hbWU9ImFkZHJlc3MiLz4NCjwhLS1baWYgIW1zb10+DQo8
c3R5bGU+DQpzdDFcOip7YmVoYXZpb3I6dXJsKCNkZWZhdWx0I2llb291aSkgfQ0KPC9zdHlsZT4N
CjwhW2VuZGlmXS0tPg0KPHN0eWxlPg0KPCEtLQ0KIC8qIFN0eWxlIERlZmluaXRpb25zICovDQog
cC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2Lk1zb05vcm1hbA0KCXttYXJnaW46MGNtOw0K
CW1hcmdpbi1ib3R0b206LjAwMDFwdDsNCglmb250LXNpemU6MTIuMHB0Ow0KCWZvbnQtZmFtaWx5
OiJUaW1lcyBOZXcgUm9tYW4iO30NCmE6bGluaywgc3Bhbi5Nc29IeXBlcmxpbmsNCgl7Y29sb3I6
Ymx1ZTsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lO30NCmE6dmlzaXRlZCwgc3Bhbi5Nc29I
eXBlcmxpbmtGb2xsb3dlZA0KCXtjb2xvcjpwdXJwbGU7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVy
bGluZTt9DQpzcGFuLkVtYWlsU3R5bGUxNw0KCXttc28tc3R5bGUtdHlwZTpwZXJzb25hbC1jb21w
b3NlOw0KCWZvbnQtZmFtaWx5OkFyaWFsOw0KCWNvbG9yOndpbmRvd3RleHQ7fQ0KQHBhZ2UgU2Vj
dGlvbjENCgl7c2l6ZTo1OTUuM3B0IDg0MS45cHQ7DQoJbWFyZ2luOjcwLjg1cHQgNzAuODVwdCA3
MC44NXB0IDcwLjg1cHQ7fQ0KZGl2LlNlY3Rpb24xDQoJe3BhZ2U6U2VjdGlvbjE7fQ0KLS0+DQo8
L3N0eWxlPg0KDQo8L2hlYWQ+DQoNCjxib2R5IGxhbmc9RlIgbGluaz1ibHVlIHZsaW5rPXB1cnBs
ZT4NCg0KPGRpdiBjbGFzcz1TZWN0aW9uMT4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIHN0eWxlPSdmb250LXNpemU6MTAuMHB0Ow0KZm9udC1mYW1p
bHk6QXJpYWwnPkhpLCA8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gc3R5bGU9J2ZvbnQtc2l6ZTox
MC4wcHQ7DQpmb250LWZhbWlseTpBcmlhbCc+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
SSBoYXZlIGEgZmlyc3Qgd29ya2luZyBzdXBwb3J0IG9mIE1vdG9yb2xhIEgyNCBtb2RlbS4NCkkg
dmUgdGVzdGVkIHNtcyAvIGdwcnMgLyBjYWxsLjxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+
DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5n
PUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPk5vdGUg
dGhhdCBmb3IgY2FsbCBJIGhhdmUgbm90IGZ1bGx5IHRlc3RlZCBzaW5jZSBvbg0KbXkgZGV2aWNl
IEkgZG8gbm90IGhhdmUgYW55IG1pY3JvcGhvbmUmIzgyMzA7LjxvOnA+PC9vOnA+PC9zcGFuPjwv
Zm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48
c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJp
YWwnPklmIHBhdGNoIGlzIG5vdCBpbiB0aGUgcmlnaHQgZm9ybWF0LCBhc2sgbWUgdG8NCnByb3Zp
ZGUgaXQgaW4gYW5vdGhlciB3YXkuIChJIHZlIHVzZWQgcXVpbHQgdG8gZ2VuZXJhdGUgaXQpPG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9mb250PjwvcD4N
Cg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9
RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+QlIsPG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+Q2hyaXN0b3BoZTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBs
YW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPjxv
OnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48
Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6
DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPi0tLS0tLS0tLTxvOnA+PC9vOnA+PC9zcGFuPjwv
Zm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48
c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJp
YWwnPkluZGV4OiBvZm9uby0wLjQ1L01ha2VmaWxlLmluPG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05v
cm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250
LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPi0tLSBvZm9uby0wLjQ1Lm9yaWcvTWFr
ZWZpbGUuaW4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMjAxMS0wMy0xNQ0KMTU6MTE6MjMuMDAw
MDAwMDAwICswMTAwPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNv
Tm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2Zv
bnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KysrIG9mb25vLTAuNDUvTWFrZWZp
bGUuaW4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMjAx
MS0wNC0wNA0KMTU6MDA6NTIuODA2NDAwOTY2ICswMjAwPG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
QEAgLTE1OSw3ICsxNTksNyBAQDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNs
YXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0
eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOzxvOnA+PC9v
OnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIg
ZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9u
dC1mYW1pbHk6QXJpYWwnPiZuYnNwO0BBVE1PREVNX1RSVUVAYW1fX2FwcGVuZF8xNCA9IGcxIGdv
Ymkgd2F2ZWNvbQ0KY2FseXBzbyBtYm0gaHNvIHp0ZSBcPG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
Jm5ic3A7QEFUTU9ERU1fVFJVRUAgaHVhd2VpIHNpZXJyYSBub3ZhdGVsIHBhbG1wcmUNCmlmeCBz
dGUgc3RlbWdyIFw8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29O
b3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9u
dC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4tQEFUTU9ERU1fVFJVRUAgY2FpZiB0
YzY1IG5va2lhIG5va2lhY2RtYSBsaW5rdG9wPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4N
Cg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9
RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+K0BBVE1P
REVNX1RSVUVAJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNhaWYNCnRjNjUgaDI0IG5va2lhIG5va2lhY2RtYSBsaW5rdG9w
PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250
IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEw
LjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7PC9zcGFuPjwvZm9udD48Zm9udCBzaXplPTIg
ZmFjZT1BcmlhbD48c3Bhbg0Kc3R5bGU9J2ZvbnQtc2l6ZToxMC4wcHQ7Zm9udC1mYW1pbHk6QXJp
YWwnPkBBVE1PREVNX1RSVUVAYW1fX2FwcGVuZF8xNSA9DQpwbHVnaW5zL2cxLmMgcGx1Z2lucy9n
b2JpLmMgXDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1h
bD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBzdHlsZT0nZm9udC1zaXplOjEwLjBwdDsN
CmZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDtAQVRNT0RFTV9UUlVFQCBwbHVnaW5zL3dhdmVjb20u
YyBwbHVnaW5zL2NhbHlwc28uYyBcPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAg
Y2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIHN0eWxlPSdmb250
LXNpemU6MTAuMHB0Ow0KZm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwO0BBVE1PREVNX1RSVUVAIHBs
dWdpbnMvbWJtLmMgcGx1Z2lucy9oc28uYw0KcGx1Z2lucy96dGUuYyBcPG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIHN0eWxlPSdmb250LXNpemU6MTAuMHB0Ow0KZm9udC1mYW1pbHk6QXJpYWwnPkBA
IC0xNjcsNiArMTY3LDcgQEA8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFz
cz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gc3R5bGU9J2ZvbnQtc2l6
ZToxMC4wcHQ7DQpmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7QEFUTU9ERU1fVFJVRUAgcGx1Z2lu
cy9ub3ZhdGVsLmMgcGx1Z2lucy9wYWxtcHJlLmMgXDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBz
dHlsZT0nZm9udC1zaXplOjEwLjBwdDsNCmZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDtAQVRNT0RF
TV9UUlVFQCBwbHVnaW5zL2lmeC5jIHBsdWdpbnMvc3RlLmMNCnBsdWdpbnMvc3RlbWdyLmMgXDxv
OnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBz
aXplPTIgZmFjZT1BcmlhbD48c3BhbiBzdHlsZT0nZm9udC1zaXplOjEwLjBwdDsNCmZvbnQtZmFt
aWx5OkFyaWFsJz4mbmJzcDtAQVRNT0RFTV9UUlVFQCBwbHVnaW5zL2NhaWYuYyBwbHVnaW5zL3Rj
NjUuYw0KcGx1Z2lucy9ub2tpYS5jIFw8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8
cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gc3R5bGU9J2Zv
bnQtc2l6ZToxMC4wcHQ7DQpmb250LWZhbWlseTpBcmlhbCc+K0BBVE1PREVNX1RSVUVAJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IHBsdWdpbnMvaDI0LmMNClw8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBj
bGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gc3R5bGU9J2ZvbnQt
c2l6ZToxMC4wcHQ7DQpmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7QEFUTU9ERU1fVFJVRUAgcGx1
Z2lucy9ub2tpYWNkbWEuYyBwbHVnaW5zL2xpbmt0b3AuYzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9u
dD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3Bh
biBzdHlsZT0nZm9udC1zaXplOjEwLjBwdDsNCmZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDs8L3Nw
YW4+PC9mb250Pjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuDQpsYW5nPUVOLUdCIHN0eWxl
PSdmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz5AQVRNT0RFTV9UUlVFQEBCTFVF
VE9PVEhfVFJVRUBhbV9fYXBwZW5kXzE2DQo9IGJsdWV0b290aCBoZnAgaGZwX2FnIFw8bzpwPjwv
bzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0y
IGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2Zv
bnQtZmFtaWx5OkFyaWFsJz4mbmJzcDtAQVRNT0RFTV9UUlVFQEBCTFVFVE9PVEhfVFJVRUAmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgZHVuX2d3PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNv
Tm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2Zv
bnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+QEAgLTMzOCw2ICszMzksNyBAQDxv
OnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBz
aXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4w
cHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBwbHVnaW5zL2hzby5jDQpwbHVnaW5zL3p0
ZS5jIHBsdWdpbnMvaHVhd2VpLmMgcGx1Z2lucy9zaWVycmEuYyBcPG86cD48L286cD48L3NwYW4+
PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFs
PjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpB
cmlhbCc+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IDwvc3Bhbj48L2ZvbnQ+PGZvbnQNCnNpemU9MiBmYWNlPUFyaWFsPjxz
cGFuIHN0eWxlPSdmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz5wbHVnaW5zL25v
dmF0ZWwuYw0KcGx1Z2lucy9wYWxtcHJlLmMgcGx1Z2lucy9pZnguYyBcPG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIHN0eWxlPSdmb250LXNpemU6MTAuMHB0Ow0KZm9udC1mYW1pbHk6QXJpYWwnPiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBwbHVnaW5zL3N0ZS5jDQpwbHVnaW5zL3N0ZW1nci5jIHBsdWdpbnMvY2FpZi5jIHBs
dWdpbnMvdGM2NS5jIFw8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gc3R5bGU9J2ZvbnQtc2l6ZTox
MC4wcHQ7DQpmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBwbHVnaW5zL2gyNC5jDQpcPG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIHN0eWxlPSdmb250LXNpemU6MTAuMHB0Ow0KZm9udC1mYW1pbHk6QXJpYWwnPiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBwbHVnaW5zL25va2lhLmMNCnBsdWdpbnMvbm9raWFjZG1hLmMgcGx1Z2lucy9saW5r
dG9wLmMgXDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1h
bD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBzdHlsZT0nZm9udC1zaXplOjEwLjBwdDsN
CmZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgPC9zcGFuPjwvZm9udD48Zm9udA0Kc2l6ZT0y
IGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOjEwLjBwdDtmb250
LWZhbWlseTpBcmlhbCc+cGx1Z2lucy9ibHVldG9vdGguYw0KcGx1Z2lucy9ibHVldG9vdGguaCBw
bHVnaW5zL2hmcF9oZi5jIFw8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFz
cz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHls
ZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcGx1Z2lu
cy9oZnBfYWcuYw0KcGx1Z2lucy9kdW5fZ3cuYyBidGlvL2J0aW8uaCBidGlvL2J0aW8uYyBcPG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+QEAgLTQ1Nyw2ICs0NTksNyBAQDxvOnA+PC9vOnA+PC9zcGFu
PjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1Bcmlh
bD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6
QXJpYWwnPiZuYnNwO0BBVE1PREVNX1RSVUVAIHBsdWdpbnMvcGFsbXByZS4kKE9CSkVYVCkNCnBs
dWdpbnMvaWZ4LiQoT0JKRVhUKSBcPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAg
Y2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Ig
c3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7QEFUTU9E
RU1fVFJVRUAgcGx1Z2lucy9zdGUuJChPQkpFWFQpDQpwbHVnaW5zL3N0ZW1nci4kKE9CSkVYVCkg
XDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9u
dCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQox
MC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwO0BBVE1PREVNX1RSVUVAIHBsdWdpbnMvY2Fp
Zi4kKE9CSkVYVCkNCnBsdWdpbnMvdGM2NS4kKE9CSkVYVCkgXDxvOnA+PC9vOnA+PC9zcGFuPjwv
Zm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48
c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJp
YWwnPitAQVRNT0RFTV9UUlVFQCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBwbHVnaW5zL2gyNC4kKE9CSkVYVCkNClw8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDtAQVRNT0RFTV9UUlVFQCBwbHVnaW5zL25va2lhLiQo
T0JKRVhUKSBcPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9y
bWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQt
c2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7QEFUTU9ERU1fVFJVRUAgcGx1
Z2lucy9ub2tpYWNkbWEuJChPQkpFWFQpIFw8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0K
DQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1F
Ti1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDtA
QVRNT0RFTV9UUlVFQCBwbHVnaW5zL2xpbmt0b3AuJChPQkpFWFQpPG86cD48L286cD48L3NwYW4+
PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFs
PjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpB
cmlhbCc+QEAgLTE1NTIsNiArMTU1NSw4IEBAPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4N
Cg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9
RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IHBsdWdpbnMvJChERVBESVIpLyQoYW1fX2RpcnN0YW1wKTxvOnA+PC9vOnA+PC9zcGFuPjwv
Zm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48
c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJp
YWwnPiZuYnNwO3BsdWdpbnMvdGM2NS4kKE9CSkVYVCk6IHBsdWdpbnMvJChhbV9fZGlyc3RhbXAp
DQpcPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxm
b250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToN
CjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHBsdWdpbnMvJChERVBESVIpLyQo
YW1fX2RpcnN0YW1wKTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1z
b05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdm
b250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPitwbHVnaW5zL2gyNC4kKE9CSkVY
VCk6IHBsdWdpbnMvJChhbV9fZGlyc3RhbXApIFw8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9w
Pg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFu
Zz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHBsdWdp
bnMvJChERVBESVIpLyQoYW1fX2RpcnN0YW1wKTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+
DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5n
PUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNw
O3BsdWdpbnMvbm9raWEuJChPQkpFWFQpOg0KcGx1Z2lucy8kKGFtX19kaXJzdGFtcCkgXDxvOnA+
PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXpl
PTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7
Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBwbHVnaW5zLyQoREVQRElSKS8kKGFtX19kaXJz
dGFtcCk8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+
PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXpl
Og0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDtwbHVnaW5zL25va2lhY2RtYS4kKE9C
SkVYVCk6DQpwbHVnaW5zLyQoYW1fX2RpcnN0YW1wKSBcPG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
QEAgLTE5MTgsNiArMTkyMyw3IEBAPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAg
Y2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Ig
c3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC1y
bQ0KLWYgcGx1Z2lucy9zdGUuJChPQkpFWFQpPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4N
Cg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9
RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IC1ybQ0KLWYgcGx1Z2lucy9zdGVtZ3IuJChPQkpFWFQpPG86cD48L286cD48L3NwYW4+PC9m
b250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxz
cGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlh
bCc+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IC1ybQ0KLWYgcGx1Z2lucy90YzY1LiQoT0JKRVhUKTxvOnA+PC9vOnA+PC9z
cGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1B
cmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1p
bHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgLXJtDQotZiBwbHVnaW5zL2gyNC4kKE9CSkVYVCk8bzpwPjwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+
PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFy
aWFsJz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgLXJtDQotZiBwbHVnaW5zL3U4NTAwLiQoT0JKRVhUKTxvOnA+PC9vOnA+
PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFj
ZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1m
YW1pbHk6QXJpYWwnPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAtcm0NCi1mIHBsdWdpbnMvdWRldi4kKE9CSkVYVCk8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLXJtDQotZiBwbHVnaW5zL3dhdmVjb20uJChP
QkpFWFQpPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFs
Pjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6
ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+QEAgLTIxMjIsNiArMjEyOCw3IEBAPG86cD48
L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9
MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtm
b250LWZhbWlseTpBcmlhbCc+Jm5ic3A7QEFNREVQX1RSVUVAQGFtX19pbmNsdWRlQA0KQGFtX19x
dW90ZUBwbHVnaW5zLyQoREVQRElSKS9zdGUuUG9AYW1fX3F1b3RlQDxvOnA+PC9vOnA+PC9zcGFu
PjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1Bcmlh
bD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6
QXJpYWwnPiZuYnNwO0BBTURFUF9UUlVFQEBhbV9faW5jbHVkZUANCkBhbV9fcXVvdGVAcGx1Z2lu
cy8kKERFUERJUikvc3RlbWdyLlBvQGFtX19xdW90ZUA8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4m
bmJzcDtAQU1ERVBfVFJVRUBAYW1fX2luY2x1ZGVADQpAYW1fX3F1b3RlQHBsdWdpbnMvJChERVBE
SVIpL3RjNjUuUG9AYW1fX3F1b3RlQDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxw
IGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdC
IHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPitAQU1ERVBfVFJV
RUBAYW1fX2luY2x1ZGVAIEBhbV9fcXVvdGVAcGx1Z2lucy8kKERFUERJUikvaDI0LlBvQGFtX19x
dW90ZUA8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+
PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXpl
Og0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDtAQU1ERVBfVFJVRUBAYW1fX2luY2x1
ZGVADQpAYW1fX3F1b3RlQHBsdWdpbnMvJChERVBESVIpL3U4NTAwLlBvQGFtX19xdW90ZUA8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDtAQU1ERVBfVFJVRUBAYW1fX2luY2x1ZGVADQpAYW1f
X3F1b3RlQHBsdWdpbnMvJChERVBESVIpL3VkZXYuUG9AYW1fX3F1b3RlQDxvOnA+PC9vOnA+PC9z
cGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1B
cmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1p
bHk6QXJpYWwnPiZuYnNwO0BBTURFUF9UUlVFQEBhbV9faW5jbHVkZUANCkBhbV9fcXVvdGVAcGx1
Z2lucy8kKERFUERJUikvd2F2ZWNvbS5Qb0BhbV9fcXVvdGVAPG86cD48L286cD48L3NwYW4+PC9m
b250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxz
cGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlh
bCc+SW5kZXg6IG9mb25vLTAuNDUvZHJpdmVycy9hdG1vZGVtL3Ntcy5jPG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWls
eTpBcmlhbCc+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNs
YXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0
eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPi0tLSBvZm9uby0wLjQ1
Lm9yaWcvZHJpdmVycy9hdG1vZGVtL3Ntcy5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDIwMTEtMDItMDYNCjEzOjQ5OjEwLjAwMDAw
MDAwMCArMDEwMDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05v
cm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250
LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisrKyBvZm9uby0wLjQ1L2RyaXZlcnMv
YXRtb2RlbS9zbXMuYyZuYnNwOyAyMDExLTA0LTA0DQoxNTowMDo1Mi44MDY0MDA5NjYgKzAyMDA8
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz5AQCAtNzgzLDYgKzc4Myw3IEBAPG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWls
eTpBcmlhbCc+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNhc2UNCk9GT05PX1ZFTkRPUl9RVUFMQ09NTV9NU006PG86cD48
L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9
MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtm
b250LWZhbWlseTpBcmlhbCc+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNhc2UNCk9GT05PX1ZFTkRPUl9OT1ZBVEVMOjxv
OnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBz
aXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4w
cHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBjYXNlDQpPRk9OT19WRU5ET1JfSFVBV0VJ
OjxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9u
dCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQox
MC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgY2FzZQ0KT0ZPTk9fVkVORE9SX01PVE9ST0xBOjxvOnA+
PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXpl
PTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7
Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAvKg0KTVNNIGRldmlj
ZXMgYWR2ZXJ0aXNlIHN1cHBvcnQgZm9yIG1vZGUgMiwgYnV0IHJldHVybiBhbjxvOnA+PC9vOnA+
PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFj
ZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1m
YW1pbHk6QXJpYWwnPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsqDQplcnJvciBpZiB3
ZSBhdHRlbXB0IHRvIGFjdHVhbGx5IHVzZSBpdC4gKi88bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4m
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgbW9kZQ0KPSAmcXVvdDsxJnF1b3Q7OzxvOnA+PC9vOnA+
PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFj
ZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1m
YW1pbHk6QXJpYWwnPkluZGV4OiBvZm9uby0wLjQ1L2RyaXZlcnMvYXRtb2RlbS92ZW5kb3IuaDxv
OnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBz
aXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4w
cHQ7Zm9udC1mYW1pbHk6QXJpYWwnPj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4t
LS0gb2Zvbm8tMC40NS5vcmlnL2RyaXZlcnMvYXRtb2RlbS92ZW5kb3IuaCZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAyMDExLTAxLTI5DQowNjo0MjoxOC4wMDAwMDAw
MDAgKzAxMDA8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3Jt
YWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1z
aXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rKysgb2Zvbm8tMC40NS9kcml2ZXJzL2F0
bW9kZW0vdmVuZG9yLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgMjAxMS0wNC0wNA0KMTU6MDA6NTIuODA2NDAwOTY2ICswMjAwPG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+QEAgLTM1LDQgKzM1LDUgQEA8bzpwPjwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+
PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFy
aWFsJz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgT0ZPTk9fVkVORE9SX1dBVkVDT00sPG86cD48L286cD48L3NwYW4+PC9m
b250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxz
cGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlh
bCc+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IE9GT05PX1ZFTkRPUl9OT0tJQSw8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4m
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgT0ZPTk9fVkVORE9SX1BIT05FU0lNLDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBs
YW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPism
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgT0ZP
Tk9fVkVORE9SX01PVE9ST0xBLDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNs
YXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0
eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwO307PG86cD48
L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9
MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtm
b250LWZhbWlseTpBcmlhbCc+SW5kZXg6IG9mb25vLTAuNDUvcGx1Z2lucy9oMjQuYzxvOnA+PC9v
OnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIg
ZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9u
dC1mYW1pbHk6QXJpYWwnPj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT08bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0K
DQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1F
Ti1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4tLS0gL2Rl
di9udWxsJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDE5NzAtMDEt
MDENCjAwOjAwOjAwLjAwMDAwMDAwMCArMDAwMDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+
DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5n
PUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisrKyBv
Zm9uby0wLjQ1L3BsdWdpbnMvaDI0LmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMjAxMS0wNC0w
NA0KMTU6MDI6NDIuNTkxMjE5NjAzICswMjAwPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4N
Cg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9
RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+QEAgLTAs
MCArMSwyNDkgQEA8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29O
b3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9u
dC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rLyo8bzpwPjwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+
PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFy
aWFsJz4rICo8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3Jt
YWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1z
aXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rICombmJzcDsgb0Zvbm8gLSBPcGVuIFNv
dXJjZSBUZWxlcGhvbnk8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0n
Zm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rICo8bzpwPjwvbzpwPjwvc3Bh
bj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJp
YWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5
OkFyaWFsJz4rICombmJzcDsgQ29weXJpZ2h0IChDKSAyMDA4LTIwMTAmbmJzcDsgSW50ZWwNCkNv
cnBvcmF0aW9uLiBBbGwgcmlnaHRzIHJlc2VydmVkLjxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBs
YW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisg
KjxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9u
dCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQox
MC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisgKiZuYnNwOyBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbg0KcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnk8bzpwPjwvbzpw
Pjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZh
Y2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQt
ZmFtaWx5OkFyaWFsJz4rICombmJzcDsgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2Vu
ZXJhbA0KUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzPG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
KyAqJm5ic3A7IHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLjxvOnA+
PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXpl
PTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7
Zm9udC1mYW1pbHk6QXJpYWwnPisgKjxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxw
IGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdC
IHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisgKiZuYnNwOyBU
aGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUNCnRoYXQgaXQgd2lsbCBiZSB1
c2VmdWwsPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFs
Pjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6
ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyAqJm5ic3A7IGJ1dCBXSVRIT1VUIEFOWSBX
QVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZQ0KaW1wbGllZCB3YXJyYW50eSBvZjxvOnA+PC9vOnA+
PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFj
ZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1m
YW1pbHk6QXJpYWwnPisgKiZuYnNwOyBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSDQpQVVJQT1NFLiZuYnNwOyBTZWUgdGhlPG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
KyAqJm5ic3A7IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuPG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+KyAqPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0K
PHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4t
R0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyAqJm5ic3A7
IFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVQ0KR2VuZXJhbCBQdWJs
aWMgTGljZW5zZTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05v
cm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250
LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisgKiZuYnNwOyBhbG9uZyB3aXRoIHRo
aXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0bw0KdGhlIEZyZWUgU29mdHdhcmU8bzpwPjwvbzpw
Pjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZh
Y2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQt
ZmFtaWx5OkFyaWFsJz4rICombmJzcDsgRm91bmRhdGlvbiwgSW5jLiwgPHN0MTpTdHJlZXQgdzpz
dD0ib24iPjxzdDE6YWRkcmVzcw0KIHc6c3Q9Im9uIj41MSBGcmFua2xpbiBTdDwvc3QxOmFkZHJl
c3M+PC9zdDE6U3RyZWV0PiwgRmlmdGggRmxvb3IsIDxzdDE6cGxhY2UNCnc6c3Q9Im9uIj48c3Qx
OkNpdHkgdzpzdD0ib24iPkJvc3Rvbjwvc3QxOkNpdHk+LCA8c3QxOlN0YXRlIHc6c3Q9Im9uIj5N
QTwvc3QxOlN0YXRlPiZuYnNwOw0KIDxzdDE6UG9zdGFsQ29kZSB3OnN0PSJvbiI+MDIxMTAtMTMw
MTwvc3QxOlBvc3RhbENvZGU+Jm5ic3A7IDxzdDE6Y291bnRyeS1yZWdpb24NCiB3OnN0PSJvbiI+
VVNBPC9zdDE6Y291bnRyeS1yZWdpb24+PC9zdDE6cGxhY2U+PG86cD48L286cD48L3NwYW4+PC9m
b250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxz
cGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlh
bCc+KyAqPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFs
Pjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6
ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyAqLzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9u
dD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3Bh
biBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwn
Pis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZv
bnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0K
MTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rI2lmZGVmIEhBVkVfQ09ORklHX0g8bzpwPjwvbzpw
Pjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZh
Y2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQt
ZmFtaWx5OkFyaWFsJz4rI2luY2x1ZGUgJmx0O2NvbmZpZy5oJmd0OzxvOnA+PC9vOnA+PC9zcGFu
PjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1Bcmlh
bD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6
QXJpYWwnPisjZW5kaWY8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0n
Zm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+
PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFs
PjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpB
cmlhbCc+KyNpbmNsdWRlICZsdDtlcnJuby5oJmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBs
YW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisj
aW5jbHVkZSAmbHQ7c3RkbGliLmgmZ3Q7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0K
PHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4t
R0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KzxvOnA+PC9v
OnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIg
ZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9u
dC1mYW1pbHk6QXJpYWwnPisjaW5jbHVkZSAmbHQ7Z2xpYi5oJmd0OzxvOnA+PC9vOnA+PC9zcGFu
PjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1Bcmlh
bD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6
QXJpYWwnPisjaW5jbHVkZSAmbHQ7Z2F0Y2hhdC5oJmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9u
dD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3Bh
biBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwn
PisjaW5jbHVkZSAmbHQ7Z2F0dHR5LmgmZ3Q7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4N
Cg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9
RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KzxvOnA+
PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXpl
PTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7
Zm9udC1mYW1pbHk6QXJpYWwnPisjZGVmaW5lIE9GT05PX0FQSV9TVUJKRUNUX1RPX0NIQU5HRTxv
OnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBz
aXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4w
cHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisjaW5jbHVkZSAmbHQ7b2Zvbm8vcGx1Z2luLmgmZ3Q7PG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+KyNpbmNsdWRlICZsdDtvZm9uby9sb2cuaCZndDs8bzpwPjwv
bzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0y
IGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2Zv
bnQtZmFtaWx5OkFyaWFsJz4rI2luY2x1ZGUgJmx0O29mb25vL21vZGVtLmgmZ3Q7PG86cD48L286
cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBm
YWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250
LWZhbWlseTpBcmlhbCc+KyNpbmNsdWRlICZsdDtvZm9uby9jYWxsLWJhcnJpbmcuaCZndDs8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4rI2luY2x1ZGUgJmx0O29mb25vL2NhbGwtZm9yd2FyZGluZy5o
Jmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48
Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6
DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisjaW5jbHVkZSAmbHQ7b2Zvbm8vY2FsbC1tZXRl
ci5oJmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1h
bD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNp
emU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisjaW5jbHVkZSAmbHQ7b2Zvbm8vY2FsbC1z
ZXR0aW5ncy5oJmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1z
b05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdm
b250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisjaW5jbHVkZSAmbHQ7b2Zvbm8v
ZGV2aW5mby5oJmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1z
b05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdm
b250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisjaW5jbHVkZSAmbHQ7b2Zvbm8v
bWVzc2FnZS13YWl0aW5nLmgmZ3Q7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAg
Y2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Ig
c3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyNpbmNsdWRlICZs
dDtvZm9uby9uZXRyZWcuaCZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBj
bGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBz
dHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rI2luY2x1ZGUgJmx0
O29mb25vL3Bob25lYm9vay5oJmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxw
IGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdC
IHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisjaW5jbHVkZSAm
bHQ7b2Zvbm8vc2ltLmgmZ3Q7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xh
c3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5
bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyNpbmNsdWRlICZsdDtv
Zm9uby9zbXMuaCZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0n
Zm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rI2luY2x1ZGUgJmx0O29mb25v
L3Vzc2QuaCZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29O
b3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9u
dC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rI2luY2x1ZGUgJmx0O29mb25vL3Zv
aWNlY2FsbC5oJmd0OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1z
b05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdm
b250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+
PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFy
aWFsJz4rI2luY2x1ZGUgJmx0O2RyaXZlcnMvYXRtb2RlbS9hdHV0aWwuaCZndDs8bzpwPjwvbzpw
Pjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZh
Y2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQt
ZmFtaWx5OkFyaWFsJz4rI2luY2x1ZGUgJmx0O2RyaXZlcnMvYXRtb2RlbS92ZW5kb3IuaCZndDs8
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0K
PHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4t
R0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyNpbmNsdWRl
ICZsdDtvZm9uby9ncHJzLmgmZ3Q7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAg
Y2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Ig
c3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyNpbmNsdWRlICZs
dDtvZm9uby9ncHJzLWNvbnRleHQuaCZndDs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0K
DQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1F
Ti1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48
L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9
MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtm
b250LWZhbWlseTpBcmlhbCc+K3N0YXRpYyBpbnQgaDI0X3Byb2JlKHN0cnVjdCBvZm9ub19tb2Rl
bSAqbW9kZW0pPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9y
bWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQt
c2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+K3s8bzpwPjwvbzpwPjwvc3Bhbj48L2Zv
bnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNw
YW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFs
Jz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IHJldHVybg0KMDs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29O
b3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9u
dC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rfTxvOnA+PC9vOnA+PC9zcGFuPjwv
Zm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48
c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJp
YWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+
PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXpl
Og0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rc3RhdGljIHZvaWQgaDI0X3JlbW92ZShzdHJ1
Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxw
IGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdC
IHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPit7PG86cD48L286
cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBm
YWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250
LWZhbWlseTpBcmlhbCc+K308bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFz
cz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHls
ZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWls
eTpBcmlhbCc+K3N0YXRpYyB2b2lkIGgyNF9kZWJ1Zyhjb25zdCBjaGFyICpzdHIsIHZvaWQNCip1
c2VyX2RhdGEpPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9y
bWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQt
c2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+K3s8bzpwPjwvbzpwPjwvc3Bhbj48L2Zv
bnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNw
YW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFs
Jz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IGNvbnN0DQpjaGFyICpwcmVmaXggPSB1c2VyX2RhdGE7PG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9u
dCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQox
MC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgb2Zvbm9faW5mbygmcXVvdDslcyVzJnF1b3Q7LA0KcHJl
Zml4LCBzdHIpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05v
cm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250
LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPit9PG86cD48L286cD48L3NwYW4+PC9m
b250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxz
cGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlh
bCc+KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48
Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6
DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPitzdGF0aWMgaW50IGgyNF9lbmFibGUoc3RydWN0
IG9mb25vX21vZGVtICptb2RlbSk8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBj
bGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBz
dHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rezxvOnA+PC9vOnA+
PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFj
ZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1m
YW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgR0F0Q2hhdA0KKmNoYXQ7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4N
Cg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9
RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBHSU9DaGFu
bmVsDQoqY2hhbm5lbDs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0n
Zm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEdBdFN5bnRheA0KKnN5bnRheDs8
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEdIYXNoVGFibGUNCipvcHRpb25zOzxvOnA+PC9vOnA+PC9z
cGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1B
cmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1p
bHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgY29uc3QNCmNoYXIgKmRldmljZTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9w
Pg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFu
Zz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBEQkcoJnF1b3Q7JXAmcXVvdDssDQptb2RlbSk7PG86cD48L286
cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBm
YWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250
LWZhbWlseTpBcmlhbCc+KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNz
PU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxl
PSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgb3B0aW9ucw0KPSBnX2hhc2hf
dGFibGVfbmV3KGdfc3RyX2hhc2gsIGdfc3RyX2VxdWFsKTs8bzpwPjwvbzpwPjwvc3Bhbj48L2Zv
bnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNw
YW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFs
Jz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IGlmDQoob3B0aW9ucyA9PSBOVUxMKTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxw
IGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdC
IHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgcmV0dXJuDQotRU5PTUVNOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNs
YXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0
eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwv
c3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9
QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFt
aWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IGRldmljZQ0KPSBvZm9ub19tb2RlbV9nZXRfc3RyaW5nKG1vZGVtLCAmcXVvdDtE
ZXZpY2UmcXVvdDspOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1z
b05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdm
b250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYNCihkZXZpY2UgPT0gTlVMTCk8
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVybg0KLUVJTlZBTDs8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAg
Y2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Ig
c3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBnX2hhc2hfdGFibGVf
aW5zZXJ0KG9wdGlvbnMsDQomcXVvdDtCYXVkJnF1b3Q7LCAmcXVvdDsxMTUyMDAmcXVvdDspOzxv
OnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBz
aXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4w
cHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgZ19oYXNoX3RhYmxlX2luc2VydChvcHRpb25zLA0KJnF1b3Q7
U3RvcEJpdHMmcXVvdDssICZxdW90OzEmcXVvdDspOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBs
YW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPism
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZ19o
YXNoX3RhYmxlX2luc2VydChvcHRpb25zLA0KJnF1b3Q7RGF0YUJpdHMmcXVvdDssICZxdW90Ozgm
cXVvdDspOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1h
bD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNp
emU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZ19oYXNoX3RhYmxlX2luc2VydChvcHRpb25z
LA0KJnF1b3Q7UGFyaXR5JnF1b3Q7LCAmcXVvdDtub25lJnF1b3Q7KTs8bzpwPjwvbzpwPjwvc3Bh
bj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJp
YWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5
OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IGdfaGFzaF90YWJsZV9pbnNlcnQob3B0aW9ucywNCiZxdW90O1hvblhvZmYmcXVvdDss
ICZxdW90O29mZiZxdW90Oyk7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xh
c3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5
bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBnX2hhc2hfdGFibGVfaW5z
ZXJ0KG9wdGlvbnMsDQomcXVvdDtSdHNDdHMmcXVvdDssICZxdW90O29uJnF1b3Q7KTs8bzpwPjwv
bzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0y
IGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2Zv
bnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IGdfaGFzaF90YWJsZV9pbnNlcnQob3B0aW9ucywNCiZxdW90O0xvY2Fs
JnF1b3Q7LCAmcXVvdDtvbiZxdW90Oyk7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0K
PHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4t
R0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBnX2hhc2hfdGFi
bGVfaW5zZXJ0KG9wdGlvbnMsDQomcXVvdDtSZWFkJnF1b3Q7LCAmcXVvdDtvbiZxdW90Oyk7PG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxw
IGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdC
IHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgY2hhbm5lbA0KPSBn
X2F0X3R0eV9vcGVuKGRldmljZSwgb3B0aW9ucyk7PG86cD48L286cD48L3NwYW4+PC9mb250Pjwv
cD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxh
bmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBnX2hh
c2hfdGFibGVfZGVzdHJveShvcHRpb25zKTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0K
DQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1F
Ti1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48
L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9
MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtm
b250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBpZg0KKGNoYW5uZWwgPT0gTlVMTCk8bzpwPjwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+
PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFy
aWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVybg0KLUVJTzs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4r
PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250
IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEw
LjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAvKjxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoN
CjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVO
LUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgDQoqIEgyNCB3
b3JrcyBhbG1vc3QgYXMgdGhlIDI3LjAwNyBzYXlzLiBUb2RheSBJPG86cD48L286cD48L3NwYW4+
PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFs
PjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpB
cmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAq
DQpqdXN0IGNvcGllZCBleGlzdGluZyBjb25maWcgZnJvbSB0YzY1LjxvOnA+PC9vOnA+PC9zcGFu
PjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1Bcmlh
bD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6
QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
KiBUT0RPOg0KY2hlY2sgaWYgaXQgd29ya3Mgd2l0aCBhIG1vcmUgc3RpY3QgcGFyc2luZzxvOnA+
PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXpl
PTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7
Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgDQoqLzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxw
IGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdC
IHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3ludGF4DQo9IGdf
YXRfc3ludGF4X25ld19nc21fcGVybWlzc2l2ZSgpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBs
YW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNoYXQNCj0gZ19hdF9jaGF0X25ldyhjaGFubmVsLCBzeW50
YXgpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48
Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6
DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZ19hdF9zeW50YXhfdW5yZWYoc3ludGF4KTs8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IGdfaW9fY2hhbm5lbF91bnJlZihjaGFubmVsKTs8bzpwPjwvbzpw
Pjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZh
Y2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQt
ZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9
TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9
J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZg0KKGNoYXQgPT0gTlVMTCk8
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVybg0KLUVOT01FTTs8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAg
Y2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Ig
c3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZg0KKGdldGVudigm
cXVvdDtPRk9OT19BVF9ERUJVRyZxdW90OykpPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4N
Cg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9
RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBnX2F0X2NoYXRfc2V0X2RlYnVnKGNoYXQsDQpoMjRfZGVidWcsICZxdW90OyZxdW90
Oyk7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxm
b250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToN
CjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+
DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5n
PUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgb2Zvbm9f
bW9kZW1fc2V0X2RhdGEobW9kZW0sDQpjaGF0KTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9w
Pg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFu
Zz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyByZXR1cm4NCjA7PG86cD48L286cD48L3NwYW4+PC9mb250Pjwv
cD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxh
bmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+K308
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0K
PHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4t
R0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+K3N0YXRpYyBp
bnQgaDI0X2Rpc2FibGUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8bzpwPjwvbzpwPjwvc3Bh
bj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJp
YWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5
OkFyaWFsJz4rezxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05v
cm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250
LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgR0F0Q2hhdA0KKmNoYXQgPSBvZm9ub19t
b2RlbV9nZXRfZGF0YShtb2RlbSk7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAg
Y2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Ig
c3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KzxvOnA+PC9vOnA+
PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFj
ZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1m
YW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgREJHKCZxdW90OyVwJnF1b3Q7LA0KbW9kZW0pOzxvOnA+PC9vOnA+PC9zcGFu
PjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1Bcmlh
bD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6
QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3Jt
YWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1z
aXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IG9mb25vX21vZGVtX3NldF9kYXRhKG1vZGVt
LA0KTlVMTCk7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9y
bWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQt
c2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9u
dD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3Bh
biBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwn
PismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
Z19hdF9jaGF0X3NlbmQoY2hhdCwNCiZxdW90O0FUK0NGVU49NCZxdW90OywgTlVMTCwgTlVMTCwg
TlVMTCwgTlVMTCk7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNv
Tm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2Zv
bnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KzxvOnA+PC9vOnA+PC9zcGFuPjwv
Zm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48
c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJp
YWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgZ19hdF9jaGF0X3VucmVmKGNoYXQpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoN
CjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVO
LUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwv
bzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0y
IGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2Zv
bnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IHJldHVybg0KMDs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0K
DQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1F
Ti1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rfTxvOnA+
PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXpl
PTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7
Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBj
bGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBz
dHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rc3RhdGljIHZvaWQg
c2V0X29ubGluZV9jYihnYm9vbGVhbiBvaywgR0F0UmVzdWx0DQoqcmVzdWx0LCBncG9pbnRlciB1
c2VyX2RhdGEpPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9y
bWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQt
c2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+K3s8bzpwPjwvbzpwPjwvc3Bhbj48L2Zv
bnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNw
YW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFs
Jz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IHN0cnVjdA0KY2JfZGF0YSAqY2JkID0gdXNlcl9kYXRhOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9u
dD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3Bh
biBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwn
PismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
b2Zvbm9fbW9kZW1fb25saW5lX2NiX3QNCmNiID0gY2JkLSZndDtjYjs8bzpwPjwvbzpwPjwvc3Bh
bj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJp
YWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5
OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IHN0cnVjdA0Kb2Zvbm9fZXJyb3IgZXJyb3I7PG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9u
dCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQox
MC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZGVjb2RlX2F0X2Vycm9yKCZhbXA7ZXJyb3IsDQpnX2F0
X3Jlc3VsdF9maW5hbF9yZXNwb25zZShyZXN1bHQpKTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4r
PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250
IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEw
LjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBjYigmYW1wO2Vycm9yLA0KY2JkLSZndDtkYXRhKTs8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4rfTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxw
IGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdC
IHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpw
Pjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZh
Y2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQt
ZmFtaWx5OkFyaWFsJz4rc3RhdGljIHZvaWQgaDI0X3NldF9vbmxpbmUoc3RydWN0IG9mb25vX21v
ZGVtDQoqbW9kZW0sIG9mb25vX2Jvb2xfdCBvbmxpbmUsPG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBvZm9ub19tb2RlbV9vbmxpbmVfY2JfdA0KY2IsIHZvaWQg
KnVzZXJfZGF0YSk8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29O
b3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9u
dC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rezxvOnA+PC9vOnA+PC9zcGFuPjwv
Zm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48
c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJp
YWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgR0F0Q2hhdA0KKmNoYXQgPSBvZm9ub19tb2RlbV9nZXRfZGF0YShtb2RlbSk7PG86cD48L286
cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBm
YWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250
LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBzdHJ1Y3QNCmNiX2RhdGEgKmNiZCA9IGNiX2RhdGFfbmV3KGNiLCB1c2Vy
X2RhdGEpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1h
bD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNp
emU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgY2hhcg0KY29uc3QgKmNvbW1hbmQgPSBvbmxp
bmUgPyAmcXVvdDtBVCtDRlVOPTEmcXVvdDsgOiAmcXVvdDtBVCtDRlVOPTQmcXVvdDs7PG86cD48
L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9
MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtm
b250LWZhbWlseTpBcmlhbCc+KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNs
YXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0
eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgREJHKCZxdW90O21vZGVt
DQolcCAlcyZxdW90OywgbW9kZW0sIG9ubGluZSA/ICZxdW90O29ubGluZSZxdW90OyA6ICZxdW90
O29mZmxpbmUmcXVvdDspOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNz
PU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxl
PSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bh
bj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJp
YWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5
OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IGlmDQooZ19hdF9jaGF0X3NlbmQoY2hhdCwgY29tbWFuZCwgTlVMTCwgc2V0X29ubGlu
ZV9jYiwgY2JkLCBnX2ZyZWUpKTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNs
YXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0
eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
cmV0dXJuOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1h
bD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNp
emU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4r
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGdf
ZnJlZShjYmQpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05v
cm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250
LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48L2Zv
bnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNw
YW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFs
Jz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IENBTExCQUNLX1dJVEhfRkFJTFVSRShjYiwNCmNiZC0mZ3Q7ZGF0YSk7PG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWls
eTpBcmlhbCc+K308bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29O
b3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9u
dC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+PC9m
b250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxz
cGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlh
bCc+K3N0YXRpYyB2b2lkIGgyNF9wcmVfc2ltKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pPG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+K3s8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8
cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1H
QiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEdBdENoYXQNCipj
aGF0ID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEobW9kZW0pOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9u
dD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3Bh
biBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwn
PismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
c3RydWN0DQpvZm9ub19zaW0gKnNpbTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8
cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1H
QiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286
cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBm
YWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250
LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBEQkcoJnF1b3Q7JXAmcXVvdDssDQptb2RlbSk7PG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWls
eTpBcmlhbCc+KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05v
cm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250
LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgb2Zvbm9fZGV2aW5mb19jcmVhdGUobW9k
ZW0sDQowLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBjaGF0KTs8bzpwPjwvbzpwPjwvc3Bhbj48L2Zv
bnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNw
YW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFs
Jz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IHNpbQ0KPSBvZm9ub19zaW1fY3JlYXRlKG1vZGVtLCAwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBj
aGF0KTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+
PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXpl
Og0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IG9mb25vX3ZvaWNlY2FsbF9jcmVhdGUobW9kZW0s
DQowLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBjaGF0KTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4r
PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250
IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEw
LjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZg0KKHNpbSk8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4r
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IG9mb25vX3NpbV9pbnNlcnRlZF9ub3RpZnkoc2ltLA0KVFJVRSk7PG86cD48
L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9
MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtm
b250LWZhbWlseTpBcmlhbCc+K308bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBj
bGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBz
dHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48
L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNl
PUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZh
bWlseTpBcmlhbCc+K3N0YXRpYyB2b2lkIGgyNF9wb3N0X3NpbShzdHJ1Y3Qgb2Zvbm9fbW9kZW0g
Km1vZGVtKTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1h
bD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNp
emU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPit7PG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBH
QXRDaGF0DQoqY2hhdCA9IG9mb25vX21vZGVtX2dldF9kYXRhKG1vZGVtKTs8bzpwPjwvbzpwPjwv
c3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9
QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFt
aWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNv
Tm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2Zv
bnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBEQkcoJnF1b3Q7JXAmcXVvdDssDQpt
b2RlbSk7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFs
Pjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6
ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBs
YW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPism
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgb2Zv
bm9fcGhvbmVib29rX2NyZWF0ZShtb2RlbSwNCjAsICZxdW90O2F0bW9kZW0mcXVvdDssIGNoYXQp
OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9u
dCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQox
MC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0K
DQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1F
Ti1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IG9mb25vX3Nt
c19jcmVhdGUobW9kZW0sDQpPRk9OT19WRU5ET1JfTU9UT1JPTEEsICZxdW90O2F0bW9kZW0mcXVv
dDssIGNoYXQpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05v
cm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250
LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPit9PG86cD48L286cD48L3NwYW4+PC9m
b250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxz
cGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlh
bCc+KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48
Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6
DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPitzdGF0aWMgdm9pZCBoMjRfcG9zdF9vbmxpbmUo
c3RydWN0IG9mb25vX21vZGVtDQoqbW9kZW0pPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4N
Cg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9
RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+K3s8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IEdBdENoYXQNCipjaGF0ID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEo
bW9kZW0pOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1h
bD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNp
emU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RydWN0DQpvZm9ub19tZXNzYWdlX3dhaXRp
bmcgKm13OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1h
bD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNp
emU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RydWN0DQpvZm9ub19ncHJzICpncHJzOzxv
OnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBz
aXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4w
cHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RydWN0DQpvZm9ub19ncHJzX2NvbnRleHQgKmdjOzxvOnA+
PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXpl
PTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7
Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBj
bGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBz
dHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IERCRygmcXVvdDslcCZx
dW90OywNCm1vZGVtKTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0n
Zm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+
PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFs
PjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpB
cmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBvZm9ub191c3NkX2NyZWF0ZShtb2RlbSwNCjAsICZxdW90O2F0bW9kZW0mcXVvdDssIGNo
YXQpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48
Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6
DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgb2Zvbm9fY2FsbF9mb3J3YXJkaW5nX2NyZWF0ZSht
b2RlbSwNCjAsICZxdW90O2F0bW9kZW0mcXVvdDssIGNoYXQpOzxvOnA+PC9vOnA+PC9zcGFuPjwv
Zm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48
c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJp
YWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgb2Zvbm9fY2FsbF9zZXR0aW5nc19jcmVhdGUobW9kZW0sDQowLCAmcXVvdDthdG1vZGVtJnF1
b3Q7LCBjaGF0KTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29O
b3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9u
dC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IG9mb25vX25ldHJlZ19jcmVhdGUobW9k
ZW0sDQowLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBjaGF0KTs8bzpwPjwvbzpwPjwvc3Bhbj48L2Zv
bnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNw
YW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFs
Jz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IG9mb25vX2NhbGxfbWV0ZXJfY3JlYXRlKG1vZGVtLA0KMCwgJnF1b3Q7YXRtb2RlbSZxdW90Oywg
Y2hhdCk7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFs
Pjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6
ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBvZm9ub19jYWxsX2JhcnJpbmdfY3JlYXRlKG1v
ZGVtLA0KMCwgJnF1b3Q7YXRtb2RlbSZxdW90OywgY2hhdCk7PG86cD48L286cD48L3NwYW4+PC9m
b250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxz
cGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlh
bCc+KzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48
Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6
DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZ3Bycw0KPSBvZm9ub19ncHJzX2NyZWF0ZShtb2Rl
bSwgMCwgJnF1b3Q7YXRtb2RlbSZxdW90OywgY2hhdCk7PG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBn
Yw0KPSBvZm9ub19ncHJzX2NvbnRleHRfY3JlYXRlKG1vZGVtLCBPRk9OT19WRU5ET1JfTU9UT1JP
TEEsICZxdW90O2F0bW9kZW0mcXVvdDssDQpjaGF0KTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4r
PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250
IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEw
LjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyAmbmJzcDsgREJHKCZxdW90O0dQUlMmcXVvdDspOzxvOnA+PC9vOnA+PC9zcGFu
PjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1Bcmlh
bD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6
QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgaWYNCihncHJzICZhbXA7JmFtcDsgZ2MpezxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBs
YW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPism
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7IERCRygmcXVv
dDtHUFJTDQphZGQgY29udGV4dCZxdW90Oyk7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4N
Cg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9
RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KzxvOnA+
PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXpl
PTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7
Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgb2Zvbm9fZ3Byc19hZGRfY29udGV4dChn
cHJzLA0KZ2MpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05v
cm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250
LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxw
IGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdC
IHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgbXcNCj0gb2Zvbm9f
bWVzc2FnZV93YWl0aW5nX2NyZWF0ZShtb2RlbSk7PG86cD48L286cD48L3NwYW4+PC9mb250Pjwv
cD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxh
bmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZg0K
KG13KTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48
Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6
DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgb2Zvbm9fbWVzc2FnZV93
YWl0aW5nX3JlZ2lzdGVyKG13KTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBj
bGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBz
dHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rfTxvOnA+PC9vOnA+
PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFj
ZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1m
YW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0n
Zm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rc3RhdGljIHN0cnVjdCBvZm9u
b19tb2RlbV9kcml2ZXIgaDI0X2RyaXZlciA9IHs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9w
Pg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFu
Zz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC5uYW1l
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7DQo9ICZx
dW90O2gyNCZxdW90Oyw8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0n
Zm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC5wcm9iZSZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOw0KPSBoMjRfcHJvYmUsPG86cD48L286cD48
L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNl
PUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZh
bWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyAucmVtb3ZlJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
DQo9IGgyNF9yZW1vdmUsPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9
TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9
J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAuZW5hYmxlJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7DQo9IGgyNF9lbmFibGUsPG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWls
eTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyAuZGlzYWJsZSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOw0KPSBoMjRf
ZGlzYWJsZSw8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3Jt
YWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1z
aXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC5zZXRfb25saW5lJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
DQo9IGgyNF9zZXRfb25saW5lLDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNs
YXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0
eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLnByZV9zaW0mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsNCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOz0gaDI0X3ByZV9zaW0sPG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWls
eTpBcmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyAucG9zdF9zaW0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsNCj0gaDI0X3Bvc3Rf
c2ltLDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48
Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6
DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLnBvc3Rfb25saW5lJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7DQo9IGgyNF9w
b3N0X29ubGluZSw8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29O
b3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9u
dC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rfTs8bzpwPjwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+
PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFy
aWFsJz4rPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFs
Pjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6
ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+K3N0YXRpYyBpbnQgaDI0X2luaXQodm9pZCk8
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rezxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoN
CjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVO
LUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuDQpv
Zm9ub19tb2RlbV9kcml2ZXJfcmVnaXN0ZXIoJmFtcDtoMjRfZHJpdmVyKTs8bzpwPjwvbzpwPjwv
c3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9
QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFt
aWx5OkFyaWFsJz4rfTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1z
b05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdm
b250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+
PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFy
aWFsJz4rc3RhdGljIHZvaWQgaDI0X2V4aXQodm9pZCk8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4r
ezxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9u
dCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQox
MC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgb2Zvbm9fbW9kZW1fZHJpdmVyX3VucmVnaXN0ZXIoJmFt
cDtoMjRfZHJpdmVyKTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0n
Zm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rfTxvOnA+PC9vOnA+PC9zcGFu
PjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1Bcmlh
bD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6
QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3Jt
YWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1z
aXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rT0ZPTk9fUExVR0lOX0RFRklORShoMjQs
ICZxdW90O01vdG9yb2xhIEgyNCBkcml2ZXINCnBsdWdpbiZxdW90OywgVkVSU0lPTiw8bzpwPjwv
bzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0y
IGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2Zv
bnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE9GT05PX1BMVUdJTl9QUklPUklUWV9ERUZB
VUxULA0KaDI0X2luaXQsIGgyNF9leGl0KTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoN
CjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVO
LUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPkluZGV4OiBv
Zm9uby0wLjQ1L3BsdWdpbnMvdWRldi5jPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0K
PHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4t
R0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9u
dCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQox
MC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPi0tLSBvZm9uby0wLjQ1Lm9yaWcvcGx1Z2lucy91ZGV2
LmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgMjAxMS0wMy0xNQ0KMTU6MTA6NTUuMDAwMDAwMDAwICswMTAwPG86cD48L286
cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBm
YWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250
LWZhbWlseTpBcmlhbCc+KysrIG9mb25vLTAuNDUvcGx1Z2lucy91ZGV2LmMmbmJzcDsmbmJzcDsm
bmJzcDsgMjAxMS0wNC0wNA0KMTU6MDA6NTIuODA2NDAwOTY2ICswMjAwPG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWls
eTpBcmlhbCc+QEAgLTU0NSw2ICs1NDUsMTkgQEA8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9w
Pg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFu
Zz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgb2Zvbm9fbW9kZW1fcmVnaXN0ZXIobW9kZW0pOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9u
dD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3Bh
biBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwn
PiZuYnNwO308bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3Jt
YWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1z
aXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDs8bzpwPjwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+
PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFy
aWFsJz4rc3RhdGljIHZvaWQgYWRkX2gyNChzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtLDxvOnA+
PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXpl
PTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7
Zm9udC1mYW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RydWN0DQp1ZGV2X2Rl
dmljZSAqdWRldl9kZXZpY2UpPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xh
c3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5
bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+K3s8bzpwPjwvbzpwPjwv
c3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9
QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFt
aWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IGNvbnN0DQpjaGFyICpkZXZub2RlOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBs
YW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IERCRygmcXVvdDttb2RlbQ0KJXAmcXVvdDssIG1vZGVtKTs8
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0K
PHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4t
R0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+KyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBkZXZub2RlDQo9
IHVkZXZfZGV2aWNlX2dldF9kZXZub2RlKHVkZXZfZGV2aWNlKTs8bzpwPjwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+
PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFy
aWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IG9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0sDQomcXVvdDtEZXZpY2UmcXVvdDssIGRl
dm5vZGUpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1h
bD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNp
emU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4r
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IG9m
b25vX21vZGVtX3JlZ2lzdGVyKG1vZGVtKTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0K
DQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1F
Ti1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rfTxvOnA+
PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXpl
PTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7
Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBj
bGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBz
dHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDtzdGF0aWMg
dm9pZCBhZGRfbm9raWFjZG1hKHN0cnVjdCBvZm9ub19tb2RlbQ0KKm1vZGVtLDxvOnA+PC9vOnA+
PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFj
ZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1m
YW1pbHk6QXJpYWwnPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBzdHJ1Y3QNCnVkZXZfZGV2aWNlICp1ZGV2X2RldmljZSk8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDt7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4N
Cg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9
RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+QEAgLTY4
Miw2ICs2OTUsOCBAQDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1z
b05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdm
b250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBhZGRfY2FseXBzbyhtb2RlbSwNCnVkZXZfZGV2aWNlKTs8bzpwPjwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+
PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFy
aWFsJz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgZWxzZQ0KaWYgKGdfc3RyY21wMChkcml2ZXIsICZxdW90O3RjNjUmcXVv
dDspID09IDApPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9y
bWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQt
c2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IGFkZF90YzY1KG1vZGVtLA0KdWRldl9kZXZpY2UpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBs
YW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPism
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZWxz
ZQ0KaWYgKGdfc3RyY21wMChkcml2ZXIsICZxdW90O2gyNCZxdW90OykgPT0gMCk8bzpwPjwvbzpw
Pjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZh
Y2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQt
ZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFkZF9oMjQobW9kZW0sDQp1ZGV2X2RldmljZSk7
PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250
IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEw
LjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGVsc2UNCmlmIChnX3N0cmNtcDAoZHJp
dmVyLCAmcXVvdDtub2tpYWNkbWEmcXVvdDspID09IDApPG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFkZF9ub2tpYWNkbWEobW9kZW0sDQp1ZGV2X2Rldmlj
ZSk7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxm
b250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToN
CjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IGVsc2UNCmlmIChnX3N0cmNtcDAoZHJpdmVyLCAmcXVvdDtsaW5r
dG9wJnF1b3Q7KSA9PSAwKTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNz
PU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxl
PSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPkluZGV4OiBvZm9uby0wLjQ1
L2RvYy9oMjQtbW9kZW0udHh0PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xh
c3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5
bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxvOnA+
PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXpl
PTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7
Zm9udC1mYW1pbHk6QXJpYWwnPi0tLSAvZGV2L251bGwmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgMTk3MC0wMS0wMQ0KMDA6MDA6MDAuMDAwMDAwMDAwICswMDAwPG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+KysrIG9mb25vLTAuNDUvZG9jL2gyNC1tb2RlbS50eHQmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMjAxMS0wNC0wNA0KMTU6MDA6
NTIuODA2NDAwOTY2ICswMjAwPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xh
c3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5
bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+QEAgLTAsMCArMSwxMSBA
QDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9u
dCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQox
MC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPitIMjQgbW9kZW0gdXNhZ2U8bzpwPjwvbzpwPjwvc3Bh
bj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJp
YWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5
OkFyaWFsJz4rPT09PT09PT09PT09PT09PT09PTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+
DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5n
PUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4rVGhlIEgyNCBtb2RlbSBpcyBwcmVzZW50ZWQgYnkgdGhlIGtl
cm5lbCBhcyBzZXJpYWwNCmRldmljZTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxw
IGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdC
IHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisvZGV2L0FDTTAg
aWYgdXNiIGxpbmsgdG8gbW9kZW0gaXMgdXNlZC4gVG8gYWxsb3cNCm9Gb25vIHRvPG86cD48L286
cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBm
YWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250
LWZhbWlseTpBcmlhbCc+K2F1dG9kZXRlY3QgYW5kIHVzZSB0aGlzLCBhIHNpbXBsZSB1ZGV2IHJ1
bGUgaXMNCm5lZWRlZDo8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0n
Zm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+
PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFs
PjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpB
cmlhbCc+K0tFUk5FTD09JnF1b3Q7dHR5QUNNMCZxdW90OywNCkVOVntPRk9OT19EUklWRVJ9PSZx
dW90O2gyNCZxdW90OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1z
b05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdm
b250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPis8bzpwPjwvbzpwPjwvc3Bhbj48
L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+
PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFy
aWFsJz4rWW91IGNhbiBwdXQgdGhpcyBpbiBhbnkgZmlsZSBpbiAvbGliL3VkZXYvcnVsZXMuZC48
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0K
PHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4t
R0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+SW5kZXg6IG9m
b25vLTAuNDUvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jPG86cD48L286cD48L3NwYW4+
PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFs
PjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpB
cmlhbCc+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNz
PU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxl
PSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPi0tLSBvZm9uby0wLjQ1Lm9y
aWcvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDIwMTEtMDQtMDQNCjE1OjAxOjQw
LjQ2MjQwMTgwNSArMDIwMDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNz
PU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxl
PSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPisrKyBvZm9uby0wLjQ1L2Ry
aXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYyZuYnNwOyAyMDExLTA0LTA0DQoxNToxOToxNy45
NTYyNzIxMTIgKzAyMDA8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1N
c29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0n
Zm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz5AQCAtNDEsNiArNDEsNyBAQDxv
OnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBz
aXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4w
cHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOyNpbmNsdWRlICZxdW90O2dhdHBwcC5oJnF1b3Q7
PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250
IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEw
LjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7PG86cD48L286cD48L3NwYW4+PC9mb250Pjwv
cD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxh
bmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5i
c3A7I2luY2x1ZGUgJnF1b3Q7YXRtb2RlbS5oJnF1b3Q7PG86cD48L286cD48L3NwYW4+PC9mb250
PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFu
IGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+
KyNpbmNsdWRlICZxdW90O3ZlbmRvci5oJnF1b3Q7PG86cD48L286cD48L3NwYW4+PC9mb250Pjwv
cD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxh
bmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5i
c3A7PG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxm
b250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToN
CjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7I2RlZmluZSBUVU5fU1lTRlNfRElSDQom
cXVvdDsvc3lzL2RldmljZXMvdmlydHVhbC9taXNjL3R1biZxdW90OzxvOnA+PC9vOnA+PC9zcGFu
PjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1Bcmlh
bD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6
QXJpYWwnPiZuYnNwOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1z
b05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdm
b250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPkBAIC02Nyw2ICs2OCw3IEBAPG86
cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNp
emU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBw
dDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IG9mb25vX2dwcnNf
Y29udGV4dF91cF9jYl90DQp1cF9jYjsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgLyogVXAgY2FsbGJhY2sgKi88bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBj
bGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBz
dHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTs8
bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQg
c2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAu
MHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdm9pZA0KKmNiX2RhdGE7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7DQovKiBDYWxsYmFjayBkYXRhICovPG86cD48L286cD48L3NwYW4+
PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFs
PjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpB
cmlhbCc+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyB1bnNpZ25lZA0KaW50IHZlbmRvcjs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0K
DQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1F
Ti1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDt9
OzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9u
dCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQox
MC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48
L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBs
YW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZu
YnNwO3N0YXRpYyB2b2lkIHBwcF9kZWJ1Zyhjb25zdCBjaGFyICpzdHIsIHZvaWQNCipkYXRhKTxv
OnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBz
aXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4w
cHQ7Zm9udC1mYW1pbHk6QXJpYWwnPkBAIC0yMDksNyArMjExLDExIEBAPG86cD48L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFy
aWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWls
eTpBcmlhbCc+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVybjs8bzpwPjwvbzpwPjwvc3Bh
bj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJp
YWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5
OkFyaWFsJz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgfTxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNs
YXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0
eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOzxvOnA+PC9v
OnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIg
ZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9u
dC1mYW1pbHk6QXJpYWwnPi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgc3ByaW50ZihidWYsDQomcXVvdDtBVCtDR0RBVEE9XCZxdW90
O1BQUFwmcXVvdDssJXUmcXVvdDssIGdjZC0mZ3Q7YWN0aXZlX2NvbnRleHQpOzxvOnA+PC9vOnA+
PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFj
ZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1m
YW1pbHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsN
CmlmKGdjZC0mZ3Q7dmVuZG9yID09IE9GT05PX1ZFTkRPUl9NT1RPUk9MQSk8bzpwPjwvbzpwPjwv
c3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9
QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFt
aWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHNwcmludGYoYnVmLA0KJnF1b3Q7QVREKjk5KioqJXUj
JnF1b3Q7LCBnY2QtJmd0O2FjdGl2ZV9jb250ZXh0KTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+
PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4g
bGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4r
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGVsc2U8bzpwPjwvbzpw
Pjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZh
Y2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQt
ZmFtaWx5OkFyaWFsJz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHNwcmludGYoYnVmLA0KJnF1b3Q7QVQrQ0dEQVRB
PVwmcXVvdDtQUFBcJnF1b3Q7LCV1JnF1b3Q7LCBnY2QtJmd0O2FjdGl2ZV9jb250ZXh0KTs8bzpw
PjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6
ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0
O2ZvbnQtZmFtaWx5OkFyaWFsJz4rPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAg
Y2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Ig
c3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlm
DQooZ19hdF9jaGF0X3NlbmQoZ2NkLSZndDtjaGF0LCBidWYsIG5vbmVfcHJlZml4LDxvOnA+PC9v
OnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIg
ZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9u
dC1mYW1pbHk6QXJpYWwnPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBhdF9jZ2RhdGFfY2IsDQpnYywgTlVMTCkgJmd0OyAwKTxvOnA+PC9vOnA+PC9zcGFu
PjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1Bcmlh
bD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6
QXJpYWwnPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyByZXR1cm47PG86cD48L286cD48L3NwYW4+
PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFs
PjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpB
cmlhbCc+QEAgLTI4Nyw2ICsyOTMsOCBAQDxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoN
CjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVO
LUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOzxv
OnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBz
aXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4w
cHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBnY2QtJmd0O2NoYXQNCj0gZ19hdF9jaGF0
X2Nsb25lKGNoYXQpOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1z
b05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdm
b250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwnPiZuYnNwOzxvOnA+PC9vOnA+PC9z
cGFuPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1B
cmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1p
bHk6QXJpYWwnPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgZ2NkLSZndDt2ZW5kb3INCj0gdmVuZG9yOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9u
dD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3Bh
biBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwn
Pis8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZv
bnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0K
MTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgb2Zvbm9fZ3Byc19jb250ZXh0X3Nl
dF9kYXRhKGdjLA0KZ2NkKTs8bzpwPjwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFz
cz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHls
ZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQtZmFtaWx5OkFyaWFsJz4mbmJzcDs8bzpwPjwvbzpw
Pjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWw+PGZvbnQgc2l6ZT0yIGZh
Y2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOg0KMTAuMHB0O2ZvbnQt
ZmFtaWx5OkFyaWFsJz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuDQowOzxvOnA+PC9vOnA+PC9zcGFuPjwvZm9u
dD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTIgZmFjZT1BcmlhbD48c3Bh
biBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6DQoxMC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWwn
Pi0tLS0tLS0tLS0gPG86cD48L286cD48L3NwYW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNv
Tm9ybWFsPjxmb250IHNpemU9MiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2Zv
bnQtc2l6ZToNCjEwLjBwdDtmb250LWZhbWlseTpBcmlhbCc+PG86cD4mbmJzcDs8L286cD48L3Nw
YW4+PC9mb250PjwvcD4NCg0KPHAgY2xhc3M9TXNvTm9ybWFsIHN0eWxlPSdtc28tbWFyZ2luLXRv
cC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRvbS1hbHQ6YXV0byc+PHN0cm9uZz48Yj48Zm9udA0K
c2l6ZT0xIGNvbG9yPSIjMDAyMDQxIiBmYWNlPUFyaWFsPjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9
J2ZvbnQtc2l6ZTo3LjVwdDsNCmZvbnQtZmFtaWx5OkFyaWFsO2NvbG9yOiMwMDIwNDEnPi0tLS0t
LS0tLS08L3NwYW4+PC9mb250PjwvYj48L3N0cm9uZz48c3Bhbg0KbGFuZz1FTi1HQj48bzpwPjwv
bzpwPjwvc3Bhbj48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbCBzdHlsZT0nbXNvLW1hcmdpbi10
b3AtYWx0OmF1dG87bXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1dG8nPjxzdHJvbmc+PGI+PGZvbnQN
CnNpemU9MSBjb2xvcj0iIzAwMjA0MSIgZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxl
PSdmb250LXNpemU6Ny41cHQ7DQpmb250LWZhbWlseTpBcmlhbDtjb2xvcjojMDAyMDQxJz5DaHJp
c3RvcGhlIE9zdGVybWFubjwvc3Bhbj48L2ZvbnQ+PC9iPjwvc3Ryb25nPjxmb250DQpjb2xvcj1u
YXZ5PjxzcGFuIGxhbmc9RU4tR0Igc3R5bGU9J2NvbG9yOm5hdnknPiA8L3NwYW4+PC9mb250Pjxm
b250IHNpemU9MQ0KY29sb3I9IiMwMDIwNDEiIGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBz
dHlsZT0nZm9udC1zaXplOjcuNXB0O2ZvbnQtZmFtaWx5Og0KQXJpYWw7Y29sb3I6IzAwMjA0MSc+
PGJyPg0KU29mdHdhcmUgRW5naW5lZXI8YnI+DQpEZXZpY2VzIEVuZ2luZWVyaW5nPC9zcGFuPjwv
Zm9udD48c3BhbiBsYW5nPUVOLUdCPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCg0KPHAgY2xhc3M9
TXNvTm9ybWFsIHN0eWxlPSdtc28tbWFyZ2luLXRvcC1hbHQ6YXV0bzttc28tbWFyZ2luLWJvdHRv
bS1hbHQ6YXV0byc+PGZvbnQNCnNpemU9MSBjb2xvcj0iIzAwMjA0MSIgZmFjZT1BcmlhbD48c3Bh
biBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6Ny41cHQ7DQpmb250LWZhbWlseTpBcmlhbDtj
b2xvcjojMDAyMDQxJz5TSUNQQSBTZWN1cml0eSBTb2x1dGlvbnMgU0E8YnI+DQo8L3NwYW4+PC9m
b250Pjxmb250IHNpemU9MSBjb2xvcj0iIzAwMWYzNyIgZmFjZT1BcmlhbD48c3BhbiBzdHlsZT0n
Zm9udC1zaXplOg0KOC4wcHQ7Zm9udC1mYW1pbHk6QXJpYWw7Y29sb3I6IzAwMUYzNyc+QXYuIGRl
IEZsb3Jpc3NhbnQgNDE8L3NwYW4+PC9mb250Pjxmb250DQpzaXplPTEgY29sb3I9IiMwMDIwNDEi
IGZhY2U9QXJpYWw+PHNwYW4gbGFuZz1FTi1HQiBzdHlsZT0nZm9udC1zaXplOjcuNXB0Ow0KZm9u
dC1mYW1pbHk6QXJpYWw7Y29sb3I6IzAwMjA0MSc+LCAxMDA4IDwvc3Bhbj48L2ZvbnQ+PGZvbnQg
c2l6ZT0xIGZhY2U9QXJpYWw+PHNwYW4NCmxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6ZTo3LjVw
dDtmb250LWZhbWlseTpBcmlhbCc+PG5zMDpwbGFjZQ0KIHc6aW5zQXV0aG9yPSJvc3Rlcm1hbm4i
IHc6aW5zRGF0ZT0iMjAxMS0wNC0wNVQwNzo1NzowMFoiDQogdzplbmRJbnNBdXRob3I9Im9zdGVy
bWFubiIgdzplbmRJbnNEYXRlPSIyMDExLTA0LTA1VDA3OjU3OjAwWiI+PG5zMDpDaXR5DQogIHc6
aW5zQXV0aG9yPSJvc3Rlcm1hbm4iIHc6aW5zRGF0ZT0iMjAxMS0wNC0wNVQwNzo1NzowMFoiDQog
IHc6ZW5kSW5zQXV0aG9yPSJvc3Rlcm1hbm4iIHc6ZW5kSW5zRGF0ZT0iMjAxMS0wNC0wNVQwNzo1
NzowMFoiPjxuczA6cGxhY2UNCiAgIHc6aW5zQXV0aG9yPSJvc3Rlcm1hbm4iIHc6aW5zRGF0ZT0i
MjAxMS0wNC0wNVQwNzo1NzowMFoiDQogICB3OmVuZEluc0F1dGhvcj0ib3N0ZXJtYW5uIiB3OmVu
ZEluc0RhdGU9IjIwMTEtMDQtMDVUMDc6NTc6MDBaIj48bnMwOkNpdHkNCiAgICB3Omluc0F1dGhv
cj0ib3N0ZXJtYW5uIiB3Omluc0RhdGU9IjIwMTEtMDQtMDVUMDc6NTc6MDBaIg0KICAgIHc6ZW5k
SW5zQXV0aG9yPSJvc3Rlcm1hbm4iIHc6ZW5kSW5zRGF0ZT0iMjAxMS0wNC0wNVQwNzo1NzowMFoi
Pjxmb250DQogICAgY29sb3I9IiMwMDIwNDEiPjxzcGFuIHN0eWxlPSdjb2xvcjojMDAyMDQxJz5Q
cmlsbHk8L3NwYW4+PC9mb250PjwvbnMwOkNpdHk+PC9uczA6cGxhY2U+PC9uczA6Q2l0eT48L25z
MDpwbGFjZT48Zm9udA0KY29sb3I9IiMwMDIwNDEiPjxzcGFuIHN0eWxlPSdjb2xvcjojMDAyMDQx
Jz4sIDwvc3Bhbj48L2ZvbnQ+PG5zMDpjb3VudHJ5LXJlZ2lvbg0KIHc6aW5zQXV0aG9yPSJvc3Rl
cm1hbm4iIHc6aW5zRGF0ZT0iMjAxMS0wNC0wNVQwNzo1NzowMFoiDQogdzplbmRJbnNBdXRob3I9
Im9zdGVybWFubiIgdzplbmRJbnNEYXRlPSIyMDExLTA0LTA1VDA3OjU3OjAwWiI+PG5zMDpjb3Vu
dHJ5LXJlZ2lvbg0KICB3Omluc0F1dGhvcj0ib3N0ZXJtYW5uIiB3Omluc0RhdGU9IjIwMTEtMDQt
MDVUMDc6NTc6MDBaIg0KICB3OmVuZEluc0F1dGhvcj0ib3N0ZXJtYW5uIiB3OmVuZEluc0RhdGU9
IjIwMTEtMDQtMDVUMDc6NTc6MDBaIj48Zm9udA0KICBjb2xvcj0iIzAwMjA0MSI+PHNwYW4gc3R5
bGU9J2NvbG9yOiMwMDIwNDEnPlN3aXR6ZXJsYW5kPC9zcGFuPjwvZm9udD48L25zMDpjb3VudHJ5
LXJlZ2lvbj48L25zMDpjb3VudHJ5LXJlZ2lvbj48Zm9udA0KY29sb3I9IiMwMDIwNDEiPjxzcGFu
IHN0eWxlPSdjb2xvcjojMDAyMDQxJz48YnI+DQpUZWwgKzQxIDIxIDYyNyA1OSA3MCAmbmJzcDtE
aXJlY3QgKzQxIDIxIDYyNyZuYnNwOzYzIDY4PGJyPg0KRmF4ICs0MSAyMSA2MjAgMDYgMjI8L3Nw
YW4+PC9mb250Pjwvc3Bhbj48L2ZvbnQ+PGZvbnQgY29sb3I9bmF2eT48c3Bhbg0KbGFuZz1FTi1H
QiBzdHlsZT0nY29sb3I6bmF2eSc+IDwvc3Bhbj48L2ZvbnQ+PGZvbnQgc2l6ZT0xIGNvbG9yPSIj
MDAyMDQxIg0KZmFjZT1BcmlhbD48c3BhbiBsYW5nPUVOLUdCIHN0eWxlPSdmb250LXNpemU6Ny41
cHQ7Zm9udC1mYW1pbHk6QXJpYWw7DQpjb2xvcjojMDAyMDQxJz48YnI+DQo8YSBocmVmPSJtYWls
dG86Y2hyaXN0b3BoZS5jaHJpc3RvcGhlLm9zdGVybWFubkBzaWNwYS5jb20iPmNocmlzdG9waGUu
b3N0ZXJtYW5uQHNpY3BhLmNvbTwvYT4NCiZuYnNwOzwvc3Bhbj48L2ZvbnQ+PGZvbnQgY29sb3I9
bmF2eT48c3BhbiBzdHlsZT0nY29sb3I6bmF2eSc+PGENCmhyZWY9Imh0dHA6Ly93d3cuc2ljcGEu
Y29tLyINCnRpdGxlPSJodHRwOi8vd3d3LnNpY3BhLmNvbS8mIzEwO2Jsb2NrZWQ6Omh0dHA6Ly93
d3cuc2ljcGEuY29tLyI+PGZvbnQgc2l6ZT0xDQpjb2xvcj0iIzAwMjA0MSIgZmFjZT1BcmlhbA0K
dGl0bGU9Imh0dHA6Ly93d3cuc2ljcGEuY29tLyYjMTA7YmxvY2tlZDo6aHR0cDovL3d3dy5zaWNw
YS5jb20vIj48c3Bhbg0KdGl0bGU9Imh0dHA6Ly93d3cuc2ljcGEuY29tLyI+PHNwYW4gdGl0bGU9
Imh0dHA6Ly93d3cuc2ljcGEuY29tLyI+PHNwYW4NCmxhbmc9RU4tR0Igc3R5bGU9J2ZvbnQtc2l6
ZTo3LjVwdDtmb250LWZhbWlseTpBcmlhbDtjb2xvcjojMDAyMDQxJz53d3cuc2ljcGEuY29tPC9z
cGFuPjwvc3Bhbj48L3NwYW4+PC9mb250PjwvYT48L3NwYW4+PC9mb250PjxvOnA+PC9vOnA+PC9w
Pg0KDQo8cCBjbGFzcz1Nc29Ob3JtYWwgc3R5bGU9J21zby1tYXJnaW4tdG9wLWFsdDphdXRvO21z
by1tYXJnaW4tYm90dG9tLWFsdDphdXRvJz48Zm9udA0Kc2l6ZT0zIGZhY2U9IlRpbWVzIE5ldyBS
b21hbiI+PHNwYW4gc3R5bGU9J2ZvbnQtc2l6ZToxMi4wcHQnPiZuYnNwOzwvc3Bhbj48bzpwPjwv
bzpwPjwvZm9udD48L3A+DQoNCjxwIGNsYXNzPU1zb05vcm1hbD48Zm9udCBzaXplPTMgZmFjZT0i
VGltZXMgTmV3IFJvbWFuIj48c3BhbiBzdHlsZT0nZm9udC1zaXplOg0KMTIuMHB0Jz48bzpwPiZu
YnNwOzwvbzpwPjwvc3Bhbj48L2ZvbnQ+PC9wPg0KDQo8L2Rpdj4NCg0KPC9ib2R5Pg0KDQo8L2h0
bWw+DQoNClRoaXMgbWVzc2FnZSB3YXMgZGVsaXZlcmVkIHRocm91Z2ggZW5jcnlwdGVkIG1lY2hh
bmlzbS4NCg0KDQpUaGUgaW5mb3JtYXRpb24gaW4gdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIGlzIGNvbmZpZGVudGlhbCBhbmQgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRo
ZSBpbmRpdmlkdWFsKHMpIHRvIHdob20gaXQgaXMgYWRkcmVzc2VkIG9yIG90aGVyd2lzZSBkaXJl
Y3RlZC4gUGxlYXNlIG5vdGUgdGhhdCBhbnkgdmlld3Mgb3Igb3BpbmlvbnMgcHJlc2VudGVkIGlu
IHRoaXMgZW1haWwgYXJlIHNvbGVseSB0aG9zZSBvZiB0aGUgYXV0aG9yIGFuZCBkbyBub3QgbmVj
ZXNzYXJpbHkgcmVwcmVzZW50IHRob3NlIG9mIHRoZSBDb21wYW55LiBGaW5hbGx5LCB0aGUgcmVj
aXBpZW50IHNob3VsZCBjaGVjayB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgZm9yIHRo
ZSBwcmVzZW5jZSBvZiB2aXJ1c2VzLiBUaGUgQ29tcGFueSBhY2NlcHRzIG5vIGxpYWJpbGl0eSBm
b3IgYW55IGRhbWFnZSBjYXVzZWQgYnkgYW55IHZpcnVzIHRyYW5zbWl0dGVkIGJ5IHRoaXMgZW1h
aWwuDQoNCg==

--===============0696692857743942805==--

