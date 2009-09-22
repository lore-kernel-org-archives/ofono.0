Content-Type: multipart/mixed; boundary="===============1337276266923441836=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] [RFC] Do the PIN check in SIMManager
Date: Tue, 22 Sep 2009 00:12:29 -0500
Message-ID: <200909220012.29847.denkenz@gmail.com>
In-Reply-To: <fb249edb0909171157w3b00b220o2538793c09016d81@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1337276266923441836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> And here's a version that implements most of what's specified in
> doc/sim-api.txt.  There are two caveats: when you re-enable SIM PIN

Patch has been applied, thanks.

> authentication, you have to give the old password from before it was
> changed to "", i.e to disable and enable SIM PIN, do:
> SimManager.ChangePin("pin", "1234", "")
> SimManager.ChangePin("pin", "1234", "1234")
>
> rather than the more logical
>
> SimManager.ChangePin("pin", "1234", "")
> SimManager.ChangePin("pin, "", "1234)
>
> The other problem is that if changing the password succeeds but
> enabling authentiation fails, ChangePin still returns failure

I added LockPin and UnlockPin methods to take care of these two cases.

Regards,
-Denis

--===============1337276266923441836==--

