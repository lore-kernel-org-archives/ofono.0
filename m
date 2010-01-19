Content-Type: multipart/mixed; boundary="===============3831632620293043889=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC v2 4/7] STE-plugin: Add STE plugin
Date: Tue, 19 Jan 2010 11:32:15 -0800
Message-ID: <1263929535.5591.192.camel@localhost.localdomain>
In-Reply-To: <1263917513-6756-5-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3831632620293043889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Added check on return value of socket() and connect() calls.
> Use gsm_permissive syntax all the time.
> Added ATE0 in initialization.

<snip>

> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <errno.h>
> +#include <stdlib.h>
> +
> +#include <glib.h>
> +#include <gatchat.h>
> +#include <gattty.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/call-barring.h>
> +#include <ofono/call-forwarding.h>
> +#include <ofono/call-meter.h>
> +#include <ofono/call-settings.h>
> +#include <ofono/devinfo.h>
> +#include <ofono/message-waiting.h>
> +#include <ofono/netreg.h>
> +#include <ofono/phonebook.h>
> +#include <ofono/sim.h>
> +#include <ofono/sms.h>
> +#include <ofono/ssn.h>
> +#include <ofono/ussd.h>
> +#include <ofono/call-volume.h>
> +#include <ofono/voicecall.h>
> +#include <drivers/atmodem/vendor.h>
> +#include <ofono/gprs.h>
> +#include <unistd.h>
> +#include <ofono/gprs-context.h>

please, please only include the atom header files you really use.

> +/* Use the local CAIF header files until is included in linux kernel */
> +#ifdef PF_CAIF
> +#include <linux/caif/caif_socket.h>
> +#include <linux/caif/if_caif.h>
> +#else
> +#include "gcaif/caif_socket.h"
> +#include "gcaif/if_caif.h"
> +#endif

This is not gonna work. To make this work you would need a GLibc that
has the PF_CAIF defined.

My current proposal to fix this would be to include caif_socket.h and
if_caif.h in the drivers/stemodem/ directory and just use them directly.

The gcaif/ directory is the wrong approach here. We have the g* prefixed
subdirectories for libraries that provide GLib mainloop integration. You
are not doing that, you just need to extra headers. So put them side by
side with the modem driver.

We can fix the upstream usage of CAIF and their header files later then
when that has been accepted into net-next-2.6 tree.

> +	int fd, err;
> +	struct sockaddr_caif addr =3D {
> +		.family =3D AF_CAIF,
> +		.u.at.type =3D CAIF_ATTYPE_PLAIN
> +	};

I would prefer if you do this like this:

	memset(&addr, 0, sizeof(addr));
	addr.family =3D AF_CAIF;
	addr.u.at.type =3D CAIF_ATTYPE_PLAIN;

And just before calling connect.

Also the more important question here is if you have two CAIF modems in
the system. How do you distinguish between them?

> +
> +	DBG("%p", modem);
> +
> +	/* Create a CAIF socket for AT Service */
> +	fd =3D socket(AF_CAIF, SOCK_SEQPACKET, CAIFPROTO_AT);
> +
> +	if (fd < 0) {

Skip that extra empty line here.

> +		ofono_debug("Failed to create CAIF socket for AT");
> +		return -EIO;
> +	}
> +	/* Connect to the AT Service at the modem */
> +	err =3D connect(fd, (struct sockaddr *) &addr, sizeof(addr));
> +
> +	if (err < 0) {

Same here.

> +		close(fd);
> +		return err;
> +	}
> +	channel =3D g_io_channel_unix_new(fd);
> +
> +	if (!channel)  {

And here.

> +static void ste_pre_sim(struct ofono_modem *modem)
> +{
> +	struct ste_data *data =3D ofono_modem_get_data(modem);
> +	DBG("%p", modem);
> +
> +	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
> +	ofono_sim_create(modem, 0, "atmodem", data->chat);
> +	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
> +}

It will not break the build, but the functionality for the stemodem
voiceall atom is not merged yet. So leave that out.

> +static void ste_post_sim(struct ofono_modem *modem)
> +{
> +	struct ste_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_message_waiting *mw;
> +	struct ofono_gprs *gprs;
> +	struct ofono_gprs_context *gc;
> +
> +	DBG("%p", modem);
> +	ofono_ussd_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
> +	ofono_netreg_create(modem, OFONO_VENDOR_STE, "atmodem", data->chat);
> +	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
> +	ofono_ssn_create(modem, 0, "atmodem", data->chat);
> +	ofono_sms_create(modem, 0, "atmodem", data->chat);
> +	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
> +
> +	gprs =3D ofono_gprs_create(modem,
> +			OFONO_VENDOR_STE, "atmodem", data->chat);
> +	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);

Same applies here. Please don't do this until all the dependencies are
merged.

You can just add these extra atom via the patch introducing the support
for it. That makes the git log way cleaner and we can follow the changes
in a lot simpler way at some later time.

Regards

Marcel



--===============3831632620293043889==--

