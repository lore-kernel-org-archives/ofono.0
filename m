Content-Type: multipart/mixed; boundary="===============6510775889629577142=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Thu, 03 Apr 2014 16:40:56 -0500
Message-ID: <533DD568.9080807@gmail.com>
In-Reply-To: <533D2CD5.8010809@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6510775889629577142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,
>
> Indeed, and this combined with commit 5f765259 one can easily run a
> series of tests (let's say dialer UI, messaging..) with different
> phonesim configurations changing the number of modems and phonesim .xml
> files for each modem.

I see what you needed that commit for now.  While I can kind of see your
usecase, I really wonder whether simply creating a large phonesim.conf
and grouping modems there would be a less intrusive way to get what you
want.

Phonesim can have an arbitrary number of instances (I once tested 100 at
once), and one can assign an object path using phonesim.conf.  Your test
application can then find such groupings and accomplish essentially the
same thing as you're trying to do now.

Regards,
-Denis


--===============6510775889629577142==--

