Content-Type: multipart/mixed; boundary="===============6191399264922202164=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 1/2] sim: add ofono_sim_ready_notify() support
Date: Thu, 26 Aug 2010 15:17:19 +0300
Message-ID: <AANLkTimmnAENOKP+HLKwifKTeuBeZ=Jkk=JrdwWSdFww@mail.gmail.com>
In-Reply-To: <1282735392-5283-2-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6191399264922202164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen and all,

I've been toying PUKs and PIN2s and it seems to me that insted of
ofono_sim_ready_notify() driver needs a method with which it can
announce which PIN code SIM might need. If that is none, then we
proceed bit like after ofono_sim_ready_notify() in Kristen's patch. If
on the other hand user somehow gets his SIM PUKed, the driver can
indicate that to core, and we can change the SIM state back to
PRESENT.

More comments to Kristen below:

2010/8/25 Kristen Carlson Accardi <kristen@linux.intel.com>:
> +#define SIM_STATUS_READY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1
> +#define SIM_STATUS_WAITING_FOR_READY =C2=A0 (1 << 1)
> +
> =C2=A0struct sim_file_op {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int id;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gboolean cache;
> @@ -78,6 +81,7 @@ struct ofono_sim {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GSList *new_numbers;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GSList *service_numbers;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gboolean sdn_ready;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int status;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0enum ofono_sim_state state;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0enum ofono_sim_password_type pin_type;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PU=
K]; /* Number of PINs */
> @@ -686,15 +690,20 @@ static void sim_enter_pin_cb(const struct ofono_err=
or *error, void *data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_sim *sim =3D data;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DBusMessage *reply;
> + =C2=A0 =C2=A0 =C2=A0 gboolean ok =3D (error->type =3D=3D OFONO_ERROR_TY=
PE_NO_ERROR);
>
> - =C2=A0 =C2=A0 =C2=A0 if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
> + =C2=A0 =C2=A0 =C2=A0 if (!ok)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reply =3D __ofono_=
error_failed(sim->pending);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reply =3D dbus_mes=
sage_new_method_return(sim->pending);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__ofono_dbus_pending_reply(&sim->pending, repl=
y);
>
> - =C2=A0 =C2=A0 =C2=A0 sim_pin_check(sim);
> + =C2=A0 =C2=A0 =C2=A0 if (ok && (sim->status & SIM_STATUS_READY)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->status &=3D ~SIM_=
STATUS_WAITING_FOR_READY;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_pin_check(sim);
> + =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->status |=3D SIM_S=
TATUS_WAITING_FOR_READY;
> =C2=A0}

This does not work if modem 1) does not implement pin check or pin
query 2) does not get ready immediately. isimodem comes to mind.

I'd guess you should set the bit sim->status |=3D SIM_STATUS_WAITING_FOR_RE=
ADY
from sim_efpl_read_cb.

Perhaps renaming the sim_pin_query() as ofono_sim_ready_notify() and
check for the WAITING_FOR_READY bit there? You could also set another
bit in ofono_sim_ready_notify, just prevent it from running
sim_initialize_after_pin() twice.

-- =

Pekka.Pessi mail at nokia.com

--===============6191399264922202164==--

