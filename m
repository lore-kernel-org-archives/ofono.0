Content-Type: multipart/mixed; boundary="===============2454880642637496654=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH] sim: Ensure to call sim_pin_check
Date: Wed, 25 Aug 2010 22:41:25 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A51663E@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA8029A8687@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2454880642637496654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi jeevaka,


>>  static void sim_iccid_read_cb(int ok, int length, int record, @@
>-1454,6 +1452,8 @@ static void sim_initialize(struct ofono_sim *sim)
>>  	ofono_sim_read(sim, SIM_EFPL_FILEID,
>>  			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>>  			sim_efpl_read_cb, sim);
>> +
>> +	sim_pin_check(sim);
>>  }
>
>>  static void sim_op_error(struct ofono_sim *sim)
>> --
>> 1.7.0.4
>
>As per the 3GPP 31.102 section 5.1.1.2, CHV1 verification procedure will
>be done after reading of EFli and EFpl. Earlier( before "sim: Reorder
>SIM initialization" patch) src/sim.c had the sim_pin_check()called from
>sim_efphase_read_cb() where it called after issuing EFli and EFpl file
>read request. The patch "sim: Reorder SIM initialization" changed it to
>call from sim_efpl_read_cb() which is as per the specification.If the
>reading of EFli and EFpl fails, then sim_pin_check is not getting called
>because we are returning from "if (sim->language_prefs =3D=3D NULL)". In
>your patch, you are moving it to be called after the EFpl read request
>which is same as what we had before "sim: Reorder SIM initialization"
>patch. I believe the right place to call the sim_pin_check() will be
>before the if condition(if (sim->language_prefs =3D=3D NULL)) in
>sim_efpl_read_cb(), like shown below
>
>      if (efpl) {
>		g_slist_foreach(efpl, (GFunc)g_free, NULL);
>	      g_slist_free(efpl);
> 	}
>
>	sim_pin_check(sim);
>
>      if (sim->language_prefs =3D=3D NULL)
>            return;
>
>      ofono_dbus_signal_array_property_changed(conn, path,
>
>OFONO_SIM_MANAGER_INTERFACE,
>                                               "PreferredLanguages",
>                                               DBUS_TYPE_STRING,
>                                               &sim->language_prefs);
>
>Let me know your views on this.

Your solution is better than mine, and might be Denis' intention of modific=
ation. Honestly, I ever thought about the change like your proposal (Actual=
ly it was the same as ppessi's patch), but I had a concern on current code.=
 Now we read EFli and EFpl in parallel. Is it guaranteed the callback of EF=
li will be called before the callback of EFpl? IMO, it can't always guarant=
ee this. If I'm correct, your solution is just half way to the final target=
. Maybe we need to work out a better one:)

Regards,
-Yang

--===============2454880642637496654==--

