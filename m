Content-Type: multipart/mixed; boundary="===============0143860186128548129=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Sat, 04 May 2019 21:06:53 +0200
Message-ID: <CAHB-Pj=9Tt08vYyLDEa46JeF5SyXvjCUphJ9U3ckV1+k=G5_pw@mail.gmail.com>
In-Reply-To: <20190422074441.11854-3-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0143860186128548129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Den m=C3=A5n 22 apr. 2019 kl 09:44 skrev Jonas Bonn <jonas@norrbonn.se>:
> +
> +static void creg_notify(GAtResult *result, gpointer user_data)
> +{
> +       struct ofono_netreg *netreg =3D user_data;
> +       int status, lac, ci, tech;
> +       struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
> +       struct tech_query *tq;
> +
> +       if (at_util_parse_reg_unsolicited(result, "+CREG:", &status,
> +                               &lac, &ci, &tech, nd->vendor) =3D=3D FALS=
E)
> +               return;
> +
> +       if (status !=3D 1 && status !=3D 5)
> +               goto notify;

Just wants to check your thoughts about CREG and LTE only...
If the modem only has 4g coverage it might set the status to 4 (unknown),
but ureg would indicate LTE(7).
I have done a local patch for this in gprs, do not go to de-attached
state in that case.

Just wondering if we should combine the CREG and UREG status
in some way, the problem is that UREG is not indicating roaming or not...

--Richard

--===============0143860186128548129==--

