Content-Type: multipart/mixed; boundary="===============0049648739275366477=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/5] netreg: Add CPHS CSP PLMN mode implementation
Date: Tue, 18 Jan 2011 15:29:08 +0100
Message-ID: <1295360948.3873.180.camel@aeonflux>
In-Reply-To: <1295356747-29758-3-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0049648739275366477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

<snip>

> +	if (netreg->settings) {
> +		g_key_file_set_boolean(netreg->settings, SETTINGS_GROUP,
> +					"ForcedAuto", netreg->forced_auto);
> +		storage_sync(netreg->imsi, SETTINGS_STORE, netreg->settings);
> +	}

why are we bothering to store this value? Would it not be better to
re-read when bringing up the modem?

Regards

Marcel



--===============0049648739275366477==--

