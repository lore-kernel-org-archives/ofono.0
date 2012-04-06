Content-Type: multipart/mixed; boundary="===============5523795636744046617=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v4 04/10] bluetooth: Add audio APIs for HFP AG
Date: Fri, 06 Apr 2012 12:27:30 -0500
Message-ID: <4F7F2782.5080905@gmail.com>
In-Reply-To: <1333718232-8447-5-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5523795636744046617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 04/06/2012 08:17 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  plugins/bluetooth.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
> index f81fc99..41ce112 100644
> --- a/plugins/bluetooth.h
> +++ b/plugins/bluetooth.h
> @@ -30,6 +30,7 @@
>  #define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
>  #define	BLUEZ_TELEPHONY_INTERFACE	BLUEZ_SERVICE ".Telephony"
>  #define	BLUEZ_TELEPHONY_AGENT_INTERFACE	BLUEZ_SERVICE ".TelephonyAgent"
> +#define	BLUEZ_TRANSPORT_INTERFACE	BLUEZ_SERVICE ".MediaTransport"
>  =

>  #define DBUS_TIMEOUT 15
>  =

> @@ -85,6 +86,9 @@ int bluetooth_sap_client_register(struct bluetooth_sap_=
driver *sap,
>  					struct ofono_modem *modem);
>  void bluetooth_sap_client_unregister(struct ofono_modem *modem);
>  =

> +void *bluetooth_set_audio_management(void *em, const char *path,
> +							guint16 features);
> +void bluetooth_free_audio_management(void *data);

I don't like passing around void pointers.  We should either try to
avoid this altogether or forward declare the struct.

>  int bluetooth_parse_newconnection_message(DBusMessage *msg, const char *=
*device,
>  					const char **uuid, guint16 *version,
>  					guint16 *features,

Regards,
-Denis

--===============5523795636744046617==--

