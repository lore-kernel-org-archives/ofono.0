Content-Type: multipart/mixed; boundary="===============2162811045283752002=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] stemodem: Add support for multiple pdp contexts.
Date: Fri, 18 Feb 2011 10:00:44 -0800
Message-ID: <1298052044.2519.30.camel@aeonflux>
In-Reply-To: <1297163868-27859-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2162811045283752002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

> Redesigned, there will be only one contexts for each instance of
> the driver and only one CAIF interface, no longer need the list
> of caif devices.
> ---
>  drivers/stemodem/gprs-context.c |  273 ++++++++-------------------------=
------
>  1 files changed, 57 insertions(+), 216 deletions(-)

it does not compile cleanly.

  CC     drivers/stemodem/gprs-context.o
cc1: warnings being treated as errors
drivers/stemodem/gprs-context.c: In function =E2=80=98ste_gprs_context_prob=
e=E2=80=99:
drivers/stemodem/gprs-context.c:382:20: error: cast from pointer to integer=
 of different size

Regards

Marcel



--===============2162811045283752002==--

