Content-Type: multipart/mixed; boundary="===============5658541015750437154=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: provisioning APN using mbpi plugin
Date: Thu, 16 Feb 2017 12:02:33 -0600
Message-ID: <37f5cc31-9dc8-a46d-9595-1c42d7658bd7@gmail.com>
In-Reply-To: <b435fea5-d7f4-dfcb-e53d-f33ff9fe9f92@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5658541015750437154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

> So I have developed another provisioning plugin based on a configuration
> file. Patches are attached to this mail and plugin details are explained
> in commit message. Let me know if you think this can be useful for
> ofono. I'll rework patches in this case (plugin name maybe,

What you have done is exactly why we have provisioning plugins.  mbpi is =

not the best database in the world.  Especially if you're shipping a =

niche device and know your settings / operators ahead of time.

> documentation needed maybe, can I use storage.c functions in a
> plugin?....) and send them cleanly using git send-email.

I'm fine carrying this upstream if you want.  Generally storage is not =

meant to be used outside the core.  Nor is there a big advantage for you =

to use these functions anyway.  So maybe convert storage_open/close to =

simple open/close calls would be enough.

Regards,
-Denis

--===============5658541015750437154==--

