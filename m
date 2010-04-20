Content-Type: multipart/mixed; boundary="===============8425582414516776816=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Added Wavecom modem plugin.
Date: Tue, 20 Apr 2010 12:03:10 -0500
Message-ID: <201004201203.11179.denkenz@gmail.com>
In-Reply-To: <1271722185-1321-1-git-send-email-matgnt@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8425582414516776816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

> The Wavecom WMP100 assumes CPIN to be the final response, therefore some
>  special handling is neccessary (see
>  6d28f82dc1ccb3de3a028a88eafb96fb001c7e61). Now the vendor id
>  OFONO_VENDOR_WAVECOM is passed with all "*create" functions.

I massaged the commit message and pushed the patch.  I did make two small =

changes afterward:

> +	if (!channel) {
> +		return -EIO;
> +	}

Coding style requires this to be without braces (all single statement block=
s =

if/while/for should not have braces)

> +
> +	/* Could not figure out whether it is fully compliant or not */
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	//syntax =3D g_at_syntax_new_gsmv1();

Commented out code is not a good idea, if you're not sure about something =

reflect it in the comment.

Regards,
-Denis

--===============8425582414516776816==--

