Content-Type: multipart/mixed; boundary="===============0518091914250314040=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 3/3] gemalto: Use sim_state_query for sim detection
Date: Tue, 18 Apr 2017 10:09:34 -0500
Message-ID: <3c560e32-616d-8432-29e7-bdaf953d9a5d@gmail.com>
In-Reply-To: <1219d5cf2e72c5e742409833bae7238a@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0518091914250314040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

>> what does this do?  Also, shouldn't you be issuing some sort of CFUN
>> as well here?  There's no guarantee that .set_online will be called
>> first.
>
> AT^SMSO shuts down the modem. I want a real power off, not just offline.
> Is ".disable" the good place to handle power state? I noticed other plugi=
ns
> just send CFUN=3DX in ".disable", but in this case how would you handle t=
he
> "SMSO" command to really power off the modem?
>

For some reason I asssumed SMSO had something to do with SMS :)

If SMSO shuts down the device, then this is fine to put in .disable. =

I've never seen any device use a custom command for this, it has =

generally been CFUN=3D0.  You can disregard my earlier comment.

Regards,
-Denis


--===============0518091914250314040==--

