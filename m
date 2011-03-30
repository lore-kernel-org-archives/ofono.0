Content-Type: multipart/mixed; boundary="===============6817232630826340829=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] isimodem: fix operator name reading with old ISI
 modems
Date: Tue, 29 Mar 2011 22:27:11 -0500
Message-ID: <4D92A30F.1040507@gmail.com>
In-Reply-To: <1301385254-28543-2-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6817232630826340829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> @@ -466,7 +466,8 @@ static void name_get_resp_cb(const GIsiMessage *msg, =
void *data)
>  =

>  	memset(&op, 0, sizeof(struct ofono_network_operator));
>  =

> -	if (!check_response_status(msg, NET_OPER_NAME_READ_RESP))
> +	if (!check_response_status(msg, NET_OPER_NAME_READ_RESP) &&
> +		!check_response_status(msg, NET_OLD_OPER_NAME_READ_RESP))

doc/coding-style.txt item M4

>  		goto error;
>  =

>  	for (g_isi_sb_iter_init(&iter, msg, 6);

Regards,
-Denis

--===============6817232630826340829==--

