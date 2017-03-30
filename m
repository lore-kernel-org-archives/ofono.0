Content-Type: multipart/mixed; boundary="===============8995168537951461304=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: [PATCH] qmi: track discovery tasks so clean up is possible
Date: Thu, 30 Mar 2017 14:02:49 +0100
Message-ID: <86817f92-4049-8cdd-4d25-299161edcf7f@gmail.com>
In-Reply-To: <3f368714-af1a-c67f-39b1-8f688a365927@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8995168537951461304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 29/03/17 16:11, Denis Kenzior wrote:
> Hi Lukasz,
> =

> Just FYI, we don't like for you to top-post on this mailing list
> =

> On 03/29/2017 06:52 AM, Lukasz Nowak wrote:
>> Hi Denis,
>>
>> I realised last night that I was not freeing the user_data memory.
>>
>> I would propose to modify your code to cover both discovery and shutdown=
. Unify struct discover_data and struct shutdown_data into struct callback_=
data with a union for the func. And then add the shutdown callback to the s=
ame queue.
> =

> The shutdown part is a bit weird.  Right now there's only a single caller=
 that uses qmi_device_shutdown, so I'm not quite sure what was intended by =
the multi-client callback handling.
> =

> My current thinking is that we should simply modify shutdown to follow a =
'first through the gate' semantic.  E.g. the first client that calls shutdo=
wn will get a callback, while the rest will get an error, e.g. -EALREADY.
> =

> That way the shutdown timeout / callback / destroy func can be stored dir=
ectly on struct qmi_device.

I don't think this is the purpose of the shutdown timeout. It is used to wa=
it for all the services to shut down before issuing a user callback.
When a device is being disabled by software, the code will issue several qm=
i_service_unref() for all the services, and then qmi_device_shutdown()
Then shutdown_timeout() will be re-scheduled until all the services close d=
own (device->release_users is decremented in service_release_callback()). O=
nly then shutdown_reply() will trigger gobi.c:shutdown_cb() =


> =

>>
>> It should also be possible to merge your struct discovery into the new s=
truct callback_data, so that we don't have to allocate two structures for e=
ach callback.
>>
> =

> Do you mean to merge discover_data, service_create_data, service_create_s=
hared_data and discovery into the same structure?

I have coded a single structure, with a union for custom fields for each ca=
llback type. And added shutdown callback to the device's callback_queue.

> =

>> Will I modify your patch with that?
>>
> =

> Regardless, feel free to modify.  It might be easier to see the code than=
 discuss it :)
> =

> I haven't tested my patch and it is meant mostly as an RFC.  Feel free to=
 take it the rest of the way.
> =

> Regards,
> -Denis

--===============8995168537951461304==--

