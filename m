Content-Type: multipart/mixed; boundary="===============7028359820783218343=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [sim-reset-pin-v2 1/3] sim: pass reset password type to driver
Date: Thu, 02 Sep 2010 19:35:04 +0300
Message-ID: <AANLkTikEK3+kZDF0Ad0VVqO0WY9J8VxtUhh-DomtcYNm@mail.gmail.com>
In-Reply-To: <4C7EB314.6010808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7028359820783218343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/9/1 Denis Kenzior <denkenz@gmail.com>:
>> =C2=A0 =C2=A0 =C2=A0 void (*send_passwd)(struct ofono_sim *sim, const ch=
ar *passwd,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ofono_sim_lock_unlock_cb_t cb, void *data);
>> - =C2=A0 =C2=A0 void (*reset_passwd)(struct ofono_sim *sim, const char *=
puk,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
const char *passwd,
>> + =C2=A0 =C2=A0 void (*reset_passwd)(struct ofono_sim *sim,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
enum ofono_sim_password_type type,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
const char *puk, const char *passwd,
>
> Honestly I'm still lost, why are we doing this again? =C2=A0reset_passwd
> corresponds to CPIN from 27.007. =C2=A0This one does not accept a type. =
=C2=A0Some
> modems (like the calypso) have the +CPIN2 command which can be used to
> enter PIN/PUK2. =C2=A0Are you trying to solve this case?

Yes, I'm trying to reset PIN2. The +CPIN=3D"puk","pin" uses the type
from the last +CPIN?. Unfortunately it may be transient (and I still
don't understand how the PIN2 is supposed to be entered using the AT
command interface).

> If so, we either need to add the type to both reset_passwd and
> send_passwd or leave this up to the driver to figure out.

OK, I'll do it that way.

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ofono_sim_lock_unlock_cb_t cb, void *data);
>> =C2=A0 =C2=A0 =C2=A0 void (*change_passwd)(struct ofono_sim *sim,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 enum ofono_sim_password_type type,
>> diff --git a/src/sim.c b/src/sim.c
>> index d0b5988..5e918f2 100644
>> --- a/src/sim.c
>> +++ b/src/sim.c
>> @@ -747,8 +747,13 @@ static DBusMessage *sim_reset_pin(DBusConnection *c=
onn, DBusMessage *msg,
>>
>> =C2=A0 =C2=A0 =C2=A0 type =3D sim_string_to_passwd(typestr);
>>
>> - =C2=A0 =C2=A0 if (type =3D=3D OFONO_SIM_PASSWORD_NONE || type !=3D sim=
->pin_type)
>> + =C2=A0 =C2=A0 switch (type) {
>> + =C2=A0 =C2=A0 case OFONO_SIM_PASSWORD_SIM_PIN:
>> + =C2=A0 =C2=A0 case OFONO_SIM_PASSWORD_SIM_PIN2:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 default:
>
> And now you're changing the API semantics completely. =C2=A0ResetPin is
> supposed to be called like this:
>
> ResetPin("puk"/"puk2"/"corppuk"/"networkpuk"/etc, puk, newpin)
>
> Now you're changing this to be called like:
>
> ResetPin("pin"/"pin2", ...)
>
> I'm not necessarily saying this is a bad idea, but this does not cover
> all the other puks described in 27.007.

Oops.  I'll remove the check, it should be in the driver.

-- =

Pekka.Pessi mail at nokia.com

--===============7028359820783218343==--

