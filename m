Content-Type: multipart/mixed; boundary="===============2273386669244298741=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 11/12] doc: Add AT command for debugging purpose
Date: Fri, 18 Mar 2011 09:04:05 -0700
Message-ID: <1300464245.2572.46.camel@aeonflux>
In-Reply-To: <1300451458-6749-12-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2273386669244298741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

> diff --git a/doc/dialup-command-set.txt b/doc/dialup-command-set.txt
> index 97ff009..554707d 100644
> --- a/doc/dialup-command-set.txt
> +++ b/doc/dialup-command-set.txt
> @@ -184,6 +184,7 @@ Device:
>  	+GMR		Request Revision Identification
>  	+CGSN		Request product serial number identification
>  	+CKPD		Keypad control
> +	+TRACE		Switch Trace ON/OFF

since this is not a standard AT command, I think we should leave it our
for now.

Regards

Marcel



--===============2273386669244298741==--

