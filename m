Content-Type: multipart/mixed; boundary="===============6910400151779644169=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/4] include: Add ofono_voicecall_en_list_notify api
Date: Tue, 29 Mar 2011 22:03:15 -0500
Message-ID: <4D929D73.6030609@gmail.com>
In-Reply-To: <1301320689-25201-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6910400151779644169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 03/28/2011 08:58 AM, Jeevaka Badrappan wrote:
> ---
>  include/voicecall.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =

> diff --git a/include/voicecall.h b/include/voicecall.h
> index 5e6da02..477b226 100644
> --- a/include/voicecall.h
> +++ b/include/voicecall.h
> @@ -140,6 +140,9 @@ struct ofono_voicecall_driver {
>  			ofono_voicecall_cb_t cb, void *data);
>  };
>  =

> +void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
> +					GSList *nw_en_list);
> +

We have a long-standing rule not to introduce G* types into the oFono
public API.  For lists, please use an array of strings for this.  Refer
to e.g. ofono_netreg_operator_list_cb_t or similar for an example.

>  void ofono_voicecall_notify(struct ofono_voicecall *vc,
>  				const struct ofono_call *call);
>  void ofono_voicecall_disconnected(struct ofono_voicecall *vc, int id,

Regards,
-Denis

--===============6910400151779644169==--

