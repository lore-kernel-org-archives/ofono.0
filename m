Content-Type: multipart/mixed; boundary="===============0887468308730030439=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 1/2] ifxmodem: add handling of XCOLP notification
Date: Mon, 07 Feb 2011 10:30:02 -0800
Message-ID: <1297103402.1520.416.camel@aeonflux>
In-Reply-To: <1297102880-32714-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0887468308730030439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

> @@ -722,6 +772,7 @@ static int ifx_voicecall_probe(struct ofono_voicecall=
 *vc, unsigned int vendor,
>  =

>  	g_at_chat_send(chat, "AT+XCALLSTAT=3D1", none_prefix, NULL, NULL, NULL);
>  	g_at_chat_send(chat, "AT+XEMC=3D1", none_prefix, NULL, NULL, NULL);
> +	g_at_chat_send(vd->chat, "AT+XCOLP=3D1", none_prefix, NULL, NULL, NULL);
>  =

>  	g_at_chat_send(vd->chat, "AT+CRC=3D1", none_prefix, NULL, NULL, NULL);
>  	g_at_chat_send(vd->chat, "AT+CLIP=3D1", none_prefix, NULL, NULL, NULL);

I just saw a bug here. We need to execute the first two commands also on
vd->chat actually. We do wanna execute them on the clone and not the
original one.

Regards

Marcel



--===============0887468308730030439==--

