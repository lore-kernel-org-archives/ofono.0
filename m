Content-Type: multipart/mixed; boundary="===============2568463187642457810=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] voicecall: api for set/clear alpha and icon id
Date: Fri, 15 Jul 2011 12:36:47 -0500
Message-ID: <4E207AAF.5050302@gmail.com>
In-Reply-To: <62556.10.254.189.70.1310750695.squirrel@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2568463187642457810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 07/15/2011 12:24 PM, jeevaka.badrappan(a)linux.intel.com wrote:
> Hi Denis,
> =

>>> +
>>> +	number =3D phone_number_to_string(&req->ph);
>>> +
>>> +	if (!strcmp(number, "112")) {
>>> +		struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>>> +
>>> +		__ofono_modem_inc_emergency_mode(modem);
>>> +	}
>>
>> I think we should do this step in the block of code in
>> ofono_voicecall_notify dealing with modem callsetup.  See below for more:
> =

> Emergency mode for all other dial(user initiated, ofono handled setup
> call) has been activated before we issue dial request to modem. Also I
> believe its better to activate it here rather than in
> ofono_voicecall_notify.
> =


This is debatable since the real world result on the IFX modem is that
we activate emergency mode 15 ms earlier than we otherwise would, but
might cause funny behavior out of our control (for example, if STK
attempts an emergency call while offline, we just flip EmergencyMode to
true & back and go nowhere)

However, in the end I'm fine doing it this way, you just need to make
sure that the logic in clear_alpha_and_icon_id can handle this case.

Regards,
-Denis

--===============2568463187642457810==--

