Content-Type: multipart/mixed; boundary="===============8907653608955829850=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] message-waiting: add API to retrieve voicemail number
Date: Mon, 20 Jun 2011 04:33:14 -0500
Message-ID: <4DFF13DA.1040803@gmail.com>
In-Reply-To: <1308582763-3605-2-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8907653608955829850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 06/20/2011 10:12 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  include/message-waiting.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/include/message-waiting.h b/include/message-waiting.h
> index b40993e..adb7ef2 100644
> --- a/include/message-waiting.h
> +++ b/include/message-waiting.h
> @@ -33,6 +33,8 @@ struct ofono_message_waiting;
>  struct ofono_message_waiting *ofono_message_waiting_create(struct ofono_=
modem *modem);
>  void ofono_message_waiting_register(struct ofono_message_waiting *mw);
>  void ofono_message_waiting_remove(struct ofono_message_waiting *mw);
> +const struct ofono_phone_number *ofono_message_waiting_get_voicemail_num=
ber(
> +					struct ofono_message_waiting *mw);

I'd like to keep this API private for now, so lets move this to ofono.h
and combine patch 1 & 2 together.

Also, can you please use the following signature:

const struct ofono_phone_number *__ofono_message_waiting_get_mbdn(
					struct ofono_message_waiting *mw, unsigned int index);

Regards,
-Denis

--===============8907653608955829850==--

