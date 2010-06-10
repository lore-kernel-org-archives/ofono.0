Content-Type: multipart/mixed; boundary="===============0999336246021892455=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/2] sms: status report notify
Date: Thu, 10 Jun 2010 11:14:56 -0500
Message-ID: <201006101114.57074.denkenz@gmail.com>
In-Reply-To: <1276153545-22260-3-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0999336246021892455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> +	if (!sms_dcs_decode(s.deliver.dcs, &cls, NULL, NULL, NULL)) {
> +		ofono_error("Unknown / Reserved DCS.  Ignoring");
> +		return;
> +	}
> +

This reminds me, one other check I'd like you to make here is that the stat=
us =

report belongs to an SMS Submit, not an SMS Command.  See TP-SRQ in 23.040.=
  I =

like to be paranoid :)

Regards,
-Denis

--===============0999336246021892455==--

