Content-Type: multipart/mixed; boundary="===============1704895113604022193=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 16:01:44 -0600
Message-ID: <53179EC8.9090302@gmail.com>
In-Reply-To: <531793F4.3030107@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1704895113604022193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

 > not my job as a middleware developer to design the UI. But in the end
> when it's decided which settings should be per-SIM and which are global,
> I see ofono which I'm already using and which implements persistent
> per-SIM storage, property change notifications and other niceties and
> wish I could just add a few little properties there.

The problem is, oFono _is_ in the business of dictating the UI.  The =

entire project was built on that premise and with that philosophy in =

mind.  It was also made to integrate nicely with sister projects =

(ConnMan, BlueZ, mmsd).

>
> I thought I suggested a simple, flexible and perfectly backward
> compatible solution which would allow to avoid both a) unnecessary
> forking of ofono and b) public arguments about "horrible Android-like
> crap", "you are doing it all wrong", "you don't really need that" and
> such. And yet let people do what they think is right for their own
> project. Doesn't that sound good?

You're free to do what you feel is good for your project, as we are free =

to do what we feel is good for ours.

Regards,
-Denis

--===============1704895113604022193==--

