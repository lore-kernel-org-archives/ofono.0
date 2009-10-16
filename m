Content-Type: multipart/mixed; boundary="===============8529461144366603821=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Parse +CUSD responses.
Date: Fri, 16 Oct 2009 13:06:07 -0500
Message-ID: <200910161306.07901.denkenz@gmail.com>
In-Reply-To: <1255716767-3807-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8529461144366603821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> USSD.Initiate still returns a string, this may be wrong because
> when the network returns data coded in 8-bits we have no information
> on the character set used, everything is "user-specified" for the
> 8-bit coding in the 23.038 and technically we should return an array

Right now we should simply ignore 8bit data and return an error.

> I removed the "TODO: be able to send UCS2 string" because the string
> we send is first checked to be a valid USSD string so we already know
> it can be encoded with GSM 7-bits.

Actually valid_ussd_string will accept just about everything.

> +	/* All 7-bit coding schemes - there's no need to distinguish
> +	 * between the different schemes because the modem is tasked
> +	 * with presenting us with only raw 7-bit characters.
> +	 */
> +	if ((dcs & 0xf0) =3D=3D 0x00 || dcs =3D=3D 0x10 || (dcs & 0xf0) =3D=3D =
0x20 ||
> +			(dcs & 0xf0) =3D=3D 0x30 || (dcs & 0xcc) =3D=3D 0x40 ||
> +			(dcs & 0xfc) =3D=3D 0x90 || (dcs & 0xf4) =3D=3D 0xf0)
> +		converted =3D convert_gsm_to_utf8(content, length,
> +						NULL, NULL, 0);
> +

What about the evil set of DCSes which indicate a ISO639 2 character code =

preceding the message?

> -	sprintf(buf, "AT+CUSD=3D1,\"%*s\",%d", (int) written, converted, dcs);
> +	len =3D sprintf(buf, "AT+CUSD=3D1,\"");
> +	for (i =3D 0; i < written; i ++)
> +		len +=3D sprintf(buf + len, "%02hhx", converted[i]);
> +	sprintf(buf + len, "\",%d", dcs);
>

So this part concerns me, see below.

> +	dump_response("cssu_notify", TRUE, result);

cssd_notify :)

> +
> +	g_at_chat_send(chat, "AT+CSCS=3D\"HEX\"", NULL, NULL, NULL, NULL);

This part of 27.007 is utterly and completely broken.  We have to be extra =

careful whenever we mess with CSCS.  Does this have any unfortunate side =

effects, in particular with +COPS, +CPUC, etc?  Also note that since we cha=
nge =

the CSCS during phonebook import, any USSDs sent/received during this time =

won't actually work properly :)

Regards,
-Denis

--===============8529461144366603821==--

