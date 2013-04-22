Content-Type: multipart/mixed; boundary="===============0388332167845994214=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1 5/7] include: Add EchoCancelingNoiseReduction to
 handsfree driver
Date: Mon, 22 Apr 2013 04:00:23 -0500
Message-ID: <5174FC27.1010205@gmail.com>
In-Reply-To: <1366635523-8272-5-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0388332167845994214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 04/22/2013 07:58 AM, Claudio Takahasi wrote:
> This patch extends the handsfree driver adding echo canceling and noise
> reduction callback to allow enabling or disabling this feature in the
> audio gateway.
> ---
>   include/handsfree.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/include/handsfree.h b/include/handsfree.h
> index b5e0d5f..dcc4d74 100644
> --- a/include/handsfree.h
> +++ b/include/handsfree.h
> @@ -48,6 +48,9 @@ struct ofono_handsfree_driver {
>   	void (*voice_recognition)(struct ofono_handsfree *hf,
>   					ofono_bool_t enabled,
>   					ofono_handsfree_cb_t cb, void *data);
> +	void (*echocanceling_noisereduction)(struct ofono_handsfree *hf,
> +					ofono_bool_t enabled,
> +					ofono_handsfree_cb_t cb, void *data);

You can use nrec here.  We are only pedantic about no Acronyms in the =

public D-Bus APIs.

Also note that NREC can only be turned off, not on.  Hence the enabled =

argument is likely not needed.

>   };
>
>   void ofono_handsfree_set_ag_features(struct ofono_handsfree *hf,

Regards,
-Denis

--===============0388332167845994214==--

