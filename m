Content-Type: multipart/mixed; boundary="===============4515279919379491661=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 1/2] sim: add sim_ready_notify
Date: Wed, 25 Aug 2010 16:32:45 +0300
Message-ID: <AANLkTimAsa98aQf3nQ+K8W+=qV-Yq2PHOS3Ci9N+n8Z1@mail.gmail.com>
In-Reply-To: <1282659854-28097-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4515279919379491661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

2010/8/24 Kristen Carlson Accardi <kristen@linux.intel.com>:
> =C2=A0static void sim_pin_check(struct ofono_sim *sim)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 if (!(sim->status & SIM_STATUS_READY)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->status |=3D SIM_S=
TATUS_WAITING_FOR_PIN;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (sim->status & SIM_STATUS_WAITING_FOR_PIN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->status &=3D ~(SIM=
_STATUS_WAITING_FOR_PIN);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!sim->driver->query_passwd_state) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sim_initialize_aft=
er_pin(sim);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> @@ -2004,6 +2016,16 @@ static void sim_free_state(struct ofono_sim *sim)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sim->mnc_length =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 sim->status =3D 0;
> +}
> +
> +void ofono_sim_ready_notify(struct ofono_sim *sim)
> +{
> + =C2=A0 =C2=A0 =C2=A0 sim->status |=3D SIM_STATUS_READY;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (sim->status & SIM_STATUS_WAITING_FOR_PIN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_pin_check(sim);

I thought the idea was to call ofono_sim_ready_notify() some time
after entering the pin. Also, if there is no pin check or if it fails,
sim core should try to read pin-proteted files.

-- =

Pekka.Pessi mail at nokia.com

--===============4515279919379491661==--

