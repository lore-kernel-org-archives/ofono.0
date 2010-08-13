Content-Type: multipart/mixed; boundary="===============2295307954369141686=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH 1/2] huawei: poll sim state
Date: Fri, 13 Aug 2010 11:11:56 +0300
Message-ID: <87iq3f53ub.fsf@potku.valot.fi>
In-Reply-To: <4C632D8A.2080704@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2295307954369141686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Kalle,

Hi Denis,

> On 08/10/2010 04:57 AM, Kalle Valo wrote:
>
>> In theory it might be possible to do this better, for example follow
>> ^BOOT notifications or something, but it's unknown what parameter we
>> should check for.

Do you know if I can use BOOT messages (or something else) here? Polling
usually creates a load of problems and I would like to avoid it at all
costs.

>> +		/* SIM is not ready, try again a bit later */
>> +		data->query_sim_state =3D
>> +			g_timeout_add_seconds(2, query_sim_state, modem);
>> +	}
>
> Polling the sim state forever might not be a good idea if the SIM is not
> inserted in the first place.  You might want to give up after several
> tries or so.

Good point. I'll add a counter for this (unless I can think of something
else).

-- =

Kalle Valo

--===============2295307954369141686==--

