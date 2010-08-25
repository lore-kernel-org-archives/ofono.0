Content-Type: multipart/mixed; boundary="===============8852417256262770139=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Ensure to call sim_pin_check
Date: Wed, 25 Aug 2010 10:06:53 -0500
Message-ID: <4C75318D.4070906@gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4732A51663E@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8852417256262770139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> Your solution is better than mine, and might be Denis' intention of modif=
ication. Honestly, I ever thought about the change like your proposal (Actu=
ally it was the same as ppessi's patch), but I had a concern on current cod=
e. Now we read EFli and EFpl in parallel. Is it guaranteed the callback of =
EFli will be called before the callback of EFpl? IMO, it can't always guara=
ntee this. If I'm correct, your solution is just half way to the final targ=
et. Maybe we need to work out a better one:)

Please note that the ofono_sim_read functions do not work in parallel.
All file operations are added to a queue and executed sequentially.
Hence we can rely on a certain order here.

Regards,
-Denis

--===============8852417256262770139==--

