Content-Type: multipart/mixed; boundary="===============7798014776185825184=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SV: Handling empty row from AT command
Date: Wed, 20 Jun 2018 08:30:00 -0500
Message-ID: <3f286d85-c72a-e4e2-c203-3524744595f5@gmail.com>
In-Reply-To: <AM5PR1001MB1171B048483CE3C97BE6584896770@AM5PR1001MB1171.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7798014776185825184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mattias,

On 06/20/2018 08:24 AM, Mattias M=C3=A5nsson wrote:
> It seems we already use that parser though:
> =

> syntax =3D g_at_syntax_new_gsm_permissive();
> chat =3D g_at_chat_new(channel, syntax);
> =


Not sure then.  Permissive should be taking care of the issue you =

describe, e.g it skips any empty lines:

                 case GSM_PERMISSIVE_STATE_IDLE:
                         if (byte =3D=3D '\r' || byte =3D=3D '\n')
                                 /* ignore */;

Maybe there's something more subtle going on?  Are there stray =

whitespace characters or something else in the spurious response?  You =

would have to trace why the permissive syntax fails and either fix it or =

design your own.

Regards,
-Denis

--===============7798014776185825184==--

