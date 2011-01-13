Content-Type: multipart/mixed; boundary="===============2147688004098278176=="
MIME-Version: 1.0
From: Jussi.Kangas@tieto.com
Subject: RE: [PATCH] sim: check if lock is locked after code changing attempt
Date: Thu, 13 Jan 2011 10:34:23 +0200
Message-ID: <20A4FB08D632914F9C09B9F05CBDF258192DAA2580@EXMB02.eu.tieto.com>
In-Reply-To: <4D2D3722.6030803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2147688004098278176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, =


On Wed, 2011-01-12 at 07:07 +0200, Denis Kenzior wrote:
> Hi Jussi,
> =

> On 01/11/2011 06:17 AM, Jussi.Kangas(a)tieto.com wrote:
> > Hi,
> > =

> > This is fix to Marit Henriksen's TODO item "Check SIM pin status if sim=
_change_pin fails". I've discussed with Marit and it's ok for her if I fix =
the issue. Problem here is that issue could perhaps also be fixed with retr=
y counter solution introduced by Lucas De Marchi couple of tasks ago. That =
would seem however require some extra implementation in ste modem ( at leas=
t I was not able get the ofono show correct values without extra modificati=
ons ) and I think that isimodems don't have that sort of retry counter at a=
ll. Because of that and since I had this solution already implemented I pro=
pose it to be added as well. =

> > =

> > Br,
> > -Jussi
> > =

> > ---
> >  src/sim.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 54 insertions(+), 0 deletions(-)
> > =

> =

> First, please fix your authorship information.  See the AUTHORS file =

> to see what we expect.  Also, please make sure that you're using tabs =

> for indentation and following the relevant coding style.  See the =

> Submitting Patches section in the HACKING document in oFono git as =

> well as doc/coding-style.txt.

I think whole this chapter should be translated as "Do not use Outlook".
I asked around little bit and best guess seems to be that you are using som=
ething that takes authorship information from mail address. Also since the =
patch passes the checkpatch here with no problems whatsoever I guess Outloo=
k ruined the patch. Fine, I'll try Evolution next. If possible, I would lik=
e to avoid using the git send-email. I prefer tools with GUI. =


> =

> > diff --git a/src/sim.c b/src/sim.c
> > index d627647..789ddde 100644
> > --- a/src/sim.c
> > +++ b/src/sim.c
> > @@ -712,8 +712,60 @@ static DBusMessage =

> > *sim_unlock_pin(DBusConnection *conn, DBusMessage *msg,  static void =

> > sim_change_pin_cb(const struct ofono_error *error, void *data)  {
> =

> So my first concern is that whatever you do here also has to work for =

> LockPin and UnlockPin.

I'm not after total solution here. I would like to implement this so that f=
irst the ChangePin starts working, i.e fullfill the existing TODO task firs=
t. Reasoning here is that I thought it would be easier to get the fixes in =
if I keep them small. If u mean that stuff inside (error->error =3D 12) con=
dition should be as separate function to be usable for LockPin and UnlockPi=
n, I agree. I was just thinking that separation could be done when fix is e=
xtended to LockPin and UnlockPin. =


> =

> >      struct ofono_sim *sim =3D data;
> > +    DBusConnection *conn =3D ofono_dbus_get_connection();
> > +    const char *path =3D __ofono_atom_get_path(sim->atom);
> > +    struct ofono_modem *modem =3D __ofono_atom_get_modem(sim->atom);
> > +    const char *pin_name;
> >  =

> >      if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> > +        if (error->error =3D=3D 12) {
> > +            sim->locked_pins[sim->pin_type] =3D TRUE;
> > +            switch (sim->pin_type) {
> > +            case OFONO_SIM_PASSWORD_SIM_PIN:
> > +                sim->pin_type =3D OFONO_SIM_PASSWORD_SIM_PUK;
> > +                pin_name =3D sim_passwd_name(
> > +                    OFONO_SIM_PASSWORD_SIM_PUK);
> > +                break;
> > +            case OFONO_SIM_PASSWORD_PHFSIM_PIN:
> > +                sim->pin_type =3D OFONO_SIM_PASSWORD_PHFSIM_PUK;
> > +                pin_name =3D sim_passwd_name(
> > +                    OFONO_SIM_PASSWORD_PHFSIM_PUK);
> > +                break;
> > +            case OFONO_SIM_PASSWORD_PHCORP_PIN:
> > +                sim->pin_type =3D OFONO_SIM_PASSWORD_PHCORP_PUK;
> > +                pin_name =3D sim_passwd_name(
> > +                    OFONO_SIM_PASSWORD_PHCORP_PUK);
> > +                break;
> > +            case OFONO_SIM_PASSWORD_PHNET_PIN:
> > +                sim->pin_type =3D OFONO_SIM_PASSWORD_PHNET_PUK;
> > +                pin_name =3D sim_passwd_name(
> > +                        OFONO_SIM_PASSWORD_PHNET_PUK);
> > +            case OFONO_SIM_PASSWORD_PHNETSUB_PIN:
> > +                sim->pin_type =3D OFONO_SIM_PASSWORD_PHNETSUB_PUK;
> > +                pin_name =3D sim_passwd_name(
> > +                    OFONO_SIM_PASSWORD_PHNETSUB_PUK);
> > +                break;
> > +            case OFONO_SIM_PASSWORD_PHSP_PIN:
> > +                sim->pin_type =3D OFONO_SIM_PASSWORD_PHSP_PUK;
> > +                pin_name =3D sim_passwd_name(
> > +                    OFONO_SIM_PASSWORD_PHSP_PUK);
> > +                break;
> > +            case OFONO_SIM_PASSWORD_SIM_PIN2:
> > +                sim->pin_type =3D OFONO_SIM_PASSWORD_SIM_PUK2;
> > +                pin_name =3D sim_passwd_name(
> > +                    OFONO_SIM_PASSWORD_SIM_PUK2);
> > +                break;
> > +            default:
> > +                break;
> > +            }
> > +            ofono_dbus_signal_property_changed(conn, path,
> > +                OFONO_SIM_MANAGER_INTERFACE,
> > +                "PinRequired", DBUS_TYPE_STRING,
> > +                &pin_name);
> =

> Have you considered querying the PIN state on a failure instead?  If =

> the lock/unlock/change pin operation fails, then re-query the current PIN.
> If the CPIN is no longer returning READY and we're in a state =

> OFONO_SIM_STATE_READY, then tear us back down to an earlier state.

Yes, I have. As I answered to Lucas already at least with the modem I'm usi=
ng the return value I get seems to be trustable and there is no point to go=
 querying the information I already know. Also there could be other reasons=
 why sim state is not ready ( small chance of course ) so to satisfy my ped=
ant nature I would have to either check the return value anyways or use som=
e other means to get the reason why the sim is not ready in order to be 100=
 % sure that PUK is required. At least Lucas seemed to favor query approach=
. I guess that has to mean that return value is not trustable with all mode=
ms. I can change this if required. =


> =

> > +
> > +            if (sim->pin_type !=3D OFONO_SIM_PASSWORD_SIM_PUK2)
> =

> What is the reason for excepting PUK2 here?  Should we be also =

> proceeding to the SIM_READY state on SIM initialization if PUK2 is =

> required as well?

PUK2 locking does not force modem to drop from network. There is no reason =
to go pre_sim state. In matter of fact I'm using SIM with PIN2 blocked here=
 all the time since I don't know how to get the code. =


> =

> > +                ofono_modem_reset(modem);
> > +        }
> =

> This seems a bit drastic, but fair enough...
> =

> >          __ofono_dbus_pending_reply(&sim->pending,
> >                  __ofono_error_failed(sim->pending));
> >  =

> > @@ -722,6 +774,7 @@ static void sim_change_pin_cb(const struct ofono_er=
ror *error, void *data)
> >          return;
> >      }
> >  =

> > +    sim->pin_type =3D OFONO_SIM_PASSWORD_NONE;
> >      __ofono_dbus_pending_reply(&sim->pending,
> >                  dbus_message_new_method_return(sim->pending));
> >  =

> > @@ -764,6 +817,7 @@ static DBusMessage *sim_change_pin(DBusConnection *=
conn, DBusMessage *msg,
> >          return dbus_message_new_method_return(msg);
> >  =

> >      sim->pending =3D dbus_message_ref(msg);
> > +    sim->pin_type =3D type;
> >      sim->driver->change_passwd(sim, type, old, new,
> >                      sim_change_pin_cb, sim);
> >  =

> =

> Regards,
> -Denis

Br,
-Jussi

--===============2147688004098278176==--

