Content-Type: multipart/mixed; boundary="===============1316925133359868648=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei E176 - not online
Date: Sun, 18 Jul 2010 20:42:28 -0500
Message-ID: <4C43AD84.8000207@gmail.com>
In-Reply-To: <20100718201936.GA29262@h02.hostsharing.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1316925133359868648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

<snip>

> The SIM is present, but still PIN code blocked.
> The notify_sim_state function needs be changed.
> =

> pseudo code:
>  If sim_state =3D=3D 0 then =

>    if 'AT+CPIN?' returns 'CPIN: SIM PIN' then
>      sim_state =3D 'present but sim locked'
>    else
>      sim_state =3D 'invalid SIM'
>    endif
>  else if sim_state =3D=3D 255 then
>    sim_state =3D 'SIM not present'
>  endif
> =


I keep forgetting about modems behaving differently with PIN code set.
You are of course correct.  The mbm driver does something very similar
for PIN / SIM inserted logic.  Might be a good template to follow.

Regards,
-Denis

--===============1316925133359868648==--

