Content-Type: multipart/mixed; boundary="===============2132498724340170665=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: Re: [PATCH 1/3] sim800: adding support for SimCom SIM800 modem
Date: Tue, 25 Sep 2018 20:08:24 +0200
Message-ID: <20180925180824.GA3215@turing>
In-Reply-To: <e23548f2-376b-179e-e682-f2d1961a505e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2132498724340170665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Sep 25, 2018 at 11:48:39AM -0500, Denis Kenzior wrote:
> Hi Clement,
> =

> On 09/24/2018 05:43 PM, Clement Viel wrote:
> >From: clem <vielclement@gmail.com>
> =

> Your author information is still broken for the actual commits.  Please f=
ix
> that.
> =

> >
> >---
> >  Makefile.am      |   4 +
> >  plugins/sim800.c | 463 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 467 insertions(+)
> >  create mode 100644 plugins/sim800.c
> >
> >diff --git a/Makefile.am b/Makefile.am
> >index 6dee4ce..f4d03b6 100644
> >--- a/Makefile.am
> >+++ b/Makefile.am
> >@@ -496,6 +496,10 @@ builtin_sources +=3D plugins/speedupcdma.c
> >  builtin_modules +=3D samsung
> >  builtin_sources +=3D plugins/samsung.c
> >+builtin_modules +=3D sim800
> >+builtin_sources +=3D plugins/sim800.c
> >+
> >+
> =

> One empty line please
> =

> >  builtin_modules +=3D sim900
> >  builtin_sources +=3D plugins/sim900.c
> >diff --git a/plugins/sim800.c b/plugins/sim800.c
> >new file mode 100644
> >index 0000000..c9285c1
> >--- /dev/null
> >+++ b/plugins/sim800.c
> >@@ -0,0 +1,463 @@
> >+/*
> >+ *
> >+ *  oFono - Open Source Telephony
> >+ *
> >+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> =

> Not updating the copyright?
> =

> >+ *
> >+ *  This program is free software; you can redistribute it and/or modify
> >+ *  it under the terms of the GNU General Public License version 2 as
> >+ *  published by the Free Software Foundation.
> >+ *
> >+ *  This program is distributed in the hope that it will be useful,
> >+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> >+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >+ *  GNU General Public License for more details.
> >+ *
> >+ *  You should have received a copy of the GNU General Public License
> >+ *  along with this program; if not, write to the Free Software
> >+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-13=
01  USA
> >+ *
> >+ */
> >+
> >+#ifdef HAVE_CONFIG_H
> >+#include <config.h>
> >+#endif
> >+
> >+#include <errno.h>
> >+#include <stdlib.h>
> >+#include <unistd.h>
> >+#include <glib.h>
> >+#include <gatchat.h>
> >+#include <gattty.h>
> >+#include <gatmux.h>
> >+
> >+#define OFONO_API_SUBJECT_TO_CHANGE
> >+#include <ofono/plugin.h>
> >+#include <ofono/modem.h>
> >+#include <ofono/devinfo.h>
> >+#include <ofono/netreg.h>
> >+#include <ofono/sim.h>
> >+#include <ofono/sms.h>
> >+#include <ofono/ussd.h>
> >+#include <ofono/gprs.h>
> >+#include <ofono/gprs-context.h>
> >+#include <ofono/phonebook.h>
> >+#include <ofono/history.h>
> >+#include <ofono/log.h>
> >+#include <ofono/voicecall.h>
> >+#include <ofono/call-volume.h>
> >+#include <drivers/atmodem/vendor.h>
> >+
> >+#define NUM_DLC 5
> >+
> >+#define VOICE_DLC   0
> >+#define NETREG_DLC  1
> >+#define SMS_DLC     2
> >+#define GPRS_DLC    3
> >+#define SETUP_DLC   4
> >+
> >+static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "SMS: ",
> >+					"GPRS: " , "Setup: "};
> >+
> >+static const char *none_prefix[] =3D { NULL };
> >+
> >+struct sim800_data {
> >+	GIOChannel *device;
> >+	GAtMux *mux;
> >+	GAtChat * dlcs[NUM_DLC];
> >+	guint frame_size;
> >+	int mux_not_supported;
> =

> bool ?
> =

> >+};
> >+
> >+
> =

> No double empty lines please
> =

> >+static void mux_ready_notify(GAtResult *result, gpointer user_data)
> >+{
> >+	struct ofono_modem *modem =3D user_data;
> >+	struct sim800_data *data =3D ofono_modem_get_data(modem);
> >+	struct ofono_gprs *gprs =3D NULL;
> >+	struct ofono_gprs_context *gc;
> >+	static int notified =3D 0;
> >+
> >+	if (!notified) {
> >+	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> >+						data->dlcs[SMS_DLC]);
> >+
> >+
> =

> Wrong indentation & coding style...
> =

> >+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
> >+	if (gprs =3D=3D NULL)
> >+		return;
> >+
> >+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
> >+					"atmodem", data->dlcs[GPRS_DLC]);
> >+	if (gc)
> >+		ofono_gprs_add_context(gprs, gc);
> >+	}
> >+	notified =3D 1;
> >+
> >+}
> >+
> >+
> =

> <snip>
> =

> >+static void mux_setup_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> >+{
> >+	struct ofono_modem *modem =3D user_data;
> >+	struct sim800_data *data =3D ofono_modem_get_data(modem);
> >+
> >+	DBG("");
> >+
> >+	g_at_chat_unref(data->dlcs[SETUP_DLC]);
> >+	data->dlcs[SETUP_DLC] =3D NULL;
> >+
> >+	if (!ok)
> >+		goto error;
> >+
> >+	data->mux_not_supported =3D 0;
> =

> What does this variable do?
> =

> >+	setup_internal_mux(modem);
> >+	return;
> >+
> >+error:
> >+	DBG("If you are on a SIM800H modem with firmware version is \
> >+		1308B02SIM800H32_BT or lower, CMUX command is not supported thus \
> >+		preventing GPRS, Voice and SMS managers \
> >+		to be executed simultaneously.");
> >+	/*
> >+	 * If your use of SIM800 does not need simultaneous use of Voice, SMS
> >+	 * and GPRS, you can ignore the error, set mux_not_supported=3D1 and c=
omment
> >+	 * setup_internal_mux function, refactor this code to use only one DLC.
> >+	 * Else, you must contact SIMCOM to get a firmware update.
> =

> I would drop all these hacks and document the required firmware version in
> doc/sim800-modem.txt.
> =

> >+	 */
> >+	shutdown_device(data);
> >+	ofono_modem_set_powered(modem, FALSE);
> >+}
> >+
> >+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> >+{
> >+	struct ofono_modem *modem =3D user_data;
> >+	struct sim800_data *data =3D ofono_modem_get_data(modem);
> >+
> >+	DBG("");
> >+
> >+	if (!ok) {
> >+		g_at_chat_unref(data->dlcs[SETUP_DLC]);
> >+		data->dlcs[SETUP_DLC] =3D NULL;
> >+		ofono_modem_set_powered(modem, FALSE);
> >+		return;
> >+	}
> >+
> >+	g_at_chat_send(data->dlcs[SETUP_DLC],"AT+CMUX=3D0,0,5,128,10,3,30,10,2=
", NULL,mux_setup_cb, modem, NULL);
> =

> Not our coding style.
> =

> >+
> >+}
> >+
> =

> =

> <snip>
> =

> I ran a quick diff between this and sim900 driver and there's really not
> enough differences to warrant a completely separate plugin.  Can't we just
> simply query the model version and act accordingly?

My opinion is that the sim800 driver is much to be needed as Simcom conside=
rs the sim800 as the new sim900.
I "fear" that merging the two drivers will end up in a big file having a lo=
t of "if...else" for every different feature
between those two drivers. Whereas having the two separate for some time wi=
ll allow to address the use of sim800's new features
and support legacy sim900.

But as you are the maintainer, I think the decision is yours. Tell me and i=
'll modify my patches accordingly then preventing too much noisy commits :)



> =

> Regards,
> -Denis

Regards
Clement

--===============2132498724340170665==--

