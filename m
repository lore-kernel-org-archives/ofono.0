Content-Type: multipart/mixed; boundary="===============8088076714632149733=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv8 3/6] plugins: mobile-broadband-provider-info parser
 changes
Date: Fri, 30 Sep 2011 09:57:45 -0500
Message-ID: <4E85D8E9.4010302@gmail.com>
In-Reply-To: <1317389474-16566-4-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8088076714632149733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 09/30/2011 08:31 AM, Oleg Zhurakivskyy wrote:
> ---
>  plugins/mbpi.h |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/mbpi.h b/plugins/mbpi.h
> index fc9f738..bb6bfdc 100644
> --- a/plugins/mbpi.h
> +++ b/plugins/mbpi.h
> @@ -19,7 +19,9 @@
>   *
>   */
>  =

> -void mbpi_provision_data_free(struct ofono_gprs_provision_data *data);
> +const char *mbpi_ap_type(enum ofono_gprs_context_type type);
> +
> +void mbpi_ap_free(struct ofono_gprs_provision_data *ap);
>  =

>  GSList *mbpi_lookup(const char *mcc, const char *mnc,
>  			gboolean allow_duplicates, GError **error);

This patch makes no logical sense.  If you want to add a new
mbpi_ap_type function, then send a patch against mbpi.h and mbpi.c
adding such a function.

If you want to rename mbpi_provision_data_free to mbpi_ap_free, then
send a patch against mbpi.h, mbpi.c and a separate patch against
tools/lookup-apn.c

The only time you should separate .h and .c patches are when you're
modifying public API in include/*

See HACKING document, the 'Submitting patches' section in particular.

Regards,
-Denis

--===============8088076714632149733==--

