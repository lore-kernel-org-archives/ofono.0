Content-Type: multipart/mixed; boundary="===============7409800551228582269=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH v2 2/4] voicecall: refactor emergency number list handling
Date: Wed, 30 Mar 2011 16:33:26 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802EEFF8F@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <4D929E50.40107@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7409800551228582269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Jeevaka,
> =

>> void emit_en_list_changed(struct ofono_voicecall *vc)  static void
>> set_new_ecc(struct ofono_voicecall *vc)  {
>>  	int i =3D 0;
>> +	GSList *l;
>> =

>>  	g_slist_foreach(vc->en_list, (GFunc) g_free, NULL); =

>> g_slist_free(vc->en_list); @@ -2079,6 +2081,12 @@ static void
>>  	set_new_ecc(struct ofono_voicecall *vc) vc->en_list =3D
>>  	vc->new_en_list; vc->new_en_list =3D NULL;
>> =

>> +	for (l =3D vc->sim_en_list; l; l =3D l->next) {
>> +		if (!g_slist_find_custom(vc->en_list, l->data,
number_compare))
>> +			vc->en_list =3D g_slist_prepend(vc->en_list,
>> +
> g_strdup(l->data));
>> +	}
>> +
>>  	while (default_en_list[i]) {
>>  		GSList *l;
>> =

>> @@ -2120,10 +2128,11 @@ static void ecc_g2_read_cb(int ok, int
>> total_length, int record,  		data +=3D 3; =

>> =

>>  		if (en[0] !=3D '\0')
>> -			vc->new_en_list =3D
> g_slist_prepend(vc->new_en_list,
>> +			vc->sim_en_list =3D
> g_slist_prepend(vc->sim_en_list,
>> =

> g_strdup(en));
> =

> To preserve the old behavior, can we also check that the
> number is not on the default_en_list?

SIM ecc number check with default_en_list is already taken care inside
set_new_ecc function. =


Regards,
Jeevaka


--===============7409800551228582269==--

