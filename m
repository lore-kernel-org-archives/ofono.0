Content-Type: multipart/mixed; boundary="===============2397990518235808940=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How does ofono work
Date: Fri, 14 Feb 2014 13:20:13 -0600
Message-ID: <52FE6C6D.2040306@gmail.com>
In-Reply-To: <CAK+sfov2mrkyta6aSn2nzu+p=EFMJWK4gC3ZmuR1JNgCmVOmKA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2397990518235808940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Homam,

 > It is working well on Ubuntu (linux 3.2.0-58-generic) but not on my
> embedded SIgma platform (linux 2.6.35)

That kernel is over 3 years old.  The kernel driver setup may be =

completely different.

> On the Sigma platform, it seems like the huawei plugin functions in
> huawei.c are not being called as on the ubuntu platform.
>
> So the question is how are those functions in huawei.c being called?

They are triggered by udev events inside plugins/udevng.c  You will need =

to analyze what is happening on your platform.  Most likely the kernel =

driver that is creating the tty nodes for the modem is not in the list =

of drivers udevng plugin recognizes for the hardware.

Regards,
-Denis

--===============2397990518235808940==--

