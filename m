Content-Type: multipart/mixed; boundary="===============1766081039112368313=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/4] isimodem2.5: Changes to add isimodem2.5
Date: Wed, 08 Dec 2010 10:30:04 +0100
Message-ID: <1291800604.4795.151.camel@aeonflux>
In-Reply-To: <1291797294-20554-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1766081039112368313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

> Updates in Makefile.am - adding of isimodem2.5
> Adding of drivers/isimodem2.5/ files to fully listed functionality.
> =

> Regards,
> Jessica Nilsson
> =

> ---
>  Makefile.am                                |   36 +-
>  drivers/isimodem2.5/call-barring.c         |  503 ++
>  drivers/isimodem2.5/call-forwarding.c      |  613 +++
>  drivers/isimodem2.5/call-settings.c        | 1093 +++++
>  drivers/isimodem2.5/call.h                 |  237 +
>  drivers/isimodem2.5/cbs.c                  |  433 ++
>  drivers/isimodem2.5/checkpatch.pl          | 2789 ++++++++++++
>  drivers/isimodem2.5/debug.c                |  694 +++
>  drivers/isimodem2.5/debug.h                |   66 +
>  drivers/isimodem2.5/devinfo.c              |  246 +
>  drivers/isimodem2.5/gpds-context.c         |  788 ++++
>  drivers/isimodem2.5/gpds.c                 |  395 ++
>  drivers/isimodem2.5/gpds.h                 |  295 ++
>  drivers/isimodem2.5/gss.h                  |   84 +
>  drivers/isimodem2.5/info.h                 |   53 +
>  drivers/isimodem2.5/isimodem.c             |  534 +++
>  drivers/isimodem2.5/isimodem.h             |   69 +
>  drivers/isimodem2.5/isiutil.h              |   64 +
>  drivers/isimodem2.5/mce.h                  |   65 +
>  drivers/isimodem2.5/network-registration.c | 1158 +++++
>  drivers/isimodem2.5/network.h              |  257 ++
>  drivers/isimodem2.5/phonebook.c            | 1320 ++++++
>  drivers/isimodem2.5/radio-settings.c       |  313 ++
>  drivers/isimodem2.5/simu_resps.h           | 6800 ++++++++++++++++++++++=
++++++
>  drivers/isimodem2.5/sms.c                  |  869 ++++
>  drivers/isimodem2.5/sms.h                  |  188 +
>  drivers/isimodem2.5/ss.h                   |  174 +
>  drivers/isimodem2.5/ssn.c                  |  456 ++
>  drivers/isimodem2.5/timeout.h              |   33 +
>  drivers/isimodem2.5/uicc.c                 | 3316 ++++++++++++++
>  drivers/isimodem2.5/uicc.h                 |  253 ++
>  drivers/isimodem2.5/uicc_interface.h       |   40 +
>  drivers/isimodem2.5/ussd.c                 |  341 ++
>  drivers/isimodem2.5/voicecall.c            | 1555 +++++++
>  34 files changed, 26128 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/isimodem2.5/call-barring.c
>  create mode 100644 drivers/isimodem2.5/call-forwarding.c
>  create mode 100644 drivers/isimodem2.5/call-settings.c
>  create mode 100644 drivers/isimodem2.5/call.h
>  create mode 100644 drivers/isimodem2.5/cbs.c
>  create mode 100755 drivers/isimodem2.5/checkpatch.pl
>  create mode 100644 drivers/isimodem2.5/debug.c
>  create mode 100644 drivers/isimodem2.5/debug.h
>  create mode 100644 drivers/isimodem2.5/devinfo.c
>  create mode 100644 drivers/isimodem2.5/gpds-context.c
>  create mode 100644 drivers/isimodem2.5/gpds.c
>  create mode 100644 drivers/isimodem2.5/gpds.h
>  create mode 100644 drivers/isimodem2.5/gss.h
>  create mode 100644 drivers/isimodem2.5/info.h
>  create mode 100644 drivers/isimodem2.5/isimodem.c
>  create mode 100644 drivers/isimodem2.5/isimodem.h
>  create mode 100644 drivers/isimodem2.5/isiutil.h
>  create mode 100644 drivers/isimodem2.5/mce.h
>  create mode 100644 drivers/isimodem2.5/network-registration.c
>  create mode 100644 drivers/isimodem2.5/network.h
>  create mode 100644 drivers/isimodem2.5/phonebook.c
>  create mode 100644 drivers/isimodem2.5/radio-settings.c
>  create mode 100644 drivers/isimodem2.5/simu_resps.h
>  create mode 100644 drivers/isimodem2.5/sms.c
>  create mode 100644 drivers/isimodem2.5/sms.h
>  create mode 100644 drivers/isimodem2.5/ss.h
>  create mode 100644 drivers/isimodem2.5/ssn.c
>  create mode 100644 drivers/isimodem2.5/timeout.h
>  create mode 100644 drivers/isimodem2.5/uicc.c
>  create mode 100644 drivers/isimodem2.5/uicc.h
>  create mode 100644 drivers/isimodem2.5/uicc_interface.h
>  create mode 100644 drivers/isimodem2.5/ussd.c
>  create mode 100644 drivers/isimodem2.5/voicecall.c

this is not gonna work this way. No one can review such a massive patch.
Actually Evolution even refused to format this for me.

So please split this into one patch per atom driver.

In addition, I don't a point in a filename. So isimodem25 or isimodem2
or something like that please. I am open for proposals.

Regards

Marcel



--===============1766081039112368313==--

