Content-Type: multipart/mixed; boundary="===============7393036427898054762=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] TODO: CBS CMAS
Date: Wed, 09 Jun 2010 09:55:50 -0700
Message-ID: <1276102550.2182.65.camel@localhost.localdomain>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9C58BCDAD@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7393036427898054762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> +Cell Broadcast System
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- Support for Commercial Mobile Alert System (CMAS) according to 3GPP
> +  23.041, 3GPP 22.268 and ATIS/TIA J-STD-100 in addition to Earthquake
> +  and Tsunami Warning Service (ETWS). oFono already reports ETWS messages
> +  with CBS message identifiers 4352-4356 as EmergencyBroadcast DBUS sign=
als.
> +  oFono should be extended with support for CMAS messages which have CBS
> +  message identifiers in the range of 4370-4382.
> +
> +  Priority: Medium
> +  Complexity: C1
> +
> +

do we expect this to be always enabled? If so, then just send a patch
for it. Should be pretty much straight forward.

Regards

Marcel



--===============7393036427898054762==--

