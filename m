Content-Type: multipart/mixed; boundary="===============7746730845909144555=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] huawei: postpone post_sim until SIM is ready
Date: Fri, 13 Aug 2010 10:38:45 -0500
Message-ID: <4C656705.1030902@gmail.com>
In-Reply-To: <87eie353p2.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7746730845909144555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

On 08/13/2010 03:15 AM, Kalle Valo wrote:
> Hi Denis,
> =

> Denis Kenzior <denkenz@gmail.com> writes:
> =

>> So this problem affects multiple modem families and I think we should
>> solve it a bit better.  What I'm proposing is to introduce a new
>> function to include/sim.h.  Something like:
>>
>> void ofono_sim_ready_notify(struct ofono_sim *sim);
>>
>> The way it should work is as follows:
>>
>> When oFono determines the SIM PIN is READY, it checks whether
>> ofono_sim_ready_notify has been called.  If it hasn't, then it stalls
>> the initialization procedure (and calling post_sim) until
>> ofono_sim_ready_notify is called.
>>
>> This way if the SIM is not PIN locked, the driver can call sim_inserted
>> and sim_ready at once.  If the PIN is locked, the driver can notify
>> sim_ready later.
> =

> Sounds good to me. Do you want to implement it? ;) I'm a bit busy right
> now and it might take some time before I can find time for this.
> =


I'm a bit swamped at the moment.  I have added a TODO task for this
feature so we don't forget.

Regards,
-Denis

--===============7746730845909144555==--

