Content-Type: multipart/mixed; boundary="===============3533640866510353323=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1 06/10] hfpmodem: Add dynamic hfp_slc_info allocation
Date: Wed, 23 Jan 2013 14:34:00 -0600
Message-ID: <51004938.30503@gmail.com>
In-Reply-To: <1358965681-7420-7-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3533640866510353323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

> diff --git a/plugins/phonesim.c b/plugins/phonesim.c
> index 26f96d0..9210e02 100644
> --- a/plugins/phonesim.c
> +++ b/plugins/phonesim.c
> @@ -929,8 +929,8 @@ static int localhfp_enable(struct ofono_modem *modem)
>
>   	g_at_chat_set_disconnect_function(chat, slc_failed, modem);
>
> -	hfp_slc_info_init(info, HFP_VERSION_LATEST);
> -	info->chat =3D chat;
> +	info =3D hfp_slc_info_init(chat, HFP_VERSION_LATEST);
> +	g_at_chat_unref(chat);
>   	hfp_slc_establish(info, slc_established, slc_failed, modem);
>
>   	return -EINPROGRESS;

This part makes no sense.  I refer you to localhfp_probe() function. =

Are you testing any of your changes?

Regards,
-Denis

--===============3533640866510353323==--

