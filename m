Content-Type: multipart/mixed; boundary="===============8254201065026265322=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] core: Always return success to a no-op
Date: Thu, 20 Jan 2011 12:23:49 +0100
Message-ID: <1295522629.3873.287.camel@aeonflux>
In-Reply-To: <1295520913-17243-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8254201065026265322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> A SetProperty that doesn't actually change the Online property's state
> when no change to that state is pending, should not fail. It should
> always succeed regardless of the current modem state.
> ---
>  src/modem.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

patch has been applied. Thanks.

Regards

Marcel



--===============8254201065026265322==--

