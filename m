Content-Type: multipart/mixed; boundary="===============8608249192528918466=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Segmentation fault
Date: Fri, 07 Aug 2009 20:15:50 -0500
Message-ID: <200908072015.51768.denkenz@gmail.com>
In-Reply-To: <4A7BB877.8010709@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8608249192528918466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> Here is a small script which can be used to test this. With Nokia E51 it
> always segfaults before the 100 is reached. Sometimes it is able to do
> sequence multiple times and sometimes only create-destroy-create is enoug=
h.
>

I seem to have fixed this issue, it was related to a g_source(s) that were =

never being cleaned up.  =


I've now run the script twice (fun to have 100 phonesim windows popping up) =

and have not encountered a segfault.

Please report back if this is still broken.

Regards,
-Denis

--===============8608249192528918466==--

