Content-Type: multipart/mixed; boundary="===============7646730904507823666=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] emit settings signal before active signal
Date: Sat, 21 Nov 2009 19:14:21 +0100
Message-ID: <1258827261.22343.28.camel@localhost.localdomain>
In-Reply-To: <1258801008-9862-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7646730904507823666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin

> ---
>  src/gprs.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)

quick question on why? I did remember that Denis and I talked about on
IRC, but I forgot what our conclusion on the order of these two signals
was. We should really document this. Do you remember? And please prepare
a patch that also puts a comment about this in the API documentation.

Regards

Marcel



--===============7646730904507823666==--

