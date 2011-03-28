Content-Type: multipart/mixed; boundary="===============9041970052061473645=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/12] atmodem: add gnss driver
Date: Mon, 28 Mar 2011 18:06:35 -0500
Message-ID: <4D91147B.1010401@gmail.com>
In-Reply-To: <1300974396-15801-10-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9041970052061473645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

On 03/24/2011 08:46 AM, Jarko Poutiainen wrote:
> ---
>  Makefile.am               |    3 +-
>  drivers/atmodem/atmodem.c |    2 +
>  drivers/atmodem/atmodem.h |    3 +
>  drivers/atmodem/gnss.c    |  282 +++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 289 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/atmodem/gnss.c

I applied this patch, however:

> +static gboolean gnss_parse_report(GAtResult *result, const char *prefix,
> +					const char **xml)
> +{
> +	GAtResultIter iter;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, prefix))
> +		return FALSE;
> +
> +	if (!g_at_result_iter_next_unquoted_string(&iter, xml))
> +		return FALSE;
> +
> +	return TRUE;
> +}
> +
> +static void gnss_report(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_gnss *gnss =3D user_data;
> +	const char *xml;
> +
> +	DBG("");
> +
> +	xml =3D NULL;
> +	if (!gnss_parse_report(result, "+CPOSR:", &xml)) {
> +		ofono_error("Unable to parse CPOSR notification");
> +		return;
> +	}
> +
> +	if (xml =3D=3D NULL) {
> +		ofono_error("Unable to parse CPOSR notification");
> +		return;
> +	}
> +
> +	ofono_gnss_notify_posr_request(gnss, xml);
> +}

The implementation of CPOSR is pretty much unacceptable.  You're relying
on the agent to parse the XML piecemeal.  I don't like this at all.  It
creates unnecessary round-trips over D-Bus for each CPOSR we receive,
not to mention ambiguity in exceptional conditions (e.g. a modem reset
happens during CPOSR emission).

I'd like you to modify the driver to detect the start and end of CPOSR
strings, assemble the XML fragments into a single chunk and only call
ofono_gnss_notify_posr_request once the XML string is assembled.

Regards,
-Denis

--===============9041970052061473645==--

