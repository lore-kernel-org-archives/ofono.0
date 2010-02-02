Content-Type: multipart/mixed; boundary="===============7958180656668162137=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix change state immediately when meet the slash
Date: Tue, 02 Feb 2010 11:47:22 -0600
Message-ID: <201002021147.22460.denkenz@gmail.com>
In-Reply-To: <1265117002-11006-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7958180656668162137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> According to V.250 spec section 5.2.4 Repeating a command line, if
> the prefix "A/" or "a/" is received, we should execute the last
> command immediately. No need to meet \r.

Yes you're right.

> @@ -214,22 +213,14 @@ static enum ParserResult server_feed(GAtServer
>  *server, i +=3D 1;
>  				res =3D PARSER_RESULT_GARBAGE;
>  				goto out;
> -			} else if (byte =3D=3D '/')
> -				server->parser_state =3D PARSER_STATE_SLASH;
> -			else if (byte =3D=3D 'T' || byte =3D=3D 't')
> +			} else if (byte =3D=3D '/') {
>  				server->parser_state =3D PARSER_STATE_COMMAND;

I changed this to PARSER_STATE_IDLE and applied the patch.

Regards,
-Denis

--===============7958180656668162137==--

