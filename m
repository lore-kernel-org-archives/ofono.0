Content-Type: multipart/mixed; boundary="===============2128687706079256105=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/4] voicecall: refactor emergency number list handling
Date: Wed, 30 Mar 2011 10:41:45 -0500
Message-ID: <4D934F39.5060708@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802EEFF8F@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2128687706079256105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 03/30/2011 08:33 AM, Jeevaka.Badrappan(a)elektrobit.com wrote:
> Hi Denis,
> =

> Denis Kenzior wrote:
>> Hi Jeevaka,
>>
>>> void emit_en_list_changed(struct ofono_voicecall *vc)  static void
>>> set_new_ecc(struct ofono_voicecall *vc)  {
>>>  	int i =3D 0;
>>> +	GSList *l;
>>>
>>>  	g_slist_foreach(vc->en_list, (GFunc) g_free, NULL); =

>>> g_slist_free(vc->en_list); @@ -2079,6 +2081,12 @@ static void
>>>  	set_new_ecc(struct ofono_voicecall *vc) vc->en_list =3D
>>>  	vc->new_en_list; vc->new_en_list =3D NULL;
>>>
>>> +	for (l =3D vc->sim_en_list; l; l =3D l->next) {
>>> +		if (!g_slist_find_custom(vc->en_list, l->data,
> number_compare))
>>> +			vc->en_list =3D g_slist_prepend(vc->en_list,
>>> +
>> g_strdup(l->data));
>>> +	}
>>> +
>>>  	while (default_en_list[i]) {
>>>  		GSList *l;
>>>
>>> @@ -2120,10 +2128,11 @@ static void ecc_g2_read_cb(int ok, int
>>> total_length, int record,  		data +=3D 3; =

>>>
>>>  		if (en[0] !=3D '\0')
>>> -			vc->new_en_list =3D
>> g_slist_prepend(vc->new_en_list,
>>> +			vc->sim_en_list =3D
>> g_slist_prepend(vc->sim_en_list,
>>>
>> g_strdup(en));
>>
>> To preserve the old behavior, can we also check that the
>> number is not on the default_en_list?
> =

> SIM ecc number check with default_en_list is already taken care inside
> set_new_ecc function. =

> =


Thinking some more about it, yes you're absolutely right that it works
out in the end.

It might still be a good idea to use a Hashtable to fake a Set (e.g.
uniqueness) behavior of ECCs.  That would make the driver
implementations a bit simpler as well.

Regards,
-Denis

--===============2128687706079256105==--

