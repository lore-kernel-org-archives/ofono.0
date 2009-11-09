Content-Type: multipart/mixed; boundary="===============4649565587882138883=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: netlink.c:97: error: cast increases required alignment of target
 type
Date: Mon, 09 Nov 2009 18:34:36 +0100
Message-ID: <fb249edb0911090934p7c1f693ag62abda1d84999430@mail.gmail.com>
In-Reply-To: <200911091927.04309.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4649565587882138883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/11/9 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
> Le lundi 9 novembre 2009 17:45:25 andrzej zaborowski, vous avez =C3=A9cri=
t :
>> Hi,
>> resurrecting this thread because I think there's no reason ofono
>> should not build on cpus with strict alignment rules, the netlink code
>> is actually aligned correctly. =C2=A0These warnings are a result of
>> -Wcast-align, the compiler can't know that the casts in the macros are
>> safe, but they obviously are if you look at the arithmetics there. =C2=
=A0In
>> the case of the netlink warnings they can be turned off for all users
>> of <linux/netlink.h> using a pragma or only for this cast by casting
>> to void * first (the only way according to gcc people), the first
>> attached file adds them (against linux), I'll send it to linux if
>> there's no better idea. =C2=A0There are also similar warnings when casti=
ng
>> struct sockaddr_pn * to struct sockaddr * and these can be worked
>> around in ofono, see second patch, but probably should also be in
>> linux's include/linux/phonet.h instead.
>
> Why do you change the sockaddr_pn type name?!

Because it's been defined without explicit alignment and I don't think
you can redefine it with the same name?

Regards

--===============4649565587882138883==--

