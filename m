Content-Type: multipart/mixed; boundary="===============6643676679547369913=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 4/4] ifxmodem: emergency number list support
Date: Fri, 01 Apr 2011 17:16:31 +0200
Message-ID: <1301670991.2572.160.camel@aeonflux>
In-Reply-To: <1301668176-19356-5-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6643676679547369913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

> +	/* Enable emergency number list notification */
> +	g_at_chat_send(vd->chat, "AT+XLEMA=3D1", none_prefix, NULL, NULL, NULL);
> +
>  	ofono_voicecall_register(vc);
> +
> +	g_at_chat_send(vd->chat, "AT+XLEMA?", xlema_prefix, xlema_read, vc,
> +									NULL);

do you really need the XLEMA? read command? If this works like the other
commands (like XCALLSTAT) that enable notifications, then with sending
AT+XLEMA=3D1 it should send out unsolicited +XLEMA: notifications and no
extra read command is needed.

Regards

Marcel



--===============6643676679547369913==--

