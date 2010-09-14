Content-Type: multipart/mixed; boundary="===============1598709535114303094=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix common misspellings
Date: Tue, 14 Sep 2010 10:35:54 +0900
Message-ID: <1284428154.2405.29.camel@localhost.localdomain>
In-Reply-To: <1284427973-22306-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1598709535114303094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> Apply to all files the list of common misspellings found at
> http://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_m=
achines.
> =

> From the list cited above, the substitution found the following
> misspellings:
> =

> accomodate->accommodate
> fomr->from
> priviledge->privilege
> proprietory->proprietary
> reponsible->responsible
> seperately->separately
> subsidary(-ies)->subsidiary(-ies)
> succeded->succeeded
> targetted->targeted
> transfering->transferring
> witheld->withheld
> withold->withhold
> =

> Signed-off-by: Lucas De Marchi <lucas.demarchi@profusion.mobi>

no signed-off-by please. We don't use it.

> ---
>  TODO                            |    4 ++--
>  doc/call-settings-api.txt       |    6 +++---
>  doc/ofono-paper.txt             |    4 ++--
>  doc/voicecallmanager-api.txt    |    2 +-
>  drivers/atmodem/voicecall.c     |    2 +-
>  drivers/hfpmodem/voicecall.c    |    2 +-
>  drivers/isimodem/gpds.h         |    2 +-
>  drivers/isimodem/gprs-context.c |    2 +-
>  drivers/isimodem/gprs.c         |    2 +-
>  drivers/stemodem/voicecall.c    |    2 +-
>  gatchat/gatppp.c                |    2 +-
>  gatchat/gsmdial.c               |    2 +-
>  gatchat/test-server.c           |    2 +-
>  gisi/client.c                   |    2 +-
>  gisi/server.c                   |    2 +-
>  src/util.c                      |    2 +-
>  16 files changed, 20 insertions(+), 20 deletions(-)

While in general I am all for fixing spelling mistakes, but you need to
break this down into logical chunks. Just doing a mega patch that does
changes all over the place is not working out.

Regards

Marcel



--===============1598709535114303094==--

