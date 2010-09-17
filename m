Content-Type: multipart/mixed; boundary="===============3829940111642112731=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] Enable some atoms for hso modem
Date: Fri, 17 Sep 2010 18:00:48 +0900
Message-ID: <1284714048.2405.200.camel@localhost.localdomain>
In-Reply-To: <1284713422-3558-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3829940111642112731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

>  plugins/hso.c |   34 ++++++++++++++++++++++++++++++++--
>  1 files changed, 32 insertions(+), 2 deletions(-)
> =

> diff --git a/plugins/hso.c b/plugins/hso.c
> index 25ca157..1fbde58 100644
> --- a/plugins/hso.c
> +++ b/plugins/hso.c
> @@ -34,14 +34,23 @@
>  #define OFONO_API_SUBJECT_TO_CHANGE
>  #include <ofono/plugin.h>
>  #include <ofono/modem.h>
> +#include <ofono/call-barring.h>
> +#include <ofono/call-forwarding.h>
> +#include <ofono/call-meter.h>
> +#include <ofono/call-settings.h>
> +#include <ofono/call-volume.h>
>  #include <ofono/devinfo.h>
> +#include <ofono/message-waiting.h>
>  #include <ofono/netreg.h>
> +#include <ofono/phonebook.h>
>  #include <ofono/sim.h>
>  #include <ofono/cbs.h>
>  #include <ofono/sms.h>
> +#include <ofono/ssn.h>
>  #include <ofono/ussd.h>
>  #include <ofono/gprs.h>
>  #include <ofono/gprs-context.h>
> +#include <ofono/voicecall.h>
>  #include <ofono/radio-settings.h>
>  #include <ofono/log.h>
>  =

> @@ -257,24 +266,40 @@ static void hso_pre_sim(struct ofono_modem *modem)
>  	ofono_devinfo_create(modem, 0, "atmodem", data->control);
>  	sim =3D ofono_sim_create(modem, OFONO_VENDOR_OPTION_HSO,
>  				"atmodem", data->control);
> +	ofono_voicecall_create(modem, 0, "atmodem", data->app);
>  =

>  	if (sim)
>  		ofono_sim_inserted_notify(sim, TRUE);
>  }
>  =

> +
> +static void hso_post_sim(struct ofono_modem *modem)
> +{
> +	struct hso_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_phonebook_create(modem, 0, "atmodem", data->app);
> +}
> +

this part is fine with me.

However why should we enable any kind of voice call support for this
modem? It is a data dongle and until you tell me that the voice is
routed to the host PC via USB or some external microphone, it makes no
sense to enable these parts.

If they are data only dongle, I prefer to leave them like that.

Regards

Marcel



--===============3829940111642112731==--

