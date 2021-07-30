Content-Type: multipart/mixed; boundary="===============6922854745899952690=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Documentation on when to free structures in/after callbacks
Date: Fri, 30 Jul 2021 09:20:56 -0500
Message-ID: <531dafbe-1ab1-2a89-576d-6586f5d42c1b@gmail.com>
In-Reply-To: <20210730132130.2797.52595@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6922854745899952690==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 7/30/21 8:21 AM, ajlennon(a)dynamicdevices.co.uk wrote:
>> I'm not sure what you mean? What exactly do you think needs freeing?
> =

> Strange. I am lookinga at the drivers and sometimes unref functions are p=
rovided into other functions and sometimes not

So you're talking about callbacks in the driver itself, not actually crossi=
ng =

the core<->driver boundary.

There aren't really any docs, but g_at_chat acts just like any other GLib b=
ased =

library (or many main-loop driven C libraries for that matter), so pretty m=
uch =

the same rules apply.  I can give you some hints...

> =

>          if (g_at_chat_send(nmd->chat, "AT+QENG=3D\"servingcell\"", qeng_=
prefix,
>                                  qeng_cb, cbd, req_cb_data_unref) =3D=3D =
0) {
> =

> =


Under the hood, g_at_chat_send puts a request on the queue.  And the reques=
t =

might not be processed until some time later.  It can also be interrupted a=
nd =

cleaned up without the callback being called (if the hardware gets pulled f=
or =

example).  So if you're passing any allocated userdata, you need to provide=
 a =

'destroy' method to de-allocate it, otherwise it will leak.

In your example, cbd is userdata and req_cb_data_unref is the destroy metho=
d, =

respectively.

Oh, and req_cb_data is a common pattern.  It is used where you need to run =

several commands in sequence (think of it as a transaction) and the allocat=
ed =

userdata needs to be cleaned up even if the transaction is interrupted.

> Then these CALLBACK_WITH_FAILURE and CALLBACK_WITH_SUCCESS calls sometime=
s seem to have free functions after them and sometimes not.
> =


There is definitely a reason why they do.  Hopefully the explanation above =
helps.

Regards,
-Denis
--===============6922854745899952690==--

