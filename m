Content-Type: multipart/mixed; boundary="===============7183041860957635132=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Present list of preferred languages on SimManager
 interface.
Date: Mon, 14 Sep 2009 11:06:47 -0500
Message-ID: <200909141106.48522.denkenz@gmail.com>
In-Reply-To: <1252946269-5745-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7183041860957635132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> It does not look like the list can be used directly for filtering CBs
> because for that, the ME should choose one language, if there is one
> that is supported by the UI (aka MMI).

It actually can, since the preferred language list for cell broadcasts can =
be =

of any length...

And now for some nitpicks:

> +static int parse_language_list(char **out_list, const unsigned char
> *sim_list, +				int length)
> +{
> +	unsigned char code[3];
> +	int count, i;
> +	long written;
> +
> +	count =3D 0;
> +	length--;
> +
> +	for (i =3D 0; i < length; i +=3D 2) {
> +		code[0] =3D sim_list[i + 0];
> +		code[1] =3D sim_list[i + 1];
> +		code[2] =3D 0;
> +
> +		if (code[0] =3D=3D 0xff || code[1] =3D=3D 0xff)
> +			continue;
> +
> +		out_list[count] =3D convert_gsm_to_utf8(code, 2,
> +							NULL, &written, 0);

Lets skip the gsm conversion.  The ISO639 standard only uses latin characte=
rs =

which are guaranteed to be the same between utf8 / gsm.

> +static void sim_efpl_read_cb(int ok,
> +				enum ofono_sim_file_structure structure,
> +				int length, int record,
> +				const unsigned char *data,
> +				int record_length, void *userdata)
> +{
> +	struct ofono_sim *sim =3D userdata;
> +	unsigned char *efli =3D sim->efli;
> +	const unsigned char *efpl =3D data;
> +	int efli_length =3D sim->efli_length;
> +	int efpl_length =3D length;
> +	int count;
> +	const char *path =3D __ofono_atom_get_path(sim->atom);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +	if (!ok || structure !=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
> +		efpl =3D NULL;
> +
> +	if (length < 2)
> +		efpl =3D NULL;
> +
> +	sim->language_prefs =3D g_malloc(((efli_length + efpl_length) / 2 + 1) *
> +			sizeof(char *));
> +
> +	count =3D 0;
> +
> +	/* Make a list of languages in both files in order of preferences
> +	 * following 31.102.
> +	 */
> +
> +	if (efli && efpl && efli[0] =3D=3D 0xff && efli[1] =3D=3D 0xff) {
> +		count +=3D parse_language_list(sim->language_prefs + count,
> +						efpl, efpl_length);
> +		efpl =3D NULL;
> +	}
> +
> +	if (efli) {
> +		count +=3D parse_language_list(sim->language_prefs + count,
> +						efli, efli_length);
> +		g_free(efli);
> +		sim->efli =3D NULL;
> +	}
> +
> +	if (efpl)
> +		count +=3D parse_language_list(sim->language_prefs + count,
> +						efpl, efpl_length);

If we're going down the path of preserving both EFli and EFpl, then you sho=
uld =

make sure no duplicates exist. Alternatively we can assume that oFono/UI wi=
ll =

support all languages and simply not read EFpl if there is useable informat=
ion =

in EFli.

> +static void sim_retrieve_efli(struct ofono_sim *sim)
> +{
> +	/* According to 31.102 the EFli is read first and EFpl is then
> +	 * only read if none of the EFli languages are supported by user
> +	 * interface.  51.011 mandates the exact opposite, making EFpl/EFelp
> +	 * preferred over EFlp (same ID as EFli, different format).
> +	 * However we don't depend on the user interface and so
> +	 * need to read both files now.
> +	 */
> +	ofono_sim_read(sim, SIM_EFLI_FILEID, sim_efli_read_cb, sim);
> +	ofono_sim_read(sim, SIM_EFPL_FILEID, sim_efpl_read_cb, sim);

Strictly speaking 31.101 & 31.102 supersede 51.011.

Regards,
-Denis

--===============7183041860957635132==--

