Content-Type: multipart/mixed; boundary="===============1021169265335720283=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC PATCH 3/5] voicecall: implement SSN handling functions
Date: Mon, 14 Mar 2011 09:30:05 +0200
Message-ID: <4D7DC3FD.1060401@nokia.com>
In-Reply-To: <4D7A7DDD.5000703@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1021169265335720283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/11/2011 09:54 PM, ext Denis Kenzior wrote:
> Hi Andras,
>
>> +static struct voicecall *voicecall_select(struct ofono_voicecall *vc,
>> +						unsigned int id, int code)
>> +{
>> +	struct voicecall *v =3D NULL;
>> +	GSList *l;
>> +
>> +	if (id !=3D 0) {
>> +		l =3D g_slist_find_custom(vc->call_list, GUINT_TO_POINTER(id),
>> +				call_compare_by_id);
>> +
>> +		if (l =3D=3D NULL)
>> +			return NULL;
>> +
>> +		v =3D l->data;
>> +	} else if (g_slist_length(vc->call_list) =3D=3D 1) {
>> +		v =3D vc->call_list->data;
>> +
>> +		switch (code) {
>> +		case SS_MT_VOICECALL_RETRIEVED:
>> +			if (v->remote_held !=3D TRUE)
>> +				return NULL;
>> +			break;
>> +		case SS_MT_VOICECALL_ON_HOLD:
>> +			if (v->remote_held =3D=3D TRUE)
>> +				return NULL;
>> +			break;
>> +		case SS_MT_MULTIPARTY_VOICECALL:
>> +			if (v->remote_multiparty =3D=3D TRUE)
>> +				return NULL;
>> +			break;
>> +		default:
>> +			return NULL;
>> +		}
> I was mostly fine with this patch, but didn't see the real need in these
> checks, so I re-factored the patch slightly afterward.  Let me know if I
> broke something.
>

I am fine with your simplified version, I was a bit overly cautious
with those checks. Thanks!

>> +	}
>> +
>> +	return v;
>> +}
>> +
> Regards,
> -Denis

Regards,
Andras

--===============1021169265335720283==--

