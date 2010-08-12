Content-Type: multipart/mixed; boundary="===============3363269756733318352=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 04/16] emulator: Add APIs to send GAtServer result
Date: Thu, 12 Aug 2010 07:52:43 -0400
Message-ID: <1281613963.12579.269.camel@localhost.localdomain>
In-Reply-To: <1281493601-14351-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3363269756733318352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Defines APIs to send final/intermediate/unsolicited result to DUN
> client.
> ---
>  include/emulator.h |    2 ++
>  src/emulator.c     |   28 ++++++++++++++++++++++++++++
>  src/ofono.h        |   11 +++++++++++
>  3 files changed, 41 insertions(+), 0 deletions(-)
> =

> diff --git a/include/emulator.h b/include/emulator.h
> index 29e87b9..2a45c65 100644
> --- a/include/emulator.h
> +++ b/include/emulator.h
> @@ -36,6 +36,8 @@ enum ofono_emulator_status {
>  	OFONO_EMULATOR_STATUS_DESTROY,
>  };
>  =

> +enum _GAtServerResult;
> +

this is not good. It should not be needed outside of GAtChat. Why not
just include gatserver.h?

And in addition the _GAt declaration should never be used. Why not use
the typedef one?

Regards

Marcel



--===============3363269756733318352==--

