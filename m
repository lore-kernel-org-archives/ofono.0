Content-Type: multipart/mixed; boundary="===============7833431612916917977=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [RFC PATCH 00/30] QMI rework
Date: Thu, 29 Mar 2018 18:43:27 +0200
Message-ID: <481f4b9b-f771-4ab2-80b6-191b4c7c8097@southpole.se>
In-Reply-To: <c171551e-8821-a8fa-3a17-7cac511b4020@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7833431612916917977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 29/03/18 17:55, Denis Kenzior wrote:
>
>> This is effectively the same as what you proposed with a little twist =

>> (improvement :) ):
>> i)=C2=A0 you wanted to add a list of groups to qmi_service so that group=
s =

>> of notifations/requests could be cancelled independently of other =

>> groups: that what ServiceHandle is above, effectively
> Note that MBIM doesn't really have a concept of a service that is =

> 'opened'.=C2=A0 It is just a UUID, so having everything sit on the device =

> object and using groups was more convenient.

I don't know enough about MBIM... the UUID could just live in the =

"shared" object and the service reference like it I've described above, =

right?
>>
>> qmi_service_create -> qmi_service_open
>> qmi_service_unref -> qmi_service_close
>> ...and we drop qmi_service_ref altogether.
>
> We're moving away from reference counting for the most part.=C2=A0 It is =
a =

> glib-ness that we never adopted whole-heartedly and is generally =

> pointless in the way oFono is setup.

Good to know.

>
>>
>> Even better would probably be qmi_device_open(device, SERVICE_NAME) =

>> because the services (files) live on the device and that's the =

>> 'object' we are requesting a service be opend on... but whatever.=C2=A0 =

>> The naming isn't important.
>
> I'd just go in the direction of:
>
> uint32_t qmi_device_service_get/open(device, service, callback)
> and
> qmi_service_free()
>

OK.



> Note that the above should be cancellable, otherwise you can crash if =

> the atom driver is removed prior to the callback being called. This is =

> a major issue with the existing implementation actually.
>
Yes, I saw this, too.

There doesn't seem to be timeouts set on QMI requests either.=C2=A0 That =

should be part of the core protocol handling.=C2=A0 The whole "struct =

discovery" bit of the code seems to be a way of providing timeouts for =

some initial interaction with the device... after that, things are =

expected to just work.

>>
>> It doesn't say that anywhere above=C2=A0 Just because I=C2=A0 removed th=
ose =

>> _unused_ functions in a patch doesn't mean they are impossible to =

>> provide.=C2=A0 If there was _one_ user of such a function then having th=
em =

>> makes sense, but since they are totally unused they are just untested =

>> code.
>>
>
> We should still have it, there are countless examples where this =

> capability made things much easier to implement certain behavior. The =

> QMI driver might not use this capability now, but you'll be glad you =

> have it when you need it.

Yes, agreed.=C2=A0 I=C2=A0 already added them back in my code... even thoug=
h they =

don't have users.

/Jonas
>
> Regards,
> -Denis


--===============7833431612916917977==--

