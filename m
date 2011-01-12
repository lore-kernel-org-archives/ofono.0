Content-Type: multipart/mixed; boundary="===============1263766403661008879=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC 3/5] voicecall: Add ofono_voicecall_tty_notify api
Date: Tue, 11 Jan 2011 22:03:34 -0800
Message-ID: <1294812214.3873.52.camel@aeonflux>
In-Reply-To: <1294668092-27896-4-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1263766403661008879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>  include/voicecall.h |    2 ++
>  src/voicecall.c     |   12 ++++++++++++
>  2 files changed, 14 insertions(+), 0 deletions(-)
> =

> diff --git a/include/voicecall.h b/include/voicecall.h
> index e37d73b..6f1bdd2 100644
> --- a/include/voicecall.h
> +++ b/include/voicecall.h
> @@ -144,6 +144,8 @@ void ofono_voicecall_notify(struct ofono_voicecall *v=
c,
>  void ofono_voicecall_disconnected(struct ofono_voicecall *vc, int id,
>  				enum ofono_disconnect_reason reason,
>  				const struct ofono_error *error);
> +void ofono_voicecall_tty_notify(struct ofono_voicecall *vc,
> +				const struct ofono_call *call);

what is the advantage of having this separate and not part of the
regular voicecall_notify and just extending struct ofono_call with a
field for TTY?

Regards

Marcel



--===============1263766403661008879==--

