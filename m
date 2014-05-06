Content-Type: multipart/mixed; boundary="===============1346711211634067877=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] sim: Handle multiple invocations of sim_imsi_obtained
Date: Tue, 06 May 2014 17:22:07 +0300
Message-ID: <5368F00F.5040609@jolla.com>
In-Reply-To: <5368E5EA.8070409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1346711211634067877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> To avoid leaking memory and issuing unnecessary D-Bus signals
>> ---
>>   src/sim.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/sim.c b/src/sim.c
>> index edae5eb..1b0cb80 100644
>> --- a/src/sim.c
>> +++ b/src/sim.c
>> @@ -1425,11 +1425,18 @@ static void sim_set_ready(struct ofono_sim *sim)
>>   =

>>   static void sim_imsi_obtained(struct ofono_sim *sim, const char *imsi)
>>   {
>> -	DBusConnection *conn =3D ofono_dbus_get_connection();
>> -	const char *path =3D __ofono_atom_get_path(sim->atom);
>> +	DBusConnection *conn;
>> +	const char *path;
>> +
>> +	if (sim->imsi && !strcmp(sim->imsi, imsi))
>> +		return;
> Calling this function a second time is an error.  So this condition
> looks highly suspect.  What issue are you trying to address?

sim_imsi_obtained() is invoked from two places: sim_imsi_cb() and =

sim_efimsi_cb(). sim_imsi_cb() in turn is a completion for =

sim_retrieve_imsi() which is invoked from 5 other asynchronous =

callbacks, mostly triggered by a number of ofono_sim_read() calls. I =

don't claim that I fully understand what's going on and I haven't =

analyzed all the call sequences but it surely is invoked twice in our =

setup. Any suggestions on where the problem might be?

Thanks,
-Slava

--===============1346711211634067877==--

