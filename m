Content-Type: multipart/mixed; boundary="===============5310332476044752605=="
MIME-Version: 1.0
From: Bo <bothebobo@gmail.com>
Subject: Re: basic connection howto
Date: Tue, 08 Sep 2015 21:32:12 +0000
Message-ID: <loom.20150908T220956-760@post.gmane.org>
In-Reply-To: <55E612A7.1040806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5310332476044752605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again,
Now after poking around in the code I realize I might be in trouble.
I'm using devtmpfs

Looks like ofono needs udev for the init of the drivers.

However, I'm going to hack ofono and hardcode my usb dev in ofono =

if i can figure it out.
Not quite sure where I should do that in the src code.

If that fails. I will rebuild my system to use eudev, =

and maybe this is a good time to hear if you =

guys support eudev, or if anyone has tried with that before.

Thanks for any guidance,
Bo



--===============5310332476044752605==--

