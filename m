Content-Type: multipart/mixed; boundary="===============2822750496512286537=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] huawei: do not set timer more than once
Date: Wed, 19 Jan 2011 11:31:55 -0200
Message-ID: <AANLkTimf_E5JN2g9g=1-EZkQQgjLQRc6kcE-CWjmQhaT@mail.gmail.com>
In-Reply-To: <1295443323.3873.244.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2822750496512286537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 19, 2011 at 11:22 AM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
> Hi Lucas,
>
>> If a "^SYSINFO" arrives after the timer for query_sim_locked() has been
>> set up, it'd would set a new timer, signaling a sim state change more
>> than once.
>> ---
>> =C2=A0plugins/huawei.c | =C2=A0 =C2=A03 ++-
>> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>
> patch looks fine to me and so I applied it.

This fix the double AT+CPIN? command. There's still an issue with a
double AT+CFUN=3D5 that I'm tracking down. I'll send a patch for this
later.


regards,
Lucas De Marchi

--===============2822750496512286537==--

