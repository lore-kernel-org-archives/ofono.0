Content-Type: multipart/mixed; boundary="===============0096048626022546557=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 12/20] packet: add context type default
Date: Mon, 11 Apr 2011 14:40:48 -0500
Message-ID: <4DA35940.40300@gmail.com>
In-Reply-To: <1302517218-2147-13-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0096048626022546557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vijay,

On 04/11/2011 05:20 AM, Vijay Nayani wrote:
> OFONO_PACKET_CONTEXT_TYPE_DEFAULT is added to
> ofono_packet_context_type and conversion functions
> are updated for the same.
> ---
>  include/packet-context.h |    1 +
>  src/packet.c             |    7 +++++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> =

> diff --git a/include/packet-context.h b/include/packet-context.h
> index 44fd69f..02a5c42 100644
> --- a/include/packet-context.h
> +++ b/include/packet-context.h
> @@ -47,6 +47,7 @@ enum ofono_packet_context_type {
>  	OFONO_PACKET_CONTEXT_TYPE_MMS,
>  	OFONO_PACKET_CONTEXT_TYPE_WAP,
>  	OFONO_PACKET_CONTEXT_TYPE_IMS,
> +	OFONO_PACKET_CONTEXT_TYPE_DEFAULT,
>  };
>  =


My understanding was that whether an EPS bearer is 'default' has no
bearing on what context type (e.g. ims, internet, mms) it actually is.
I remember there was a conversation on how a 'default' context is
chosen, but I already forgot most of it.

To me it makes no sense that a default context is going to be anything
other than internet or ims.  The fact that it is a 'default' context
doesn't really help the upper layers in any way.  Especially ConnMan
needs to know whether this context can be used for internet access or not.

Regards,
-Denis

--===============0096048626022546557==--

