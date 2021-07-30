Content-Type: multipart/mixed; boundary="===============9059427917752827701=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Documentation on when to free structures in/after callbacks
Date: Fri, 30 Jul 2021 09:30:30 -0500
Message-ID: <3412c190-8249-b906-6172-df73d03a7086@gmail.com>
In-Reply-To: <20210730142448.2797.36519@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9059427917752827701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 7/30/21 9:24 AM, ajlennon(a)dynamicdevices.co.uk wrote:
> Thanks Denis that helps. I see I need to learn a bit and get my head arou=
nd this.
> =

> For example I find this really confusing:
> =

>    cbd =3D req_cb_data_ref(cbd);
>          if (g_at_chat_send(nmd->chat, "AT+CESQ", cesq_prefix,
>                                  cesq_cb, cbd, req_cb_data_unref) =3D=3D =
0) {
>                  CALLBACK_WITH_FAILURE(cbd->cb, cbd->data);
>                  req_cb_data_unref(cbd);
>          }
> =

> This does some kind of allocation - ok
> This makes the call - ok fine
> Provides the unref function into the call - ok so far
> =


So in this particular case, g_at_chat_send() returning 0 means the command =
could =

not be scheduled for whatever reason (usually the tty port is dead).  By =

convention, failures do not side-effect.  So you have to free any allocated =

resources manually.  Hence the unref here.

> But then I'm thinking if the call _succeeds_ our unref gets called?

Yes.  destroy callback is called in every circumstance once g_at_chat_send(=
) =

returns a success.  So it will get called after cesq_cb(), or if the reques=
t is =

cleaned up early (cesq_cb() never called)

> But if our call _fails_ then we have to do the unref ourselves?

Right, the 'no-side-effect' part applies.

Regards,
-Denis
--===============9059427917752827701==--

