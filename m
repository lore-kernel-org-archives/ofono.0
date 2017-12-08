Content-Type: multipart/mixed; boundary="===============2436836296912437022=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] sim: Handle multiple EFpl read completions
Date: Fri, 08 Dec 2017 15:06:42 +0300
Message-ID: <da2b7def-d4df-952f-3e27-bf3cc5d827f3@jolla.com>
In-Reply-To: <1512666576-28999-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2436836296912437022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Since sim_efli_efpl_changed() can be invoked several times before
> completion of SIM reads (which are not cancellable), followed by
> multiple completions, it's not enough to free old sim->language_prefs
> in sim_efli_efpl_changed(). The same thing has to be done by
> sim_efpl_read_cb() to avoid leaking memory e.g. after this
> sequence of calls:
>
> ...

There are more leaks like this in sim.c, you can expect a few more =

patches if this one gets applied.

Cheers,
-Slava

--===============2436836296912437022==--

