Content-Type: multipart/mixed; boundary="===============7981787760665570321=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Add mpty field to ofono_call
Date: Mon, 23 Nov 2009 09:06:00 +0100
Message-ID: <1258963560.2993.14.camel@violet>
In-Reply-To: <1258956413-14197-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7981787760665570321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> A field 'mpty' is added to ofono_call so that we can know
> whether the call belongs to multiparty call or not. According
> to 27.007 7.18, it is a defined return value of AT+CLCC.
> ---
>  drivers/atmodem/atutil.c |    4 +++-
>  include/types.h          |    1 +
>  2 files changed, 4 insertions(+), 1 deletions(-)

patch has been applied. Thanks.

Regards

Marcel



--===============7981787760665570321==--

