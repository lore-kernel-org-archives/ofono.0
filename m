Content-Type: multipart/mixed; boundary="===============4765968037473707942=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/9] sim: Implement basic Refresh.
Date: Sat, 19 Feb 2011 05:18:50 +0100
Message-ID: <AANLkTinZ=2gHvmQnRukrcN9Kd7VQDDv1GJAN895_xsOS@mail.gmail.com>
In-Reply-To: <4D5D8D05.60403@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4765968037473707942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 17 February 2011 22:03, Denis Kenzior <denkenz@gmail.com> wrote:
> On 02/15/2011 01:58 AM, Andrzej Zaborowski wrote:
>> ---
>> =C2=A0src/ofono.h | =C2=A0 =C2=A04 ++
>> =C2=A0src/sim.c =C2=A0 | =C2=A0163 +++++++++++++++++++++++++++++++++++++=
+++++++++++++++++----
>> =C2=A02 files changed, 155 insertions(+), 12 deletions(-)
>>
>
> Patch has been applied, but some comments below:
>
>> + =C2=A0 =C2=A0 if (reinit_naa) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Force the sim state out o=
f READY */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim_free_main_state(sim);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sim->state =3D OFONO_SIM_STA=
TE_INSERTED;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (l =3D sim->state_watche=
s->items; l; l =3D l->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct ofono_watchlist_item *item =3D l->data;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
notify =3D item->notify;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
notify(sim->state, item->notify_data);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> I changed this to directly call the modem object and force it into
> pre-sim state. =C2=A0I think this is a bit more clear than your proposed
> approach.

Looks good to me, maybe it would be even better if this was just a
different type of sim state change, like OFONO_SIM_STATE_NOT_READY so
it is handled in a similar way as other events.

>
> Another question here is whether we want to maintain two separate simfs
> contexts. =C2=A0One for the main state and one for the early state. =C2=
=A0This
> might make things a bit easier to implement for patch 3 in this series.

I was thinking about that too, I'll send a patch to implement this.

Best regards

--===============4765968037473707942==--

