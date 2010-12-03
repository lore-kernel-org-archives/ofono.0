Content-Type: multipart/mixed; boundary="===============1497311641692934758=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [PATCH 2/5] cdma-voicecall: Add CDMA MO Call Support
Date: Thu, 02 Dec 2010 16:30:15 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3AA1A@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <1291332685-18740-3-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1497311641692934758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara, =

  =

> +enum cdma_call_status {
> +	CDMA_CALL_STATUS_ACTIVE =3D 0,
> +	CDMA_CALL_STATUS_DIALING =3D 1,
> +	CDMA_CALL_STATUS_ALERTING =3D 2,
> +	CDMA_CALL_STATUS_INCOMING =3D 4,

Should be 3 ?

> +	CDMA_CALL_STATUS_DISCONNECTED
> +};

We can use the existing gsm call status itself ?
Just that we wont use the HELD and WAITING status
in CDMA.

BR,
Rajesh
=20

--===============1497311641692934758==--

