Content-Type: multipart/mixed; boundary="===============2216099779367324927=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [RFC PATCH 1/3] radio-settings: add frequency band selection
 methods
Date: Wed, 01 Dec 2010 14:24:30 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3A719@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <1291205419-2659-2-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2216099779367324927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas, =


> +enum ofono_radio_band_gsm {
> +	OFONO_RADIO_BAND_GSM_ANY	=3D 0,
> +	OFONO_RADIO_BAND_GSM_850	=3D 1,
> +	OFONO_RADIO_BAND_GSM_900P	=3D 2,
> +	OFONO_RADIO_BAND_GSM_900E	=3D 3,
> +	OFONO_RADIO_BAND_GSM_1800	=3D 4,
> +	OFONO_RADIO_BAND_GSM_1900	=3D 5,
> +};
> +
> +enum ofono_radio_band_umts {
> +	OFONO_RADIO_BAND_UMTS_ANY	=3D 0,
> +	OFONO_RADIO_BAND_UMTS_850	=3D 1,
> +	OFONO_RADIO_BAND_UMTS_900	=3D 2,
> +	OFONO_RADIO_BAND_UMTS_1700AWS	=3D 3,
> +	OFONO_RADIO_BAND_UMTS_1900	=3D 4,
> +	OFONO_RADIO_BAND_UMTS_2100	=3D 5,
> +};

A minor coding style comment. Accodring to code style M11: Naming of
enums,
If the enum contents have values (e.g. from specification) then the
above =

formatting you have used is OK. But as these values are not defined as
such
in the specification as such, then it should be,

 enum ofono_radio_band_gsm {
	OFONO_RADIO_BAND_GSM_ANY,
	OFONO_RADIO_BAND_GSM_850,
	OFONO_RADIO_BAND_GSM_900P,
	OFONO_RADIO_BAND_GSM_900E,
	OFONO_RADIO_BAND_GSM_1800,
	OFONO_RADIO_BAND_GSM_1900,
 };

 enum ofono_radio_band_umts {
	OFONO_RADIO_BAND_UMTS_ANY,
	OFONO_RADIO_BAND_UMTS_850,
	OFONO_RADIO_BAND_UMTS_900,
	OFONO_RADIO_BAND_UMTS_1700AWS,
	OFONO_RADIO_BAND_UMTS_19004,
	OFONO_RADIO_BAND_UMTS_21005,
 };

BR,
Rajesh

--===============2216099779367324927==--

