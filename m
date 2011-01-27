Content-Type: multipart/mixed; boundary="===============0315613778641303538=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 6/9] oFono smsagent enhancements to permit more flexible
 parameter set to be dispatched.
Date: Thu, 27 Jan 2011 14:18:22 +0100
Message-ID: <1296134302.1520.154.camel@aeonflux>
In-Reply-To: <1293627085-24428-7-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0315613778641303538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

>  src/smsagent.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =

> diff --git a/src/smsagent.h b/src/smsagent.h
> index 39513d6..348d36d 100644
> --- a/src/smsagent.h
> +++ b/src/smsagent.h
> @@ -31,6 +31,8 @@ typedef void (*sms_agent_dispatch_cb)(struct sms_agent =
*agent,
>  					enum sms_agent_result result,
>  					void *data);
>  =

> +typedef void (*sms_agent_dict_append_cb)(DBusMessageIter *dict, void *pa=
ram);
> +
>  struct sms_agent *sms_agent_new(const char *interface,
>  					const char *service, const char *path);
>  =

> @@ -49,4 +51,6 @@ int sms_agent_dispatch_datagram(struct sms_agent *agent=
, const char *method,
>  				const struct tm *local_sent_time,
>  				const unsigned char *content, unsigned int len,
>  				sms_agent_dispatch_cb cb, void *user_data,
> +				sms_agent_dict_append_cb dict_cb,
> +				void *dict_cb_data,
>  				ofono_destroy_func destroy);

I have a bunch of comments for the other patches, but what is this
about? I don't see any need to it.

Regards

Marcel



--===============0315613778641303538==--

