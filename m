Content-Type: multipart/mixed; boundary="===============3780620256888954020=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC PATCH 1/4] sim: check if FD is enabled in the SIM-card
Date: Mon, 04 Oct 2010 16:31:48 +0300
Message-ID: <AANLkTi=q4f5H=knNbV9jq+R1c7oW-duobJJ1zOFbWqVx@mail.gmail.com>
In-Reply-To: <1285949201-2994-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3780620256888954020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Moro Petteri and others,

2010/10/1 Petteri Tikander <petteri.tikander@ixonos.com>:
> index 42b19bd..e73a995 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -74,6 +74,7 @@ enum ofono_sim_cphs_phase {
> =C2=A0enum ofono_sim_state {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OFONO_SIM_STATE_NOT_PRESENT,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OFONO_SIM_STATE_INSERTED,
> + =C2=A0 =C2=A0 =C2=A0 OFONO_SIM_STATE_FAILED,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OFONO_SIM_STATE_READY,
> =C2=A0};

Would it be a good idea to let modem driver indicate the failure state
in some cases? I recall the N900 modem had some pathological cases
where it crashed if a SIM has certain services enabled?

-- =

Pekka.Pessi mail at nokia.com

--===============3780620256888954020==--

