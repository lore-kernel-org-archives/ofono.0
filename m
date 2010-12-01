Content-Type: multipart/mixed; boundary="===============5304896231788366725=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [RFC PATCH 3/3] doc: document frequency band selection
Date: Wed, 01 Dec 2010 14:29:39 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3A721@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <1291205419-2659-4-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5304896231788366725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> +
> +		string UmtsBand [readwrite, optional]
> +
> +			Frequency band in which the modem is allowed to
> +			operate when using "umts" mode. Setting this
property
> +			has an imediate effect on modem only if
> +			TechnologyPreference is set to "gsm".

Should be "Setting this property has an imediate effect on modem only if
TechnologyPreference is set to "umts"."

BR,
Rajesh


--===============5304896231788366725==--

