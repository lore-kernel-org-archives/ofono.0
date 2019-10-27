Content-Type: multipart/mixed; boundary="===============7730849239035582516=="
MIME-Version: 1.0
From: Alexander Akulich <akulichalexander@gmail.com>
Subject: Re: Port ofono-phonesim to Qt5
Date: Sun, 27 Oct 2019 14:42:14 +0300
Message-ID: <CAA1VrPoV-fa1tWRtKy7Z=8snhqs53guS7pG38_RtMrVo3T6c_Q@mail.gmail.com>
In-Reply-To: <9ac19806-579c-c976-7568-0427393ecda3@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7730849239035582516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello devs, Hi Jonah!

I'm also interested in upstreaming Qt5 support, but I'm still not
managed to setup `git send-email`.
I pushed my Qt5 fixes to a branch on github [1] and there is one
'must-have' patch: [2].
Without that patch, phonesim doesn't work on 64-bit platforms.

[1] https://github.com/Kaffeine/phonesim/commits/upstreaming
[2] https://github.com/Kaffeine/phonesim/commit/33ce5700c6352db731ec6859fdd=
1fdefc6671e16

On Sun, Oct 27, 2019 at 3:11 AM Jonah Br=C3=BCchert <jbb.prv@gmx.de> wrot=
e:
>
> The proper url is of course
> https://layers.openembedded.org/layerindex/recipe/32381/. Sorry for the
> truncated one in the first mail.
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
--===============7730849239035582516==--

