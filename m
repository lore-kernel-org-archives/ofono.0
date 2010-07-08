Content-Type: multipart/mixed; boundary="===============5783131937063533497=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] huawei: recreate the GPRS atom on hup
Date: Thu, 08 Jul 2010 14:30:30 -0500
Message-ID: <4C362756.20507@gmail.com>
In-Reply-To: <1278584269-3995-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5783131937063533497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

On 07/08/2010 05:17 AM, Zhenhua Zhang wrote:
> System is either crashed or usb_serial module reports warnings after
> activate/deactivate GPRS context several times. Handle this by remove
> and recreate the GPRS atom in oFono.
> =

> Tested with Huawei E1552, EM770W.
> System: Ubuntu 9.10.
> Kernel: 2.6.31-16-generic #53-Ubuntu SMP
> ---
>  plugins/huawei.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index cfc693d..6cc1448 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -237,6 +237,7 @@ static void huawei_disconnect(gpointer user_data)
>  	DBG("");
>  =

>  	ofono_gprs_context_remove(data->gc);
> +	ofono_gprs_remove(data->gprs);
>  =

>  	g_at_chat_unref(data->modem);
>  	data->modem =3D NULL;
> @@ -250,6 +251,7 @@ static void huawei_disconnect(gpointer user_data)
>  =

>  	ofono_info("Reopened GPRS context channel");
>  =

> +	data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
>  	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
>  							data->modem);
>  =


This is really not the preferred solution.  Can we investigate deeper
into what is crashing here?  Perhaps we're not waiting on the 'NO
CARRIER' signal from the modem before attempting another context activation?

Regards,
-Denis

--===============5783131937063533497==--

