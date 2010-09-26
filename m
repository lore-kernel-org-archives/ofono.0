Content-Type: multipart/mixed; boundary="===============7067056484110609186=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/1] Patch Description
Date: Sun, 26 Sep 2010 18:38:32 -0500
Message-ID: <4C9FD978.7050502@gmail.com>
In-Reply-To: <1285343369-10418-1-git-send-email-gyagp0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7067056484110609186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 09/24/2010 10:49 AM, Yang Gu wrote:
> Phonesim is most of time a convenient way to test oFono. For example, it =
can be used to test MO call, as well as MT call. =

> And talking about test area, test automation is quite important regarding=
 to both efficiency and effectiveness. In the test of MO call, scripts can =
be used to interact with oFono via D-Bus to make test automation possible. =
However, in the test of MT call, currently we have to enter the caller numb=
er and click some button in Phonesim GUI to simulate an incoming call, whic=
h makes test automation unrealistic.
> This patch is to enable Qt script (JavaScript following ECMAScript spec) =
in Phonesim, so that we can have some script control its GUI conveniently, =
and satisfy the test automation.
> =


I like this idea

> With this patch, Phonesim can work in the following way:
> 1. It observes some specific directory (/tmp/scripts) to see if there is =
some test scripts added.
> 2. Once Phonesim finds a new test script is added, it will parse and exec=
ute the script.
> 3. You may add more and more test scripts to the specific directory with =
your test goes on.
> =


However, using cp to run scripts seems a bit un-intuitive.  Perhaps a
simple D-Bus interface which can run the scripts would be better?

E.g. something like

org.ofono.Phonesim:

string Run(string script)

where the script contains the script to run and the return value might
return whatever is printed from the script.

Regards,
-Denis

--===============7067056484110609186==--

