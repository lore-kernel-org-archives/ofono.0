Content-Type: multipart/mixed; boundary="===============2102661070055258633=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/6] Change in at_cds_notify for status report.
Date: Fri, 04 Jun 2010 11:52:13 -0500
Message-ID: <201006041152.14627.denkenz@gmail.com>
In-Reply-To: <1275650257-30593-2-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2102661070055258633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> ---
>  drivers/atmodem/sms.c |   19 +++++++++++++++----
>  1 files changed, 15 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> index 439beea..3dafbc9 100644
> -	DBG("Got new Status-Report PDU via CDS: %s, %d", pdu, pdulen);
> +	if (strlen(hexpdu) > sizeof(pdu) * 2) {
> +		ofono_error("Bad PDU length in CMT notification");
> +		return;
> +	}

Watch out for copy-paste mistakes.  Fixed it for you.

Patch has been applied, thanks.

Regards,
-Denis

--===============2102661070055258633==--

