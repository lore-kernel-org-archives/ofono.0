Content-Type: multipart/mixed; boundary="===============5757248463819509717=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatmux: add telit specific mux implementation.
Date: Wed, 05 Oct 2016 14:54:58 -0500
Message-ID: <57F55A92.3020102@gmail.com>
In-Reply-To: <1475650301-22115-1-git-send-email-a.aubert@overkiz.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5757248463819509717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antoine,

On 10/05/2016 01:51 AM, Antoine Aubert wrote:
> quote from telit: Initiator is the station that take the initiative to in=
itialize the multiplexer (i.e. sends the
> SABM command at DLCI 0 ) and the responder is the station that accepts th=
e initialization
> of the multiplexer (i.e. sends the UA response at DLCI 0)
> In Telit implementation module is NEVER an initiator since it is up to co=
ntroller to send the
> SABM command to DLCI 0
> ---
>   gatchat/gatmux.c | 24 ++++++++++++++++++++++++
>   gatchat/gatmux.h |  2 ++
>   2 files changed, 26 insertions(+)
>
> diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
> index 9beeece..5785822 100644
> --- a/gatchat/gatmux.c
> +++ b/gatchat/gatmux.c
> @@ -35,6 +35,7 @@
>   #include "ringbuffer.h"
>   #include "gatmux.h"
>   #include "gsm0710.h"
> +#include "drivers/atmodem/vendor.h"

So we can't do this.  gatchat is a separate library and cannot depend on =

non-system headers.  E.g. anything outside of standard #includes or =

gatchat/*.h.

>
>   static const char *cmux_prefix[] =3D { "+CMUX:", NULL };
>   static const char *none_prefix[] =3D { NULL };
> @@ -87,6 +88,7 @@ struct _GAtMux {
>   	char buf[MUX_BUFFER_SIZE];		/* Buffer on the main mux */
>   	int buf_used;				/* Bytes of buf being used */
>   	gboolean shutdown;
> +	unsigned int vendor;			/* Specific vendor */
>   };
>
>   struct mux_setup_data {
> @@ -566,6 +568,8 @@ GAtMux *g_at_mux_new(GIOChannel *channel, const GAtMu=
xDriver *driver)
>   	mux->channel =3D channel;
>   	g_io_channel_ref(channel);
>
> +	mux->vendor =3D OFONO_VENDOR_GENERIC;
> +
>   	g_io_channel_set_close_on_unref(channel, TRUE);
>
>   	return mux;
> @@ -669,6 +673,16 @@ gboolean g_at_mux_set_debug(GAtMux *mux, GAtDebugFun=
c func, gpointer user_data)
>   	return TRUE;
>   }
>
> +gboolean g_at_mux_set_vendor(GAtMux *mux, unsigned int vendor)
> +{
> +	if (mux =3D=3D NULL)
> +		return FALSE;
> +
> +	mux->vendor =3D vendor;
> +
> +	return TRUE;
> +}
> +
>   GIOChannel *g_at_mux_create_channel(GAtMux *mux)
>   {
>   	GAtMuxChannel *mux_channel;
> @@ -951,6 +965,16 @@ static gboolean gsm0710_packet(GAtMux *mux, int dlc,=
 guint8 control,
>   		resp[1] =3D ((len << 1) | 0x01);
>   		memcpy(resp + 2, data, len);
>   		write_frame(mux, 0, GSM0710_DATA, resp, len + 2);
> +
> +		/* In Telit implementation module is NEVER an initiator
> +		 * since it is up to controller to send the SABM command to DLCI 0
> +		 */

Aren't we already sending the SABM command by virtue of using =

GSM0710_OPEN_CHANNEL inside *_open_dlc?

> +		if (mux->vendor =3D=3D OFONO_VENDOR_TELIT) {
> +			resp[0] =3D GSM0710_STATUS_SET;
> +			resp[3] =3D 0x0D;
> +			write_frame(mux, 0, GSM0710_DATA, resp, len + 2);
> +		}
> +

This looks completely unrelated to SABM.  Are you setting RTC/RTR bits?

>   	}
>
>   	return TRUE;
> diff --git a/gatchat/gatmux.h b/gatchat/gatmux.h
> index 4d77c72..ab1962c 100644
> --- a/gatchat/gatmux.h
> +++ b/gatchat/gatmux.h
> @@ -69,6 +69,8 @@ gboolean g_at_mux_set_disconnect_function(GAtMux *mux,
>
>   gboolean g_at_mux_set_debug(GAtMux *mux, GAtDebugFunc func, gpointer us=
er_data);
>
> +gboolean g_at_mux_set_vendor(GAtMux *mux, unsigned int vendor);
> +
>   GIOChannel *g_at_mux_create_channel(GAtMux *mux);
>
>   /*!
>

Regards,
-Denis

--===============5757248463819509717==--

