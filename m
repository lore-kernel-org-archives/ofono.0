Content-Type: multipart/mixed; boundary="===============7897022250300234367=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2 1/2] mbm: fix initial polling for sim
Date: Mon, 23 Aug 2010 16:32:08 +0200
Message-ID: <1282573928.23399.241.camel@localhost.localdomain>
In-Reply-To: <1282573090-8351-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7897022250300234367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> There seems to be no specific error codes returned when SIM is missing.
> Poll at least 5 times upon an error and give up after that.
> ---
>  plugins/mbm.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)

looks good to me. Patch has been applied. Thanks.

Regards

Marcel



--===============7897022250300234367==--

