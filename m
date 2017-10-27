Content-Type: multipart/mixed; boundary="===============1629938251714481925=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] sim: Move atom registration to the end of
 ofono_sim_register
Date: Fri, 27 Oct 2017 18:49:39 +0300
Message-ID: <96169c0e-74b5-070d-1931-1bd1a6fecc89@jolla.com>
In-Reply-To: <0e39cdc6-7c4b-c773-0019-69a4849c3527@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1629938251714481925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 27/10/17 16:56, Denis Kenzior wrote:
> Hi Slava,
>
> On 10/27/2017 08:15 AM, Slava Monich wrote:
>> The state needs to be checked prior to calling __ofono_atom_register
>> because atom registration calls OFONO_ATOM_WATCH_CONDITION_REGISTERED
>> callbacks each of which may call ofono_sim_inserted_notify. Should
>> that happen, by the time __ofono_atom_register returns, ofono_sim
>> will be in OFONO_SIM_STATE_INSERTED state and sim_initialize will
>> be called twice if the initial state was OFONO_SIM_STATE_NOT_PRESENT.
>
> Okay, can you tell me why you would have such a setup? sim_inserted is =

> generally either called from the modem driver or when an unsolicited =

> notification occurs.=C2=A0 Not when the sim atom is registered.
>

For the reasons too long to explain, I already know the SIM state by the =

time I register the SIM atom (or even the modem). I could work around =

this problem by delaying ofono_sim_inserted_notify call or partially =

duplicating the logic in my modem driver, but if the core can handle my =

setup, that's even better.

Thanks,

-Slava

--===============1629938251714481925==--

