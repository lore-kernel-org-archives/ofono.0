Content-Type: multipart/mixed; boundary="===============3192982774922548450=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH v0 1/7] doc: Add ECNR to Handsfree
Date: Fri, 19 Apr 2013 23:11:23 +0300
Message-ID: <20130419201123.GA10478@x220.P-661HNU-F1>
In-Reply-To: <1366392884-7116-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3192982774922548450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On Fri, Apr 19, 2013, Claudio Takahasi wrote:
> This patch adds echo canceling and noise reduction property to Handsfree
> interface, allowing the handsfree unit to enable or disable this feature
> in the audio gateway.
> =

> According to Bluetooth HFP 1.6 spec: By default, if the AG supports its
> own embedded echo canceling and/or noise reduction functions, it shall
> have them activated until the AT+NREC command is received.
> ---
>  doc/handsfree-api.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> =

> diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
> index 0b5d421..f877db0 100644
> --- a/doc/handsfree-api.txt
> +++ b/doc/handsfree-api.txt
> @@ -56,6 +56,13 @@ Properties	array{string} Features [readonly]
>  			to activate or deactivate the function from the HF, or
>  			the AG could autonomously initiate it.
>  =

> +		boolean ECNR [readwrite]
> +
> +			Boolean representing whether echo canceling and noise
> +			reduction is enabled in the AG. This property may be
> +			written to activate or deactivate this feature from
> +			the HF unit.

Why would we want to have two different acronyms, NREC and ECNR, for the
same thing? We can't get rid of what's defined in the AT command
specification, so why add more confusion by inventing a second acronym?

Johan

--===============3192982774922548450==--

