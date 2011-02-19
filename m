Content-Type: multipart/mixed; boundary="===============4943790207313322261=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 3/9] sim: Watch for changes to relevant SIM files.
Date: Sat, 19 Feb 2011 05:24:20 +0100
Message-ID: <AANLkTikKp5BcjuSY_D49gTZpH5YWS-tJ7ytjpoOOyJqK@mail.gmail.com>
In-Reply-To: <4D5D8E44.5050906@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4943790207313322261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 17 February 2011 22:08, Denis Kenzior <denkenz@gmail.com> wrote:
> On 02/15/2011 01:58 AM, Andrzej Zaborowski wrote:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_remove_file_watch(=
sim->context, SIM_EFMSISDN_FILEID);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_remove_file_watch(=
sim->context, SIM_EFSDN_FILEID);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_remove_file_watch(=
sim->context, SIM_EFIMG_FILEID);
>> +
>
> So two problems here. =C2=A0The file_watch id is not related to the file =
EF.
> =C2=A0So this won't really work anyway. =C2=A0It also sounds like we shou=
ld be
> canceling the entire context (and thus the related file watches) instead
> of trying to cancel them one by one.

Oh right.  I read the commit where ofono_sim_add_file_watch and
ofono_sim_remove_file_watch were added but I didn't notice this change
from the earlier proposed api, where this would have worked.  I'll fix
that by using a second context.

>
> What do you think of using two separate sim contexts here? =C2=A0Also, th=
is
> might really belong in sim_free_main_state instead of this function.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sim->efimg =3D=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D sim->efimg_length=
 / 9 - 1; i >=3D 0; i--) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
iidf_id =3D (sim->efimg[i * 9 + 3] << 8) |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->efimg[i * 9 + 4];
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ofono_sim_remove_file_watch(sim->context, iidf_id);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 if (new_state !=3D OFONO_SIM_STATE_READY)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 sim_own_numbers_update(sim);
>> + =C2=A0 =C2=A0 ofono_sim_add_file_watch(sim->context, SIM_EFMSISDN_FILE=
ID,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_own_numbers_cha=
nged, sim, NULL);
>>
>> =C2=A0 =C2=A0 =C2=A0 ofono_sim_read(sim->context, SIM_EFSDN_FILEID,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OFONO_SIM_FILE_STRUCTURE_FIXED, sim_sdn_read_cb, sim);
>> + =C2=A0 =C2=A0 ofono_sim_add_file_watch(sim->context, SIM_EFSDN_FILEID,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_service_numbers=
_changed, sim, NULL);
>> +
>> =C2=A0 =C2=A0 =C2=A0 ofono_sim_read(sim->context, SIM_EFIMG_FILEID,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OFONO_SIM_FILE_STRUCTURE_FIXED, sim_efimg_read_cb, sim);
>> + =C2=A0 =C2=A0 ofono_sim_add_file_watch(sim->context, SIM_EFIMG_FILEID,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_efimg_changed, =
sim, NULL);
>> =C2=A0}
>>
>> =C2=A0static void sim_imsi_cb(const struct ofono_error *error, const cha=
r *imsi,
>> @@ -1873,7 +1955,11 @@ skip_efpl:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 DBUS_TYPE_STRING,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &sim->language_prefs);
>>
>> - =C2=A0 =C2=A0 sim_pin_check(sim);
>> + =C2=A0 =C2=A0 /* Proceed with sim initialization if we're not merely u=
pdating */
>> + =C2=A0 =C2=A0 if (!sim->language_prefs_update)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_pin_check(sim);
>> +
>> + =C2=A0 =C2=A0 sim->language_prefs_update =3D FALSE;
>> =C2=A0}
>>
>> =C2=A0static void sim_iccid_read_cb(int ok, int length, int record,
>> @@ -1899,6 +1985,43 @@ static void sim_iccid_read_cb(int ok, int length,=
 int record,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &sim->iccid);
>> =C2=A0}
>>
>> +static void sim_iccid_changed(int id, void *userdata)
>> +{
>> + =C2=A0 =C2=A0 struct ofono_sim *sim =3D userdata;
>> +
>> + =C2=A0 =C2=A0 if (sim->iccid) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(sim->iccid);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->iccid =3D NULL;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 ofono_sim_read(sim->context, SIM_EF_ICCID_FILEID,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
sim_iccid_read_cb, sim);
>> +}
>> +
>> +static void sim_efli_efpl_changed(int id, void *userdata)
>> +{
>> + =C2=A0 =C2=A0 struct ofono_sim *sim =3D userdata;
>> +
>> + =C2=A0 =C2=A0 if (sim->efli !=3D NULL) /* This shouldn't happen */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 if (sim->language_prefs) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(sim->language_pre=
fs);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->language_prefs =3D NULL;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 sim->language_prefs_update =3D TRUE;
>> +
>> + =C2=A0 =C2=A0 ofono_sim_read(sim->context, SIM_EFLI_FILEID,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
sim_efli_read_cb, sim);
>> +
>> + =C2=A0 =C2=A0 ofono_sim_read(sim->context, SIM_EFPL_FILEID,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
sim_efpl_read_cb, sim);
>> +}
>> +
>> =C2=A0static void sim_initialize(struct ofono_sim *sim)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 /*
>> @@ -1927,10 +2050,15 @@ static void sim_initialize(struct ofono_sim *sim)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* in the EFust
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>
>> + =C2=A0 =C2=A0 if (sim->context =3D=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->context =3D ofono_sim_c=
ontext_create(sim);
>> +
>> =C2=A0 =C2=A0 =C2=A0 /* Grab the EFiccid which is always available */
>> =C2=A0 =C2=A0 =C2=A0 ofono_sim_read(sim->context, SIM_EF_ICCID_FILEID,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 sim_iccid_read_cb, sim);
>> + =C2=A0 =C2=A0 ofono_sim_add_file_watch(sim->context, SIM_EF_ICCID_FILE=
ID,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_iccid_changed, =
sim, NULL);
>>
>> =C2=A0 =C2=A0 =C2=A0 /* EFecc is read by the voicecall atom */
>>
>> @@ -1945,9 +2073,14 @@ static void sim_initialize(struct ofono_sim *sim)
>> =C2=A0 =C2=A0 =C2=A0 ofono_sim_read(sim->context, SIM_EFLI_FILEID,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 sim_efli_read_cb, sim);
>> + =C2=A0 =C2=A0 ofono_sim_add_file_watch(sim->context, SIM_EFLI_FILEID,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_efli_efpl_chang=
ed, sim, NULL);
>> +
>> =C2=A0 =C2=A0 =C2=A0 ofono_sim_read(sim->context, SIM_EFPL_FILEID,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 sim_efpl_read_cb, sim);
>> + =C2=A0 =C2=A0 ofono_sim_add_file_watch(sim->context, SIM_EFPL_FILEID,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_efli_efpl_chang=
ed, sim, NULL);
>> =C2=A0}
>>
>> =C2=A0struct ofono_sim_context *ofono_sim_context_create(struct ofono_si=
m *sim)
>> @@ -2096,6 +2229,11 @@ static void sim_free_early_state(struct ofono_sim=
 *sim)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(sim->languag=
e_prefs);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->language_prefs =3D=
 NULL;
>> =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (sim->context) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_context_free(sim->=
context);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->context =3D NULL;
>> + =C2=A0 =C2=A0 }
>> =C2=A0}
>>
>> =C2=A0static void sim_free_main_state(struct ofono_sim *sim)
>> @@ -2119,6 +2257,7 @@ static void sim_free_main_state(struct ofono_sim *=
sim)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (GFunc)service_number_free, NULL);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_slist_free(sim->servi=
ce_numbers);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->service_numbers =
=3D NULL;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->sdn_ready =3D FALSE;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 if (sim->efust) {
>> @@ -2296,11 +2435,6 @@ static void sim_remove(struct ofono_atom *atom)
>>
>> =C2=A0 =C2=A0 =C2=A0 sim_free_state(sim);
>>
>> - =C2=A0 =C2=A0 if (sim->context) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_sim_context_free(sim->=
context);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->context =3D NULL;
>> - =C2=A0 =C2=A0 }
>> -
>
> Out of curiosity, why are you moving this one? =C2=A0It seems to have no
> effect. =C2=A0Either way, this belongs in a separate patch ;)

This is because the context was logically invalid once sim is removed
even though the atom wasn't unregistered, so the context needs to be
created on sim insertion and removed on sim removal (this also
releases the watches)

Best regards.

--===============4943790207313322261==--

