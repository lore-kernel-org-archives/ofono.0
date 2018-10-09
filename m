Content-Type: multipart/mixed; boundary="===============0026313128897976983=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] netmon: Enabled netmon atom for xmm7modem plugin
Date: Tue, 09 Oct 2018 12:57:22 -0500
Message-ID: <aebbeacc-a37d-8a28-3aaf-6186e238111b@gmail.com>
In-Reply-To: <1539085330-4517-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0026313128897976983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

> diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
> index 066e2e7..243738e 100644
> --- a/plugins/xmm7xxx.c
> +++ b/plugins/xmm7xxx.c

I also added '#include <ofono/netmon.h>' at the top of this file.

> @@ -356,6 +356,7 @@ static void xmm7xxx_post_online(struct ofono_modem *m=
odem)
>   		ofono_gprs_add_context(gprs, gc);
>   =

>   	ofono_ims_create(modem, "xmm7modem", data->chat);
> +	ofono_netmon_create(modem, 0, "xmm7modem", data->chat);
>   }
>   =

>   static int xmm7xxx_probe(struct ofono_modem *modem)
> =


Applied, thanks.

Regards,
-Denis

--===============0026313128897976983==--

