Content-Type: multipart/mixed; boundary="===============1051781933303789821=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 07/10] ril: Remove asserts
Date: Tue, 20 Oct 2015 07:31:58 -0500
Message-ID: <5626343E.9070800@gmail.com>
In-Reply-To: <CACM4vuD4e9bpbaDNbp=vmuRpoKHtcf5VJv=HP1Hf7-A5LQfL7A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1051781933303789821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

 >
>     Can we just remove the ril modem in question instead of killing the
>     entire daemon?
>
>
> I think that if we start to do these things we need to add modem watches
> to udev/udevng/rildev as they keep lists with the modems and remove them
> in shutdown. Maybe we could try a modem reset here, within a limited
> number of retries instead?
>

You can always simply call ofono_modem_set_powered here and make sure =

your initialization procedure can re-init all the file-descriptors, etc =

after set_powered(FALSE) -> set_powered(TRUE).

Would be in the end the same as restarting the daemon.

Regards,
-Denis

--===============1051781933303789821==--

