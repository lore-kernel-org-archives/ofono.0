Content-Type: multipart/mixed; boundary="===============4919060841750742193=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono crashes on SIM notifications
Date: Wed, 28 Feb 2018 11:36:54 -0600
Message-ID: <6b1e3c28-fc4d-fad1-e99b-2b93989948f7@gmail.com>
In-Reply-To: <HE1PR1001MB1113A47ADBDD840B3527DCB396C70@HE1PR1001MB1113.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4919060841750742193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mattias,

On 02/28/2018 04:01 AM, Mattias M=C3=A5nsson wrote:
> Hi!
> =

> =

> I'm working with integrating a new Gemalto modem with Ofono and is =

> currently working with dynamic SIM card detection. This is not done by =

> any included driver what I can see, so it is possible I have done =

> something wrong. Anyway, I am listening to SIM card URCs and when I get =

> one, I call ofono_sim_inserted_notify with the proper state. This seems =

> to work fine at first, but if I do the following, I get a crash:

Plenty of drivers support this actually.  plugins/ifx.c for example or =

plugins/phonesim.c

> =

> =

>  1. Insert SIM
>  2. Remove SIM
>  3. Insert SIM
>  4. Remove SIM
> =


So I tested this with phonesim and could replicate the issue easily.  I =

pushed a bunch of fixes upstream which takes care of this and some =

memory leaks as well.  These were introduced recently by the =

SimAuthentication API related changes.

> =

> In this case I get a SIGABRT in src/sim.c:aid_session_free(). It seems =

> as it tries to free that list sim->aid_sessions, but it has just been =

> freed before. However, after freeing it the first time, it is never set =

> to NULL, so the second time the NULL check doesn't take it and crash. I =


Right, this is the correct fix...

> tried setting it to NULL, but then I realized that it is used in =

> __ofono_sim_remove_session_watch() without allocating it again. So it =

> seems that there is a chain of problems. Any ideas?
> =


This seems fine to me, the session should be re-allocated when =

discover_apps_cb is called after SIM insertion / initialization.

<snip>

> =

> It has also crashed in other parts of sim.c as well as in simfs.c, so =

> I'm starting to doubt it can really handle spontaneous SIM card =

> notifications...
> =


oFono should handle SIM removal / re-insertion just fine.  If you =

encounter issues, please report these and we'll have them fixed.

Regards,
-Denis

--===============4919060841750742193==--

