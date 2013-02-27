Content-Type: multipart/mixed; boundary="===============2731227575667812048=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1 1/6] hfp_hf_bluez5: Add registering Audio Card
Date: Wed, 27 Feb 2013 14:49:18 -0600
Message-ID: <512E714E.3050301@gmail.com>
In-Reply-To: <1361997234-13804-2-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2731227575667812048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 02/27/2013 02:33 PM, Claudio Takahasi wrote:
> This patch registers the Handsfree Audio Card when the service level
> connection is established.
> ---
>   plugins/hfp_hf_bluez5.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index 7057d71..436d98c 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -46,6 +46,7 @@
>   #include<ofono/netreg.h>
>   #include<ofono/voicecall.h>
>   #include<ofono/call-volume.h>
> +#include<ofono/handsfree-audio.h>
>   #include<ofono/handsfree.h>
>
>   #include<drivers/hfpmodem/slc.h>
> @@ -61,6 +62,7 @@
>   struct hfp {
>   	struct hfp_slc_info info;
>   	DBusMessage *msg;
> +	struct ofono_handsfree_card *card;
>   };
>
>   static GDBusClient *bluez =3D NULL;
> @@ -88,6 +90,8 @@ static void slc_established(gpointer userdata)
>   	hfp->msg =3D NULL;
>
>   	ofono_info("Service level connection established");
> +
> +	ofono_handsfree_card_register(hfp->card);
>   }
>
>   static void slc_failed(gpointer userdata)
> @@ -315,8 +319,11 @@ static DBusMessage *profile_new_connection(DBusConne=
ction *conn,
>   {
>   	struct hfp *hfp;
>   	struct ofono_modem *modem;
> +	struct sockaddr_rc saddr;
> +	socklen_t optlen;
>   	DBusMessageIter entry;
>   	const char *device;
> +	char remote[18];
>   	int fd, err;
>
>   	DBG("Profile handler NewConnection");
> @@ -353,8 +360,20 @@ static DBusMessage *profile_new_connection(DBusConne=
ction *conn,
>   					"Not enough resources");
>   	}
>
> +	memset(&saddr, 0, sizeof(saddr));
> +	optlen =3D sizeof(saddr);
> +	if (getpeername(fd, (struct sockaddr *)&saddr,&optlen)<  0) {

Please fix this according to doc/coding-style.txt Item M1 1)

> +		err =3D errno;
> +		ofono_error("RFCOMM getpeername(): %s (%d)", strerror(err), err);

This part seems to be over 80 characters

> +		close(fd);
> +		goto invalid;
> +	}
> +
> +	bt_ba2str(&saddr.rc_bdaddr, remote);
> +
>   	hfp =3D ofono_modem_get_data(modem);
>   	hfp->msg =3D dbus_message_ref(msg);
> +	hfp->card =3D ofono_handsfree_card_create(remote, NULL);
>
>   	return NULL;
>

Regards,
-Denis

--===============2731227575667812048==--

