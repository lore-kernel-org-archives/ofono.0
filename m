Content-Type: multipart/mixed; boundary="===============3603047414190250304=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] cdma-connman: add feature to load/save credentials
Date: Tue, 09 Aug 2011 13:52:12 -0500
Message-ID: <4E4181DC.4040306@gmail.com>
In-Reply-To: <1312901287-30032-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3603047414190250304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 08/09/2011 09:48 AM, Guillaume Zajac wrote:
> ---
>  include/cdma-connman.h |    3 ++
>  src/cdma-connman.c     |   57 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/modem.c            |   35 +++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+), 0 deletions(-)
> =

> diff --git a/include/cdma-connman.h b/include/cdma-connman.h
> index 6a1c9ff..0f8e388 100644
> --- a/include/cdma-connman.h
> +++ b/include/cdma-connman.h
> @@ -77,6 +77,9 @@ void ofono_cdma_connman_set_data(struct ofono_cdma_conn=
man *cm,
>  						void *data);
>  void *ofono_cdma_connman_get_data(struct ofono_cdma_connman *cm);
>  =

> +void ofono_cdma_connman_load_credentials(struct ofono_cdma_connman *cm,
> +					const char *serial);
> +

Stop right there, this is pretty much the wrong design.  In fact it is
completely opposite of what you want to have from an encapsulation / API
point of view.

You need to ensure that the imsi/meid are known prior to cdma-connman
going live.  That way the cdma-connman atom can lookup the relevant
information and load its settings as needed.

If that means that the modem needs to query the relevant information
prior to calling post_sim/post_online, then that is what you have to do.

>  #ifdef __cplusplus
>  }
>  #endif

<snip>

Regards,
-Denis

--===============3603047414190250304==--

