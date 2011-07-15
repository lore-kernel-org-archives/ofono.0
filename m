Content-Type: multipart/mixed; boundary="===============6609258965278243322=="
MIME-Version: 1.0
From: jeevaka.badrappan@linux.intel.com
Subject: Re: [PATCH 2/4] voicecall: api for set/clear alpha and icon id
Date: Fri, 15 Jul 2011 10:24:55 -0700
Message-ID: <62556.10.254.189.70.1310750695.squirrel@linux.intel.com>
In-Reply-To: <4E2065EE.7010902@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6609258965278243322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> +
>> +	number =3D phone_number_to_string(&req->ph);
>> +
>> +	if (!strcmp(number, "112")) {
>> +		struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>> +
>> +		__ofono_modem_inc_emergency_mode(modem);
>> +	}
>
> I think we should do this step in the block of code in
> ofono_voicecall_notify dealing with modem callsetup.  See below for more:

Emergency mode for all other dial(user initiated, ofono handled setup
call) has been activated before we issue dial request to modem. Also I
believe its better to activate it here rather than in
ofono_voicecall_notify.

Regards,
Jeevaka

--===============6609258965278243322==--

