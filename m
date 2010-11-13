Content-Type: multipart/mixed; boundary="===============7698719368518585780=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v5b 1/3] stemodem: Fix for error handling,
 memleak and changed some defines
Date: Sat, 13 Nov 2010 10:31:08 +0900
Message-ID: <1289611868.3266.123.camel@aeonflux>
In-Reply-To: <1289574160-22899-2-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7698719368518585780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> * renamed MAX_LEN to IP_ADDR_LEN
> * removed memory leak from unneeded strdup when parsing xml response.
> * better handling of AT error responses
> * reduced number of caif interfaces to 4
> ---
>  drivers/stemodem/gprs-context.c |   54 ++++++++++++++++++++++-----------=
-----
>  1 files changed, 31 insertions(+), 23 deletions(-)

patch has been applied. Thanks.

Regards

Marcel



--===============7698719368518585780==--

