Content-Type: multipart/mixed; boundary="===============4809192644825452056=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] netmon: modified api.txt for network monitor agent
Date: Thu, 07 Sep 2017 12:30:03 -0500
Message-ID: <da52a7d8-959d-483b-f309-be71a3e34ef2@gmail.com>
In-Reply-To: <989359f1-9639-27ec-b2b2-7cbee320402f@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4809192644825452056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,
> =

> In the Sailfish OS case, one is the positioning helper, and there's the =

> factory test app. That makes it at least two. The factory test app often =

> plays the role of the second client since it's touching pretty much all =

> the important interfaces in the system. And there are 3rd party apps =

> which we don't control.

See? This wasn't that hard ;)

How does the factory test app use this info?  Does it need actual =

periodic updates or can it simply obtain this via the method call?

I'm open to the idea of supporting multiple agents.  We do have to =

figure out who dictates the periodic update interval.  One approach =

might be to have a single master agent and multiple observer agents. =

Feel free to propose something.

Regards,
-Denis

--===============4809192644825452056==--

