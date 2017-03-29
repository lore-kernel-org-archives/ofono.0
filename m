Content-Type: multipart/mixed; boundary="===============1296806156493183560=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmi: track discovery tasks so clean up is possible
Date: Wed, 29 Mar 2017 10:11:50 -0500
Message-ID: <3f368714-af1a-c67f-39b1-8f688a365927@gmail.com>
In-Reply-To: <5d82876b-75f0-6ff0-29f1-3af89133382e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1296806156493183560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

Just FYI, we don't like for you to top-post on this mailing list

On 03/29/2017 06:52 AM, Lukasz Nowak wrote:
> Hi Denis,
>
> I realised last night that I was not freeing the user_data memory.
>
> I would propose to modify your code to cover both discovery and shutdown.=
 Unify struct discover_data and struct shutdown_data into struct callback_d=
ata with a union for the func. And then add the shutdown callback to the sa=
me queue.

The shutdown part is a bit weird.  Right now there's only a single =

caller that uses qmi_device_shutdown, so I'm not quite sure what was =

intended by the multi-client callback handling.

My current thinking is that we should simply modify shutdown to follow a =

'first through the gate' semantic.  E.g. the first client that calls =

shutdown will get a callback, while the rest will get an error, e.g. =

-EALREADY.

That way the shutdown timeout / callback / destroy func can be stored =

directly on struct qmi_device.

>
> It should also be possible to merge your struct discovery into the new st=
ruct callback_data, so that we don't have to allocate two structures for ea=
ch callback.
>

Do you mean to merge discover_data, service_create_data, =

service_create_shared_data and discovery into the same structure?

> Will I modify your patch with that?
>

Regardless, feel free to modify.  It might be easier to see the code =

than discuss it :)

I haven't tested my patch and it is meant mostly as an RFC.  Feel free =

to take it the rest of the way.

Regards,
-Denis

--===============1296806156493183560==--

