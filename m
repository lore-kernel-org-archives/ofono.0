Content-Type: multipart/mixed; boundary="===============4361641685077177114=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] Add radio settings atom and driver API
Date: Thu, 04 Feb 2010 06:36:53 -0800
Message-ID: <1265294213.31341.158.camel@localhost.localdomain>
In-Reply-To: <1265266709-3835-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4361641685077177114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> +Properties	string Mode [read-write]
> +
> +			The current radio access selection mode, also known
> +			as network preference.
> +
> +			The possible values are:
> +				"dual"     Radio access selection is done
> +					   automatically, using either 2G
> +					   or 3G, depending on reception.
> +				"2g"       Only GSM used for radio access.
> +				"3g"       Only UTRAN used for radio access.
> +				"unknown"  Mode currently unknown.

how would we be dealing with LTE here. The word "dual" is kinda tricky
in that sense. Also what about chips like Qualcomm GOBI that can change
their firmware and start operating in CDMA. We do wanna extend oFono to
support CDMA at some point.

Regards

Marcel



--===============4361641685077177114==--

