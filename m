Content-Type: multipart/mixed; boundary="===============5847535727449891405=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [RFC v0 02/13] hfp_hf_bluez5: Register handsfree audio driver
Date: Mon, 11 Mar 2013 11:30:58 -0300
Message-ID: <CAKT1EBdAxrR3+aCS2t-59p0isp=9MMA2CAjpM_ZkTH0GMTS3dA@mail.gmail.com>
In-Reply-To: <1362784285-22731-3-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5847535727449891405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:

<snip>

>         if (err < 0) {
> +               ofono_handsfree_card_driver_register(&card_driver15);

I will fix it in the next series. Copy & paste error: It is unregister
instead of register.

>                 g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
>                                                 BLUEZ_PROFILE_INTERFACE);
>                 return err;
> @@ -647,6 +675,7 @@ static void hfp_exit(void)
>         g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
>                                                 BLUEZ_PROFILE_INTERFACE);
>         ofono_modem_driver_unregister(&hfp_driver);
> +       ofono_handsfree_card_driver_register(&card_driver15);

Same here.

>         g_dbus_client_unref(bluez);
>
>         ofono_handsfree_audio_unref();
> --
> 1.7.11.7
>

Regards,
Claudio

--===============5847535727449891405==--

