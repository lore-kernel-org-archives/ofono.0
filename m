Content-Type: multipart/mixed; boundary="===============0809216298350033866=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] gemalto: acquire the network technology
Date: Thu, 15 Mar 2018 12:19:27 -0500
Message-ID: <5ecb1ebc-55e5-6bca-5686-69a9deeebff1@gmail.com>
In-Reply-To: <1521118170-23722-4-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0809216298350033866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On 03/15/2018 07:49 AM, Gabriel Lucas wrote:
> From: Mariem Cherif <mariem.cherif@ardia.com.tn>
> =

> ---
>   drivers/atmodem/network-registration.c | 45 +++++++++++++++++++++++++++=
+++++++
>   1 file changed, 45 insertions(+)
> =

> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/net=
work-registration.c
> index a5e2af3..aec9c2d 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -48,6 +48,7 @@ static const char *cops_prefix[] =3D { "+COPS:", NULL };
>   static const char *csq_prefix[] =3D { "+CSQ:", NULL };
>   static const char *cind_prefix[] =3D { "+CIND:", NULL };
>   static const char *cmer_prefix[] =3D { "+CMER:", NULL };
> +static const char *smoni_prefix[] =3D { "^SMONI:", "", NULL };

Is there a reason why "" is added?  Is the modem sending lines not =

prefixed by '^SMONI:' in the response?

>   static const char *zpas_prefix[] =3D { "+ZPAS:", NULL };
>   static const char *option_tech_prefix[] =3D { "_OCTI:", "_OUWCTI:", NUL=
L };
>   =

> @@ -178,6 +179,32 @@ static int option_parse_tech(GAtResult *result)
>   	return tech;
>   }
>   =

> +static int cinterion_parse_tech(GAtResult *result)
> +{
> +	int tech =3D -1;
> +	GAtResultIter iter;
> +	GSList *l;

new line here please

> +	g_at_result_iter_init(&iter, result);
> +	l =3D result->lines;

What does the output look like?

> +	if (strstr(l->data, "^SMONI: ") !=3D NULL) {

Generally we use g_at_result_iter_next("^SMONI:");

> +		gchar **body =3D g_strsplit(l->data, "^SMONI: ", 2);
> +		if (*body !=3D NULL) {
> +			gchar **data =3D g_strsplit(body[1], ",", 20);
> +			if (*data !=3D NULL) {
> +				if (g_strcmp0(data[0], "2G") =3D=3D 0) {
> +					tech =3D ACCESS_TECHNOLOGY_GSM;
> +				} else if (g_strcmp0 (data[0], "3G") =3D=3D 0) {
> +					tech =3D ACCESS_TECHNOLOGY_UTRAN;
> +				} else if (g_strcmp0 (data[0], "4G") =3D=3D 0) {
> +					tech =3D ACCESS_TECHNOLOGY_EUTRAN;
> +				}
> +			}

Are you leaking data?  Have you run this through valgrind?

> +			g_strfreev(body);

It seems all of this can be accomplished with =

g_at_result_iter_next_unquoted_string.

> +		}
> +	}
> +	return tech;
> +}
> +
>   static void at_creg_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>   {
>   	struct cb_data *cbd =3D user_data;
> @@ -205,6 +232,18 @@ static void at_creg_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>   	cb(&error, status, lac, ci, tech, cbd->data);
>   }
>   =

> +static void cinterion_query_tech_cb(gboolean ok, GAtResult *result,
> +                                              gpointer user_data)
> +{
> +	struct tech_query *tq =3D user_data;
> +	int tech;
> +
> +	tech =3D cinterion_parse_tech(result);
> +
> +	ofono_netreg_status_notify(tq->netreg,
> +			tq->status, tq->lac, tq->ci, tech);
> +}
> +
>   static void zte_tech_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
>   {
>   	struct cb_data *cbd =3D user_data;
> @@ -1518,6 +1557,12 @@ static void creg_notify(GAtResult *result, gpointe=
r user_data)
>   					option_query_tech_cb, tq, g_free) > 0)
>   			return;
>   		break;
> +    case OFONO_VENDOR_CINTERION:
> +              if (g_at_chat_send(nd->chat, "AT^SMONI",
> +                                      smoni_prefix,
> +                                      cinterion_query_tech_cb, tq, g_fre=
e) > 0)
> +                      return;
> +              break;
>   	}
>   =

>   	g_free(tq);
> =


Regards,
-Denis

--===============0809216298350033866==--

