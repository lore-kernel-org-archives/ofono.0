Content-Type: multipart/mixed; boundary="===============1880172471719133315=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 00/30] QMI rework
Date: Thu, 29 Mar 2018 10:55:40 -0500
Message-ID: <c171551e-8821-a8fa-3a17-7cac511b4020@gmail.com>
In-Reply-To: <f695ef6f-f5b3-8b96-aa11-af0a652a4e02@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1880172471719133315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/29/2018 05:31 AM, Jonas Bonn wrote:
> On 28/03/18 23:51, Denis Kenzior wrote:
>> Hi Jonas,
>>
>>>
>>> So, that said, this is my attempt at cleaning up service sharing in the
>>> QMI core.=C2=A0 The jist of this is that we switch to a model that look=
s a
>>> bit like file descriptions/descriptors in Linux.=C2=A0 The QMI services
>>> obtain a service description which manages their info and the underlying
>>> connection (client id) state that the 'shared services' actually share.
>>
>> So can you save me the trouble of looking through 30 patches and =

>> describe what the end resulting API is going to look like?
> =

> Right. So this what I'm aiming for:
> =

> QMI Device -> Service1
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0=C2=A0 -> ServiceHandle1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -> ServiceHandle2
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Service2
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0=C2=A0 -> ServiceHandle1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -> ServiceHandle2
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Service3
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0=C2=A0 -> ServiceHandle1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -> ServiceHandle2
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0=C2=A0 -> ServiceHandle3
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -> ServiceHandle4
> =

> ServiceN contains all the shared service data.=C2=A0 This is an underlyin=
g =

> structure; it is not made available directly to any user.
> =

> ServiceHandleN is an service instance that requests can be sent to. =

> Notifications and requests are tied to the ServiceHandle they originate =

> on so that they can be properly cancelled when the ServiceHandle i
> =

> This differs from what ofono has today in that today qmi_service_create =

> returns (effecitvely) a reference counted ServiceN instance. qmi_service =

> is a ServiceN object.=C2=A0 In order to not have to change the API, I wan=
t to =

> push the shared details of the service down a level and make the user =

> visible qmi_service type be a ServiceHandle.

Okay, so essentially GAtChat (ServiceHandle) and at_chat (Service).

> =

> This is effectively the same as what you proposed with a little twist =

> (improvement :) ):
> i)=C2=A0 you wanted to add a list of groups to qmi_service so that groups=
 of =

> notifations/requests could be cancelled independently of other groups: =

> that what ServiceHandle is above, effectively
Note that MBIM doesn't really have a concept of a service that is =

'opened'.  It is just a UUID, so having everything sit on the device =

object and using groups was more convenient.

> ii)=C2=A0 the improvement is making ServiceHandle the user-visible type =

> instead of ServiceN so that user doesn't need to be aware of this =

> grouping or even the fact that the underlying service is shared... =

> things just work

So same as GAtChat, which is essentially a group id and a pointer to the =

underlying object.

> =

> The reason the patch series becomes long is that reworking the layering =

> in this way is a bit intrusive.=C2=A0 It's worth it though, as the end =

> results is _no API change_.=C2=A0 qmi_service_ref becomes a no-op because=
 the =

> ServiceHandles are not shareable; qmi_service_unref becomes effectively =

> free(ServiceHandle).
> =

> The above is sound.=C2=A0 Now we take things further, just for fun, and p=
ut =

> new windows on the house.=C2=A0 Since the above looks like "file =

> descriptions" and "file descriptors" from UNIX, we _could_ use similar =

> terminology.=C2=A0 Just for fun, I proposed a rename:

These are not file descriptors.  You can't cancel an individual send =

request on file descriptors ;)  But anyway, the naming doesn't matter.

> =

> qmi_service_create -> qmi_service_open
> qmi_service_unref -> qmi_service_close
> ...and we drop qmi_service_ref altogether.

We're moving away from reference counting for the most part.  It is a =

glib-ness that we never adopted whole-heartedly and is generally =

pointless in the way oFono is setup.

> =

> Even better would probably be qmi_device_open(device, SERVICE_NAME) =

> because the services (files) live on the device and that's the 'object' =

> we are requesting a service be opend on... but whatever.=C2=A0 The naming =

> isn't important.

I'd just go in the direction of:

uint32_t qmi_device_service_get/open(device, service, callback)
and
qmi_service_free()

Note that the above should be cancellable, otherwise you can crash if =

the atom driver is removed prior to the callback being called.  This is =

a major issue with the existing implementation actually.

> =

> =

>>
>>> On top of this service description we provide service descriptors which
>>> provide private state.=C2=A0 Requests and notifications are registered =
on the
>>> service descriptor and their lifetimes are tied to it; when the service
>>> descriptor is closed (released), the requests and notifications can be
>>> cleaned up without affecting other users of the shared unlying
>>> description.
>>>
>>
>> This sounds an awful lot like what GAtChat does.=C2=A0 Except less flexi=
ble =

>> since you can't unregister or cancel an individual notification/request.
> =

> It doesn't say that anywhere above=C2=A0 Just because I=C2=A0 removed tho=
se =

> _unused_ functions in a patch doesn't mean they are impossible to =

> provide.=C2=A0 If there was _one_ user of such a function then having the=
m =

> makes sense, but since they are totally unused they are just untested cod=
e.
> =


We should still have it, there are countless examples where this =

capability made things much easier to implement certain behavior.  The =

QMI driver might not use this capability now, but you'll be glad you =

have it when you need it.

Regards,
-Denis

--===============1880172471719133315==--

