Content-Type: multipart/mixed; boundary="===============8146806000980490720=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simple fixes
Date: Wed, 09 May 2018 09:39:51 -0500
Message-ID: <1ec82cc3-a5d4-6b31-557c-78f0852cfd6b@gmail.com>
In-Reply-To: <20180509143356.GA28193@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8146806000980490720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 05/09/2018 09:33 AM, Pavel Machek wrote:
> Fix typo in location-reporting-api.txt.
> =

> AFAICT, at_cmt_notify() calls ofono_error even in case stuff is
> okay. Fix that.
> =

> Move debug print to more useful place in setup_gobi().
> =

> Explain  "delivery report" parameter in send-sms.

These mostly look fine, but can you do me a favor and read HACKING, =

'Submitting patches' section and break up this patch accordingly?

> =

> diff --git a/doc/location-reporting-api.txt b/doc/location-reporting-api.=
txt
> index 21e346d4..ff0a35dc 100644
> --- a/doc/location-reporting-api.txt
> +++ b/doc/location-reporting-api.txt
> @@ -13,7 +13,7 @@ Methods		dict GetProperties()
>   		filedescriptor Request()
>   =

>   			Asks to turn ON the NMEA stream and supplies the
> -			gps device file descriptor. The external cliend should
> +			gps device file descriptor. The external client should
>   			use the file descriptor to receive the NMEA data.
>   =

>   			Possible Errors: [service].Error.InProgress
> diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> index 68b89862..217971e7 100644
> --- a/drivers/atmodem/sms.c
> +++ b/drivers/atmodem/sms.c
> @@ -440,6 +436,8 @@ static void at_cmt_notify(GAtResult *result, gpointer=
 user_data)
>   	if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
>   		at_ack_delivery(sms);
>   =

> +	return;
> +
>   err:
>   	ofono_error("Unable to parse CMT notification");
>   }
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index ff5d41af..a4b18488 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -233,10 +233,11 @@ static gboolean setup_gobi(struct modem_info *modem)
>   		}
>   	}
>   =

> +	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps=
, diag);
> +	=

>   	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
>   		return FALSE;
>   =

> -	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps=
, diag);
>   =

>   	ofono_modem_set_string(modem->modem, "Device", qmi);
>   	ofono_modem_set_string(modem->modem, "Modem", mdm);
> diff --git a/test/send-sms b/test/send-sms
> index 98808aaf..cabe0652 100755
> --- a/test/send-sms
> +++ b/test/send-sms
> @@ -6,6 +6,7 @@ import dbus
>   if len(sys.argv) < 4:
>   	print("Usage: %s [modem] <to> <message> <delivery report>" %\
>   					(sys.argv[0]))
> +        print("  where delivery report is 0|1")

Something is funny with indentation here.

>   	sys.exit(1)
>   =

>   bus =3D dbus.SystemBus()
> =


Regards,
-Denis

--===============8146806000980490720==--

