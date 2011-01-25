Content-Type: multipart/mixed; boundary="===============6851199293880977583=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: voicecall: behavior of ReleaseAndAnswere with held calls?
Date: Tue, 25 Jan 2011 17:32:18 -0600
Message-ID: <4D3F5D82.4060101@gmail.com>
In-Reply-To: <AANLkTinwec10=fv5sHM4+VeBEcJnQXMAtQva5FPBCV0E@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6851199293880977583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>     Yep, Hangup or HangupMultiparty then SwapCalls.  If you feel that a
>     single operation to accomplish hangup + swap is required we can
>     certainly consider it.  For now it didn't pass our API is Minimal +
>     Complete test.  Perhaps ReleaseAndSwap()...?
> =

> =

> I would go with easy solution by just changing src/voicecall.c line 1418
> =

> static DBusMessage *manager_release_and_answer(DBusConnection *conn,
>                         DBusMessage *msg, void *data)
> {
> ...
> =

> 1418:
> -    if (!voicecalls_have_waiting(vc))
> +    if (!voicecalls_have_waiting(vc) &&

I guess you mean || here.

> !voicecalls_have_with_status(vc, CALL_STATUS_HELD))
>         return __ofono_error_failed(msg);
> =

> ...
>     vc->driver->release_all_active(vc, generic_callback, vc);
> =

>     return NULL;
> }
> =

> This would give ReleaseAndAnswer full functionality of +CHLD=3D1.
> =

> (sorry for pseudo-patch, working temporary on windows machine)
>  =

> =


Anyhow, I don't agree, we want the API to reflect what is going to
happen.  The various scenarios involving CHLD are pretty bizarre and
hard to explain to a developer who hasn't learned 22.030 by heart.

Regards,
-Denis

--===============6851199293880977583==--

